From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 04/13] Add git-column and column mode parsing
Date: Fri,  3 Feb 2012 20:34:29 +0700
Message-ID: <1328276078-27955-5-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 14:31:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtJEh-000838-SY
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 14:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366Ab2BCNbQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 08:31:16 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47389 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361Ab2BCNbM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 08:31:12 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so2900162pbd.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 05:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/wfolRQIRRomBcCrnaMs8tAx46LEj2EfiZXXrcLsNMk=;
        b=XWJbODNUPPkVMBGvclFweh9zb0b+voX5/2amRBRc/DO2EhcRkqChVunRn5gEyqgt1D
         T+ey5XSr5cre2J6/gv1IwIVMDMAyrSDqNTET9XFD1FY2WqkEm68AU20QQfV3k24qkARf
         yeluaFpnUrjY3R6L8sY0UducuaafwcmLTbOjE=
Received: by 10.68.74.167 with SMTP id u7mr17510294pbv.103.1328275872020;
        Fri, 03 Feb 2012 05:31:12 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id o7sm13119489pbq.8.2012.02.03.05.31.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 05:31:10 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 03 Feb 2012 20:35:20 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189763>

A column option string consists of many token separated by either
space of commas. A token belongs to one of three groups:

 - enabling: always, never and auto
 - layout mode: to be implemented
 - other tuning, which could be negated be prefix 'no'

A command line option without argument (e.g. --column) will enable
column output and reuse existing settings (layout mode and options..).
--no-column disables columnar output.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                   |    1 +
 Documentation/git-column.txt |   49 ++++++++++++++++
 Makefile                     |    1 +
 builtin.h                    |    1 +
 builtin/column.c             |   41 ++++++++++++++
 column.c                     |  125 ++++++++++++++++++++++++++++++++++=
++++++++
 column.h                     |    6 ++
 command-list.txt             |    1 +
 git.c                        |    1 +
 parse-options.h              |    2 +
 t/t9002-column.sh            |   27 +++++++++
 11 files changed, 255 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-column.txt
 create mode 100644 builtin/column.c
 create mode 100755 t/t9002-column.sh

diff --git a/.gitignore b/.gitignore
index 3b7680e..039e5ef 100644
--- a/.gitignore
+++ b/.gitignore
@@ -26,6 +26,7 @@
 /git-cherry-pick
 /git-clean
 /git-clone
+/git-column
 /git-commit
 /git-commit-tree
 /git-config
diff --git a/Documentation/git-column.txt b/Documentation/git-column.tx=
t
new file mode 100644
index 0000000..508b85f
--- /dev/null
+++ b/Documentation/git-column.txt
@@ -0,0 +1,49 @@
+git-column(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-column - Display data in columns
+
+SYNOPSIS
+--------
+[verse]
+'git column' [--mode=3D<mode> | --rawmode=3D<n>] [--width=3D<width>]
+	     [--indent=3D<string>] [--nl=3D<string>] [--pading=3D<n>]
+
+DESCRIPTION
+-----------
+This command formats its input into multiple columns.
+
+OPTIONS
+-------
+--mode=3D<mode>::
+	Specify layout mode. See configuration variable column.ui for option
+	syntax.
+
+--rawmode=3D<n>::
+	Same as --mode but take mode encoded as a number. This is mainly used
+	by other commands that have already parsed layout mode.
+
+--width=3D<width>::
+	Specify the terminal width. By default 'git column' will detect the
+	terminal width, or fall back to 80 if it is unable to do so.
+
+--indent=3D<string>::
+	String to be printed at the beginning of each line.
+
+--nl=3D<N>::
+	String to be printed at the end of each line,
+	including newline character.
+
+--padding=3D<N>::
+	The number of spaces between columns. One space by default.
+
+
+Author
+------
+Written by Nguyen Thai Ngoc Duy <pclouds@gmail.com>
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 5f0531b..92700ca 100644
--- a/Makefile
+++ b/Makefile
@@ -766,6 +766,7 @@ BUILTIN_OBJS +=3D builtin/checkout-index.o
 BUILTIN_OBJS +=3D builtin/checkout.o
 BUILTIN_OBJS +=3D builtin/clean.o
 BUILTIN_OBJS +=3D builtin/clone.o
+BUILTIN_OBJS +=3D builtin/column.o
 BUILTIN_OBJS +=3D builtin/commit-tree.o
 BUILTIN_OBJS +=3D builtin/commit.o
 BUILTIN_OBJS +=3D builtin/config.o
diff --git a/builtin.h b/builtin.h
index 857b9c8..338f540 100644
--- a/builtin.h
+++ b/builtin.h
@@ -61,6 +61,7 @@ extern int cmd_cherry(int argc, const char **argv, co=
nst char *prefix);
 extern int cmd_cherry_pick(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_clone(int argc, const char **argv, const char *prefix);
 extern int cmd_clean(int argc, const char **argv, const char *prefix);
+extern int cmd_column(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_commit(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_commit_tree(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_config(int argc, const char **argv, const char *prefix)=
;
diff --git a/builtin/column.c b/builtin/column.c
new file mode 100644
index 0000000..c4a0431
--- /dev/null
+++ b/builtin/column.c
@@ -0,0 +1,41 @@
+#include "builtin.h"
+#include "cache.h"
+#include "strbuf.h"
+#include "parse-options.h"
+#include "string-list.h"
+#include "column.h"
+
+static const char * const builtin_column_usage[] =3D {
+	"git column [options]",
+	NULL
+};
+static int colopts;
+
+int cmd_column(int argc, const char **argv, const char *prefix)
+{
+	struct string_list list =3D STRING_LIST_INIT_DUP;
+	struct strbuf sb =3D STRBUF_INIT;
+	struct column_options copts;
+	struct option options[] =3D {
+		OPT_COLUMN(0, "mode", &colopts, "layout to use"),
+		OPT_INTEGER(0, "rawmode", &colopts, "layout to use"),
+		OPT_INTEGER(0, "width", &copts.width, "Maximum width"),
+		OPT_STRING(0, "indent", &copts.indent, "string", "Padding space on l=
eft border"),
+		OPT_INTEGER(0, "nl", &copts.nl, "Padding space on right border"),
+		OPT_INTEGER(0, "padding", &copts.padding, "Padding space between col=
umns"),
+		OPT_END()
+	};
+
+	memset(&copts, 0, sizeof(copts));
+	copts.width =3D term_columns();
+	copts.padding =3D 1;
+	argc =3D parse_options(argc, argv, "", options, builtin_column_usage,=
 0);
+	if (argc)
+		usage_with_options(builtin_column_usage, options);
+
+	while (!strbuf_getline(&sb, stdin, '\n'))
+		string_list_append(&list, sb.buf);
+
+	print_columns(&list, colopts, &copts);
+	return 0;
+}
diff --git a/column.c b/column.c
index 4ae98f3..bd15bea 100644
--- a/column.c
+++ b/column.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "column.h"
 #include "string-list.h"
+#include "parse-options.h"
=20
 #define MODE(mode) ((mode) & COL_MODE)
=20
@@ -52,3 +53,127 @@ void print_columns(const struct string_list *list, =
int mode,
 	}
 	die("BUG: invalid mode %d", MODE(mode));
 }
+
+struct colopt {
+	enum {
+		ENABLE,
+		MODE,
+		OPTION
+	} type;
+	const char *name;
+	int value;
+};
+
+/*
+ * Set COL_ENABLED and COL_ENABLED_SET. If 'set' is -1, check if
+ * stdout is tty.
+ */
+static int set_enable_bit(int *mode, int set, int stdout_is_tty)
+{
+	if (set < 0) {	/* auto */
+		if (stdout_is_tty < 0)
+			stdout_is_tty =3D isatty(1);
+		set =3D stdout_is_tty || (pager_in_use() && pager_use_color);
+	}
+	if (set)
+		*mode =3D *mode | COL_ENABLED | COL_ENABLED_SET;
+	else
+		*mode =3D (*mode & ~COL_ENABLED) | COL_ENABLED_SET;
+	return 0;
+}
+
+/*
+ * Set COL_MODE_*. mode is intially copied from column.ui. If
+ * COL_ENABLED_SET is not set, then neither 'always', 'never' nor
+ * 'auto' has been used. Default to 'always'.
+ */
+static int set_mode(int *mode, int value)
+{
+	*mode =3D (*mode & ~COL_MODE) | value;
+	if (!(*mode & COL_ENABLED_SET))
+		*mode |=3D COL_ENABLED | COL_ENABLED_SET;
+
+	return 0;
+}
+
+/* Set or unset other COL_* */
+static int set_option(int *mode, int opt, int set)
+{
+	if (set)
+		*mode |=3D opt;
+	else
+		*mode &=3D ~opt;
+	return 0;
+}
+
+static int parse_option(const char *arg, int len,
+			int *mode, int stdout_is_tty)
+{
+	struct colopt opts[] =3D {
+		{ ENABLE, "always",  1 },
+		{ ENABLE, "never",   0 },
+		{ ENABLE, "auto",   -1 },
+	};
+	int i, set, name_len;
+
+	for (i =3D 0; i < ARRAY_SIZE(opts); i++) {
+		if (opts[i].type =3D=3D OPTION) {
+			if (len > 2 && !strncmp(arg, "no", 2)) {
+				arg +=3D 2;
+				len -=3D 2;
+				set =3D 0;
+			}
+			else
+				set =3D 1;
+		}
+
+		name_len =3D strlen(opts[i].name);
+		if (len !=3D name_len ||
+		    strncmp(arg, opts[i].name, name_len))
+			continue;
+
+		switch (opts[i].type) {
+		case ENABLE: return set_enable_bit(mode, opts[i].value,
+						   stdout_is_tty);
+		case MODE: return set_mode(mode, opts[i].value);
+		case OPTION: return set_option(mode, opts[i].value, set);
+		default: die("BUG: Unknown option type %d", opts[i].type);
+		}
+	}
+
+	return error("unsupported style '%s'", arg);
+}
+
+int git_config_column(int *mode, const char *value,
+		      int stdout_is_tty)
+{
+	const char *sep =3D " ,";
+
+	while (*value) {
+		int len =3D strcspn(value, sep);
+		if (len) {
+			if (parse_option(value, len, mode, stdout_is_tty))
+				return -1;
+
+			value +=3D len;
+		}
+		value +=3D strspn(value, sep);
+	}
+	return 0;
+}
+
+int parseopt_column_callback(const struct option *opt,
+			     const char *arg, int unset)
+{
+	int *mode =3D opt->value;
+	if (unset) {
+		*mode =3D (*mode & ~COL_ENABLED) | COL_ENABLED_SET;
+		return 0;
+	}
+	if (arg)
+		return git_config_column(mode, arg, -1);
+
+	/* no arg, turn it on */
+	*mode |=3D COL_ENABLED | COL_ENABLED_SET;
+	return 0;
+}
diff --git a/column.h b/column.h
index e0f8c26..59f26dc 100644
--- a/column.h
+++ b/column.h
@@ -3,6 +3,7 @@
=20
 #define COL_MODE          0x000F
 #define COL_ENABLED      (1 << 4)
+#define COL_ENABLED_SET  (1 << 5)  /* Has COL_ENABLED been set by conf=
ig? */
=20
 struct column_options {
 	int width;
@@ -19,5 +20,10 @@ extern struct string_list_item *add_cell_to_list(str=
uct string_list *list,
 extern void print_cell(struct string_list *list, int mode, const char =
*string);
 extern void print_columns(const struct string_list *list,
 			  int mode, struct column_options *opts);
+extern int git_config_column(int *mode, const char *value, int stdout_=
is_tty);
+
+struct option;
+extern int parseopt_column_callback(const struct option *opt,
+				    const char *arg, int unset);
=20
 #endif
diff --git a/command-list.txt b/command-list.txt
index a36ee9b..fe06f15 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -20,6 +20,7 @@ git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
 git-clone                               mainporcelain common
+git-column                              purehelpers
 git-commit                              mainporcelain common
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
diff --git a/git.c b/git.c
index 3805616..419e3cc 100644
--- a/git.c
+++ b/git.c
@@ -348,6 +348,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "clone", cmd_clone },
+		{ "column", cmd_column },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config, RUN_SETUP_GENTLY },
diff --git a/parse-options.h b/parse-options.h
index 2e811dc..56fcafd 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -238,5 +238,7 @@ extern int parse_opt_noop_cb(const struct option *,=
 const char *, int);
 	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
 #define OPT__COLOR(var, h) \
 	OPT_COLOR_FLAG(0, "color", (var), (h))
+#define OPT_COLUMN(s, l, v, h) \
+	{ OPTION_CALLBACK, (s), (l), (v), "style", (h), PARSE_OPT_OPTARG, par=
seopt_column_callback }
=20
 #endif
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
new file mode 100755
index 0000000..b0b6d62
--- /dev/null
+++ b/t/t9002-column.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description=3D'git column'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	cat >lista <<\EOF
+one
+two
+three
+four
+five
+six
+seven
+eight
+nine
+ten
+eleven
+EOF
+'
+
+test_expect_success 'never' '
+	git column --mode=3Dnever <lista >actual &&
+	test_cmp lista actual
+'
+
+test_done
--=20
1.7.8.36.g69ee2
