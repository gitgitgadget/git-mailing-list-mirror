From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/10] attr: avoid strlen() on every match
Date: Fri,  5 Oct 2012 11:41:01 +0700
Message-ID: <1349412069-627-3-git-send-email-pclouds@gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 09:23:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK2Fi-0000Xh-Cl
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab2JEHXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 03:23:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53065 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab2JEHXG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 03:23:06 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1462351pbb.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LRDCumHvU9hrLLoNB202ofVe61MaQPeII8jvDqPpGqw=;
        b=Uv2PbL7YgOZCKzYx0fvp+f0SCLv7/k5ITIl3n0g5DVYhamZ09UBSV4RUQFmUQCJjOY
         T9xwuAWB+wdYKgNHzM7uvIRHBudF2rZnTswkvegYYzLmDpzfX9kBgwM8uLV7TSXa6foK
         I+vouQxC1IFcUP/VNIPq8ulNItJivbjQIhsCK7Dz66gTXj/NlvwtsY1aUb7FVlF9jntd
         77XDd+Dia+I0nT0jE1H3upodt6dyNUsj0/S9+LQGFPBlh+9EjiizNTRFGlMnXr3zrw1Q
         0XdPbldGcKf6NIMq2nI6M4yGQdy8evbtRQrrnsmhsdjvt38DBPEYjFdwNQOee30sPNzX
         aN9A==
Received: by 10.66.90.4 with SMTP id bs4mr18849053pab.3.1349412073627;
        Thu, 04 Oct 2012 21:41:13 -0700 (PDT)
Received: from tre ([115.74.45.10])
        by mx.google.com with ESMTPS id d9sm5365843paw.35.2012.10.04.21.41.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 21:41:12 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 05 Oct 2012 11:41:22 +0700
X-Mailer: git-send-email 1.7.10.1.641.g9354186
In-Reply-To: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207082>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index b52efb5..2942bf6 100644
--- a/attr.c
+++ b/attr.c
@@ -277,6 +277,7 @@ static struct match_attr *parse_attr_line(const cha=
r *line, const char *src,
 static struct attr_stack {
 	struct attr_stack *prev;
 	char *origin;
+	size_t originlen;
 	unsigned num_matches;
 	unsigned alloc;
 	struct match_attr **attrs;
@@ -532,6 +533,7 @@ static void bootstrap_attr_stack(void)
 	if (!is_bare_repository() || direction =3D=3D GIT_ATTR_INDEX) {
 		elem =3D read_attr(GITATTRIBUTES_FILE, 1);
 		elem->origin =3D xstrdup("");
+		elem->originlen =3D 0;
 		elem->prev =3D attr_stack;
 		attr_stack =3D elem;
 		debug_push(elem);
@@ -625,7 +627,7 @@ static void prepare_attr_stack(const char *path)
 			strbuf_addstr(&pathbuf, GITATTRIBUTES_FILE);
 			elem =3D read_attr(pathbuf.buf, 0);
 			strbuf_setlen(&pathbuf, cp - path);
-			elem->origin =3D strbuf_detach(&pathbuf, NULL);
+			elem->origin =3D strbuf_detach(&pathbuf, &elem->originlen);
 			elem->prev =3D attr_stack;
 			attr_stack =3D elem;
 			debug_push(elem);
@@ -700,7 +702,7 @@ static int fill(const char *path, int pathlen, stru=
ct attr_stack *stk, int rem)
 		if (a->is_macro)
 			continue;
 		if (path_matches(path, pathlen,
-				 a->u.pattern, base, strlen(base)))
+				 a->u.pattern, base, stk->originlen))
 			rem =3D fill_one("fill", a, rem);
 	}
 	return rem;
--=20
1.7.12.1.405.gb727dc9
