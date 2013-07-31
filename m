From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 6/6] config: "git config --get-urlmatch" parses section.<url>.key
Date: Wed, 31 Jul 2013 12:26:08 -0700
Message-ID: <1375298768-7740-7-git-send-email-gitster@pobox.com>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com>
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 21:26:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4c2m-0006eE-LB
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 21:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757044Ab3GaT0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 15:26:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50344 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932179Ab3GaT0i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 15:26:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F2E2357DE;
	Wed, 31 Jul 2013 19:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=r88+
	/zAZvbpmYja7sLaWVOS0iNw=; b=MCiWkMAdYYcnLU14n9BSBWMLcwGx+XCQLbjP
	SAqcoIxAr0871D91alWx24ENBdcRTsKbQPuUFzeJKwC5b5ddfZb5+Yxrm/S7ATGm
	QfRR3mcMyoNbMzV1NeJdPOg4JKlAQFhV0pWldmkv/xz8bfxufVEd+RqLBIVdLziK
	8c6qZ34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ixi+GAeCAZCTQyr9wVfsz/TagulBnCHd1PkiQO62Z0xEhAvdW0uxHEnR+Pv0TY3O
	7IGlvt+1EQcy8ypoa43V6yhy/IelXSgqbSaJPfIYlVs82nxuCrnYUzY6rgUnS+eX
	Fgp0c9/IB4TLGq5bRnIIOLcjg1gF0iwJOtrKv/AIHIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E414357DB;
	Wed, 31 Jul 2013 19:26:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE8CF357D0;
	Wed, 31 Jul 2013 19:26:33 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc0-153-g9820077
In-Reply-To: <1375298768-7740-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1C6275DE-FA17-11E2-B340-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231449>

Using the same urlmatch_config_entry() infrastructure, add a new
mode "--get-urlmatch" to the "git config" command, to learn values
for the "virtual" two-level variables customized for the specific
URL.

    git config [--<type>] --get-urlmatch <section>[.<key>] <url>

With <section>.<key> fully specified, the configuration data for
<section>.<urlpattern>.<key> for <urlpattern> that best matches the
given <url> is sought (and if not found, <section>.<key> is used)
and reported.  For example, with this configuration:

    [http]
        sslVerify
    [http "https://weak.example.com"]
        cookieFile = /tmp/cookie.txt
        sslVerify = false

You would get

    $ git config --bool --get-urlmatch http.sslVerify https://good.example.com
    true
    $ git config --bool --get-urlmatch http.sslVerify https://weak.example.com
    false

With only <section> specified, you can get a list of all variables
in the section with their values that apply to the given URL.  E.g

    $ git config --get-urlmatch http https://weak.example.com
    http.cookiefile /tmp/cookie.txt
    http.sslverify false

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-config.txt | 29 ++++++++++++++
 builtin/config.c             | 92 ++++++++++++++++++++++++++++++++++++++++++++
 t/t1300-repo-config.sh       | 25 ++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index d88a6fc..b48e2ec 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git config' [<file-option>] [type] [-z|--null] --get name [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-all name [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [type] [-z|--null] --get-urlmatch name URL
 'git config' [<file-option>] --unset name [value_regex]
 'git config' [<file-option>] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
@@ -95,6 +96,14 @@ OPTIONS
 	in which section and variable names are lowercased, but subsection
 	names are not.
 
+--get-urlmatch name URL::
+	When given a two-part name section.key, the value for
+	section.<url>.key whose <url> part matches the best to the
+	given URL is returned (if no such key exists, the value for
+	section.key is used as a fallback).  When given just the
+	section as name, do so for all the keys in the section and
+	list them.
+
 --global::
 	For writing options: write to global ~/.gitconfig file rather than
 	the repository .git/config, write to $XDG_CONFIG_HOME/git/config file
@@ -273,6 +282,13 @@ Given a .git/config like this:
 		gitproxy=proxy-command for kernel.org
 		gitproxy=default-proxy ; for all the rest
 
+	; HTTP
+	[http]
+		sslVerify
+	[http "https://weak.example.com"]
+		sslVerify = false
+		cookieFile = /tmp/cookie.txt
+
 you can set the filemode to true with
 
 ------------
@@ -358,6 +374,19 @@ RESET=$(git config --get-color "" "reset")
 echo "${WS}your whitespace color or blue reverse${RESET}"
 ------------
 
+For URLs in `https://weak.example.com`, `http.sslVerify` is set to
+false, while it is set to `true` for all others:
+
+------------
+% git config --bool --get-urlmatch http.sslverify https://good.example.com
+true
+% git config --bool --get-urlmatch http.sslverify https://weak.example.com
+false
+% git config --get-urlmatch http https://weak.example.com
+http.cookiefile /tmp/cookie.txt
+http.sslverify false
+------------
+
 include::config.txt[]
 
 GIT
diff --git a/builtin/config.c b/builtin/config.c
index 12c5073..c35c5be 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "color.h"
 #include "parse-options.h"
+#include "urlmatch.h"
 
 static const char *const builtin_config_usage[] = {
 	N_("git config [options]"),
@@ -41,6 +42,7 @@ static int respect_includes = -1;
 #define ACTION_SET_ALL (1<<12)
 #define ACTION_GET_COLOR (1<<13)
 #define ACTION_GET_COLORBOOL (1<<14)
+#define ACTION_GET_URLMATCH (1<<15)
 
 #define TYPE_BOOL (1<<0)
 #define TYPE_INT (1<<1)
@@ -57,6 +59,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTION_GET),
 	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]"), ACTION_GET_ALL),
 	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex [value-regex]"), ACTION_GET_REGEXP),
+	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: section[.var] URL"), ACTION_GET_URLMATCH),
 	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: name value [value_regex]"), ACTION_REPLACE_ALL),
 	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_ADD),
 	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-regex]"), ACTION_UNSET),
@@ -348,6 +351,91 @@ static int get_colorbool(int print)
 		return get_colorbool_found ? 0 : 1;
 }
 
+struct urlmatch_current_candidate_value {
+	char value_is_null;
+	struct strbuf value;
+};
+
+static int urlmatch_collect_fn(const char *var, const char *value, void *cb)
+{
+	struct string_list *values = cb;
+	struct string_list_item *item = string_list_insert(values, var);
+	struct urlmatch_current_candidate_value *matched = item->util;
+
+	if (!matched) {
+		matched = xmalloc(sizeof(*matched));
+		strbuf_init(&matched->value, 0);
+		item->util = matched;
+	} else {
+		strbuf_reset(&matched->value);
+	}
+
+	if (value) {
+		strbuf_addstr(&matched->value, value);
+		matched->value_is_null = 0;
+	} else {
+		matched->value_is_null = 1;
+	}
+	return 0;
+}
+
+static int get_urlmatch(const char *var, const char *url)
+{
+	const char *section_tail;
+	struct string_list_item *item;
+	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
+	struct string_list values = STRING_LIST_INIT_DUP;
+
+	config.collect_fn = urlmatch_collect_fn;
+	config.cascade_fn = NULL;
+	config.cb = &values;
+
+	if (!url_normalize(url, &config.url))
+		die(config.url.err);
+
+	section_tail = strchr(var, '.');
+	if (section_tail) {
+		config.section = xmemdupz(var, section_tail - var);
+		config.key = strrchr(var, '.') + 1;
+		show_keys = 0;
+	} else {
+		config.section = var;
+		config.key = NULL;
+		show_keys = 1;
+	}
+
+	git_config_with_options(urlmatch_config_entry, &config,
+				given_config_file, respect_includes);
+
+	for_each_string_list_item(item, &values) {
+		struct urlmatch_current_candidate_value *matched = item->util;
+		struct strbuf key = STRBUF_INIT;
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_addstr(&key, item->string);
+		format_config(&buf, key.buf,
+			      matched->value_is_null ? NULL : matched->value.buf);
+		fwrite(buf.buf, 1, buf.len, stdout);
+		strbuf_release(&key);
+		strbuf_release(&buf);
+
+		strbuf_release(&matched->value);
+	}
+	string_list_clear(&config.vars, 1);
+	string_list_clear(&values, 1);
+	free(config.url.url);
+
+	/*
+	 * section name may have been copied to replace the dot, in which
+	 * case it needs to be freed.  key name is either NULL (e.g. 'http'
+	 * alone) or points into var (e.g. 'http.savecookies'), and we do
+	 * not own the storage.
+	 */
+	if (config.section != var)
+		free((void *)config.section);
+	return 0;
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = !startup_info->have_repository;
@@ -499,6 +587,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		return get_value(argv[0], argv[1]);
 	}
+	else if (actions == ACTION_GET_URLMATCH) {
+		check_argc(argc, 2, 2);
+		return get_urlmatch(argv[0], argv[1]);
+	}
 	else if (actions == ACTION_UNSET) {
 		check_argc(argc, 1, 2);
 		if (argc == 2)
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index c4a7d84..323e880 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1087,6 +1087,31 @@ test_expect_success 'barf on incomplete string' '
 	grep " line 3 " error
 '
 
+test_expect_success 'urlmatch' '
+	cat >.git/config <<-\EOF &&
+	[http]
+		sslVerify
+	[http "https://weak.example.com"]
+		sslVerify = false
+		cookieFile = /tmp/cookie.txt
+	EOF
+
+	echo true >expect &&
+	git config --bool --get-urlmatch http.sslverify https://good.example.com >actual &&
+	test_cmp expect actual &&
+
+	echo false >expect &&
+	git config --bool --get-urlmatch http.sslverify https://weak.example.com >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo http.cookiefile /tmp/cookie.txt &&
+		echo http.sslverify false
+	} >expect &&
+	git config --get-urlmatch http https://weak.example.com >actual &&
+	test_cmp expect actual
+'
+
 # good section hygiene
 test_expect_failure 'unsetting the last key in a section removes header' '
 	cat >.git/config <<-\EOF &&
-- 
1.8.4-rc0-153-g9820077
