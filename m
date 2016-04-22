From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v5 2/4] format-patch: add '--base' option to record base tree info
Date: Fri, 22 Apr 2016 13:42:34 +0800
Message-ID: <1461303756-25975-3-git-send-email-xiaolong.ye@intel.com>
References: <1461303756-25975-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 07:44:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atTsz-0001Zw-C2
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 07:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbcDVFoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 01:44:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:18374 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753506AbcDVFn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 01:43:59 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 21 Apr 2016 22:43:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,516,1455004800"; 
   d="scan'208";a="950498161"
Received: from yexl-desktop.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2016 22:43:54 -0700
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1461303756-25975-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292170>

Maintainers or third party testers may want to know the exact base tree
the patch series applies to. Teach git format-patch a '--base' option
to record the base tree info and append it at the end of the first
message (either the cover letter or the first patch in the series).

The base tree info consists of the "base commit", which is a well-known
commit that is part of the stable part of the project history everybody
else works off of, and zero or more "prerequisite patches", which are
well-known patches in flight that is not yet part of the "base commit"
that need to be applied on top of "base commit" in topological order
before the patches can be applied.

The "base commit" is shown as "base-commit: " followed by the 40-hex of
the commit object name.  A "prerequisite patch" is shown as
"prerequisite-patch-id: " followed by the 40-hex "patch id", which can
be obtained by passing the patch through the "git patch-id --stable"
command.

Imagine that on top of the public commit P, you applied well-known
patches X, Y and Z from somebody else, and then built your three-patch
series A, B, C, the history would be like:

---P---X---Y---Z---A---B---C

With "git format-patch --base=P -3 C" (or variants thereof, e.g. with
"--cover-letter" of using "Z..C" instead of "-3 C" to specify the
range), the base tree information block is shown at the end of the
first message the command outputs (either the first patch, or the
cover letter), like this:

base-commit: P
prerequisite-patch-id: X
prerequisite-patch-id: Y
prerequisite-patch-id: Z

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Wu Fengguang <fengguang.wu@intel.com>
Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 Documentation/git-format-patch.txt |  54 ++++++++++++++
 builtin/log.c                      | 139 +++++++++++++++++++++++++++++++++++++
 t/t4014-format-patch.sh            |  15 ++++
 3 files changed, 208 insertions(+)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6821441..1d790f1 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -265,6 +265,11 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
   Output an all-zero hash in each patch's From header instead
   of the hash of the commit.
 
+--base=<commit>::
+	Record the base tree information to identify the state the
+	patch series applies to.  See the BASE TREE INFORMATION section
+	below for details.
+
 --root::
 	Treat the revision argument as a <revision range>, even if it
 	is just a single commit (that would normally be treated as a
@@ -520,6 +525,55 @@ This should help you to submit patches inline using KMail.
 5. Back in the compose window: add whatever other text you wish to the
    message, complete the addressing and subject fields, and press send.
 
+BASE TREE INFORMATION
+---------------------
+
+The base tree information block is used for maintainers or third party
+testers to know the exact state the patch series applies to. It consists
+of the 'base commit', which is a well-known commit that is part of the
+stable part of the project history everybody else works off of, and zero
+or more 'prerequisite patches', which are well-known patches in flight
+that is not yet part of the 'base commit' that need to be applied on top
+of 'base commit' in topological order before the patches can be applied.
+
+The 'base commit' is shown as "base-commit: " followed by the 40-hex of
+the commit object name.  A 'prerequisite patch' is shown as
+"prerequisite-patch-id: " followed by the 40-hex 'patch id', which can
+be obtained by passing the patch through the `git patch-id --stable`
+command.
+
+Imagine that on top of the public commit P, you applied well-known
+patches X, Y and Z from somebody else, and then built your three-patch
+series A, B, C, the history would be like:
+
+................................................
+---P---X---Y---Z---A---B---C
+................................................
+
+With `git format-patch --base=P -3 C` (or variants thereof, e.g. with
+`--cover-letter` of using `Z..C` instead of `-3 C` to specify the
+range), the base tree information block is shown at the end of the
+first message the command outputs (either the first patch, or the
+cover letter), like this:
+
+------------
+base-commit: P
+prerequisite-patch-id: X
+prerequisite-patch-id: Y
+prerequisite-patch-id: Z
+------------
+
+For non-linear topology, such as
+
+................................................
+---P---X---A---M---C
+    \         /
+     Y---Z---B
+................................................
+
+You can also use `git format-patch --base=P -3 C` to generate patches
+for A, B and C, and the identifiers for P, X, Y, Z are appended at the
+end of the first message.
 
 EXAMPLES
 --------
diff --git a/builtin/log.c b/builtin/log.c
index dff3fbb..ee332ab 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1191,6 +1191,131 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+struct base_tree_info {
+	struct object_id base_commit;
+	int nr_patch_id, alloc_patch_id;
+	struct object_id *patch_id;
+};
+
+static struct commit *get_base_commit(const char *base_commit,
+				      struct commit **list,
+				      int total)
+{
+	struct commit *base = NULL;
+	struct commit **rev;
+	int i = 0, rev_nr = 0;
+
+	base = lookup_commit_reference_by_name(base_commit);
+	if (!base)
+		die(_("Unknown commit %s"), base_commit);
+
+	ALLOC_ARRAY(rev, total);
+	for (i = 0; i < total; i++)
+		rev[i] = list[i];
+
+	rev_nr = total;
+	/*
+	 * Get merge base through pair-wise computations
+	 * and store it in rev[0].
+	 */
+	while (rev_nr > 1) {
+		for (i = 0; i < rev_nr / 2; i++) {
+			struct commit_list *merge_base;
+			merge_base = get_merge_bases(rev[2 * i], rev[2 * i + 1]);
+			if (!merge_base || merge_base->next)
+				die(_("Failed to find exact merge base"));
+
+			rev[i] = merge_base->item;
+		}
+
+		if (rev_nr % 2)
+			rev[i] = rev[2 * i];
+		rev_nr = (rev_nr + 1) / 2;
+	}
+
+	if (!in_merge_bases(base, rev[0]))
+		die(_("base commit should be the ancestor of revision list"));
+
+	for (i = 0; i < total; i++) {
+		if (base == list[i])
+			die(_("base commit shouldn't be in revision list"));
+	}
+
+	free(rev);
+	return base;
+}
+
+static void prepare_bases(struct base_tree_info *bases,
+			  struct commit *base,
+			  struct commit **list,
+			  int total)
+{
+	struct commit *commit;
+	struct rev_info revs;
+	struct diff_options diffopt;
+	int i;
+
+	if (!base)
+		return;
+
+	diff_setup(&diffopt);
+	DIFF_OPT_SET(&diffopt, RECURSIVE);
+	diff_setup_done(&diffopt);
+
+	oidcpy(&bases->base_commit, &base->object.oid);
+
+	init_revisions(&revs, NULL);
+	revs.max_parents = 1;
+	revs.topo_order = 1;
+	for (i = 0; i < total; i++) {
+		list[i]->object.flags &= ~UNINTERESTING;
+		add_pending_object(&revs, &list[i]->object, "rev_list");
+		list[i]->util = (void *)1;
+	}
+	base->object.flags |= UNINTERESTING;
+	add_pending_object(&revs, &base->object, "base");
+
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+	/*
+	 * Traverse the commits list, get prerequisite patch ids
+	 * and stuff them in bases structure.
+	 */
+	while ((commit = get_revision(&revs)) != NULL) {
+		unsigned char sha1[20];
+		struct object_id *patch_id;
+		if (commit->util)
+			continue;
+		if (commit_patch_id(commit, &diffopt, sha1))
+			die(_("cannot get patch id"));
+		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
+		patch_id = bases->patch_id + bases->nr_patch_id;
+		hashcpy(patch_id->hash, sha1);
+		bases->nr_patch_id++;
+	}
+}
+
+static void print_bases(struct base_tree_info *bases)
+{
+	int i;
+
+	/* Only do this once, either for the cover or for the first one */
+	if (is_null_oid(&bases->base_commit))
+		return;
+
+	/* Show the base commit */
+	printf("base-commit: %s\n", oid_to_hex(&bases->base_commit));
+
+	/* Show the prerequisite patches */
+	for (i = bases->nr_patch_id - 1; i >= 0; i--)
+		printf("prerequisite-patch-id: %s\n", oid_to_hex(&bases->patch_id[i]));
+
+	free(bases->patch_id);
+	bases->nr_patch_id = 0;
+	bases->alloc_patch_id = 0;
+	oidclr(&bases->base_commit);
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -1215,6 +1340,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int reroll_count = -1;
 	char *branch_name = NULL;
 	char *from = NULL;
+	char *base_commit = NULL;
+	struct base_tree_info bases;
+
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
 			    N_("use [PATCH n/m] even with a single patch"),
@@ -1277,6 +1405,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
+		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
+			   N_("add prerequisite tree info to the patch series")),
 		OPT_FILENAME(0, "signature-file", &signature_file,
 				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
@@ -1514,6 +1644,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		signature = strbuf_detach(&buf, NULL);
 	}
 
+	memset(&bases, 0, sizeof(bases));
+	if (base_commit) {
+		struct commit *base = get_base_commit(base_commit, list, nr);
+		reset_revision_walk();
+		prepare_bases(&bases, base, list, nr);
+	}
+
 	if (in_reply_to || thread || cover_letter)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
@@ -1527,6 +1664,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout,
 				  origin, nr, list, branch_name, quiet);
+		print_bases(&bases);
 		total++;
 		start_number--;
 	}
@@ -1592,6 +1730,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				       rev.mime_boundary);
 			else
 				print_signature();
+			print_bases(&bases);
 		}
 		if (!use_stdout)
 			fclose(stdout);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index eed2981..a6ce727 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1460,4 +1460,19 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 	test_path_is_dir patchset
 '
 
+test_expect_success 'format-patch --base' '
+	git checkout side &&
+	git format-patch --stdout --base=HEAD~~~ -1 >patch &&
+	grep -e "^base-commit:" -A3 patch >actual &&
+	echo "base-commit: $(git rev-parse HEAD~~~)" >expected &&
+	echo "prerequisite-patch-id: $(git show --patch HEAD~~ | git patch-id --stable | awk "{print \$1}")" >>expected &&
+	echo "prerequisite-patch-id: $(git show --patch HEAD~ | git patch-id --stable | awk "{print \$1}")" >>expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'format-patch --base error handling' '
+	! git format-patch --base=HEAD~ -2 &&
+	! git format-patch --base=HEAD~ -3
+'
+
 test_done
-- 
2.8.1.221.ga4c6ba7
