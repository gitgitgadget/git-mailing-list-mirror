Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DFF20C13
	for <e@80x24.org>; Tue, 28 Nov 2017 21:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753030AbdK1VnY (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 16:43:24 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:44936
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752829AbdK1VnX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 16:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1511905401;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=QcpU0R94shEAMXxQWi2IQBB8V7ueX/qDUmsNKuJZTnA=;
        b=KC3DXijhlEzx/9ytbXVmgHkO9SsY1wfyvv/bc5bTB87GvQARonJ9yAcOTygt1pPi
        IUgSpQzbi7BQYejBY4bZ/YYHFyop6j5MGIn6tSKS5VZMcylFLGfM6fx6gzslNhvZXPj
        qp83vY/Ij97OJorXWXxNRN6QTeQJji1eQf8q2KIA=
From:   Soukaina NAIT HMID <nhsoukaina@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016004959a28-410f021b-ac2b-4756-8e55-244071c074b5-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
References: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
Subject: [add-default-config] add --default option to git config.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Nov 2017 21:43:21 +0000
X-SES-Outgoing: 2017.11.28-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Soukaina NAIT HMID <snaithmid@bloomberg.net>

Signed-off-by: Soukaina NAIT HMID <snaithmid@bloomberg.net>
---
 Documentation/git-config.txt |   4 ++
 builtin/config.c             |  34 ++++++++-
 config.c                     |  10 +++
 config.h                     |   1 +
 t/t1300-repo-config.sh       | 161 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 209 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 4edd09fc6b074..5d5cd58fdae37 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -179,6 +179,10 @@ See also <<FILES>>.
 	specified user.  This option has no effect when setting the
 	value (but you can use `git config section.variable ~/`
 	from the command line to let your shell do the expansion).
+--color::
+	Find the color configured for `name` (e.g. `color.diff.new`) and
+	output it as the ANSI color escape sequence to the standard
+	output. 
 
 -z::
 --null::
diff --git a/builtin/config.c b/builtin/config.c
index d13daeeb55927..5e5b998b7c892 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -30,6 +30,7 @@ static int end_null;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
 static int show_origin;
+static const char *default_value;
 
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -52,6 +53,8 @@ static int show_origin;
 #define TYPE_INT (1<<1)
 #define TYPE_BOOL_OR_INT (1<<2)
 #define TYPE_PATH (1<<3)
+#define TYPE_COLOR (1<<4)
+
 
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
@@ -80,11 +83,13 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
 	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
 	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
+	OPT_BIT(0, "color", &types, N_("find the color configured"), TYPE_COLOR),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
+	OPT_STRING(0, "default", &default_value, N_("default-value"), N_("sets default value when no value is returned from config")),
 	OPT_END(),
 };
 
@@ -159,6 +164,13 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 				return -1;
 			strbuf_addstr(buf, v);
 			free((char *)v);
+		}
+		else if (types == TYPE_COLOR) {
+			char *v = xmalloc(COLOR_MAXLEN);
+			if (git_config_color(&v, key_, value_) < 0)
+				return -1;
+			strbuf_addstr(buf, v);
+			free((char *)v);
 		} else if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
@@ -244,8 +256,16 @@ static int get_value(const char *key_, const char *regex_)
 	config_with_options(collect_config, &values,
 			    &given_config_source, &config_options);
 
-	ret = !values.nr;
+	if (!values.nr && default_value && types) {
+		struct strbuf *item;
+		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
+		item = &values.items[values.nr++];
+		if(format_config(item, key_, default_value) < 0){
+			values.nr = 0;
+		}
+	}
 
+	ret = !values.nr;
 	for (i = 0; i < values.nr; i++) {
 		struct strbuf *buf = values.items + i;
 		if (do_all || i == values.nr - 1)
@@ -268,6 +288,7 @@ static int get_value(const char *key_, const char *regex_)
 	return ret;
 }
 
+
 static char *normalize_value(const char *key, const char *value)
 {
 	if (!value)
@@ -281,6 +302,17 @@ static char *normalize_value(const char *key, const char *value)
 		 * when retrieving the value.
 		 */
 		return xstrdup(value);
+	if (types == TYPE_COLOR)
+	{
+		char *v = xmalloc(COLOR_MAXLEN);
+		if (git_config_color(&v, key, value) == 0)
+		{
+			free((char *)v);
+			return xstrdup(value);
+		}
+		free((char *)v);
+		die("cannot parse color '%s'", value);
+	}
 	if (types == TYPE_INT)
 		return xstrfmt("%"PRId64, git_config_int64(key, value));
 	if (types == TYPE_BOOL)
diff --git a/config.c b/config.c
index 903abf9533b18..5c5daffeb6723 100644
--- a/config.c
+++ b/config.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "dir.h"
+#include "color.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -990,6 +991,15 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_color(char **dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	if (color_parse(value, *dest) < 0)
+		return -1;
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
diff --git a/config.h b/config.h
index a49d264416225..8f8ca6a9b0741 100644
--- a/config.h
+++ b/config.h
@@ -72,6 +72,7 @@ extern int git_config_rename_section(const char *, const char *);
 extern int git_config_rename_section_in_file(const char *, const char *, const char *);
 extern int git_config_copy_section(const char *, const char *);
 extern int git_config_copy_section_in_file(const char *, const char *, const char *);
+extern int git_config_color(char ** dest, const char *var, const char *value);
 extern const char *git_etc_gitconfig(void);
 extern int git_env_bool(const char *, int);
 extern unsigned long git_env_ulong(const char *, unsigned long);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 364a537000bbb..b5804ab05ee3a 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1558,4 +1558,165 @@ test_expect_success '--local requires a repo' '
 	test_expect_code 128 nongit git config --local foo.bar
 '
 
+boolean()
+{
+	slot=${3:-no.such.slot} &&
+	actual=$(git config --default "$1" --bool "$slot") &&
+	test "$actual" = "$2"
+}
+
+invalid_boolean()
+{
+	slot=${2:-no.such.slot} &&
+	test_must_fail git config --default "$1" --bool "$slot"
+}
+
+test_expect_success 'empty value for boolean' '
+	boolean "" "false"
+'
+
+test_expect_success 'true' '
+	boolean "true" "true"
+'
+
+test_expect_success '1 is true' '
+	boolean "1" "true"
+'
+
+test_expect_success 'non-zero is true' '
+	boolean "5312" "true"
+'
+
+test_expect_success 'false' '
+	boolean "false" "false"
+'
+
+test_expect_success '0 is false' '
+	boolean "0" "false"
+'
+
+test_expect_success 'invalid value' '
+	invalid_boolean "ab"
+'
+
+test_expect_success 'existing slot has priority = true' '
+	git config bool.value true &&
+	boolean "false" "true" "bool.value"
+'
+
+test_expect_success 'existing slot has priority = false' '
+	git config bool.value false &&
+	boolean "true" "false" "bool.value"
+'
+
+int()
+{
+	slot=${3:-no.such.slot} &&
+	actual=$(git config --default "$1" --int "$slot") &&
+	test "$actual" = "$2"
+}
+
+invalid_int()
+{
+	slot=${2:-no.such.slot} &&
+	test_must_fail git config "$1" --int "$slot"
+}
+
+test_expect_success 'empty value for int' '
+	invalid_int "" ""
+'
+
+test_expect_success 'positive' '
+	int "12345" "12345"
+'
+
+test_expect_success 'negative' '
+	int "-679032" "-679032"
+'
+
+test_expect_success 'invalid value' '
+	invalid_int "abc"
+'
+test_expect_success 'existing slot has priority = 123' '
+	git config int.value 123 &&
+	int "666" "123" "int.value"
+'
+
+test_expect_success 'existing slot with bad value' '
+	git config int.value abc &&
+	invalid_int "123" "int.value"
+'
+
+path()
+{
+	slot=${3:-no.such.slot} &&
+	actual=$(git config --default "$1" --path "$slot") &&
+	test "$actual" = "$2"
+}
+
+invalid_path()
+{
+	slot=${2:-no.such.slot} &&
+	test_must_fail git config "$1" --path "$slot"
+}
+
+test_expect_success 'empty path is invalid' '
+	invalid_path "" ""
+'
+
+test_expect_success 'valid path' '
+	path "/aa/bb/cc" "/aa/bb/cc"
+'
+
+test_expect_success 'existing slot has priority = /to/the/moon' '
+	git config path.value /to/the/moon &&
+	path "/to/the/sun" "/to/the/moon" "path.value"
+'
+ESC=$(printf '\033')
+
+color()
+{
+	slot=${3:-no.such.slot} &&
+	actual=$(git config --default "$1" --color "$slot" ) &&
+	test "$actual" = "${2:+$ESC}$2"
+}
+
+invalid_color()
+{
+	slot=${2:-no.such.slot} &&
+	test_must_fail git config --default "$1" --color "$slot"
+}
+
+test_expect_success 'reset' '
+	color "reset" "[m"
+'
+
+test_expect_success 'empty color is empty' '
+	color "" ""
+'
+
+test_expect_success 'absurdly long color specification' '
+	color \
+	  "#ffffff #ffffff bold nobold dim nodim italic noitalic
+	   ul noul blink noblink reverse noreverse strike nostrike" \
+	  "[1;2;3;4;5;7;9;22;23;24;25;27;29;38;2;255;255;255;48;2;255;255;255m"
+'
+
+test_expect_success 'color too small' '
+	invalid_color "-2"
+'
+
+test_expect_success 'color too big' '
+	invalid_color "256"
+'
+
+test_expect_success 'extra character after color name' '
+	invalid_color "redX"
+'
+
+test_expect_success 'existing slot has priority = red' '
+	git config color.value red &&
+	color "blue" "[31m" "color.value"
+'
+
 test_done

--
https://github.com/git/git/pull/431
