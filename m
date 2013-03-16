From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/12] pretty: add %C(auto) for auto-coloring on the next placeholder
Date: Sat, 16 Mar 2013 09:24:40 +0700
Message-ID: <1363400683-14813-10-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 03:26:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGgp7-0002zI-Fv
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 03:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345Ab3CPCZs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 22:25:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36623 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932333Ab3CPCZr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 22:25:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo15so4573853pbc.19
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 19:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=62zjBGYuZrdUU3h/15TdHVqpHUmRMK3jfL7cdDJYi30=;
        b=ZyAljy+IxrQj8pwNsXReGvQrKOpj6uCsPiI5Ws9sxkORufWDDwlE9V0vcN/5KJHUoz
         CSfITfovPHEgjz5ZW4r4VidrI1vs51wdyZemVWaDGr2HxZyRvk/uIirGhfwEEfYO9/wO
         XLz0KfXdmYuW320qKWggRlPyK7SHqBiUJatmV4ePTsDyuyTMyNDCaQN4uM9uI9Itz9YF
         MGIbwqsqxG7zjnZ9Z4KKKyq3jlKtSWMoFOlfv+WSx7Xs1qStQghvakYXU8ufAnhjuRfO
         nP/WhPtP5uADQC3tnj1MfIg+XGabJcVZi1mwU6SGzbux8GLTJHDL64iIjNqcYz0sCLjt
         Tjzg==
X-Received: by 10.68.11.135 with SMTP id q7mr21202029pbb.5.1363400746616;
        Fri, 15 Mar 2013 19:25:46 -0700 (PDT)
Received: from lanh ([115.74.58.84])
        by mx.google.com with ESMTPS id qd8sm11488988pbc.29.2013.03.15.19.25.43
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 19:25:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Mar 2013 09:25:41 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218278>

This is not simply convenient over $C(auto,xxx). Some placeholders
(actually only one, %d) do multi coloring and we can't emit a multiple
colors with %C(auto,xxx).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |  3 ++-
 pretty.c                         | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 66345d1..8734224 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -154,7 +154,8 @@ The placeholders are:
   adding `auto,` at the beginning will emit color only when colors are
   enabled for log output (by `color.diff`, `color.ui`, or `--color`, a=
nd
   respecting the `auto` settings of the former if we are going to a
-  terminal)
+  terminal). `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
+  on the following placeholder.
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%%': a raw '%'
diff --git a/pretty.c b/pretty.c
index 3f4809a..c333fd6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -774,6 +774,7 @@ struct format_commit_context {
 	char *message;
 	char *commit_encoding;
 	size_t width, indent1, indent2;
+	int auto_color;
=20
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
@@ -1011,7 +1012,7 @@ static size_t format_commit_one(struct strbuf *sb=
, /* in UTF-8 */
 	const struct commit *commit =3D c->commit;
 	const char *msg =3D c->message;
 	struct commit_list *p;
-	int h1, h2;
+	int h1, h2, use_color;
=20
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
@@ -1023,6 +1024,10 @@ static size_t format_commit_one(struct strbuf *s=
b, /* in UTF-8 */
=20
 			if (!end)
 				return 0;
+			if (!prefixcmp(begin, "auto)")) {
+				c->auto_color =3D 1;
+				return end - placeholder + 1;
+			}
 			if (!prefixcmp(begin, "auto,")) {
 				if (!want_color(c->pretty_ctx->color))
 					return end - placeholder + 1;
@@ -1090,16 +1095,22 @@ static size_t format_commit_one(struct strbuf *=
sb, /* in UTF-8 */
 	/* these depend on the commit */
 	if (!commit->object.parsed)
 		parse_object(commit->object.sha1);
+	use_color =3D c->auto_color;
+	c->auto_color =3D 0;
=20
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
+		strbuf_addstr(sb, diff_get_color(use_color, DIFF_COMMIT));
 		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
+		strbuf_addstr(sb, diff_get_color(use_color, DIFF_RESET));
 		return 1;
 	case 'h':		/* abbreviated commit hash */
+		strbuf_addstr(sb, diff_get_color(use_color, DIFF_COMMIT));
 		if (add_again(sb, &c->abbrev_commit_hash))
 			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
 						     c->pretty_ctx->abbrev));
+		strbuf_addstr(sb, diff_get_color(use_color, DIFF_RESET));
 		c->abbrev_commit_hash.len =3D sb->len - c->abbrev_commit_hash.off;
 		return 1;
 	case 'T':		/* tree hash */
@@ -1136,7 +1147,7 @@ static size_t format_commit_one(struct strbuf *sb=
, /* in UTF-8 */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		format_decoration(sb, commit, 0);
+		format_decoration(sb, commit, use_color);
 		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
--=20
1.8.2.83.gc99314b
