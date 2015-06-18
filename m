From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 20/31] am: implement 3-way merge
Date: Thu, 18 Jun 2015 19:25:32 +0800
Message-ID: <1434626743-8552-21-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xyl-0005MN-CX
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbbFRL1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:22 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33045 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932154AbbFRL1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:05 -0400
Received: by padev16 with SMTP id ev16so59563069pad.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wyfwgI9ehbY6+4JpBXKia+3JuKEkhlFteS7vW6L2Q0M=;
        b=Qu+0Jn+d7x8v7ifgX8k4TwCK0M0j98wtfRV+JPfBD8jLseuQv68qeGhEQuy5wdeJzx
         N6JlOYs3rPaGiCvgLL1wMB6eTSD1yRG17jjmkNVu4PIo5hbj0hEI1q96rpaFrSQeKQb9
         +PFVRK9zDX+oEsY5I/6SBgFD43zz33IK/fN2jTGgP3yGeJvACeUoCBuIDnL6yARGhs7k
         gtiXWPAiuRombe+kVY4DbDXZ38iOZPUOv+N++zJ6itZpYNYPXkmS2cX0d+vq3dC5m5Ey
         s0fabtV7PlCHFsRLcZVQqqoQt5/VzAA7fI4s6I20poUJ+A3bvfpTQBRScBsYFOraL9wI
         uFCw==
X-Received: by 10.66.157.202 with SMTP id wo10mr20403571pab.44.1434626825508;
        Thu, 18 Jun 2015 04:27:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.27.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:27:04 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271985>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh supported the --3way option, and if set, would attempt to do a
3-way merge if the initial patch application fails.

Since 5d86861 (am -3: list the paths that needed 3-way fallback,
2012-03-28), in a 3-way merge git-am.sh would list the paths that needed
3-way fallback, so that the user can review them more carefully to spot
mismerges.

Re-implement the above in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 143 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d45dd41..e154c87 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -19,6 +19,8 @@
 #include "unpack-trees.h"
 #include "branch.h"
 #include "sequencer.h"
+#include "revision.h"
+#include "merge-recursive.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -70,6 +72,8 @@ struct am_state {
 	/* number of digits in patch filename */
 	int prec;
 
+	int threeway;
+
 	int quiet;
 
 	int sign;
@@ -292,6 +296,9 @@ static void am_load(struct am_state *state)
 
 	read_state_file(&state->msg, am_path(state, "final-commit"), 0, 0);
 
+	read_state_file(&sb, am_path(state, "threeway"), 2, 1);
+	state->threeway = !strcmp(sb.buf, "t");
+
 	read_state_file(&sb, am_path(state, "quiet"), 2, 1);
 	state->quiet = !strcmp(sb.buf, "t");
 
@@ -481,6 +488,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "last"), 1, "%d", state->last);
 
+	write_file(am_path(state, "threeway"), 1, state->threeway ? "t" : "f");
+
 	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
 
 	write_file(am_path(state, "sign"), 1, state->sign ? "t" : "f");
@@ -666,17 +675,33 @@ static void NORETURN die_user_resolve(const struct am_state *state)
 }
 
 /*
- * Applies current patch with git-apply. Returns 0 on success, -1 otherwise.
+ * Applies current patch with git-apply. Returns 0 on success, -1 otherwise. If
+ * index_file is not NULL, the patch will be applied to that index.
  */
-static int run_apply(const struct am_state *state)
+static int run_apply(const struct am_state *state, const char *index_file)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
 	cp.git_cmd = 1;
 
+	if (index_file)
+		argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", index_file);
+
+	/*
+	 * If we are allowed to fall back on 3-way merge, don't give false
+	 * errors during the initial attempt.
+	 */
+	if (state->threeway && !index_file) {
+		cp.no_stdout = 1;
+		cp.no_stderr = 1;
+	}
+
 	argv_array_push(&cp.args, "apply");
 
-	argv_array_push(&cp.args, "--index");
+	if (index_file)
+		argv_array_push(&cp.args, "--cached");
+	else
+		argv_array_push(&cp.args, "--index");
 
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -685,8 +710,100 @@ static int run_apply(const struct am_state *state)
 
 	/* Reload index as git-apply will have modified it. */
 	discard_cache();
+	read_cache_from(index_file ? index_file : get_index_file());
+
+	return 0;
+}
+
+/**
+ * Builds a index that contains just the blobs needed for a 3way merge.
+ */
+static int build_fake_ancestor(const struct am_state *state, const char *index_file)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "apply");
+	argv_array_pushf(&cp.args, "--build-fake-ancestor=%s", index_file);
+	argv_array_push(&cp.args, am_path(state, "patch"));
+
+	if (run_command(&cp))
+		return -1;
+
+	return 0;
+}
+
+/**
+ * Attempt a threeway merge, using index_path as the temporary index.
+ */
+static int fall_back_threeway(const struct am_state *state, const char *index_path)
+{
+	unsigned char orig_tree[GIT_SHA1_RAWSZ], his_tree[GIT_SHA1_RAWSZ],
+		      our_tree[GIT_SHA1_RAWSZ];
+	const unsigned char *bases[1] = {orig_tree};
+	struct merge_options o;
+	struct commit *result;
+
+	if (get_sha1("HEAD", our_tree) < 0)
+		hashcpy(our_tree, EMPTY_TREE_SHA1_BIN);
+
+	if (build_fake_ancestor(state, index_path))
+		return error("could not build fake ancestor");
+
+	discard_cache();
+	read_cache_from(index_path);
+
+	if (write_index_as_tree(orig_tree, &the_index, index_path, 0, NULL))
+		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
+
+	say(state, stdout, _("Using index info to reconstruct a base tree..."));
+
+	if (!state->quiet) {
+		/*
+		 * List paths that needed 3-way fallback, so that the user can
+		 * review them with extra care to spot mismerges.
+		 */
+		struct rev_info rev_info;
+		const char *diff_filter_str = "--diff-filter=AM";
+
+		init_revisions(&rev_info, NULL);
+		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
+		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1);
+		add_pending_sha1(&rev_info, "HEAD", our_tree, 0);
+		diff_setup_done(&rev_info.diffopt);
+		run_diff_index(&rev_info, 1);
+	}
+
+	if (run_apply(state, index_path))
+		return error(_("Did you hand edit your patch?\n"
+				"It does not apply to blobs recorded in its index."));
+
+	if (write_index_as_tree(his_tree, &the_index, index_path, 0, NULL))
+		return error("could not write tree");
+
+	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
+
+	discard_cache();
 	read_cache();
 
+	/*
+	 * This is not so wrong. Depending on which base we picked, orig_tree
+	 * may be wildly different from ours, but his_tree has the same set of
+	 * wildly different changes in parts the patch did not touch, so
+	 * recursive ends up canceling them, saying that we reverted all those
+	 * changes.
+	 */
+
+	init_merge_options(&o);
+
+	o.branch1 = "HEAD";
+	o.branch2 = firstline(state->msg.buf);
+	if (state->quiet)
+		o.verbosity = 0;
+
+	if (merge_recursive_generic(&o, our_tree, his_tree, 1, bases, &result))
+		return error(_("Failed to merge in the changes."));
+
 	return 0;
 }
 
@@ -753,6 +870,7 @@ static void am_run(struct am_state *state)
 
 	while (state->cur <= state->last) {
 		const char *patch = am_path(state, msgnum(state));
+		int apply_status;
 
 		if (!file_exists(patch))
 			goto next;
@@ -765,7 +883,26 @@ static void am_run(struct am_state *state)
 
 		say(state, stdout, _("Applying: %s"), firstline(state->msg.buf));
 
-		if (run_apply(state) < 0) {
+		apply_status = run_apply(state, NULL);
+
+		if (apply_status && state->threeway) {
+			struct strbuf sb = STRBUF_INIT;
+
+			strbuf_addstr(&sb, am_path(state, "patch-merge-index"));
+			apply_status = fall_back_threeway(state, sb.buf);
+			strbuf_release(&sb);
+
+			/*
+			 * Applying the patch to an earlier tree and merging
+			 * the result may have produced the same tree as ours.
+			 */
+			if (!apply_status && !index_has_changes(NULL)) {
+				say(state, stdout, _("No changes -- Patch already applied."));
+				goto next;
+			}
+		}
+
+		if (apply_status) {
 			int value;
 
 			printf_ln(_("Patch failed at %s %s"), msgnum(state),
@@ -1017,6 +1154,8 @@ static const char * const am_usage[] = {
 };
 
 static struct option am_options[] = {
+	OPT_BOOL('3', "3way", &state.threeway,
+		N_("allow fall back on 3way merging if needed")),
 	OPT__QUIET(&state.quiet, N_("be quiet")),
 	OPT_BOOL('s', "signoff", &state.sign,
 		N_("add a Signed-off-by line to the commit message")),
-- 
2.1.4
