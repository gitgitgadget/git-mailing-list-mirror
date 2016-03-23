From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v2 2/4] format-patch: add '--base' option to record base tree info
Date: Wed, 23 Mar 2016 16:52:25 +0800
Message-ID: <1458723147-7335-3-git-send-email-xiaolong.ye@intel.com>
References: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 09:53:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aieXg-0006rI-6e
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 09:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379AbcCWIxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 04:53:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:13327 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032AbcCWIxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 04:53:19 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP; 23 Mar 2016 01:53:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,381,1455004800"; 
   d="scan'208";a="939795341"
Received: from yexl-desktop.sh.intel.com ([10.239.159.26])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2016 01:53:17 -0700
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289604>

Maintainers or third party testers may want to know the exact base tree
the patch series applies to. Teach git format-patch a '--base' option to
record the base tree info and append this information at the end of the
_first_ message (either the cover letter or the first patch in the series).

Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 Documentation/git-format-patch.txt | 15 ++++++
 builtin/log.c                      | 98 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6821441..a5f145e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -265,6 +265,21 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
   Output an all-zero hash in each patch's From header instead
   of the hash of the commit.
 
+--base=<commit>::
+	Record the base tree information to identify the whole tree
+	the patch series applies to. For example, the patch submitter
+	has a commit history of this shape:
+
+	---P---X---Y---Z---A---B---C
+
+	where "P" is the well-known public commit (e.g. one in Linus's tree),
+	"X", "Y", "Z" are prerequisite patches in flight, and "A", "B", "C"
+	are the work being sent out, the submitter would say "format-patch
+	--base=P -3 C" (or variants thereof, e.g. with "--cover" or using
+	"Z..C" instead of "-3 C" to specify the range), and the identifiers
+	for P, X, Y, Z are appended at the end of the _first_ message (either
+	the cover letter or the first patch in the series).
+
 --root::
 	Treat the revision argument as a <revision range>, even if it
 	is just a single commit (that would normally be treated as a
diff --git a/builtin/log.c b/builtin/log.c
index 0d738d6..d3804b3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1185,6 +1185,88 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+struct base_tree_info {
+	struct object_id base_commit;
+	int nr_patch_id, alloc_patch_id;
+	struct object_id *patch_id;
+};
+
+static void prepare_bases(struct base_tree_info *bases,
+			  const char *base_commit,
+			  struct commit *prerequisite_head)
+{
+	struct commit *base = NULL, *commit;
+	struct rev_info revs;
+	struct diff_options diffopt;
+	struct object_id *patch_id;
+	unsigned char sha1[20];
+	int pos = 0;
+
+	if (!prerequisite_head)
+		return;
+	base = lookup_commit_reference_by_name(base_commit);
+	if (!base)
+		die(_("Unknown commit %s"), base_commit);
+	oidcpy(&bases->base_commit, &base->object.oid);
+
+	if (base == prerequisite_head)
+		return;
+
+	if (!in_merge_bases(base, prerequisite_head))
+		die(_("base commit should be the ancestor of revs you specified"));
+
+	init_revisions(&revs, NULL);
+	revs.max_parents = 1;
+
+	base->object.flags |= UNINTERESTING;
+	add_pending_object(&revs, &base->object, "base");
+	prerequisite_head->object.flags |= 0;
+	add_pending_object(&revs, &prerequisite_head->object, "prerequisite-head");
+
+	diff_setup(&diffopt);
+	DIFF_OPT_SET(&diffopt, RECURSIVE);
+	diff_setup_done(&diffopt);
+
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+	/*
+	 * Traverse the commits list between base and prerequisite head,
+	 * get the patch ids and stuff them in bases structure.
+	 */
+	while ((commit = get_revision(&revs)) != NULL) {
+		if (commit_patch_id(commit, &diffopt, sha1))
+			return;
+		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
+		patch_id = bases->patch_id + pos;
+		hashcpy(patch_id->hash, sha1);
+		pos++;
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
+	printf("** base-commit-info **\n");
+
+	/* Show the base commit */
+	printf("base-commit: %s\n", oid_to_hex(&bases->base_commit));
+
+	/* Show the prerequisite patches */
+	for (i = 0; i < bases->nr_patch_id; i++)
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
@@ -1209,6 +1291,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int reroll_count = -1;
 	char *branch_name = NULL;
 	char *from = NULL;
+	char *base_commit = NULL;
+	struct base_tree_info bases;
+
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
 			    N_("use [PATCH n/m] even with a single patch"),
@@ -1271,6 +1356,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
+		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
+			   N_("add prerequisite tree info to the patch series")),
 		OPT_FILENAME(0, "signature-file", &signature_file,
 				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
@@ -1507,6 +1594,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		signature = strbuf_detach(&buf, NULL);
 	}
 
+	if (base_commit) {
+		struct commit *prerequisite_head = NULL;
+		if (list[nr - 1]->parents)
+			prerequisite_head = list[nr - 1]->parents->item;
+		memset(&bases, 0, sizeof(bases));
+		reset_revision_walk();
+		prepare_bases(&bases, base_commit, prerequisite_head);
+	}
+
 	if (in_reply_to || thread || cover_letter)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
@@ -1520,6 +1616,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout,
 				  origin, nr, list, branch_name, quiet);
+		print_bases(&bases);
 		total++;
 		start_number--;
 	}
@@ -1585,6 +1682,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				       rev.mime_boundary);
 			else
 				print_signature();
+			print_bases(&bases);
 		}
 		if (!use_stdout)
 			fclose(stdout);
-- 
2.8.0.rc4.4.ga41a987
