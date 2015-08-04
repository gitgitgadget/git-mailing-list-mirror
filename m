From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 20/45] builtin-am: implement --3way
Date: Tue,  4 Aug 2015 21:51:41 +0800
Message-ID: <1438696326-19590-21-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfM-0002W9-1N
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbbHDNxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:53:49 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36456 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbbHDNxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:47 -0400
Received: by pacgq8 with SMTP id gq8so9173259pac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tohjFYOJQhqZwsj8xGHtwh9ioxasoiqfOvN8oYv4SDk=;
        b=eYCrYReEOaE/Fz5Ub6H3cPspztzIOcYgyzOyoksHyDhN+iaM0qXRRdiahjqVvMcDLA
         V0E9KuLqKgThAb0Z/t+nsGy3xlZZDO9bNGcITdIpRyvCtQ9oyQ8WJzIjd/bM3S7GhRpw
         C3XlNiT+7t+c0xjSwK/rDPZIWIvW1PYN5+F+OpAv+WdCkh+iqXTujOYrw473S1ur9pSP
         9XEiiyo/9tGRs6WwjzC1mm3gHBnfkINdHCPrX1859eZGHdAASA5VC5AMkDv2C3unMn/l
         fsfHNmxRUwQOjO2APzehhleWcnnq/a3ZKVDy/E/OaRjyk1JE3JiifnYpcGNM8T63ycZD
         vsgg==
X-Received: by 10.68.88.69 with SMTP id be5mr8043791pbb.105.1438696426811;
        Tue, 04 Aug 2015 06:53:46 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:46 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275289>

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

Notes:
    v7
    
    * As support for am.threeWay was removed in master, this patch now
      does not implement am.threeWay as well.

 builtin/am.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 150 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 12952cf..a5d5e8c 100644
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
@@ -83,6 +85,7 @@ struct am_state {
 	int prec;
 
 	/* various operating modes and command line options */
+	int threeway;
 	int quiet;
 	int signoff;
 	const char *resolvemsg;
@@ -352,6 +355,9 @@ static void am_load(struct am_state *state)
 
 	read_commit_msg(state);
 
+	read_state_file(&sb, state, "threeway", 1);
+	state->threeway = !strcmp(sb.buf, "t");
+
 	read_state_file(&sb, state, "quiet", 1);
 	state->quiet = !strcmp(sb.buf, "t");
 
@@ -536,6 +542,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 		die(_("Failed to split patches."));
 	}
 
+	write_file(am_path(state, "threeway"), 1, state->threeway ? "t" : "f");
+
 	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
 
 	write_file(am_path(state, "sign"), 1, state->signoff ? "t" : "f");
@@ -766,16 +774,34 @@ finish:
 }
 
 /**
- * Applies current patch with git-apply. Returns 0 on success, -1 otherwise.
+ * Applies current patch with git-apply. Returns 0 on success, -1 otherwise. If
+ * `index_file` is not NULL, the patch will be applied to that index.
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
+
+	if (index_file)
+		argv_array_push(&cp.args, "--cached");
+	else
+		argv_array_push(&cp.args, "--index");
+
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
 	if (run_command(&cp))
@@ -783,8 +809,106 @@ static int run_apply(const struct am_state *state)
 
 	/* Reload index as git-apply will have modified it. */
 	discard_cache();
+	read_cache_from(index_file ? index_file : get_index_file());
+
+	return 0;
+}
+
+/**
+ * Builds an index that contains just the blobs needed for a 3way merge.
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
+	char *his_tree_name;
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
+	his_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
+	o.branch2 = his_tree_name;
+
+	if (state->quiet)
+		o.verbosity = 0;
+
+	if (merge_recursive_generic(&o, our_tree, his_tree, 1, bases, &result)) {
+		free(his_tree_name);
+		return error(_("Failed to merge in the changes."));
+	}
+
+	free(his_tree_name);
 	return 0;
 }
 
@@ -872,6 +996,7 @@ static void am_run(struct am_state *state, int resume)
 
 	while (state->cur <= state->last) {
 		const char *mail = am_path(state, msgnum(state));
+		int apply_status;
 
 		if (!file_exists(mail))
 			goto next;
@@ -889,7 +1014,26 @@ static void am_run(struct am_state *state, int resume)
 
 		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
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
 			int advice_amworkdir = 1;
 
 			printf_ln(_("Patch failed at %s %.*s"), msgnum(state),
@@ -1159,6 +1303,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	};
 
 	struct option options[] = {
+		OPT_BOOL('3', "3way", &state.threeway,
+			N_("allow fall back on 3way merging if needed")),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
 		OPT_BOOL('s', "signoff", &state.signoff,
 			N_("add a Signed-off-by line to the commit message")),
-- 
2.5.0.280.gd88bd6e
