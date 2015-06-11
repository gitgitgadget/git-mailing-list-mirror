From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 19/19] am: implement 3-way merge
Date: Thu, 11 Jun 2015 18:22:05 +0800
Message-ID: <1434018125-31804-20-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:23:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zdv-0008FL-Ok
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbbFKKXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:23:22 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35220 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbbFKKXK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:23:10 -0400
Received: by pdbnf5 with SMTP id nf5so1994941pdb.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IbJyLpzoaJsuIgbxbd5tY7JmoLDWL93s0E4PCOGAd+c=;
        b=Qs5KbBonQG52owyE8y3JICQ91byzHfcXjstkIbk9ECWw6SiXB8U7FKGfa2QJUuThqW
         0vuQekpO4CusTIlVTGtGXG4b6p7K12tgU/DNhjRR+z4NH+1q6mBy5FF+h3Ylysc/StQH
         a0VdOjbwr8G/fPKltZoleT2o5fAS7sqb++7V4NeCfUsNsfvumJyJVxZU1u5aJlo1gzIk
         vuDwbi9lIohJp/Y4NtDBVhSR5ZGuFnf2lMWinOLduNPgPHjQFPZ9YANylO/EiGL65bGy
         5OQoO/a1FwTvlqXQKYOV9d4Mmzr7b1hz2mOdIR4H77Zcf3fw716r5A1EQ9kN4yWpHxzx
         AuVw==
X-Received: by 10.68.108.65 with SMTP id hi1mr13583227pbb.129.1434018189294;
        Thu, 11 Jun 2015 03:23:09 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.23.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:23:08 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271400>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
supported the --3way option, and if set, would attempt to do a 3-way
merge if the initial patch application fails. Re-implement this feature
through the fall_back_threeway() function.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 71fda16..8566d22 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -19,6 +19,7 @@
 #include "unpack-trees.h"
 #include "branch.h"
 #include "sequencer.h"
+#include "merge-recursive.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -76,6 +77,8 @@ struct am_state {
 	const char *resolvemsg;
 
 	int sign;
+
+	int threeway;
 };
 
 /**
@@ -659,16 +662,32 @@ static void NORETURN die_user_resolve(const struct am_state *state)
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
 
 	if (run_command(&cp))
@@ -676,8 +695,92 @@ static int run_apply(const struct am_state *state)
 
 	/* Reload index as git-apply will have modified it. */
 	discard_cache();
+	read_cache_from(index_file ? index_file : get_index_file());
+
+	return 0;
+}
+
+/*
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
+	unsigned char orig_tree[20], his_tree[20], our_tree[20];
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
+		struct child_process cp = CHILD_PROCESS_INIT;
+		cp.git_cmd = 1;
+		argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", index_path);
+		argv_array_pushl(&cp.args, "diff-index", "--cached",
+				"--diff-filter=AM", "--name-status", "HEAD", NULL);
+		run_command(&cp);
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
 
@@ -743,6 +846,7 @@ static void am_run(struct am_state *state)
 
 	while (state->cur <= state->last) {
 		const char *patch = am_path(state, msgnum(state));
+		int apply_status;
 
 		if (!file_exists(patch))
 			goto next;
@@ -755,7 +859,26 @@ static void am_run(struct am_state *state)
 
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
@@ -1007,6 +1130,8 @@ static const char * const am_usage[] = {
 };
 
 static struct option am_options[] = {
+	OPT_BOOL('3', "3way", &state.threeway,
+		N_("allow fall back on 3way merging if needed")),
 	OPT__QUIET(&state.quiet, N_("be quiet")),
 	OPT_BOOL('s', "signoff", &state.sign,
 		N_("add a Signed-off-by line to the commit message")),
-- 
2.1.4
