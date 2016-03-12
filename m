From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 04/17] builtin-rebase: parse rebase arguments into a common rebase_options struct
Date: Sat, 12 Mar 2016 18:46:24 +0800
Message-ID: <1457779597-6918-5-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh4q-0005nK-KG
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbcCLKrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:16 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33397 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbcCLKrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:08 -0500
Received: by mail-pf0-f173.google.com with SMTP id 124so101674760pfg.0
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9bfWc9z1OX6/jR7pQRHdAwiPdEJ/PQK3kQSmL+aPFF0=;
        b=v9mdKumLoFOVWoXQzSlaqmKSz8RzrH9Tl4pt586wPaueFF99TDgwdwuFN8s7lKZYTY
         /rrdUnxwqrWhnz7kdTUWvs4J7u72hwbu0L1dKr6vJdPK09LgqENb5AzPE5xa6L06nFSz
         h6gCSTxnLIliXWs/qkTjXWmOgcpZbd0ovz8OAg+/6IRBjAZ9Z8k9oaeakvqBxtMpV/pT
         GSsRjxu7AOUUGgNgzgAdIdoDazj/tIxkiNLOQGTULtQsmS6abdLMjnCp2XDOU/Pu5Vk6
         WOmE8T51n48mw5+cq74WJZxrTO+xbQIPAeMoi6CCb5L17a8IFj1Gp4DAFGtFX3o8Kcz9
         9aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9bfWc9z1OX6/jR7pQRHdAwiPdEJ/PQK3kQSmL+aPFF0=;
        b=eqFJNAGy0lRw7pEmMVdF5ecsi6lJkyDPPW1vDP4H1Ir/Q1aCkqY5f2UpO8ZyQ7JH5G
         AoAzRKDiOsETKx6CzFH4XfJIJ3H/EMhcobQGMTyEZtbWCU3CgGKQTwyPXH+uYAjKIHSC
         tRhyXf9qURHIMk8roYuXi87CoIe/G5PkG3uLd8KMZYoFoiO8SRftIxCrkJ6iTDfYPEHL
         ISYa+KKpam3u6hZMcJrP6LgDJOaxZSq684xPsCDMOOXd5Pa4t14KjhN3cofcLvUgn1Aw
         gMfCYSNRexOtZ0SxTjonn/aYhfZQdz8JVbQXL6GNve2IEVmEFmw4Na9uEVSdDFslWdNi
         0uCg==
X-Gm-Message-State: AD7BkJKJKQyVBybGa3rYvdoBsPeWEByZ7CIDq8hLDKQcxmsqsSZuWodB/J6yMKdFHHO1Gg==
X-Received: by 10.98.93.155 with SMTP id n27mr14867755pfj.88.1457779627522;
        Sat, 12 Mar 2016 02:47:07 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:06 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288732>

A non-root rebase takes 3 arguments:

* branch_name -- the branch or commit that will be rebased. If it is not
  specified, the current branch is used.

* upstream -- The upstream commit to compare against. If it is not
  specified, the configured upstream for the current branch is used.

* onto (or newbase) -- The commit to be used as the starting point to
  re-apply the commits. If it is not specified, `upstream` is used.

Since these parameters are used by all 3 rebase backends, introduce a
common rebase_options struct to hold all these options. Teach
builtin/rebase.c to handle the above arguments and store them in a
rebase_options struct. In later patches we will pass the rebase_options
struct to the appropriate backend to perform the rebase.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Makefile         |   1 +
 builtin/rebase.c | 184 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 rebase-common.c  |  28 +++++++++
 rebase-common.h  |  23 +++++++
 4 files changed, 235 insertions(+), 1 deletion(-)
 create mode 100644 rebase-common.c
 create mode 100644 rebase-common.h

diff --git a/Makefile b/Makefile
index ad98714..b29c672 100644
--- a/Makefile
+++ b/Makefile
@@ -779,6 +779,7 @@ LIB_OBJS += prompt.o
 LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
+LIB_OBJS += rebase-common.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/files-backend.o
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 04cc1bd..40176ca 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -4,6 +4,112 @@
 #include "cache.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "rebase-common.h"
+#include "remote.h"
+#include "branch.h"
+#include "refs.h"
+
+/**
+ * Used by get_curr_branch_upstream_name() as a for_each_remote() callback to
+ * retrieve the name of the remote if the repository only has one remote.
+ */
+static int get_only_remote(struct remote *remote, void *cb_data)
+{
+	const char **remote_name = cb_data;
+
+	if (*remote_name)
+		return -1;
+
+	*remote_name = remote->name;
+	return 0;
+}
+
+const char *get_curr_branch_upstream_name(void)
+{
+	const char *upstream_name;
+	struct branch *curr_branch;
+
+	curr_branch = branch_get("HEAD");
+	if (!curr_branch) {
+		fprintf_ln(stderr, _("You are not currently on a branch."));
+		fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
+		fprintf_ln(stderr, _("See git-rebase(1) for details."));
+		fprintf(stderr, "\n");
+		fprintf_ln(stderr, "    git rebase <branch>");
+		fprintf(stderr, "\n");
+		exit(1);
+	}
+
+	upstream_name = branch_get_upstream(curr_branch, NULL);
+	if (!upstream_name) {
+		const char *remote_name = NULL;
+
+		if (for_each_remote(get_only_remote, &remote_name) || !remote_name)
+			remote_name = "<remote>";
+
+		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
+		fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
+		fprintf_ln(stderr, _("See git-rebase(1) for details."));
+		fprintf(stderr, "\n");
+		fprintf_ln(stderr, "    git rebase <branch>");
+		fprintf(stderr, "\n");
+		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:"));
+		fprintf(stderr, "\n");
+		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:\n"
+		"\n"
+		"    git branch --set-upstream-to=%s/<branch> %s\n"),
+		remote_name, curr_branch->name);
+		exit(1);
+	}
+
+	return upstream_name;
+}
+
+/**
+ * Given the --onto <name>, return the onto hash
+ */
+static void get_onto_oid(const char *_onto_name, struct object_id *onto)
+{
+	char *onto_name = xstrdup(_onto_name);
+	struct commit *onto_commit;
+	char *dotdot;
+
+	dotdot = strstr(onto_name, "...");
+	if (dotdot) {
+		const char *left = onto_name;
+		const char *right = dotdot + 3;
+		struct commit *left_commit, *right_commit;
+		struct commit_list *merge_bases;
+
+		*dotdot = 0;
+		if (!*left)
+			left = "HEAD";
+		if (!*right)
+			right = "HEAD";
+
+		/* git merge-base --all $left $right */
+		left_commit = lookup_commit_reference_by_name(left);
+		right_commit = lookup_commit_reference_by_name(right);
+		if (!left_commit || !right_commit)
+			die(_("%s: there is no merge base"), _onto_name);
+
+		merge_bases = get_merge_bases(left_commit, right_commit);
+		if (merge_bases && merge_bases->next)
+			die(_("%s: there are more than one merge bases"), _onto_name);
+		else if (!merge_bases)
+			die(_("%s: there is no merge base"), _onto_name);
+
+		onto_commit = merge_bases->item;
+		free_commit_list(merge_bases);
+	} else {
+		onto_commit = lookup_commit_reference_by_name(onto_name);
+		if (!onto_commit)
+			die(_("invalid upstream %s"), onto_name);
+	}
+
+	free(onto_name);
+	oidcpy(onto, &onto_commit->object.oid);
+}
 
 static int git_rebase_config(const char *k, const char *v, void *cb)
 {
@@ -12,20 +118,96 @@ static int git_rebase_config(const char *k, const char *v, void *cb)
 
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
+	struct rebase_options rebase_opts;
+	const char *onto_name = NULL;
+	const char *branch_name;
+
 	const char * const usage[] = {
-		N_("git rebase [options]"),
+		N_("git rebase [options] [--onto <newbase>] [<upstream>] [<branch>]"),
 		NULL
 	};
 	struct option options[] = {
+		OPT_GROUP(N_("Available options are")),
+		OPT_STRING(0, "onto", &onto_name, NULL,
+			N_("rebase onto given branch instead of upstream")),
 		OPT_END()
 	};
 
 	git_config(git_rebase_config, NULL);
+	rebase_options_init(&rebase_opts);
+	rebase_opts.resolvemsg = _("\nWhen you have resolved this problem, run \"git rebase --continue\".\n"
+			"If you prefer to skip this patch, run \"git rebase --skip\" instead.\n"
+			"To check out the original branch and stop rebasing, run \"git rebase --abort\".");
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (read_cache_preload(NULL) < 0)
 		die(_("failed to read the index"));
 
+	/*
+	 * Parse command-line arguments:
+	 *    rebase [<options>] [<upstream_name>] [<branch_name>]
+	 */
+
+	/* Parse <upstream_name> into rebase_opts.upstream */
+	{
+		const char *upstream_name;
+		if (argc > 2)
+			usage_with_options(usage, options);
+		if (!argc) {
+			upstream_name = get_curr_branch_upstream_name();
+		} else {
+			upstream_name = argv[0];
+			argv++, argc--;
+			if (!strcmp(upstream_name, "-"))
+				upstream_name = "@{-1}";
+		}
+		if (get_oid_commit(upstream_name, &rebase_opts.upstream))
+			die(_("invalid upstream %s"), upstream_name);
+		if (!onto_name)
+			onto_name = upstream_name;
+	}
+
+	/*
+	 * Parse --onto <onto_name> into rebase_opts.onto and
+	 * rebase_opts.onto_name
+	 */
+	get_onto_oid(onto_name, &rebase_opts.onto);
+	rebase_opts.onto_name = xstrdup(onto_name);
+
+	/*
+	 * Parse <branch_name> into rebase_opts.orig_head and
+	 * rebase_opts.orig_refname
+	 */
+	branch_name = argv[0];
+	if (branch_name) {
+		/* Is branch_name a branch or commit? */
+		char *ref_name = xstrfmt("refs/heads/%s", branch_name);
+		struct object_id orig_head_id;
+
+		if (!read_ref(ref_name, orig_head_id.hash)) {
+			rebase_opts.orig_refname = ref_name;
+			if (get_oid_commit(ref_name, &rebase_opts.orig_head))
+				die("get_sha1_commit failed");
+		} else if (!get_oid_commit(branch_name, &rebase_opts.orig_head)) {
+			rebase_opts.orig_refname = NULL;
+			free(ref_name);
+		} else {
+			die(_("no such branch: %s"), branch_name);
+		}
+	} else {
+		/* Do not need to switch branches, we are already on it */
+		struct branch *curr_branch = branch_get("HEAD");
+
+		if (curr_branch)
+			rebase_opts.orig_refname = xstrdup(curr_branch->refname);
+		else
+			rebase_opts.orig_refname = NULL;
+
+		if (get_oid_commit("HEAD", &rebase_opts.orig_head))
+			die(_("Failed to resolve '%s' as a valid revision."), "HEAD");
+	}
+
+	rebase_options_release(&rebase_opts);
 	return 0;
 }
diff --git a/rebase-common.c b/rebase-common.c
new file mode 100644
index 0000000..5a49ac4
--- /dev/null
+++ b/rebase-common.c
@@ -0,0 +1,28 @@
+#include "cache.h"
+#include "rebase-common.h"
+
+void rebase_options_init(struct rebase_options *opts)
+{
+	oidclr(&opts->onto);
+	opts->onto_name = NULL;
+
+	oidclr(&opts->upstream);
+
+	oidclr(&opts->orig_head);
+	opts->orig_refname = NULL;
+
+	opts->resolvemsg = NULL;
+}
+
+void rebase_options_release(struct rebase_options *opts)
+{
+	free(opts->onto_name);
+	free(opts->orig_refname);
+}
+
+void rebase_options_swap(struct rebase_options *dst, struct rebase_options *src)
+{
+	struct rebase_options tmp = *dst;
+	*dst = *src;
+	*src = tmp;
+}
diff --git a/rebase-common.h b/rebase-common.h
new file mode 100644
index 0000000..db5146a
--- /dev/null
+++ b/rebase-common.h
@@ -0,0 +1,23 @@
+#ifndef REBASE_COMMON_H
+#define REBASE_COMMON_H
+
+/* common rebase backend options */
+struct rebase_options {
+	struct object_id onto;
+	char *onto_name;
+
+	struct object_id upstream;
+
+	struct object_id orig_head;
+	char *orig_refname;
+
+	const char *resolvemsg;
+};
+
+void rebase_options_init(struct rebase_options *);
+
+void rebase_options_release(struct rebase_options *);
+
+void rebase_options_swap(struct rebase_options *dst, struct rebase_options *src);
+
+#endif /* REBASE_COMMON_H */
-- 
2.7.0
