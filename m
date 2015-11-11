From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH 1/5] ff-refs: builtin cmd to check and fast forward local refs to their upstream
Date: Tue, 10 Nov 2015 21:11:21 -0500
Message-ID: <1447207885-10911-2-git-send-email-rappazzo@gmail.com>
References: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net,
	dturner@twopensource.com, pclouds@gmail.com,
	sunshine@sunshineco.com, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 11 03:13:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwKuc-0007Gn-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 03:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbbKKCNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 21:13:22 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36041 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbbKKCNV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 21:13:21 -0500
Received: by ykdr82 with SMTP id r82so28097279ykd.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 18:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=25lzx3Sil6MipyHbIXMgzERehLfXL6Bpn1257HU3Rbg=;
        b=rFw2RqNS3hmK7C2L/Oja5dDblOfXvLbC9LiigJKbuW3AX0FUbdPQCtfOyZ8gPDAoue
         lenBE3bJ/fQ884wL+kECEjcIOiGyDoUp5HJioOu0LCiPKD2AqIpzlvjmnnKe0M92+/Im
         ej7BBZXgsFEc0sI2OuIdZen/VfpMQPpVQ9LmeeWSMa4GLkyaI824K66E/VzG+KLhCT7i
         WziGAzNe2N+K6H3vPw3Gwz5hPl1K9FiPa1F4yQLCEE4MqO1pTJpeFH3FY7JJ4rBWUQs3
         ptrfdhRWPlYDdUmETowYGZuam/WUB6cXAPF8jSWGpeh3ok7ZVwqLD2EM1vYGciPnka5g
         UG0Q==
X-Received: by 10.129.82.18 with SMTP id g18mr6724216ywb.234.1447208000519;
        Tue, 10 Nov 2015 18:13:20 -0800 (PST)
Received: from localhost.localdomain (ool-18e4990e.dyn.optonline.net. [24.228.153.14])
        by smtp.gmail.com with ESMTPSA id m128sm7948819ywm.34.2015.11.10.18.13.19
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Nov 2015 18:13:19 -0800 (PST)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281143>

Each local branch with an upstream remote is checked to see if it can be
fast-forwarded to its upstream.  If fast-forward applies to the branch,
then this is reported to the user.

The statuses are
	UP-TO-DATE - The local branch is the same or equal to the upstream
	WOULD-UPDATE - The branch would be fast forwarded
	REMOTE-MISSING - The branch is tracking an upstream that is not present
	NON-FAST-FORWARD - The branch has diverged from the upstream

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 .gitignore        |   1 +
 Makefile          |   1 +
 builtin.h         |   1 +
 builtin/ff-refs.c | 221 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 command-list.txt  |   1 +
 git.c             |   1 +
 6 files changed, 226 insertions(+)
 create mode 100644 builtin/ff-refs.c

diff --git a/.gitignore b/.gitignore
index 1c2f832..e86a490 100644
--- a/.gitignore
+++ b/.gitignore
@@ -53,6 +53,7 @@
 /git-difftool--helper
 /git-describe
 /git-fast-export
+/git-ff-refs
 /git-fast-import
 /git-fetch
 /git-fetch-pack
diff --git a/Makefile b/Makefile
index 43ceeb9..8e312ad 100644
--- a/Makefile
+++ b/Makefile
@@ -853,6 +853,7 @@ BUILTIN_OBJS += builtin/diff.o
 BUILTIN_OBJS += builtin/fast-export.o
 BUILTIN_OBJS += builtin/fetch-pack.o
 BUILTIN_OBJS += builtin/fetch.o
+BUILTIN_OBJS += builtin/ff-refs.o
 BUILTIN_OBJS += builtin/fmt-merge-msg.o
 BUILTIN_OBJS += builtin/for-each-ref.o
 BUILTIN_OBJS += builtin/fsck.o
diff --git a/builtin.h b/builtin.h
index 6b95006..5680e33 100644
--- a/builtin.h
+++ b/builtin.h
@@ -63,6 +63,7 @@ extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_fast_export(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
+extern int cmd_ff_refs(int argc, const char **argv, const char *prefix);
 extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
 extern int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
diff --git a/builtin/ff-refs.c b/builtin/ff-refs.c
new file mode 100644
index 0000000..94a4649
--- /dev/null
+++ b/builtin/ff-refs.c
@@ -0,0 +1,221 @@
+#include "cache.h"
+#include "refs.h"
+#include "builtin.h"
+#include "remote.h"
+#include "run-command.h"
+#include "worktree.h"
+
+struct worktree **worktrees;
+const char *padding = ".....................................................";
+
+static const char * const builtin_ff_refs_usage[] = {
+	N_("git ff-refs [<options>]"),
+	NULL
+};
+
+enum ff_result_type {
+	UP_TO_DATE,
+	UPDATABLE,
+	REMOTE_MISSING,
+	NON_FAST_FORWARD,
+	UNABLE_TO_UPDATE
+};
+
+struct ff_ref_details {
+	struct branch *branch;
+	const char *upstream;
+	const char *shortened_upstream;
+	int names_length;
+	enum ff_result_type result_type;
+
+	struct commit *branch_commit;
+	struct commit *upstream_commit;
+	struct commit *merge_base;
+	struct worktree *wt;
+};
+
+struct ff_ref_data {
+	int max_names_length;
+
+	int detail_counter;
+	int detail_alloc;
+	struct ff_ref_details **detail_list;
+};
+
+static const char *result_type_str(enum ff_result_type result_type)
+{
+	switch (result_type) {
+	case UP_TO_DATE:
+		return _("UP-TO-DATE");
+	case UPDATABLE:
+		return _("WOULD-UPDATE");
+	case REMOTE_MISSING:
+		return _("REMOTE-MISSING");
+	case NON_FAST_FORWARD:
+		return _("NON-FAST-FORWARD");
+	default:
+		return _("UNABLE-TO-UPDATE");
+	}
+}
+
+/**
+ * return the worktree with the given refname checked out, or NULL if that
+ * ref is not checked out in any branch.
+ *
+ * This implementation assumes a small number of worktrees (since it loops
+ * through each worktree for every ref).  If a repository has a large number
+ * of worktrees, then it might be beneficial to implement this as a hashmap
+ * lookup instead.
+ */
+static struct worktree *find_worktree(const char *refname)
+{
+	int i = 0;
+
+	for (i = 0; worktrees[i]; i++) {
+		if (!worktrees[i]->is_detached && !strcmp(worktrees[i]->head_ref, refname)) {
+			return worktrees[i];
+		}
+	}
+	return NULL;
+}
+
+/**
+ * After all of the relevant refs have been collected, process the
+ * interesting ones
+ */
+static void process_refs(struct ff_ref_data *data)
+{
+	int i = 0;
+
+	for (i = 0; data->detail_list[i]; i++) {
+		struct ff_ref_details *details;
+		int padLen;
+
+		details = data->detail_list[i];
+		padLen = 3 + data->max_names_length - details->names_length;
+		if (padLen < 0)
+			padLen = 0;
+
+		printf("     %s -> %s%*.*s",
+			details->branch->name, details->shortened_upstream, padLen, padLen, padding);
+		printf("[%s]\n", result_type_str(details->result_type));
+	}
+}
+
+static void add_to_detail_list(struct ff_ref_data *data,
+		struct ff_ref_details *details)
+{
+	if (!data->detail_alloc) {
+		data->detail_list = xmalloc(sizeof(struct ff_ref_details *));
+		data->detail_alloc = 1;
+	} else
+		ALLOC_GROW(data->detail_list, data->detail_counter + 1, data->detail_alloc);
+
+	if (details && details->names_length > data->max_names_length)
+		data->max_names_length = details->names_length;
+
+	data->detail_list[data->detail_counter++] = details;
+}
+
+/**
+ * Look for refs which have an upstream configured.  Each ref with an upstream
+ * is added to a list to later possibly make changes on.  All of the necessary
+ * read-only data is gleaned here.
+ */
+static int analize_refs(const char *refname,
+			const struct object_id *oid, int flags, void *cb_data) {
+
+	struct branch *branch;
+	const char *upstream;
+	struct ff_ref_data *data = cb_data;
+
+	branch = branch_get(shorten_unambiguous_ref(refname, 0));
+	upstream = branch_get_upstream(branch, NULL);
+	if (upstream) {
+		struct ff_ref_details *details = xmalloc(sizeof(struct ff_ref_details));
+		unsigned char upstream_hash[GIT_SHA1_RAWSZ];
+
+		details->branch = branch;
+		details->upstream = upstream;
+
+		details->shortened_upstream = shorten_unambiguous_ref(upstream, 0);
+		details->branch_commit = NULL;
+		details->upstream_commit = NULL;
+		details->merge_base = NULL;
+		details->result_type = UNABLE_TO_UPDATE;
+		details->names_length = strlen(branch->name) +
+				strlen(details->shortened_upstream);
+		details->wt = find_worktree(details->branch->refname);
+
+		if (!resolve_ref_unsafe(details->upstream, RESOLVE_REF_READING,
+				upstream_hash, NULL))
+			details->result_type = REMOTE_MISSING;
+
+		else if (!hashcmp(oid->hash, upstream_hash))
+			details->result_type = UP_TO_DATE;
+		else {
+			struct commit_list *bases;
+
+			details->branch_commit = lookup_commit_reference(oid->hash);
+			details->upstream_commit = lookup_commit_reference(upstream_hash);
+			bases = get_merge_bases(details->branch_commit,
+					details->upstream_commit);
+			details->merge_base = bases->item;
+
+			if (!hashcmp(upstream_hash, details->merge_base->object.sha1))
+				details->result_type = UP_TO_DATE;
+
+			else if (!in_merge_bases(details->branch_commit, details->upstream_commit))
+				details->result_type = NON_FAST_FORWARD;
+
+			else
+				details->result_type = UPDATABLE;
+		}
+		add_to_detail_list(data, details);
+	}
+	return 0;
+}
+
+/**
+ * Free the memory allocated for all of the data
+ */
+static void free_data(struct ff_ref_data *data)
+{
+	int i = 0;
+
+	for (i = 0; data->detail_list[i]; i++)
+		free(data->detail_list[i]);
+	free(data);
+}
+
+int cmd_ff_refs(int argc, const char **argv, const char *prefix)
+{
+	int ret = 0;
+
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, builtin_ff_refs_usage, 0);
+	if (argc)
+		usage_with_options(builtin_ff_refs_usage, options);
+	else {
+		struct ff_ref_data *data = NULL;
+
+		worktrees = get_worktrees();
+		data = xmalloc(sizeof(struct ff_ref_data));
+		data->detail_alloc = 0;
+		data->detail_counter = 0;
+		data->max_names_length = 0;
+
+		ret = for_each_ref(&analize_refs, data);
+		add_to_detail_list(data, NULL);
+
+		//for each detail
+		process_refs(data);
+
+		free_worktrees(worktrees);
+		free_data(data);
+	}
+	return ret;
+}
diff --git a/command-list.txt b/command-list.txt
index 2a94137..b766ea8 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -54,6 +54,7 @@ git-fast-export                         ancillarymanipulators
 git-fast-import                         ancillarymanipulators
 git-fetch                               mainporcelain           remote
 git-fetch-pack                          synchingrepositories
+git-ff-refs                             mainporcelain           history
 git-filter-branch                       ancillarymanipulators
 git-fmt-merge-msg                       purehelpers
 git-for-each-ref                        plumbinginterrogators
diff --git a/git.c b/git.c
index 6ed824c..1c75156 100644
--- a/git.c
+++ b/git.c
@@ -404,6 +404,7 @@ static struct cmd_struct commands[] = {
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
+	{ "ff-refs", cmd_ff_refs, RUN_SETUP },
 	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
-- 
2.6.2
