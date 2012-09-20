From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] pretty: support placeholders %C+ and %C-
Date: Thu, 20 Sep 2012 19:26:16 +0700
Message-ID: <1348143976-4506-3-git-send-email-pclouds@gmail.com>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
 <1348143976-4506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 14:34:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEfxC-0002wE-PG
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 14:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab2ITMdv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Sep 2012 08:33:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54244 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab2ITMdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 08:33:49 -0400
Received: by pbbrr4 with SMTP id rr4so109808pbb.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=G5VZjowGSVhadCASKeufYpHriLoEeJ99YQLAuIbSEoo=;
        b=ji4VTFESkh8DVe+8TBqDfQh468KDrGhLX8bJGJf8UxwQanOtMxGHsYz+XwvT4s6/Fo
         u6SM+mPbM5C9RjrMzb97blv4aP0GGHYXBWWJrv7iPe20ysyMfGFWpl/b7OOa1K5Qe6C/
         7E8prKSNuALkZ5CGCo/lwBIfRnLh/R8AWDGvGo0cRA1iiE7FxzZv/8XY+NjfYFux6oMI
         HVC6CifDcZRaeltOcYzHc+wrFirOYEiKn64G85PCmDLqkJF1EgYGscE4NcDyJ+SLz/LW
         e+Bn97f+YfHTb5NfgrXvcKWRUx5da69S+qlZD4f+hceHT9m/8ceDqiG9A6jf9B8Oyk0t
         NESg==
Received: by 10.68.223.163 with SMTP id qv3mr6270376pbc.101.1348143983915;
        Thu, 20 Sep 2012 05:26:23 -0700 (PDT)
Received: from lanh ([115.74.50.93])
        by mx.google.com with ESMTPS id c5sm2393914pay.5.2012.09.20.05.26.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Sep 2012 05:26:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Sep 2012 19:26:32 +0700
X-Mailer: git-send-email 1.7.12.1.383.gda6001e.dirty
In-Reply-To: <1348143976-4506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206048>

%C+ tells the next specifiers that color is preferred. %C- the
opposite. So far only %H, %h and %d support coloring.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |  2 ++
 pretty.c                         | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index e3d8a83..6e287d6 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -142,6 +142,8 @@ The placeholders are:
 - '%Cblue': switch color to blue
 - '%Creset': reset color
 - '%C(...)': color specification, as described in color.branch.* confi=
g option
+- '%C+': enable coloring on the following placeholders if supported
+- '%C-': disable coloring on the following placeholders
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%%': a raw '%'
diff --git a/pretty.c b/pretty.c
index e910679..b1cec71 100644
--- a/pretty.c
+++ b/pretty.c
@@ -623,6 +623,7 @@ struct format_commit_context {
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
 	unsigned commit_signature_parsed:1;
+	unsigned use_color:1;
 	struct {
 		char *gpg_output;
 		char good_bad;
@@ -885,6 +886,12 @@ static size_t format_commit_one(struct strbuf *sb,=
 const char *placeholder,
 					"--pretty format", color);
 			strbuf_addstr(sb, color);
 			return end - placeholder + 1;
+		} else if (placeholder[1] =3D=3D '+') {
+			c->use_color =3D 1;
+			return 2;
+		} else if (placeholder[1] =3D=3D '-') {
+			c->use_color =3D 0;
+			return 2;
 		}
 		if (!prefixcmp(placeholder + 1, "red")) {
 			strbuf_addstr(sb, GIT_COLOR_RED);
@@ -945,13 +952,17 @@ static size_t format_commit_one(struct strbuf *sb=
, const char *placeholder,
=20
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
+		strbuf_addstr(sb, diff_get_color(c->use_color, DIFF_COMMIT));
 		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
+		strbuf_addstr(sb, diff_get_color(c->use_color, DIFF_RESET));
 		return 1;
 	case 'h':		/* abbreviated commit hash */
+		strbuf_addstr(sb, diff_get_color(c->use_color, DIFF_COMMIT));
 		if (add_again(sb, &c->abbrev_commit_hash))
 			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
 						     c->pretty_ctx->abbrev));
+		strbuf_addstr(sb, diff_get_color(c->use_color, DIFF_RESET));
 		c->abbrev_commit_hash.len =3D sb->len - c->abbrev_commit_hash.off;
 		return 1;
 	case 'T':		/* tree hash */
@@ -988,7 +999,7 @@ static size_t format_commit_one(struct strbuf *sb, =
const char *placeholder,
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		format_decoration(sb, commit, 0);
+		format_decoration(sb, commit, c->use_color);
 		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
--=20
1.7.12.1.383.gda6001e.dirty
