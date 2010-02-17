From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCHv2] Add an optional argument for --color options
Date: Tue, 16 Feb 2010 23:55:58 -0500
Message-ID: <1266382558-26325-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 05:54:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhbvH-0000Fs-2h
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 05:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934059Ab0BQExr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 23:53:47 -0500
Received: from mail-qy0-f178.google.com ([209.85.221.178]:33111 "EHLO
	mail-qy0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934049Ab0BQExp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 23:53:45 -0500
Received: by qyk8 with SMTP id 8so1579331qyk.24
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 20:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=amhJA19tzcnatOPrMYclzepnT5FyQb018/Z8hMwpV5M=;
        b=ccU4KRZ+dcfwN2dQjyzkGb0lmfNBnCPBjNexTI8uqMMCNOrpzDxWgeFzB7V8WujL0y
         LGwLLwATJ69MJRw7bpMbSL2hQIdYUeL9Suv6453aWH3o6HYMw7WaAboAPZnbRtVb30FW
         rCY3/UWDXchKPK6oD8yJIbjJXUVoVlw+zRePM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AoUtwQRLd3goc5DMFv37V7cDuVSAD2xxr6a64y4HQTkUzgQlmu4E+DwKHKhhXccLNd
         /JH8D/vI7bvjeqbSbpXeeaJbPI0fm3EAi7tNaC/yiqb/fDV/R2wgHp9b1DjdKHDxHJW2
         8R7fmFXU79EkPsswQLlC1tWdzj8Le9GXusKmo=
Received: by 10.224.65.99 with SMTP id h35mr1317326qai.150.1266382423373;
        Tue, 16 Feb 2010 20:53:43 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 20sm5607734qyk.1.2010.02.16.20.53.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 20:53:42 -0800 (PST)
X-Mailer: git-send-email 1.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140205>

Make git-branch, git-show-branch, git-grep, and all the diff-based
programs accept an optional argument <when> for --color.  The argument
is a colorbool: "always", "never", or "auto".  If no argument is given,
"always" is used;  --no-color is an alias for --color=never.  This makes
the command-line interface consistent with other GNU tools, such as `ls'
and `grep', and with the git-config color options.  Note that, without
an argument, --color and --no-color work exactly as before.

To implement this, two internal changes were made:

1. Allow the first argument of git_config_colorbool() to be NULL,
   in which case it returns -1 if the argument isn't "always", "never",
   or "auto".

2. Add OPT_COLOR_FLAG(), OPT__COLOR(), and parse_opt_color_flag_cb()
   to the option parsing library.  The callback uses
   git_config_colorbool(), so color.h is now a dependency
   of parse-options.c.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---

The first version is in pu, so here's an update that addresses the issues.  It
still needs a test.  I'll try to use Jonathan Nieder's pager tests as a start.

 Documentation/diff-options.txt                |    4 +++-
 Documentation/git-branch.txt                  |    6 ++++--
 Documentation/git-grep.txt                    |    6 ++++--
 Documentation/git-show-branch.txt             |    6 ++++--
 Documentation/technical/api-parse-options.txt |   12 ++++++++++++
 builtin-branch.c                              |    2 +-
 builtin-grep.c                                |    2 +-
 builtin-show-branch.c                         |    4 ++--
 color.c                                       |    3 +++
 diff.c                                        |    9 +++++++++
 parse-options.c                               |   17 +++++++++++++++++
 parse-options.h                               |    7 +++++++
 12 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 8707d0e..60e922e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -117,12 +117,14 @@ any of those replacements occurred.
 	option and lists the commits in that commit range like the 'summary'
 	option of linkgit:git-submodule[1] does.
 
---color::
+--color[=<when>]::
 	Show colored diff.
+	The value must be always (the default), never, or auto.
 
 --no-color::
 	Turn off colored diff, even when the configuration file
 	gives the default to color output.
+	Same as `--color=never`.
 
 --color-words[=<regex>]::
 	Show colored word diff, i.e., color words which have changed.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 6b6c3da..903a690 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,7 +8,7 @@ git-branch - List, create, or delete branches
 SYNOPSIS
 --------
 [verse]
-'git branch' [--color | --no-color] [-r | -a]
+'git branch' [--color[=<when>] | --no-color] [-r | -a]
 	[-v [--abbrev=<length> | --no-abbrev]]
 	[(--merged | --no-merged | --contains) [<commit>]]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
@@ -84,12 +84,14 @@ OPTIONS
 -M::
 	Move/rename a branch even if the new branch name already exists.
 
---color::
+--color[=<when>]::
 	Color branches to highlight current, local, and remote branches.
+	The value must be always (the default), never, or auto.
 
 --no-color::
 	Turn off branch colors, even when the configuration file gives the
 	default to color output.
+	Same as `--color=never`.
 
 -r::
 	List or delete (if used with -d) the remote-tracking branches.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index e019e76..70c7ef9 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 	   [-z | --null]
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
-	   [--color | --no-color]
+	   [--color[=<when>] | --no-color]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...] [<tree>...]
@@ -111,12 +111,14 @@ OPTIONS
 	Instead of showing every matched line, show the number of
 	lines that match.
 
---color::
+--color[=<when>]::
 	Show colored matches.
+	The value must be always (the default), never, or auto.
 
 --no-color::
 	Turn off match highlighting, even when the configuration file
 	gives the default to color output.
+	Same as `--color=never`.
 
 -[ABC] <context>::
 	Show `context` trailing (`A` -- after), or leading (`B`
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 7343361..519f9e1 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git show-branch' [-a|--all] [-r|--remotes] [--topo-order | --date-order]
-		[--current] [--color | --no-color] [--sparse]
+		[--current] [--color[=<when>] | --no-color] [--sparse]
 		[--more=<n> | --list | --independent | --merge-base]
 		[--no-name | --sha1-name] [--topics]
 		[<rev> | <glob>]...
@@ -117,13 +117,15 @@ OPTIONS
 	When no explicit <ref> parameter is given, it defaults to the
 	current branch (or `HEAD` if it is detached).
 
---color::
+--color[=<when>]::
 	Color the status sign (one of these: `*` `!` `+` `-`) of each commit
 	corresponding to the branch it's in.
+	The value must be always (the default), never, or auto.
 
 --no-color::
 	Turn off colored output, even when the configuration file gives the
 	default to color output.
+	Same as `--color=never`.
 
 Note that --more, --list, --independent and --merge-base options
 are mutually exclusive.
diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 50f9e9a..312e3b2 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -115,6 +115,9 @@ There are some macros to easily define options:
 `OPT__ABBREV(&int_var)`::
 	Add `\--abbrev[=<n>]`.
 
+`OPT__COLOR(&int_var, description)`::
+	Add `\--color[=<when>]` and `--no-color`.
+
 `OPT__DRY_RUN(&int_var)`::
 	Add `-n, \--dry-run`.
 
@@ -183,6 +186,15 @@ There are some macros to easily define options:
 	arguments.  Short options that happen to be digits take
 	precedence over it.
 
+`OPT_COLOR_FLAG(short, long, &int_var, description)`::
+	Introduce an option that takes an optional argument that can
+	have one of three values: "always", "never", or "auto".  If the
+	argument is not given, it defaults to "always".  The `--no-` form
+	works like `--long=never`; it cannot take an argument.  If
+	"always", set `int_var` to 1; if "never", set `int_var` to 0; if
+	"auto", set `int_var` to 1 if stdout is a tty or a pager,
+	0 otherwise.
+
 
 The last element of the array must be `OPT_END()`.
 
diff --git a/builtin-branch.c b/builtin-branch.c
index a28a139..6cf7e72 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -610,7 +610,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			BRANCH_TRACK_EXPLICIT),
 		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
 			BRANCH_TRACK_OVERRIDE),
-		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
+		OPT__COLOR(&branch_use_color, "use colored output"),
 		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
 		{
diff --git a/builtin-grep.c b/builtin-grep.c
index 26d4deb..00cbd90 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -782,7 +782,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			"print NUL after filenames"),
 		OPT_BOOLEAN('c', "count", &opt.count,
 			"show the number of matches instead of matching lines"),
-		OPT_SET_INT(0, "color", &opt.color, "highlight matches", 1),
+		OPT__COLOR(&opt.color, "highlight matches"),
 		OPT_GROUP(""),
 		OPT_CALLBACK('C', NULL, &opt, "n",
 			"show <n> context lines before and after matches",
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 9f13caa..32d862a 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -6,7 +6,7 @@
 #include "parse-options.h"
 
 static const char* show_branch_usage[] = {
-    "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [<rev> | <glob>]...",
+    "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color[=<when>] | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [<rev> | <glob>]...",
     "git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]",
     NULL
 };
@@ -661,7 +661,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			    "show remote-tracking and local branches"),
 		OPT_BOOLEAN('r', "remotes", &all_remotes,
 			    "show remote-tracking branches"),
-		OPT_BOOLEAN(0, "color", &showbranch_use_color,
+		OPT__COLOR(&showbranch_use_color,
 			    "color '*!+-' corresponding to the branch"),
 		{ OPTION_INTEGER, 0, "more", &extra, "n",
 			    "show <n> more commits after the common ancestor",
diff --git a/color.c b/color.c
index 62977f4..8f07fc9 100644
--- a/color.c
+++ b/color.c
@@ -138,6 +138,9 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 			goto auto_color;
 	}
 
+	if (!var)
+		return -1;
+
 	/* Missing or explicit false to turn off colorization */
 	if (!git_config_bool(var, value))
 		return 0;
diff --git a/diff.c b/diff.c
index 381cc8d..8f645f6 100644
--- a/diff.c
+++ b/diff.c
@@ -2826,6 +2826,15 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
 	else if (!strcmp(arg, "--color"))
 		DIFF_OPT_SET(options, COLOR_DIFF);
+	else if (!prefixcmp(arg, "--color=")) {
+		int value = git_config_colorbool(NULL, arg+8, -1);
+		if (value == 0)
+			DIFF_OPT_CLR(options, COLOR_DIFF);
+		else if (value > 0)
+			DIFF_OPT_SET(options, COLOR_DIFF);
+		else
+			return error("option `color' expects \"always\", \"auto\", or \"never\"");
+	}
 	else if (!strcmp(arg, "--no-color"))
 		DIFF_OPT_CLR(options, COLOR_DIFF);
 	else if (!strcmp(arg, "--color-words")) {
diff --git a/parse-options.c b/parse-options.c
index d218122..22da9be 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -2,6 +2,7 @@
 #include "parse-options.h"
 #include "cache.h"
 #include "commit.h"
+#include "color.h"
 
 static int parse_options_usage(const char * const *usagestr,
 			       const struct option *opts);
@@ -599,6 +600,22 @@ int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
 	return 0;
 }
 
+int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
+			    int unset)
+{
+	int value;
+	if (unset && arg)
+		return opterror(opt, "takes no value", OPT_UNSET);
+	if (!arg)
+		arg = unset ? "never" : (const char *)opt->defval;
+	value = git_config_colorbool(NULL, arg, -1);
+	if (value < 0)
+		return opterror(opt,
+			"expects \"always\", \"auto\", or \"never\"", 0);
+	*(int *)opt->value = value;
+	return 0;
+}
+
 int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
 			   int unset)
 {
diff --git a/parse-options.h b/parse-options.h
index 0c99691..9429f7e 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -135,6 +135,10 @@ struct option {
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
 #define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), \
 				       "FILE", (h) }
+#define OPT_COLOR_FLAG(s, l, v, h) \
+	{ OPTION_CALLBACK, (s), (l), (v), "when", (h), PARSE_OPT_OPTARG, \
+		parse_opt_color_flag_cb, (intptr_t)"always" }
+
 
 /* parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[].
@@ -187,6 +191,7 @@ extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
 extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
+extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 extern int parse_opt_with_commit(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
@@ -203,5 +208,7 @@ extern int parse_opt_tertiary(const struct option *, const char *, int);
 	{ OPTION_CALLBACK, 0, "abbrev", (var), "n", \
 	  "use <n> digits to display SHA-1s", \
 	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
+#define OPT__COLOR(var, h) \
+	OPT_COLOR_FLAG(0, "color", (var), (h))
 
 #endif
-- 
1.7.0
