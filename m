Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A591F404
	for <e@80x24.org>; Fri,  9 Feb 2018 21:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeBIVpP (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 16:45:15 -0500
Received: from grym.ekleog.org ([94.23.42.210]:55090 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752892AbeBIVpO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 16:45:14 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id cff964fc;
        Fri, 9 Feb 2018 21:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=
        grym-20170528; bh=uIbYurCkpI1LiaKIlpUbZBZgeL0=; b=fHLpqVPL4lbBXJ
        +F9VrsmsYsGcq6pOym/kF4uLOTdYEnbWVmiJ4BINLG7ArSeCWypjKNyILErZTJwF
        suMmZRYfNDWCnlJTWp0e89bcKTXzilPNWl8tFcKmKpjE9avMGD8HG156QG2YiONY
        5BzUIROuFYfi5cBoWm4Zm6Xn7z340=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id 4d3d7fc2;
        Fri, 9 Feb 2018 21:45:12 +0000 (UTC)
Received: from localhost (llwynog [local])
        by llwynog (OpenSMTPD) with ESMTPA id 3bab035c;
        Fri, 9 Feb 2018 21:45:12 +0000 (UTC)
From:   Leo Gaspard <leo@gaspard.io>
To:     git@vger.kernel.org
Cc:     Joey Hess <id@joeyh.name>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?L=C3=A9o=20Gaspard?= <leo@gaspard.io>
Subject: [PATCH 2/2] fetch: add tweak-fetch hook
Date:   Fri,  9 Feb 2018 22:44:58 +0100
Message-Id: <20180209214458.16135-2-leo@gaspard.io>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209214458.16135-1-leo@gaspard.io>
References: <30753d19-d77d-1a1a-ba42-afcd6fbb4223@gaspard.io>
 <20180209214458.16135-1-leo@gaspard.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Léo Gaspard <leo@gaspard.io>

The tweak-fetch hook is fed lines on stdin for all refs that were
fetched, and outputs on stdout possibly modified lines. Its output is
then parsed and used when `git fetch` updates the remote tracking refs,
records the entries in FETCH_HEAD, and produces its report.

The modifications here are heavily based on prior work by Joey Hess.

Based-on-patch-by: Joey Hess <joey@kitenet.net>
Signed-off-by: Leo Gaspard <leo@gaspard.io>
---
 Documentation/githooks.txt          |  37 +++++++
 builtin/fetch.c                     | 210 +++++++++++++++++++++++++++++++++++-
 t/t5574-fetch-tweak-fetch-hook.sh   |  90 ++++++++++++++++
 templates/hooks--tweak-fetch.sample |  24 +++++
 4 files changed, 359 insertions(+), 2 deletions(-)
 create mode 100755 t/t5574-fetch-tweak-fetch-hook.sh
 create mode 100755 templates/hooks--tweak-fetch.sample

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index f877f7b7c..1b4a18bf0 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -177,6 +177,43 @@ This hook can be used to perform repository validity checks, auto-display
 differences from the previous HEAD if different, or set working dir metadata
 properties.
 
+tweak-fetch
+~~~~~~~~~~~
+
+This hook is invoked by 'git fetch' (commonly called by 'git pull'), after refs
+have been fetched from the remote repository. It is not executed, if nothing was
+fetched.
+
+The output of the hook is used to update the remote-tracking branches, and
+`.git/FETCH_HEAD`, in preparation for a later merge operation done by 'git
+merge'.
+
+It takes no arguments, but is fed a line of the following format on its standard
+input for each ref that was fetched.
+
+  <sha1> SP not-for-merge|merge|ignore SP <remote-refname> SP <local-refname> LF
+
+Where the "not-for-merge" flag indicates the ref is not to be merged into the
+current branch, and the "merge" flag indicates that 'git merge' should later
+merge it.
+
+The `<remote-refname>` is the remote's name for the ref that was fetched, and
+`<local-refname>` is a name of a remote-tracking branch, like
+"refs/remotes/origin/master". `<local-refname>` can be undefined if the fetched
+ref is not being stored in a local refname. In this case, it will be set to `@`,
+an invalide refspec, so that scripts can be written more easily.
+
+TODO: Add documentation for the “ignore” parameter. Unfortunately, I'm not
+really sure I get what this does or what invariants it is supposed to maintain
+(eg. all “ignore” updates at the end of the refs list?), so this may also
+require code changes.
+
+The hook must consume all of its standard input, and output back lines of the
+same format. It can modify its input as desired, including adding or removing
+lines, updating the sha1 (i.e. re-point the remote-tracking branch), changing
+the merge flag, and changing the `<local-refname>` (i.e. use different
+remote-tracking branch).
+
 post-merge
 ~~~~~~~~~~
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 76dc05f61..1bb394530 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -28,6 +28,8 @@ static const char * const builtin_fetch_usage[] = {
 	NULL
 };
 
+static const char tweak_fetch_hook[] = "tweak-fetch";
+
 enum {
 	TAGS_UNSET = 0,
 	TAGS_DEFAULT = 1,
@@ -181,6 +183,206 @@ static struct option builtin_fetch_options[] = {
 	OPT_END()
 };
 
+static int feed_tweak_fetch_hook(int in, int out, void *data)
+{
+	struct ref *ref;
+	struct strbuf buf = STRBUF_INIT;
+	const char *kw, *peer_ref;
+	char oid_buf[GIT_SHA1_HEXSZ + 1];
+	int ret;
+
+	for (ref = data; ref; ref = ref->next) {
+		if (ref->fetch_head_status == FETCH_HEAD_MERGE)
+			kw = "merge";
+		else if (ref->fetch_head_status == FETCH_HEAD_IGNORE)
+			kw = "ignore";
+		else
+			kw = "not-for-merge";
+		if (!ref->name)
+			die("trying to fetch an inexistant ref");
+		if (ref->peer_ref && ref->peer_ref->name)
+			peer_ref = ref->peer_ref->name;
+		else
+			peer_ref = "@";
+		strbuf_addf(&buf, "%s %s %s %s\n",
+				oid_to_hex_r(oid_buf, &ref->old_oid), kw,
+				ref->name, peer_ref);
+	}
+
+	ret = write_in_full(out, buf.buf, buf.len) != buf.len;
+	if (ret)
+		warning("%s hook failed to consume all its input",
+				tweak_fetch_hook);
+	close(out);
+	strbuf_release(&buf);
+	return ret;
+}
+
+static struct ref *parse_tweak_fetch_hook_line(char *l,
+		struct string_list *existing_refs)
+{
+	struct ref *ref = NULL, *peer_ref = NULL;
+	struct string_list_item *peer_item = NULL;
+	char *words[4];
+	int i, word = 0;
+	char *problem;
+
+	for (i = 0; l[i]; i++) {
+		if (isspace(l[i])) {
+			l[i] = '\0';
+			words[word] = l;
+			l += i + 1;
+			i = 0;
+			word++;
+			if (word > 3) {
+				problem = "too many words";
+				goto unparsable;
+			}
+		}
+	}
+	if (word < 3) {
+		problem = "not enough words";
+		goto unparsable;
+	}
+
+	ref = alloc_ref(words[2]);
+	peer_ref = ref->peer_ref = alloc_ref(l);
+	ref->peer_ref->force = 1;
+
+	if (get_oid_hex(words[0], &ref->old_oid)) {
+		problem="bad oid";
+		goto unparsable;
+	}
+
+	if (!strcmp(words[1], "merge")) {
+		ref->fetch_head_status = FETCH_HEAD_MERGE;
+	} else if (!strcmp(words[1], "ignore")) {
+		ref->fetch_head_status = FETCH_HEAD_IGNORE;
+	} else if (!strcmp(words[1], "not-for-merge")) {
+		ref->fetch_head_status = FETCH_HEAD_NOT_FOR_MERGE;
+	} else {
+		problem = "bad merge flag";
+		goto unparsable;
+	}
+
+	peer_item = string_list_lookup(existing_refs, peer_ref->name);
+	if (peer_item)
+		hashcpy(peer_ref->old_oid.hash, peer_item->util);
+
+	return ref;
+
+unparsable:
+	warning("%s hook output a wrongly formed line: %s",
+			tweak_fetch_hook, problem);
+	free(ref);
+	free(peer_ref);
+	return NULL;
+}
+
+static struct refs_result read_tweak_fetch_hook(int in)
+{
+	struct refs_result res;
+	FILE *f;
+	struct strbuf buf;
+	struct string_list existing_refs = STRING_LIST_INIT_DUP;
+	struct ref *ref, *prevref = NULL;
+
+	res.status = 0;
+	res.new_refs = NULL;
+
+	f = fdopen(in, "r");
+	if (f == NULL) {
+		res.status = 1;
+		return res;
+	}
+
+	strbuf_init(&buf, 128);
+	for_each_ref(add_existing, &existing_refs);
+
+	while (strbuf_getline(&buf, f) != EOF) {
+		char *l = strbuf_detach(&buf, NULL);
+		ref = parse_tweak_fetch_hook_line(l, &existing_refs);
+		if (!ref) {
+			res.status = 1;
+		} else {
+			if (prevref) {
+				prevref->next = ref;
+				prevref = ref;
+			} else {
+				res.new_refs = prevref = ref;
+			}
+		}
+		free(l);
+	}
+
+	string_list_clear(&existing_refs, 0);
+	strbuf_release(&buf);
+	fclose(f);
+	return res;
+}
+
+/*
+ * The hook is fed lines of the form:
+ * <sha1> SP <not-for-merge|merge|ignore> SP <remote-refname> SP <local-refname> LF
+ * And should output rewritten lines of the same form.
+ */
+static struct ref *run_tweak_fetch_hook(struct ref *fetched_refs)
+{
+	struct child_process hook;
+	const char *argv[2];
+	struct async async;
+	struct refs_result res;
+
+	if (!fetched_refs)
+		return fetched_refs;
+
+	argv[0] = find_hook(tweak_fetch_hook);
+	if (access(argv[0], X_OK) < 0)
+		return fetched_refs;
+	argv[1] = NULL;
+
+	memset(&hook, 0, sizeof(hook));
+	hook.argv = argv;
+	hook.in = -1;
+	hook.out = -1;
+	if (start_command(&hook))
+		return fetched_refs;
+
+	/*
+	 * Use an async writer to feed the hook process.
+	 * This allows the hook to read and write a line at
+	 * a time without blocking.
+	 */
+	memset(&async, 0, sizeof(async));
+	async.proc = feed_tweak_fetch_hook;
+	async.data = fetched_refs;
+	async.out = hook.in;
+	if (start_async(&async)) {
+		close(hook.in);
+		close(hook.out);
+		finish_command(&hook);
+		return fetched_refs;
+	}
+
+	res = read_tweak_fetch_hook(hook.out);
+	res.status |= finish_async(&async);
+	res.status |= finish_command(&hook);
+
+	if (res.status) {
+		warning("%s hook failed, ignoring its output", tweak_fetch_hook);
+		free(res.new_refs);
+		return fetched_refs;
+	} else {
+		/*
+		 * The new_refs are returned, to be used in place of
+		 * fetched_refs, so it is not needed anymore and can
+		 * be freed here.
+		 */
+		free_refs(fetched_refs);
+		return res.new_refs;
+	}
+}
+
 static void unlock_pack(void)
 {
 	if (gtransport)
@@ -934,7 +1136,7 @@ static struct refs_result fetch_refs(struct transport *transport,
 		ret.status = transport_fetch_refs(transport, ref_map);
 	}
 	if (!ret.status) {
-		ret.new_refs = ref_map;
+		ret.new_refs = run_tweak_fetch_hook(ref_map);
 		ret.status |= store_updated_refs(transport->url,
 				transport->remote->name,
 				ret.new_refs);
@@ -1150,7 +1352,11 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-
+	// TODO(?): Were this placed above the `if (prune)`, it would avoid the
+	// unfortunate fact that `git fetch --prune` first drops the ref then
+	// re-adds it (in cases where the tweak-fetch hook renames it). There is
+	// likely a better solution than this one that would break Commit
+	// 10a6cc889 ("fetch --prune: Run prune before fetching", 2014-01-02)
 	res = fetch_refs(transport, ref_map);
 	ref_map = res.new_refs;
 	if (res.status) {
diff --git a/t/t5574-fetch-tweak-fetch-hook.sh b/t/t5574-fetch-tweak-fetch-hook.sh
new file mode 100755
index 000000000..17cf52684
--- /dev/null
+++ b/t/t5574-fetch-tweak-fetch-hook.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+
+test_description='testing tweak-fetch-hook'
+. ./test-lib.sh
+
+HOOKDIR="$(git rev-parse --git-dir)/hooks"
+HOOK="$HOOKDIR/tweak-fetch"
+mkdir -p "$HOOKDIR"
+
+# Setup
+test_expect_success 'setup' '
+	git init parent-repo &&
+	git remote add parent parent-repo &&
+	(cd parent-repo && test_commit commit-100) &&
+	git fetch parent &&
+	git tag | grep -E "^commit-100$"
+'
+
+# No-effect hook
+write_script "$HOOK" <<EOF
+cat
+EOF
+test_expect_success 'no-op hook' '
+	(cd parent-repo && test_commit commit-200) &&
+	git fetch parent &&
+	git tag | grep -E "^commit-200$"
+'
+
+# Ref-renaming hook
+write_script "$HOOK" <<EOF
+sed 's/commit-/tag-/g'
+EOF
+test_expect_success 'ref-renaming hook' '
+	(cd parent-repo && test_commit commit-300) &&
+	git fetch parent &&
+	git tag | grep -E "^tag-300" &&
+	! git tag | grep -E "^commit-300"
+'
+
+# Drop branch
+write_script "$HOOK" <<EOF
+cat
+EOF
+test_expect_success 'dropping hook setup' '
+	(cd parent-repo && test_commit commit-400) &&
+	git fetch parent &&
+	test "$(git rev-parse parent/master)" = "$(git rev-parse commit-400)"
+'
+write_script "$HOOK" <<EOF
+grep -v 'refs/remotes/parent/master'
+exit 0
+EOF
+test_expect_success 'dropping hook' '
+	(cd parent-repo && test_commit commit-401) &&
+	git fetch parent &&
+	test "$(git rev-parse parent/master)" = "$(git rev-parse commit-400)" &&
+	chmod -x "'"$HOOK"'" &&
+	git fetch parent &&
+	test "$(git rev-parse parent/master)" = "$(git rev-parse commit-401)"
+'
+
+# Repointing hook
+write_script "$HOOK" <<EOF
+cat
+EOF
+test_expect_success 'repointing hook setup' '
+	(cd parent-repo && test_commit commit-500) &&
+	git fetch parent
+'
+write_script "$HOOK" <<'EOF'
+while read hash merge remote_ref local_ref; do
+	if [ "$local_ref" = "refs/remotes/parent/master" ]; then
+		repointed="$(git rev-parse "$hash^")"
+		echo "$repointed $merge $remote_ref $local_ref"
+	else
+		echo "$hash $merge $remote_ref $local_ref"
+	fi
+done
+exit 0
+EOF
+test_expect_success 'repointing hook' '
+	(cd parent-repo && test_commit commit-501 && test_commit commit-502) &&
+	git fetch parent &&
+	test "$(git rev-parse parent/master)" = "$(git rev-parse commit-501)" &&
+	(cd parent-repo && test_commit commit-503) &&
+	git fetch parent &&
+	test "$(git rev-parse parent/master)" = "$(git rev-parse commit-502)"
+'
+
+test_done
diff --git a/templates/hooks--tweak-fetch.sample b/templates/hooks--tweak-fetch.sample
new file mode 100755
index 000000000..93b86ad2f
--- /dev/null
+++ b/templates/hooks--tweak-fetch.sample
@@ -0,0 +1,24 @@
+#!/bin/sh
+#
+# Copyright (c) 2018 Leo Gaspard
+#
+# The "tweak-fetch" hook is run during the fetching process. It is called with
+# no parameters. Its communication protocol is reading fetched references on
+# stdin, and outputting references to update on stdout, with the same protocol
+# described in `git help hooks`.
+#
+# This sample shows how to refuse fetching any unsigned commit.
+
+while read hash merge remote_ref local_ref; do
+    allowed_commit="$(git rev-parse "$local_ref")"
+    git rev-list "$local_ref..$hash" | tac | while read commit; do
+        if git verify-commit "$commit" > /dev/null 2>&1; then
+            allowed_commit="$commit"
+        else
+            echo "Commit '$commit' is not signed! Refusing to fetch past it" >&2
+            break
+        fi
+    done
+    echo "$allowed_commit $merge $remote_ref $local_ref"
+done
+# TODO: actually verify this hook works
-- 
2.16.1

