From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH] Add git remote set-url
Date: Mon, 18 Jan 2010 19:18:02 +0200
Message-ID: <1263835082-21506-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 18:20:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWvGa-0007tr-AX
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 18:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab0ARRSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 12:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754871Ab0ARRSK
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 12:18:10 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:36075 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab0ARRSH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 12:18:07 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id E43CBC7C6C
	for <git@vger.kernel.org>; Mon, 18 Jan 2010 19:18:03 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0234EB0C57; Mon, 18 Jan 2010 19:18:03 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id A0D2F406C
	for <git@vger.kernel.org>; Mon, 18 Jan 2010 19:18:02 +0200 (EET)
X-Mailer: git-send-email 1.6.6.199.gff4b0
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137390>

Add 'git remote set-url' for changing URL of remote repository with
one "porcelain-level" command.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
Built atop master. Another one from my TODO list.

 Documentation/git-remote.txt |   17 ++++
 builtin-remote.c             |  100 +++++++++++++++++++
 t/t5505-remote.sh            |  216 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 332 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index c272c92..35d32f7 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -14,6 +14,9 @@ SYNOPSIS
 'git remote rename' <old> <new>
 'git remote rm' <name>
 'git remote set-head' <name> (-a | -d | <branch>)
+'git remote set-url' [--push] <name> <newurl> [<oldurl>]
+'git remote set-url --add' [--push] <name> <newurl>
+'git remote set-url --delete' [--push] <name> <url>
 'git remote' [-v | --verbose] 'show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
 'git remote' [-v | --verbose] 'update' [-p | --prune] [group | remote]...
@@ -101,6 +104,20 @@ remote set-head origin master" will set `$GIT_DIR/refs/remotes/origin/HEAD` to
 `refs/remotes/origin/master` already exists; if not it must be fetched first.
 +
 
+'set-url'::
+
+Changes URL remote points to. Sets first URL remote points to matching
+regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If
+<oldurl> doesn't match any URL, error occurs and nothing is changed.
++
+With '--push', push URLs are manipulated instead of fetch URLs.
++
+With '--add', instead of changing some URL, new URL is added.
++
+With '--delete', instead of changing some URL, all URLs matching
+regex <url> are deleted. Trying to delete all non-push URLs is an
+error.
+
 'show'::
 
 Gives some information about the remote <name>.
diff --git a/builtin-remote.c b/builtin-remote.c
index c4945b8..03ac7ee 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -16,6 +16,9 @@ static const char * const builtin_remote_usage[] = {
 	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
 	"git remote [-v | --verbose] update [-p | --prune] [group | remote]",
+	"git remote set-url <name> <newurl> [<oldurl>]",
+	"git remote set-url --add <name> <newurl>",
+	"git remote set-url --delete <name> <url>",
 	NULL
 };
 
@@ -54,12 +57,21 @@ static const char * const builtin_remote_update_usage[] = {
 	NULL
 };
 
+static const char * const builtin_remote_seturl_usage[] = {
+	"git remote set-url [--push] <name> <newurl> [<oldurl>]",
+	"git remote set-url --add <name> <newurl>",
+	"git remote set-url --delete <name> <url>",
+	NULL
+};
+
 #define GET_REF_STATES (1<<0)
 #define GET_HEAD_NAMES (1<<1)
 #define GET_PUSH_REF_STATES (1<<2)
 
 static int verbose;
 
+
+
 static int show_all(void);
 static int prune_remote(const char *remote, int dry_run);
 
@@ -1255,6 +1267,92 @@ static int update(int argc, const char **argv)
 	return run_command_v_opt(fetch_argv, RUN_GIT_CMD);
 }
 
+static int set_url(int argc, const char **argv)
+{
+	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
+	int matches = 0, negative_matches = 0;
+	const char *remotename = NULL;
+	const char *newurl = NULL;
+	const char *oldurl = NULL;
+	struct remote *remote;
+	regex_t old_regex;
+	const char **urlset;
+	int urlset_nr;
+	struct strbuf name_buf = STRBUF_INIT;
+	struct option options[] = {
+		OPT_BOOLEAN('\0', "push", &push_mode,
+			    "manipulate push URLs"),
+		OPT_BOOLEAN('\0', "add", &add_mode,
+			    "add URL"),
+		OPT_BOOLEAN('\0', "delete", &delete_mode,
+			    "delete URLs"),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_update_usage,
+			     PARSE_OPT_KEEP_ARGV0);
+
+	if (add_mode && delete_mode)
+		die("--add --delete doesn't make sense");
+
+	if (argc < 3 || argc > 4 || ((add_mode || delete_mode) && argc != 3))
+		usage_with_options(builtin_remote_seturl_usage, options);
+
+	remotename = argv[1];
+	newurl = argv[2];
+	if (argc > 3)
+		oldurl = argv[3];
+
+	if (delete_mode)
+		oldurl = newurl;
+
+	if (!remote_is_configured(remotename))
+		die("No such remote '%s'", remotename);
+	remote = remote_get(remotename);
+
+	if (push_mode) {
+		strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
+		urlset = remote->pushurl;
+		urlset_nr = remote->pushurl_nr;
+	} else {
+		strbuf_addf(&name_buf, "remote.%s.url", remotename);
+		urlset = remote->url;
+		urlset_nr = remote->url_nr;
+	}
+
+	/* Special cases that add new entry. */
+	if ((!oldurl && !delete_mode) || add_mode) {
+		if (add_mode)
+			git_config_set_multivar(name_buf.buf, newurl,
+				"^$", 0);
+		else
+			git_config_set(name_buf.buf, newurl);
+		strbuf_release(&name_buf);
+		return 0;
+	}
+
+	/* Old URL specified. Demand that one matches. */
+	if (regcomp(&old_regex, oldurl, REG_EXTENDED))
+		die("Invalid old URL pattern: %s", oldurl);
+
+	for (i = 0; i < urlset_nr; i++)
+		if (!regexec(&old_regex, urlset[i], 0, NULL, 0))
+			matches++;
+		else
+			negative_matches++;
+	if (!delete_mode && !matches)
+		die("No such URL found: %s", oldurl);
+	if (delete_mode && !negative_matches && !push_mode)
+		die("Will not delete all non-push URLs");
+
+	regfree(&old_regex);
+
+	if (!delete_mode)
+		git_config_set_multivar(name_buf.buf, newurl, oldurl, 0);
+	else
+		git_config_set_multivar(name_buf.buf, NULL, oldurl, 1);
+	return 0;
+}
+
 static int get_one_entry(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
@@ -1334,6 +1432,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = rm(argc, argv);
 	else if (!strcmp(argv[0], "set-head"))
 		result = set_head(argc, argv);
+	else if (!strcmp(argv[0], "set-url"))
+		result = set_url(argc, argv);
 	else if (!strcmp(argv[0], "show"))
 		result = show(argc, argv);
 	else if (!strcmp(argv[0], "prune"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 936fe0a..a82c5ff 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -533,5 +533,219 @@ test_expect_success 'show empty remote' '
 	)
 '
 
-test_done
+test_expect_success 'new remote' '
+(
+	git remote add someremote foo &&
+	echo foo >expect &&
+	git config --get-all remote.someremote.url >actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url bar' '
+(
+	git remote set-url someremote bar &&
+	echo bar >expect &&
+	git config --get-all remote.someremote.url >actual &&
+	cmp expect actual
+)
+'
 
+test_expect_success 'remote set-url baz bar' '
+(
+	git remote set-url someremote baz bar &&
+	echo baz >expect &&
+	git config --get-all remote.someremote.url >actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url zot bar' '
+(
+	test_must_fail git remote set-url someremote zot bar &&
+	echo baz >expect &&
+	git config --get-all remote.someremote.url >actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --push zot baz' '
+(
+	test_must_fail git remote set-url --push someremote zot baz &&
+	echo "YYY" >expect &&
+	echo baz >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --push zot' '
+(
+	git remote set-url --push someremote zot &&
+	echo zot >expect &&
+	echo "YYY" >>expect &&
+	echo baz >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --push qux zot' '
+(
+	git remote set-url --push someremote qux zot &&
+	echo qux >expect &&
+	echo "YYY" >>expect &&
+	echo baz >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --push foo qu+x' '
+(
+	git remote set-url --push someremote foo qu+x &&
+	echo foo >expect &&
+	echo "YYY" >>expect &&
+	echo baz >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --push --add aaa' '
+(
+	git remote set-url --push --add someremote aaa &&
+	echo foo >expect &&
+	echo aaa >>expect &&
+	echo "YYY" >>expect &&
+	echo baz >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --push bar aaa' '
+(
+	git remote set-url --push someremote bar aaa &&
+	echo foo >expect &&
+	echo bar >>expect &&
+	echo "YYY" >>expect &&
+	echo baz >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --push --delete bar' '
+(
+	git remote set-url --push --delete someremote bar &&
+	echo foo >expect &&
+	echo "YYY" >>expect &&
+	echo baz >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --push --delete foo' '
+(
+	git remote set-url --push --delete someremote foo &&
+	echo "YYY" >expect &&
+	echo baz >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --add bbb' '
+(
+	git remote set-url --add someremote bbb &&
+	echo "YYY" >expect &&
+	echo baz >>expect &&
+	echo bbb >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --delete .*' '
+(
+	test_must_fail git remote set-url --delete someremote .* &&
+	echo "YYY" >expect &&
+	echo baz >>expect &&
+	echo bbb >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --delete bbb' '
+(
+	git remote set-url --delete someremote bbb &&
+	echo "YYY" >expect &&
+	echo baz >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --delete baz' '
+(
+	test_must_fail git remote set-url --delete someremote baz &&
+	echo "YYY" >expect &&
+	echo baz >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --add ccc' '
+(
+	git remote set-url --add someremote ccc &&
+	echo "YYY" >expect &&
+	echo baz >>expect &&
+	echo ccc >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_expect_success 'remote set-url --delete baz' '
+(
+	git remote set-url --delete someremote baz &&
+	echo "YYY" >expect &&
+	echo ccc >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+)
+'
+
+test_done
-- 
1.6.6.199.gff4b0
