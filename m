Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF26207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 19:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932694AbcI3Tge (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 15:36:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:50606 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932431AbcI3Tgd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 15:36:33 -0400
Received: (qmail 31237 invoked by uid 109); 30 Sep 2016 19:36:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 19:36:33 +0000
Received: (qmail 13499 invoked by uid 111); 30 Sep 2016 19:36:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 15:36:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 15:36:31 -0400
Date:   Fri, 30 Sep 2016 15:36:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH 4/6] receive-pack: quarantine objects until pre-receive
 accepts
Message-ID: <20160930193630.vwq6n5hjbthrz6fj@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a client pushes objects to us, index-pack checks the
objects themselves and then installs them into place. If we
then reject the push due to a pre-receive hook, we cannot
just delete the packfile; other processes may be depending
on it. We have to do a normal reachability check at this
point via `git gc`.

But such objects may hang around for weeks due to the
gc.pruneExpire grace period. And worse, during that time
they may be exploded from the pack into inefficient loose
objects.

Instead, this patch teaches receive-pack to put the new
objects into a "quarantine" temporary directory. We make
these objects available to the connectivity check and to the
pre-receive hook, and then install them into place only if
it is successful (and otherwise remove them as tempfiles).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c     | 41 ++++++++++++++++++++++++++++++++++++++++-
 t/t5547-push-quarantine.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100755 t/t5547-push-quarantine.sh

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 896b16f..04ad909 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -20,6 +20,7 @@
 #include "gpg-interface.h"
 #include "sigchain.h"
 #include "fsck.h"
+#include "tmp-objdir.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -86,6 +87,8 @@ static enum {
 } use_keepalive;
 static int keepalive_in_sec = 5;
 
+struct tmp_objdir *tmp_objdir;
+
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
 	if (value) {
@@ -663,6 +666,9 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	} else
 		argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
 
+	if (tmp_objdir)
+		argv_array_pushv(&proc.env_array, tmp_objdir_env(tmp_objdir));
+
 	if (use_sideband) {
 		memset(&muxer, 0, sizeof(muxer));
 		muxer.proc = copy_to_sideband;
@@ -762,6 +768,7 @@ static int run_update_hook(struct command *cmd)
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
 	proc.argv = argv;
+	proc.env = tmp_objdir_env(tmp_objdir);
 
 	code = start_command(&proc);
 	if (code)
@@ -833,6 +840,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 		    !delayed_reachability_test(si, i))
 			sha1_array_append(&extra, si->shallow->sha1[i]);
 
+	opt.env = tmp_objdir_env(tmp_objdir);
 	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
 	if (check_connected(command_singleton_iterator, cmd, &opt)) {
 		rollback_lock_file(&shallow_lock);
@@ -1240,12 +1248,17 @@ static void set_connectivity_errors(struct command *commands,
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		struct command *singleton = cmd;
+		struct check_connected_options opt = CHECK_CONNECTED_INIT;
+
 		if (shallow_update && si->shallow_ref[cmd->index])
 			/* to be checked in update_shallow_ref() */
 			continue;
+
+		opt.env = tmp_objdir_env(tmp_objdir);
 		if (!check_connected(command_singleton_iterator, &singleton,
-				     NULL))
+				     &opt))
 			continue;
+
 		cmd->error_string = "missing necessary objects";
 	}
 }
@@ -1428,6 +1441,7 @@ static void execute_commands(struct command *commands,
 	data.si = si;
 	opt.err_fd = err_fd;
 	opt.progress = err_fd && !quiet;
+	opt.env = tmp_objdir_env(tmp_objdir);
 	if (check_connected(iterate_receive_command_list, &data, &opt))
 		set_connectivity_errors(commands, si);
 
@@ -1444,6 +1458,19 @@ static void execute_commands(struct command *commands,
 		return;
 	}
 
+	/*
+	 * Now we'll start writing out refs, which means the objects need
+	 * to be in their final positions so that other processes can see them.
+	 */
+	if (tmp_objdir_migrate(tmp_objdir) < 0) {
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!cmd->error_string)
+				cmd->error_string = "unable to migrate objects to permanent storage";
+		}
+		return;
+	}
+	tmp_objdir = NULL;
+
 	check_aliased_updates(commands);
 
 	free(head_name_to_free);
@@ -1639,6 +1666,18 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		argv_array_push(&child.args, alt_shallow_file);
 	}
 
+	tmp_objdir = tmp_objdir_create();
+	if (!tmp_objdir)
+		return "unable to create temporary object directory";
+	child.env = tmp_objdir_env(tmp_objdir);
+
+	/*
+	 * Normally we just pass the tmp_objdir environment to the child
+	 * processes that do the heavy lifting, but we may need to see these
+	 * objects ourselves to set up shallow information.
+	 */
+	tmp_objdir_add_as_alternate(tmp_objdir);
+
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		argv_array_pushl(&child.args, "unpack-objects", hdr_arg, NULL);
 		if (quiet)
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
new file mode 100755
index 0000000..1e5d32d
--- /dev/null
+++ b/t/t5547-push-quarantine.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='check quarantine of objects during push'
+. ./test-lib.sh
+
+test_expect_success 'create picky dest repo' '
+	git init --bare dest.git &&
+	write_script dest.git/hooks/pre-receive <<-\EOF
+	while read old new ref; do
+		test "$(git log -1 --format=%s $new)" = reject && exit 1
+	done
+	exit 0
+	EOF
+'
+
+test_expect_success 'accepted objects work' '
+	test_commit ok &&
+	git push dest.git HEAD &&
+	commit=$(git rev-parse HEAD) &&
+	git --git-dir=dest.git cat-file commit $commit
+'
+
+test_expect_success 'rejected objects are not installed' '
+	test_commit reject &&
+	commit=$(git rev-parse HEAD) &&
+	test_must_fail git push dest.git reject &&
+	test_must_fail git --git-dir=dest.git cat-file commit $commit
+'
+
+test_expect_success 'rejected objects are removed' '
+	echo "incoming-*" >expect &&
+	(cd dest.git/objects && echo incoming-*) >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.10.0.618.g82cc264

