From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/9] pretty: support %C(auto[,N]) to turn on coloring on next placeholder(s)
Date: Sun, 23 Sep 2012 16:10:27 +0700
Message-ID: <1348391433-11300-4-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
 <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 11:17:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFiJu-0001Jz-Ur
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 11:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab2IWJRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 05:17:38 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:48273 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2IWJRh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 05:17:37 -0400
Received: by dady13 with SMTP id y13so43708dad.19
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eJWo7ujb2ulJM9imuITVbgvJkTFZgmRVeyvCoGQZdYE=;
        b=ErPDFxbjnLRrKs3Wvcln+MXgpfel4qegXcBTcPAU1xVbT5+mJnExSrSLb/c0WEIw/c
         Jz7g7eYwQPZ3KbXFKIHwdlbTcvTAxIenrseoVwMdT9l/YBi2r2CmQDkmuc05+D7Qeety
         iXreLTvHVhqO67GnAGx3s1Hq+VDLh0RlONVWPU8/vjGtrfVC0mkaLtpXdevpaMWV9Pjk
         eFvnhbmpCrEatUg0sRCezlBUsogTFQTXr5qDScJhHQL0Xfs7n/PRf8MyUbp/7PNbS4EW
         s2Bq9vlpFYehOaMWsXN7zjnAK8MzaY/4NTkRyzHwFhxdmLJwPTBYEgkFqPKjM3YN8Eh/
         iDyA==
Received: by 10.66.83.234 with SMTP id t10mr24901861pay.39.1348391855220;
        Sun, 23 Sep 2012 02:17:35 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.47.110])
        by mx.google.com with ESMTPS id sr3sm7849813pbc.44.2012.09.23.02.17.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Sep 2012 02:17:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 23 Sep 2012 16:10:52 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206228>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |  1 +
 pretty.c                         | 28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index d9edded..c706556 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -145,6 +145,7 @@ The placeholders are:
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
1.7.12.1.406.g6ab07c4
