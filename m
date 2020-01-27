Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A65C32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 10:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1760820661
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 10:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgA0KQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:16:59 -0500
Received: from unsecure-smtp.soverin.net ([94.130.159.241]:34680 "EHLO
        g02sm02.soverin.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725990AbgA0KQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 05:16:59 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jan 2020 05:16:56 EST
Received: from soverin.net by soverin.net
From:   Zeger-Jan van de Weg <git@zjvandeweg.nl>
To:     git@vger.kernel.org
Cc:     Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: [PATCH v2 1/1] config: learn the --stdin option for instructions
Date:   Mon, 27 Jan 2020 11:09:33 +0100
Message-Id: <20200127100933.10765-2-git@zjvandeweg.nl>
In-Reply-To: <20200127100933.10765-1-git@zjvandeweg.nl>
References: <20200127100933.10765-1-git@zjvandeweg.nl>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at g02sm02
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When setting values in the git config, the value is part of the
arguments for execution. This potentially leaks the value through
logging, or other programs like `ps`.

Add the `--stdin` option that reads from stdin for instructions to set
and unset values to hide them from prying eyes. The instructions are based
on the `update-ref` DSL, and accept the set and unset commands.

Signed-off-by: Zeger-Jan van de Weg <git@zjvandeweg.nl>
---
 Documentation/git-config.txt |  29 ++++++++++
 builtin/config.c             | 104 +++++++++++++++++++++++++++++++++++
 t/t1300-config.sh            |  60 ++++++++++++++++++++
 3 files changed, 193 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 899e92a1c9..9f7462284d 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -23,6 +23,7 @@ SYNOPSIS
 'git config' [<file-option>] [--show-origin] [-z|--null] [--name-only] -l | --list
 'git config' [<file-option>] --get-color name [default]
 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
+'git config' [<file-option>] [-z|--null] --stdin
 'git config' [<file-option>] -e | --edit
 
 DESCRIPTION
@@ -212,6 +213,10 @@ Valid `<type>`'s include:
 	output without getting confused e.g. by values that
 	contain line breaks.
 
+--stdin::
+	Instructions are read from the standard input, instead of the command
+	line interface. Refer to the STDIN section.
+
 --name-only::
 	Output only the names of config variables for `--list` or
 	`--get-regexp`.
@@ -259,6 +264,30 @@ Valid `<type>`'s include:
   When using `--get`, and the requested variable is not found, behave as if
   <value> were the value assigned to the that variable.
 
+STDIN
+-----
+
+With `--stdin`, config reads instructions from standard input and performs
+all modifications in sequence.
+
+Specify commands of the form:
+
+	set SP <key> SP <newvalue>
+	unset SP <key>
+
+Alternatively, use `-z` or `--null` to specify in NUL-terminated format, without
+quoting:
+
+	set SP <key> NULL <newvalue>
+	unset SP <key>
+
+set::
+	Set or update the value for <key> to <newvalue>.
+
+unset:
+	Remove the value from the configuration by <key>, when the <key> isn't
+	present in the configuration no error is returned.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
diff --git a/builtin/config.c b/builtin/config.c
index 98d65bc0ad..a449b00b65 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -50,6 +50,7 @@ static int show_origin;
 #define ACTION_GET_COLOR (1<<13)
 #define ACTION_GET_COLORBOOL (1<<14)
 #define ACTION_GET_URLMATCH (1<<15)
+#define ACTION_STDIN (1<<16)
 
 /*
  * The actions "ACTION_LIST | ACTION_GET_*" which may produce more than
@@ -143,6 +144,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
+	OPT_BIT(0, "stdin", &actions, N_("input changes from stdin"), ACTION_STDIN),
 	OPT_GROUP(N_("Type")),
 	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
 	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
@@ -594,6 +596,102 @@ static char *default_user_config(void)
 	return strbuf_detach(&buf, NULL);
 }
 
+static char *parse_key_or_value(const char **next, const char *max_char) {
+	struct strbuf token = STRBUF_INIT;
+
+	if (term) {
+		if (**next == '"') {
+			const char **orig = next;
+
+			if (unquote_c_style(&token, *next, next))
+				die("badly quoted argument: %s", *orig);
+			if (*next && !isspace(**next))
+				die("unexpected character after quoted argument: %s", *orig);
+		} else {
+			while (*next && !isspace(**next)) {
+				if (*next > max_char)
+					die("unexpected end of buffer");
+
+				strbuf_addch(&token, *(*next)++);
+			}
+		}
+
+		(*next)++;
+	} else {
+		strbuf_addstr(&token, *next);
+		*next += token.len + 1;
+	}
+
+	return strbuf_detach(&token, NULL);
+}
+
+static const char *parse_cmd_set(const char *next, const char *max_char)
+{
+	char *key, *value;
+	int ret;
+
+	key = parse_key_or_value(&next, max_char);
+	if (!key)
+		die(_("set: missing key"));
+
+	value = parse_key_or_value(&next, max_char);
+	if (!value)
+		die(_("set: missing value"));
+
+	ret = git_config_set_in_file_gently(given_config_source.file, key, value);
+	if (ret)
+		die(_("cannot set key value pair: %d"), ret);
+
+	free(key);
+	free(value);
+	return next;
+}
+
+
+static const char *parse_cmd_unset(const char *next, const char *max_char)
+{
+	char *key;
+	int ret;
+
+	key = parse_key_or_value(&next, max_char);
+	if (!key)
+		die(_("no key found to unset"));
+
+	ret = git_config_set_in_file_gently(given_config_source.file, key, NULL);
+	if (ret)
+		die(_("cannot unset key: %d"), ret);
+
+	free(key);
+	return next;
+}
+
+static void update_config_stdin()
+{
+	struct strbuf input = STRBUF_INIT;
+	const char *next;
+	const char *max_char;
+
+	if (strbuf_read(&input, 0, 1000) < 0)
+		die_errno(_("could not read from stdin"));
+	next = input.buf;
+
+	max_char = input.buf + input.len;
+	while(next < max_char) {
+		if (*next == term)
+			die(_("empty command in input"));
+		else if (isspace(*next))
+			die(_("whitespace before command"));
+		else if (skip_prefix(next, "set ", &next))
+			next = parse_cmd_set(next, max_char);
+		else if (skip_prefix(next, "unset ", &next))
+			next = parse_cmd_unset(next, max_char);
+		else
+			die(_("unknown command %s"), next);
+	}
+
+	strbuf_release(&input);
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = !startup_info->have_repository;
@@ -867,6 +965,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			color_stdout_is_tty = git_config_bool("command line", argv[1]);
 		return get_colorbool(argv[0], argc == 2);
 	}
+	else if (actions == ACTION_STDIN) {
+		check_write();
+		check_argc(argc, 0, 0);
+
+		update_config_stdin();
+	}
 
 	return 0;
 }
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 983a0a1583..d8ad82922d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -380,6 +380,66 @@ test_expect_success '--add' '
 	test_cmp expect output
 '
 
+test_expect_success '--stdin to set a value' '
+	echo "set foo.mepmep true" | git config --stdin &&
+	git config --get foo.mepmep >output &&
+	echo true >expect &&
+	test_cmp expect output
+'
+
+test_expect_success '--stdin multiline support' '
+	cat >stdin <<-EOF &&
+	set bar.mepmep true
+	set foo.mepmep true
+	EOF
+	git config --stdin <stdin &&
+	git config --get bar.mepmep >output &&
+	git config --get foo.mepmep >>output &&
+	echo -e "true\ntrue" > expect &&
+	test_cmp expect output
+'
+
+test_expect_success '--stdin hides input on errors' '
+	cat >stdin <<-EOF &&
+	set bar.mepmep
+	EOF
+	test_must_fail git config --stdin <stdin 2>output &&
+	echo "fatal: unexpected end of buffer" >expect &&
+	test_cmp expect output
+'
+
+test_expect_success '--stdin fails on leading whitespace' '
+	cat >stdin <<-EOF &&
+	 set bar.mepmep
+	EOF
+	test_must_fail git config --stdin <stdin
+'
+
+test_expect_success '--stdin fails on unknown command' '
+	cat >stdin <<-EOF &&
+	foo bar.mepmep
+	EOF
+	test_must_fail git config --stdin <stdin
+'
+
+test_expect_success '--stdin works on no input' '
+	echo -n "" | git config --stdin
+'
+
+test_expect_success '--stdin fails on unbalanced quotes' '
+	cat >stdin <<-EOF &&
+	set "foo.bar
+	EOF
+	test_must_fail git config --stdin <stdin
+'
+
+test_expect_success '--stdin with --null flag' '
+	echo -ne "set bar.baz\0false" | git config --stdin --null &&
+	git config --get bar.baz >output &&
+	echo false >expect &&
+	test_cmp expect output
+'
+
 cat > .git/config << EOF
 [novalue]
 	variable
-- 
2.24.1

