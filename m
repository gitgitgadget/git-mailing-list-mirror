From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] attr: avoid strlen() on every match
Date: Thu,  4 Oct 2012 14:39:48 +0700
Message-ID: <1349336392-1772-3-git-send-email-pclouds@gmail.com>
References: <7v626q3hen.fsf@alter.siamese.dyndns.org>
 <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:21:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUJ-0001w8-8s
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282Ab2JDHk1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 03:40:27 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55961 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256Ab2JDHkV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 03:40:21 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so235863pad.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CN1qK6k0axen72R3NhIpUNtA2pdofr2tYbS1sdQwjVY=;
        b=rCHZszQxHdspFfGMRiY+rk/yiXboy+vZkrrAp0rMn+vAEcIuDH9DYrPjPmxsiYRUMx
         PkeyC0EKkO1Ah8d6NjCQOheX2flL7SNJQIlfHCKpmajBhrbY3pOhw68wEYDGqXBmqv3V
         +DIAk7XknzBrfPYW0R+gPl3BLzggigo6229OhKYoWJYigAggovJzJnmjGPoHS378XTgn
         a/RX4XmMwXlQKOpHXr6nWcmBsf4mi9v0LZm4pOaGQnY2BjhsHyPbmZaWyHPE9l4oHbCA
         iqVtBYu19eBWW4EYDGh6G0DrobeGV/vw2JnhmguwRvbaBy4DR+R/Wb/NnMZiI04PSQIH
         Dbcg==
Received: by 10.68.226.100 with SMTP id rr4mr19630654pbc.143.1349336421004;
        Thu, 04 Oct 2012 00:40:21 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id pw9sm3937726pbb.42.2012.10.04.00.40.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 00:40:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 04 Oct 2012 14:40:09 +0700
X-Mailer: git-send-email 1.7.12.1.405.gb727dc9
In-Reply-To: <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206991>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 48df800..66b96d9 100644
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
@@ -701,7 +703,7 @@ static int fill(const char *path, int pathlen, stru=
ct attr_stack *stk, int rem)
 		if (a->is_macro)
 			continue;
 		if (path_matches(path, pathlen,
-				 a->pattern, base, strlen(base)))
+				 a->pattern, base, stk->originlen))
 			rem =3D fill_one("fill", a, rem);
 	}
 	return rem;
--=20
1.7.12.1.405.gb727dc9
