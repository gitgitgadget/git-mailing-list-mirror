From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Unify appending signoff in format-patch, commit and sequencer
Date: Thu, 15 Nov 2012 19:32:58 +0700
Message-ID: <1352982778-28631-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 13:33:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYyd4-0006st-LM
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 13:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767603Ab2KOMc4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2012 07:32:56 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46497 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993328Ab2KOMcz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 07:32:55 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1047166pad.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 04:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=yO+GwK9eWBV9i3Op0I2vteEYURcw/GLhQSjQ+gVmW5E=;
        b=r0pcFYthibScZlgl8pApGh6VY45TwU7hyOVnSAiya5fet8xJ/s3/cOrLoGody/TLol
         gM2Q/RnjFgQZSlDwCJdEpuzx0cNCzQQIz8arNcos99/Cnl1zuSprabw46Dw69JnpDinq
         FIxtmQnqef0MnbLT/nVT6SYD2UviAGu02NSojZBkkFHlzezOZWnNbCWY85iH+Vwl2yq0
         365XQ7RU4GSdo9aim45Hzk8+yrcvrj7xPa+YgdH0GV2jPa7PoHiySbfSU+3Pt5o+IWfS
         97LxQmlaajZfq5gs6d2cv8pa1uEqayROjsBAeAA3Uy2cOmD44yDOIYAO+A3T1HYyB60B
         tK/g==
Received: by 10.66.82.102 with SMTP id h6mr2870760pay.38.1352982775432;
        Thu, 15 Nov 2012 04:32:55 -0800 (PST)
Received: from lanh ([115.74.37.170])
        by mx.google.com with ESMTPS id mn5sm9464023pbc.12.2012.11.15.04.32.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 04:32:54 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 15 Nov 2012 19:32:59 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209819>

There are two implementations of append_signoff in log-tree.c and
sequencer.c, which do more or less the same thing. This patch

 - teaches sequencer.c's append_signoff() not to append the signoff if
   it's already there but not at the bottom

 - removes log-tree.c's

 - make sure "Signed-off-by: foo" in the middle of a line is not
   counted as a sign off

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Interestingly this patch triggers the fault that it fixes.
 I was surprised that there was no blank line before my S-o-b
 and thought I broke something. It turns out I used unmodified
 format-patch and it mistook the S-o-b quote as true S-o-b line.
 The modified one puts the blank line back.

 builtin/log.c | 13 +--------
 log-tree.c    | 92 ++++-----------------------------------------------=
--------
 revision.h    |  2 +-
 sequencer.c   | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 4 files changed, 88 insertions(+), 105 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e7b7db1..bb48344 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1058,7 +1058,6 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 	struct commit *origin =3D NULL, *head =3D NULL;
 	const char *in_reply_to =3D NULL;
 	struct patch_ids ids;
-	char *add_signoff =3D NULL;
 	struct strbuf buf =3D STRBUF_INIT;
 	int use_patch_format =3D 0;
 	int quiet =3D 0;
@@ -1154,16 +1153,6 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
=20
-	if (do_signoff) {
-		const char *committer;
-		const char *endpos;
-		committer =3D git_committer_info(IDENT_STRICT);
-		endpos =3D strchr(committer, '>');
-		if (!endpos)
-			die(_("bogus committer info %s"), committer);
-		add_signoff =3D xmemdupz(committer, endpos - committer + 1);
-	}
-
 	for (i =3D 0; i < extra_hdr.nr; i++) {
 		strbuf_addstr(&buf, extra_hdr.items[i].string);
 		strbuf_addch(&buf, '\n');
@@ -1354,7 +1343,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 		total++;
 		start_number--;
 	}
-	rev.add_signoff =3D add_signoff;
+	rev.add_signoff =3D do_signoff;
 	while (0 <=3D --nr) {
 		int shown;
 		commit =3D list[nr];
diff --git a/log-tree.c b/log-tree.c
index c894930..18cf006 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -9,6 +9,7 @@
 #include "string-list.h"
 #include "color.h"
 #include "gpg-interface.h"
+#include "sequencer.h"
=20
 struct decoration name_decoration =3D { "object names" };
=20
@@ -206,89 +207,6 @@ void show_decorations(struct rev_info *opt, struct=
 commit *commit)
 	putchar(')');
 }
=20
-/*
- * Search for "^[-A-Za-z]+: [^@]+@" pattern. It usually matches
- * Signed-off-by: and Acked-by: lines.
- */
-static int detect_any_signoff(char *letter, int size)
-{
-	char *cp;
-	int seen_colon =3D 0;
-	int seen_at =3D 0;
-	int seen_name =3D 0;
-	int seen_head =3D 0;
-
-	cp =3D letter + size;
-	while (letter <=3D --cp && *cp =3D=3D '\n')
-		continue;
-
-	while (letter <=3D cp) {
-		char ch =3D *cp--;
-		if (ch =3D=3D '\n')
-			break;
-
-		if (!seen_at) {
-			if (ch =3D=3D '@')
-				seen_at =3D 1;
-			continue;
-		}
-		if (!seen_colon) {
-			if (ch =3D=3D '@')
-				return 0;
-			else if (ch =3D=3D ':')
-				seen_colon =3D 1;
-			else
-				seen_name =3D 1;
-			continue;
-		}
-		if (('A' <=3D ch && ch <=3D 'Z') ||
-		    ('a' <=3D ch && ch <=3D 'z') ||
-		    ch =3D=3D '-') {
-			seen_head =3D 1;
-			continue;
-		}
-		/* no empty last line doesn't match */
-		return 0;
-	}
-	return seen_head && seen_name;
-}
-
-static void append_signoff(struct strbuf *sb, const char *signoff)
-{
-	static const char signed_off_by[] =3D "Signed-off-by: ";
-	size_t signoff_len =3D strlen(signoff);
-	int has_signoff =3D 0;
-	char *cp;
-
-	cp =3D sb->buf;
-
-	/* First see if we already have the sign-off by the signer */
-	while ((cp =3D strstr(cp, signed_off_by))) {
-
-		has_signoff =3D 1;
-
-		cp +=3D strlen(signed_off_by);
-		if (cp + signoff_len >=3D sb->buf + sb->len)
-			break;
-		if (strncmp(cp, signoff, signoff_len))
-			continue;
-		if (!isspace(cp[signoff_len]))
-			continue;
-		/* we already have him */
-		return;
-	}
-
-	if (!has_signoff)
-		has_signoff =3D detect_any_signoff(sb->buf, sb->len);
-
-	if (!has_signoff)
-		strbuf_addch(sb, '\n');
-
-	strbuf_addstr(sb, signed_off_by);
-	strbuf_add(sb, signoff, signoff_len);
-	strbuf_addch(sb, '\n');
-}
-
 static unsigned int digits_in_number(unsigned int number)
 {
 	unsigned int i =3D 10, result =3D 1;
@@ -651,8 +569,10 @@ void show_log(struct rev_info *opt)
 	/*
 	 * And then the pretty-printed message itself
 	 */
-	if (ctx.need_8bit_cte >=3D 0)
-		ctx.need_8bit_cte =3D has_non_ascii(opt->add_signoff);
+	if (ctx.need_8bit_cte >=3D 0 && opt->add_signoff)
+		ctx.need_8bit_cte =3D
+			has_non_ascii(fmt_name(getenv("GIT_COMMITTER_NAME"),
+					       getenv("GIT_COMMITTER_EMAIL")));
 	ctx.date_mode =3D opt->date_mode;
 	ctx.date_mode_explicit =3D opt->date_mode_explicit;
 	ctx.abbrev =3D opt->diffopt.abbrev;
@@ -663,7 +583,7 @@ void show_log(struct rev_info *opt)
 	pretty_print_commit(&ctx, commit, &msgbuf);
=20
 	if (opt->add_signoff)
-		append_signoff(&msgbuf, opt->add_signoff);
+		append_signoff(&msgbuf, 0);
 	if (opt->show_log_size) {
 		printf("log size %i\n", (int)msgbuf.len);
 		graph_show_oneline(opt->graph);
diff --git a/revision.h b/revision.h
index a95bd0b..af35325 100644
--- a/revision.h
+++ b/revision.h
@@ -136,7 +136,7 @@ struct rev_info {
 	int		numbered_files;
 	char		*message_id;
 	struct string_list *ref_message_ids;
-	const char	*add_signoff;
+	int              add_signoff;
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
diff --git a/sequencer.c b/sequencer.c
index be0cb8b..4eb59e4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1058,21 +1058,95 @@ static int ends_rfc2822_footer(struct strbuf *s=
b, int ignore_footer)
 	return 1;
 }
=20
+/*
+ * Search for "^[-A-Za-z]+: [^@]+@" pattern. It usually matches
+ * Signed-off-by: and Acked-by: lines.
+ */
+static int detect_any_signoff(char *letter, int size)
+{
+	char *cp;
+	int seen_colon =3D 0;
+	int seen_at =3D 0;
+	int seen_name =3D 0;
+	int seen_head =3D 0;
+
+	cp =3D letter + size;
+	while (letter <=3D --cp && *cp =3D=3D '\n')
+		continue;
+
+	while (letter <=3D cp) {
+		char ch =3D *cp--;
+		if (ch =3D=3D '\n')
+			break;
+
+		if (!seen_at) {
+			if (ch =3D=3D '@')
+				seen_at =3D 1;
+			continue;
+		}
+		if (!seen_colon) {
+			if (ch =3D=3D '@')
+				return 0;
+			else if (ch =3D=3D ':')
+				seen_colon =3D 1;
+			else
+				seen_name =3D 1;
+			continue;
+		}
+		if (('A' <=3D ch && ch <=3D 'Z') ||
+		    ('a' <=3D ch && ch <=3D 'z') ||
+		    ch =3D=3D '-') {
+			seen_head =3D 1;
+			continue;
+		}
+		/* no empty last line doesn't match */
+		return 0;
+	}
+	return seen_head && seen_name;
+}
+
 void append_signoff(struct strbuf *msgbuf, int ignore_footer)
 {
 	struct strbuf sob =3D STRBUF_INIT;
-	int i;
+	const char *cp;
+	int i, has_signoff =3D 0;
+	int signoff_header_len =3D strlen(sign_off_header);
=20
 	strbuf_addstr(&sob, sign_off_header);
 	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
 				getenv("GIT_COMMITTER_EMAIL")));
-	strbuf_addch(&sob, '\n');
 	for (i =3D msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - =
1] !=3D '\n'; i--)
 		; /* do nothing */
-	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
-		if (!i || !ends_rfc2822_footer(msgbuf, ignore_footer))
-			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
-		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.l=
en);
+
+	/* First see if we already have the sign-off by the signer */
+	cp =3D msgbuf->buf;
+	while ((cp =3D strstr(cp, sign_off_header)) &&
+	       cp + signoff_header_len < msgbuf->buf + msgbuf->len - ignore_f=
ooter) {
+
+		if (cp > msgbuf->buf && cp[-1] !=3D '\n' && cp[-1] !=3D '\r') {
+			/*
+			 * Signed-off-by: found in the middle of the
+			 * commit message is not really a sign off
+			 */
+			cp +=3D signoff_header_len;
+			continue;
+		}
+		has_signoff =3D 1;
+
+	       if (cp + sob.len >=3D msgbuf->buf + msgbuf->len)
+		       break;
+	       if (!strncmp(cp, sob.buf, sob.len) && isspace(cp[sob.len]))
+		       return;	/* we already have him */
+	       cp +=3D signoff_header_len;
 	}
+
+	if (!has_signoff)
+		has_signoff =3D detect_any_signoff(msgbuf->buf,
+						 msgbuf->len - ignore_footer);
+
+	if (!i || (!has_signoff && !ends_rfc2822_footer(msgbuf, ignore_footer=
)))
+		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
+	strbuf_addch(&sob, '\n');
+	strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.le=
n);
 	strbuf_release(&sob);
 }
--=20
1.8.0.151.g12dbe03
