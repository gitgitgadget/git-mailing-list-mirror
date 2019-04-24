Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AEE91F453
	for <e@80x24.org>; Wed, 24 Apr 2019 00:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfDXAy1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 20:54:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35598 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728840AbfDXAy0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Apr 2019 20:54:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3B19361002;
        Wed, 24 Apr 2019 00:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556067263;
        bh=1Cn4XO4xCe9MzCwDXnAvdgRfCukWbf5RUslyk04bgE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gNPSdQUKev3FZsDKZAt6iDTfkUJv8VDO32hwdD6dhYaN3R0p8fHw+yB4L4U3pg93Y
         j1K+/KN0OQA+PEUoW96U3kRM1VImSAyGIzeMW6ujZl9gptEoCoYGoVej6KnF2sWiQf
         VQkcFjqRbg+dXfV0AMUyGPtP8sumfn7/i8tFTxLFtKRfQO3paB0D8BVcPh1MPZo+hX
         qehStymYRXY68fl0gleZIfkPCxeo2EjNRO3HPUqYMdyiRwX2JMnsQFTPaHRXoQUgKd
         TIdkK3sQ27OGCKQKW/Q6PtyGW17CuYbn88K+Va16/tFbla4Vkq1sOFBGomKanCAKf3
         3XGPbzAewIvmFvRryJx7ggConSom+PNRchts5LhB9Vw0v/BulXbMQEWuBIP9WBor0b
         /kPsEh/hXwnxxpEN9ECqLx0A+Wz+aFQqd/H9Ol2S8SKWrGLeb0EGwnJDfsJ0JPfP8d
         Cyy7WA3BN267BZx4Q5nAkGr+yGKA/lBzhV+/qfTKUl2OyXHfcm4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/5] run-command: add preliminary support for multiple hooks
Date:   Wed, 24 Apr 2019 00:49:44 +0000
Message-Id: <20190424004948.728326-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190424004948.728326-1-sandals@crustytoothpaste.net>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A variety of types of software take advantage of Git's hooks. However,
if a user would like to integrate multiple pieces of software which use
a particular hook, they currently must manage those hooks themselves,
which can be burdensome. Sometimes various pieces of software try to
overwrite each other's hooks, leading to problems.

To solve this problem, introduce a framework for running multiple hooks
using a ".d" directory named similarly to the hook, running each hook in
order sorted by name. Wire this framework up for those functions using
run_hook_le or run_hook_ve. To preserve backwards compatibility, ensure
that multiple hooks run only if there is no hook using the current hook
style.

If we are running multiple hooks and one of them exits nonzero, don't
execute the remaining hooks and return that exit code immediately. This
allows hooks to fail fast and it avoids having to deal with what happens
if multiple hooks fail with different exit statuses.

Create a test framework for testing multiple hooks with different
commands. This is necessary because not all hooks use run_hook_ve or
run_hook_le and we'll want to ensure all the various hooks work without
needing to write lots of duplicative test code.

Test the pre-commit hook to verify that the run_hook_ve implementation
works correctly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/commit.c           |   5 +-
 run-command.c              | 141 +++++++++++++++++++++++++--------
 run-command.h              |   7 ++
 t/lib-hooks.sh             | 156 +++++++++++++++++++++++++++++++++++++
 t/t7503-pre-commit-hook.sh |  15 ++++
 5 files changed, 292 insertions(+), 32 deletions(-)
 create mode 100644 t/lib-hooks.sh

diff --git a/builtin/commit.c b/builtin/commit.c
index f17537474a..e7cf6b16ba 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -666,6 +666,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	struct strbuf sb = STRBUF_INIT;
 	const char *hook_arg1 = NULL;
 	const char *hook_arg2 = NULL;
+	struct string_list *hooks;
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
 
@@ -943,13 +944,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
+	hooks = find_hooks("pre-commit");
+	if (!no_verify && hooks) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
 		 * the editor and after we invoke run_status above.
 		 */
 		discard_cache();
+		free_hooks(hooks);
 	}
 	read_cache_from(index_file);
 
diff --git a/run-command.c b/run-command.c
index 3449db319b..669af5ebc7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1308,58 +1308,137 @@ int async_with_fork(void)
 #endif
 }
 
+static int has_hook(struct strbuf *path, int strip)
+{
+	if (access(path->buf, X_OK) < 0) {
+		int err = errno;
+
+		if (strip) {
+#ifdef STRIP_EXTENSION
+			strbuf_addstr(path, STRIP_EXTENSION);
+			if (access(path->buf, X_OK) >= 0)
+				return 1;
+			if (errno == EACCES)
+				err = errno;
+#endif
+		}
+
+		if (err == EACCES && advice_ignored_hook) {
+			static struct string_list advise_given = STRING_LIST_INIT_DUP;
+
+			if (!string_list_lookup(&advise_given, path->buf)) {
+				string_list_insert(&advise_given, path->buf);
+				advise(_("The '%s' hook was ignored because "
+					 "it's not set as executable.\n"
+					 "You can disable this warning with "
+					 "`git config advice.ignoredHook false`."),
+				       path->buf);
+			}
+		}
+		return 0;
+	}
+	return 1;
+}
+
 const char *find_hook(const char *name)
 {
 	static struct strbuf path = STRBUF_INIT;
 
 	strbuf_reset(&path);
 	strbuf_git_path(&path, "hooks/%s", name);
-	if (access(path.buf, X_OK) < 0) {
-		int err = errno;
+	if (has_hook(&path, 1)) {
+		return path.buf;
+	}
+	return NULL;
+}
 
-#ifdef STRIP_EXTENSION
-		strbuf_addstr(&path, STRIP_EXTENSION);
-		if (access(path.buf, X_OK) >= 0)
-			return path.buf;
-		if (errno == EACCES)
-			err = errno;
-#endif
+struct string_list *find_hooks(const char *name)
+{
+	struct string_list *list = xmalloc(sizeof(*list));
+	struct strbuf path = STRBUF_INIT;
+	DIR *d;
+	struct dirent *de;
 
-		if (err == EACCES && advice_ignored_hook) {
-			static struct string_list advise_given = STRING_LIST_INIT_DUP;
+	string_list_init(list, 1);
 
-			if (!string_list_lookup(&advise_given, name)) {
-				string_list_insert(&advise_given, name);
-				advise(_("The '%s' hook was ignored because "
-					 "it's not set as executable.\n"
-					 "You can disable this warning with "
-					 "`git config advice.ignoredHook false`."),
-				       path.buf);
-			}
-		}
+	/*
+	 * We look for a single hook. If present, return it, and skip the
+	 * individual directories.
+	 */
+	strbuf_git_path(&path, "hooks/%s", name);
+	if (has_hook(&path, 1)) {
+		string_list_append(list, path.buf);
+		return list;
+	}
+
+	strbuf_reset(&path);
+	strbuf_git_path(&path, "hooks/%s.d", name);
+	d = opendir(path.buf);
+	if (!d) {
+		string_list_clear(list, 0);
 		return NULL;
 	}
-	return path.buf;
+	while ((de = readdir(d))) {
+		if (!strcmp(de->d_name, ".") || !strcmp(de->d_name, ".."))
+			continue;
+		strbuf_reset(&path);
+		strbuf_git_path(&path, "hooks/%s.d/%s", name, de->d_name);
+		if (has_hook(&path, 0))
+			string_list_append(list, path.buf);
+	}
+	closedir(d);
+	strbuf_reset(&path);
+	if (!list->nr) {
+		free_hooks(list);
+		return NULL;
+	}
+
+	string_list_sort(list);
+	return list;
+}
+
+void free_hooks(struct string_list *hooks)
+{
+	string_list_clear(hooks, 0);
+	free(hooks);
 }
 
 int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
-	struct child_process hook = CHILD_PROCESS_INIT;
+	struct string_list *hooks;
+	struct string_list arglist = STRING_LIST_INIT_NODUP;
 	const char *p;
+	struct string_list_item *q;
+	int ret = 0;
 
-	p = find_hook(name);
-	if (!p)
+	hooks = find_hooks(name);
+	if (!hooks)
 		return 0;
 
-	argv_array_push(&hook.args, p);
 	while ((p = va_arg(args, const char *)))
-		argv_array_push(&hook.args, p);
-	hook.env = env;
-	hook.no_stdin = 1;
-	hook.stdout_to_stderr = 1;
-	hook.trace2_hook_name = name;
+		string_list_append(&arglist, p);
 
-	return run_command(&hook);
+	for_each_string_list_item(q, hooks) {
+		struct child_process hook = CHILD_PROCESS_INIT;
+		struct string_list_item *arg;
+
+		argv_array_push(&hook.args, q->string);
+		for_each_string_list_item(arg, &arglist) {
+			argv_array_push(&hook.args, arg->string);
+		}
+
+		hook.env = env;
+		hook.no_stdin = 1;
+		hook.stdout_to_stderr = 1;
+		hook.trace2_hook_name = name;
+
+		ret = run_command(&hook);
+		if (ret)
+			break;
+	}
+	string_list_clear(&arglist, 0);
+	free_hooks(hooks);
+	return ret;
 }
 
 int run_hook_le(const char *const *env, const char *name, ...)
diff --git a/run-command.h b/run-command.h
index a6950691c0..7266dc2969 100644
--- a/run-command.h
+++ b/run-command.h
@@ -68,6 +68,13 @@ int run_command(struct child_process *);
  * overwritten by further calls to find_hook and run_hook_*.
  */
 extern const char *find_hook(const char *name);
+/*
+ * Returns the paths to all hook files, or NULL if all hooks are missing or
+ * disabled.
+ */
+struct string_list *find_hooks(const char *name);
+/* Frees the result of find_hooks. */
+void free_hooks(struct string_list *hooks);
 LAST_ARG_MUST_BE_NULL
 extern int run_hook_le(const char *const *env, const char *name, ...);
 extern int run_hook_ve(const char *const *env, const char *name, va_list args);
diff --git a/t/lib-hooks.sh b/t/lib-hooks.sh
new file mode 100644
index 0000000000..91b3acaba2
--- /dev/null
+++ b/t/lib-hooks.sh
@@ -0,0 +1,156 @@
+create_multihooks () {
+	mkdir -p "$MULTIHOOK_DIR"
+	for i in "a $1" "b $2" "c $3"
+	do
+		echo "$i" | (while read script ex
+		do
+			mkdir -p "$MULTIHOOK_DIR"
+			write_script "$MULTIHOOK_DIR/$script" <<-EOF
+			mkdir -p "$OUTPUTDIR"
+			touch "$OUTPUTDIR/$script"
+			exit $ex
+			EOF
+		done)
+	done
+}
+
+# Run the multiple hook tests.
+# Usage: test_multiple_hooks [--ignore-exit-status] HOOK COMMAND [SKIP-COMMAND]
+# HOOK:  the name of the hook to test
+# COMMAND: command to test the hook for; takes a single argument indicating test
+# name.
+# SKIP-COMMAND: like $1, except the hook should be skipped.
+# --ignore-exit-status: the command does not fail if the exit status from the
+# hook is nonzero.
+test_multiple_hooks () {
+	local must_fail cmd skip_cmd hook
+	if test "$1" = "--ignore-exit-status"
+	then
+		shift
+	else
+		must_fail="test_must_fail"
+	fi
+	hook="$1"
+	cmd="$2"
+	skip_cmd="$3"
+
+	HOOKDIR="$(git rev-parse --absolute-git-dir)/hooks"
+	OUTPUTDIR="$(git rev-parse --absolute-git-dir)/../hook-output"
+	HOOK="$HOOKDIR/$hook"
+	MULTIHOOK_DIR="$HOOKDIR/$hook.d"
+	rm -f "$HOOK" "$MULTIHOOK_DIR" "$OUTPUTDIR"
+
+	test_expect_success "$hook: with no hook" '
+		$cmd foo
+	'
+
+	if test -n "$skip_cmd"
+	then
+		test_expect_success "$hook: skipped hook with no hook" '
+			$skip_cmd bar
+		'
+	fi
+
+	test_expect_success 'setup' '
+		mkdir -p "$HOOKDIR" &&
+		write_script "$HOOK" <<-EOF
+		mkdir -p "$OUTPUTDIR"
+		touch "$OUTPUTDIR/simple"
+		exit 0
+		EOF
+	'
+
+	test_expect_success "$hook: with succeeding hook" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		$cmd more &&
+		test -f "$OUTPUTDIR/simple"
+	'
+
+	if test -n "$skip_cmd"
+	then
+		test_expect_success "$hook: skipped but succeeding hook" '
+			test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+			$skip_cmd even-more &&
+			! test -f "$OUTPUTDIR/simple"
+		'
+	fi
+
+	test_expect_success "$hook: with both simple and multiple hooks, simple success" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		create_multihooks 0 1 0 &&
+		$cmd yet-more &&
+		test -f "$OUTPUTDIR/simple" &&
+		! test -f "$OUTPUTDIR/a" &&
+		! test -f "$OUTPUTDIR/b" &&
+		! test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success 'setup' '
+		rm -fr "$MULTIHOOK_DIR" &&
+
+		# now a hook that fails
+		write_script "$HOOK" <<-EOF
+		mkdir -p "$OUTPUTDIR"
+		touch "$OUTPUTDIR/simple"
+		exit 1
+		EOF
+	'
+
+	test_expect_success "$hook: with failing hook" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		$must_fail $cmd another &&
+		test -f "$OUTPUTDIR/simple"
+	'
+
+	if test -n "$skip_cmd"
+	then
+		test_expect_success "$hook: skipped but failing hook" '
+			test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+			$skip_cmd stuff &&
+			! test -f "$OUTPUTDIR/simple"
+		'
+	fi
+
+	test_expect_success "$hook: with both simple and multiple hooks, simple failure" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		create_multihooks 0 1 0 &&
+		$must_fail $cmd more-stuff &&
+		test -f "$OUTPUTDIR/simple" &&
+		! test -f "$OUTPUTDIR/a" &&
+		! test -f "$OUTPUTDIR/b" &&
+		! test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success "$hook: multiple hooks, all successful" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		rm -f "$HOOK" &&
+		create_multihooks 0 0 0 &&
+		$cmd content &&
+		test -f "$OUTPUTDIR/a" &&
+		test -f "$OUTPUTDIR/b" &&
+		test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success "$hook: hooks after first failure not executed" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		create_multihooks 0 1 0 &&
+		$must_fail $cmd more-content &&
+		test -f "$OUTPUTDIR/a" &&
+		test -f "$OUTPUTDIR/b" &&
+		! test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success POSIXPERM "$hook: non-executable hook not executed" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		create_multihooks 0 1 0 &&
+		chmod -x "$MULTIHOOK_DIR/b" &&
+		$cmd things &&
+		test -f "$OUTPUTDIR/a" &&
+		! test -f "$OUTPUTDIR/b" &&
+		test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success 'cleanup' '
+		rm -fr "$MULTIHOOK_DIR"
+	'
+}
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 984889b39d..d63d059e04 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -3,6 +3,7 @@
 test_description='pre-commit hook'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-hooks.sh"
 
 test_expect_success 'with no hook' '
 
@@ -136,4 +137,18 @@ test_expect_success 'check the author in hook' '
 	git show -s
 '
 
+commit_command () {
+	echo "$1" >>file &&
+	git add file &&
+	git commit -m "$1"
+}
+
+commit_no_verify_command () {
+	echo "$1" >>file &&
+	git add file &&
+	git commit --no-verify -m "$1"
+}
+
+test_multiple_hooks pre-commit commit_command commit_no_verify_command
+
 test_done
