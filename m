From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] pretty: support %C(auto[,N]) to turn on coloring on next placeholder(s)
Date: Sat, 22 Sep 2012 11:22:16 +0700
Message-ID: <1348287739-12128-4-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 06:23:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHF9-0003Pi-M0
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab2IVEWn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2012 00:22:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61105 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab2IVEW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:22:28 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3905556pbb.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 21:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=43JYeE+sa7JUIEk96fXWTSzVc5rVQhszPJ2oZMMvT24=;
        b=itppoVQFTCR36bC1ZM8C8wUPWBd1627ie6VlgnM0WuYSiBAwrLwhPGki6lcOvuHWib
         TwYRkCr9NLp79zDjUxHJLKTaa/CV27CjoIVUwpAgzOFox5j0knJsE1y0z0fwDadnHMVO
         1oRJNia/7xfwAUWAW+t28LWEmXlVD8MGBeZWgC8gOBpLK5YZ4aVyButJut2cPFhxc3U2
         nt7W5qghNTqn2fIiKYUc7CNd8ZQYhP7gcp7RBZy/5iIucnobga3x0rDeok7X1PyOr+0/
         BU8Er4gjCqPlpbm1sZyCM+eGSjdu3LkUZ1lcm0nFDwRQmv5ozk+nh0qHP/67OrEABSzV
         v3FQ==
Received: by 10.68.131.2 with SMTP id oi2mr20432546pbb.78.1348287747902;
        Fri, 21 Sep 2012 21:22:27 -0700 (PDT)
Received: from lanh ([115.74.43.144])
        by mx.google.com with ESMTPS id ho7sm6109581pbc.3.2012.09.21.21.22.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Sep 2012 21:22:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Sep 2012 11:22:38 +0700
X-Mailer: git-send-email 1.7.12.1.384.g7b808e7
In-Reply-To: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206180>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |  1 +
 pretty.c                         | 28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index e3d8a83..8304325 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -142,6 +142,7 @@ The placeholders are:
 - '%Cblue': switch color to blue
 - '%Creset': reset color
 - '%C(...)': color specification, as described in color.branch.* confi=
g option
+- '%C(auto[,<N>])': turn on coloring on the next placeholder (or the n=
ext N placeholders) if supported
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%%': a raw '%'
diff --git a/pretty.c b/pretty.c
index 93c96c2..45fe878 100644
--- a/pretty.c
+++ b/pretty.c
@@ -630,6 +630,7 @@ struct format_commit_context {
 	} signature;
 	char *message;
 	size_t width, indent1, indent2;
+	unsigned use_color;
=20
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
@@ -872,6 +873,24 @@ static size_t parse_color_placeholder(struct strbu=
f *sb,
 		char color[COLOR_MAXLEN];
 		if (!end)
 			return 0;
+		if (!prefixcmp(placeholder + 1, "(auto")) {
+			/*
+			 * use_color decreased after every
+			 * format_commit_one() so we lose one right
+			 * after parsing "%C". Which is why we add an
+			 * extra one to use_color here.
+			 */
+			if (placeholder[6] =3D=3D ',') {
+				char *next;
+				int v =3D strtoul(placeholder + 7, &next, 10);
+				if (next =3D=3D end)
+					c->use_color =3D v + 1;
+				else
+					return 0;
+			} else
+				c->use_color =3D 2;
+			return end - placeholder + 1;
+		}
 		color_parse_mem(placeholder + 2,
 				end - (placeholder + 2),
 				"--pretty format", color);
@@ -955,13 +974,17 @@ static size_t format_commit_one(struct strbuf *sb=
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
@@ -998,7 +1021,7 @@ static size_t format_commit_one(struct strbuf *sb,=
 const char *placeholder,
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		format_decoration(sb, commit, 0);
+		format_decoration(sb, commit, c->use_color);
 		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
@@ -1101,6 +1124,7 @@ static size_t format_commit_one(struct strbuf *sb=
, const char *placeholder,
 static size_t format_commit_item(struct strbuf *sb, const char *placeh=
older,
 				 void *context)
 {
+	struct format_commit_context *c =3D context;
 	int consumed;
 	size_t orig_len;
 	enum {
@@ -1128,6 +1152,8 @@ static size_t format_commit_item(struct strbuf *s=
b, const char *placeholder,
=20
 	orig_len =3D sb->len;
 	consumed =3D format_commit_one(sb, placeholder, context);
+	if (c->use_color)
+		c->use_color--;
 	if (magic =3D=3D NO_MAGIC)
 		return consumed;
=20
--=20
1.7.12.1.384.g7b808e7
