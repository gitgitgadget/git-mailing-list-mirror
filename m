From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/5] grep: color patterns in output
Date: Sat, 07 Mar 2009 13:32:32 +0100
Message-ID: <1236429152.6486.50.camel@ubuntu.ubuntu-domain>
References: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Thiago Alves <thiago.salves@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 13:34:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfvjA-00018K-Na
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 13:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbZCGMch convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 07:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754486AbZCGMch
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 07:32:37 -0500
Received: from india601.server4you.de ([85.25.151.105]:36513 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbZCGMcg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 07:32:36 -0500
Received: from [10.0.1.101] (p57B7BF05.dip.t-dialin.net [87.183.191.5])
	by india601.server4you.de (Postfix) with ESMTPSA id 5615B2F8057;
	Sat,  7 Mar 2009 13:32:33 +0100 (CET)
In-Reply-To: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112535>

Coloring matches makes them easier to spot in the output.

Add two options and two parameters: color.grep (to turn coloring on
or off), color.grep.match (to set the color of matches), --color
and --no-color (to turn coloring on or off, respectively).

The output of external greps is not changed.

This patch is based on earlier ones by Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy and
Thiago Alves.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/config.txt   |    9 ++++
 Documentation/git-grep.txt |    8 ++++
 builtin-grep.c             |   32 +++++++++++++++
 grep.c                     |   90 ++++++++++++++++++++++++++++++++++++=
++------
 grep.h                     |    3 +
 5 files changed, 130 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f5152c5..b75dada 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -548,6 +548,15 @@ color.diff.<slot>::
 	whitespace errors). The values of these variables may be specified as
 	in color.branch.<slot>.
=20
+color.grep::
+	When set to `always`, always highlight matches.  When `false` (or
+	`never`), never.  When set to `true` or `auto`, use color only
+	when the output is written to the terminal.  Defaults to `false`.
+
+color.grep.match::
+	Use customized color for matches.  The value of this variable
+	may be specified as in color.branch.<slot>.
+
 color.interactive::
 	When set to `always`, always use colors for interactive prompts
 	and displays (such as those used by "git-add --interactive").
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 553da6c..fccb82d 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [-z | --null]
 	   [-c | --count] [--all-match]
+	   [--color | --no-color]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...] [<tree>...]
@@ -105,6 +106,13 @@ OPTIONS
 	Instead of showing every matched line, show the number of
 	lines that match.
=20
+--color::
+	Show colored matches.
+
+--no-color::
+	Turn off match highlighting, even when the configuration file
+	gives the default to color output.
+
 -[ABC] <context>::
 	Show `context` trailing (`A` -- after), or leading (`B`
 	-- before), or both (`C` -- context) lines, and place a
diff --git a/builtin-grep.c b/builtin-grep.c
index 3f12ba3..e2c0f01 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -22,6 +22,24 @@
=20
 static int builtin_grep;
=20
+static int grep_config(const char *var, const char *value, void *cb)
+{
+	struct grep_opt *opt =3D cb;
+
+	if (!strcmp(var, "grep.color") || !strcmp(var, "color.grep")) {
+		opt->color =3D git_config_colorbool(var, value, -1);
+		return 0;
+	}
+	if (!strcmp(var, "grep.color.match") ||
+	    !strcmp(var, "color.grep.match")) {
+		if (!value)
+			return config_error_nonbool(var);
+		color_parse(value, var, opt->color_match);
+		return 0;
+	}
+	return git_color_default_config(var, value, cb);
+}
+
 /*
  * git grep pathspecs are somewhat different from diff-tree pathspecs;
  * pathname wildcards are allowed.
@@ -536,6 +554,12 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 	opt.pattern_tail =3D &opt.pattern_list;
 	opt.regflags =3D REG_NEWLINE;
=20
+	strcpy(opt.color_match, GIT_COLOR_RED GIT_COLOR_BOLD);
+	opt.color =3D -1;
+	git_config(grep_config, &opt);
+	if (opt.color =3D=3D -1)
+		opt.color =3D git_use_color_default;
+
 	/*
 	 * If there is no -- then the paths must exist in the working
 	 * tree.  If there is no explicit pattern specified with -e or
@@ -732,6 +756,14 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 			opt.relative =3D 0;
 			continue;
 		}
+		if (!strcmp("--color", arg)) {
+			opt.color =3D 1;
+			continue;
+		}
+		if (!strcmp("--no-color", arg)) {
+			opt.color =3D 0;
+			continue;
+		}
 		if (!strcmp("--", arg)) {
 			/* later processing wants to have this at argv[1] */
 			argv--;
diff --git a/grep.c b/grep.c
index bdcff7b..cace1c8 100644
--- a/grep.c
+++ b/grep.c
@@ -253,18 +253,6 @@ static int word_char(char ch)
 	return isalnum(ch) || ch =3D=3D '_';
 }
=20
-static void show_line(struct grep_opt *opt, const char *bol, const cha=
r *eol,
-		      const char *name, unsigned lno, char sign)
-{
-	if (opt->null_following_name)
-		sign =3D '\0';
-	if (opt->pathname)
-		printf("%s%c", name, sign);
-	if (opt->linenum)
-		printf("%d%c", lno, sign);
-	printf("%.*s\n", (int)(eol-bol), bol);
-}
-
 static void show_name(struct grep_opt *opt, const char *name)
 {
 	printf("%s%c", name, opt->null_following_name ? '\0' : '\n');
@@ -437,6 +425,84 @@ static int match_line(struct grep_opt *opt, char *=
bol, char *eol,
 	return 0;
 }
=20
+static int match_next_pattern(struct grep_pat *p, char *bol, char *eol=
,
+			      enum grep_context ctx,
+			      regmatch_t *pmatch, int eflags)
+{
+	regmatch_t match;
+
+	if (!match_one_pattern(p, bol, eol, ctx, &match, eflags))
+		return 0;
+	if (match.rm_so < 0 || match.rm_eo < 0)
+		return 0;
+	if (pmatch->rm_so >=3D 0 && pmatch->rm_eo >=3D 0) {
+		if (match.rm_so > pmatch->rm_so)
+			return 1;
+		if (match.rm_so =3D=3D pmatch->rm_so && match.rm_eo < pmatch->rm_eo)
+			return 1;
+	}
+	pmatch->rm_so =3D match.rm_so;
+	pmatch->rm_eo =3D match.rm_eo;
+	return 1;
+}
+
+static int next_match(struct grep_opt *opt, char *bol, char *eol,
+		      enum grep_context ctx, regmatch_t *pmatch, int eflags)
+{
+	struct grep_pat *p;
+	int hit =3D 0;
+
+	pmatch->rm_so =3D pmatch->rm_eo =3D -1;
+	if (bol < eol) {
+		for (p =3D opt->pattern_list; p; p =3D p->next) {
+			switch (p->token) {
+			case GREP_PATTERN: /* atom */
+			case GREP_PATTERN_HEAD:
+			case GREP_PATTERN_BODY:
+				hit |=3D match_next_pattern(p, bol, eol, ctx,
+							  pmatch, eflags);
+				break;
+			default:
+				break;
+			}
+		}
+	}
+	return hit;
+}
+
+static void show_line(struct grep_opt *opt, char *bol, char *eol,
+		      const char *name, unsigned lno, char sign)
+{
+	int rest =3D eol - bol;
+
+	if (opt->null_following_name)
+		sign =3D '\0';
+	if (opt->pathname)
+		printf("%s%c", name, sign);
+	if (opt->linenum)
+		printf("%d%c", lno, sign);
+	if (opt->color) {
+		regmatch_t match;
+		enum grep_context ctx =3D GREP_CONTEXT_BODY;
+		int ch =3D *eol;
+		int eflags =3D 0;
+
+		*eol =3D '\0';
+		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
+			printf("%.*s%s%.*s%s",
+			       match.rm_so, bol,
+			       opt->color_match,
+			       match.rm_eo - match.rm_so, bol + match.rm_so,
+			       GIT_COLOR_RESET);
+			bol +=3D match.rm_eo;
+			rest -=3D match.rm_eo;
+			eflags =3D REG_NOTBOL;
+		}
+		*eol =3D ch;
+	}
+	printf("%.*s\n", rest, bol);
+}
+
 static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 char *buf, unsigned long size, int collect_hits)
 {
diff --git a/grep.h b/grep.h
index d2a8674..73b33ab 100644
--- a/grep.h
+++ b/grep.h
@@ -1,5 +1,6 @@
 #ifndef GREP_H
 #define GREP_H
+#include "color.h"
=20
 enum grep_pat_token {
 	GREP_PATTERN,
@@ -77,6 +78,8 @@ struct grep_opt {
 	unsigned relative:1;
 	unsigned pathname:1;
 	unsigned null_following_name:1;
+	int color;
+	char color_match[COLOR_MAXLEN];
 	int regflags;
 	unsigned pre_context;
 	unsigned post_context;
--=20
1.6.2
