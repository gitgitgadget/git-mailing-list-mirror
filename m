From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] push: Don't push a repository with unpushed submodules
Date: Tue,  9 Aug 2011 20:15:52 +0200
Message-ID: <1312913752-21555-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, iveqy@iveqy.com, hvoigt@hvoigt.net,
	jens.lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 20:15:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqqqH-0004AU-EG
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 20:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab1HISPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 14:15:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35666 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab1HISPr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 14:15:47 -0400
Received: by fxh19 with SMTP id 19so270172fxh.19
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=N52tgv1iitr6z15rUR7r8yFkTxa72sxJOarzEKUPY+k=;
        b=ptPOAPtCJ/RyRp5gBNVoxuW3EtlaeC463MNdQsARjOJMWGup22TSMTu5HJdPBKcA+G
         0kMKE+6y6rn3j1uVWLY5LYalX7AqWhkUNt/9pCnamew7e+5ZHzjK8AO7LkdwYL+aOiVX
         ZGL6vbW8Zz/+9X6DcEI8GKEhATTKl1uJLPs4g=
Received: by 10.223.50.15 with SMTP id x15mr390374faf.147.1312913745449;
        Tue, 09 Aug 2011 11:15:45 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id i16sm130146faa.21.2011.08.09.11.15.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 09 Aug 2011 11:15:44 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QqqqK-0005cD-Mx; Tue, 09 Aug 2011 20:15:57 +0200
X-Mailer: git-send-email 1.7.6.397.gb282b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179037>

When working with submodules it is easy to forget to push a
submodule to the server but pushing a super-project that
contains a commit for that submodule. The result is that the
superproject points at a submodule commit that is not available
on the server.

This adds the option --recurse-submodules=check to push. When
using this option git will check that all submodule commits that
are about to be pushed are present on a remote of the submodule.

This does not guarantee that all submodules a super-project
needs will be available on the server. In that case both the
super-project and the submodules would need an atomic push. This
does however prevent the human error of forgetting to push a
submodule.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
We decided to make this a one patch series since by the default
the check is turned off.

The first iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/176328/focus=176327

A new test is added in this iteration to show a bug that now is fixed.

 Documentation/git-push.txt     |    6 ++
 builtin/push.c                 |   17 +++++
 submodule.c                    |  129 ++++++++++++++++++++++++++++++++++++++++
 submodule.h                    |    1 +
 t/t5531-deep-submodule-push.sh |   99 ++++++++++++++++++++++++++++++
 transport.c                    |    9 +++
 transport.h                    |    1 +
 7 files changed, 262 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 88acfcd..6ae6ba3 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -162,6 +162,12 @@ useful if you write an alias or script around 'git push'.
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
+--recurse-submodules=check::
+	Check whether all submodule commits used by the revisions to be
+	pushed are available on a remote tracking branch. Otherwise the
+	push will be aborted and the command will exit with non-zero status.
+
+
 include::urls-remotes.txt[]
 
 OUTPUT
diff --git a/builtin/push.c b/builtin/push.c
index 9cebf9e..23ba365 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -8,6 +8,7 @@
 #include "remote.h"
 #include "transport.h"
 #include "parse-options.h"
+#include "submodule.h"
 
 static const char * const push_usage[] = {
 	"git push [<options>] [<repository> [<refspec>...]]",
@@ -219,6 +220,19 @@ static int do_push(const char *repo, int flags)
 	return !!errs;
 }
 
+static int option_parse_recurse_submodules(const struct option *opt,
+				   const char *arg, int unset)
+{
+	int *flags = opt->value;
+	if (arg) {
+		if (!strcmp(arg, "check"))
+			*flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
+		else
+			die("bad %s argument: %s", opt->long_name, arg);
+	}
+	return 0;
+}
+
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
@@ -236,6 +250,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT('n' , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &flags, "check",
+			"controls recursive pushing of submodules",
+			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
diff --git a/submodule.c b/submodule.c
index 1ba9646..c44472f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -308,6 +308,135 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
+static int has_remote(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+{
+	return 1;
+}
+
+/*
+ * checks whether a certain submodule commit is pushed based on the
+ * submodules remote tracking branches. returns 1 in case no remote
+ * tracking branches are found.
+ */
+static int is_submodule_commit_pushed(const char *path, const unsigned char sha1[20])
+{
+	int is_pushed = 0;
+	if (!add_submodule_odb(path) && lookup_commit_reference(sha1)) {
+		if (for_each_remote_ref_submodule(path, has_remote, NULL)) {
+			struct child_process cp;
+			const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
+			struct strbuf buf = STRBUF_INIT;
+
+			argv[1] = sha1_to_hex(sha1);
+			memset(&cp, 0, sizeof(cp));
+			cp.argv = argv;
+			cp.env = local_repo_env;
+			cp.git_cmd = 1;
+			cp.no_stdin = 1;
+			cp.out = -1;
+			cp.dir = path;
+			if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 41))
+				is_pushed = 1;
+			close(cp.out);
+			strbuf_release(&buf);
+		} else
+			is_pushed = 1;
+	}
+	return is_pushed;
+}
+
+static void collect_unpushed_submodules_from_revs(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
+{
+	int i;
+	int *found_unpushed_submodule = data;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (!S_ISGITLINK(p->two->mode))
+			continue;
+		if (!is_submodule_commit_pushed(p->two->path, p->two->sha1)) {
+			*found_unpushed_submodule = 1;
+			break;
+		}
+	}
+}
+
+static int collect_unpushed_submodules_in_tree(const unsigned char *sha1,
+					const char *base, int baselen,
+					const char *pathname, unsigned mode,
+					int stage, void *context)
+{
+	int *found_unpushed_submodules = context;
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_add(&path, base, strlen(base));
+	strbuf_add(&path, pathname, strlen(pathname));
+
+	if (S_ISGITLINK(mode) && !is_submodule_commit_pushed(path.buf, sha1)) {
+		*found_unpushed_submodules = 1;
+		return 0;
+	}
+	return READ_TREE_RECURSIVE;
+}
+
+static void parent_commits_pushed(struct commit *commit, struct commit_list *parent, int *found_unpushed_submodule)
+{
+	while (parent) {
+		struct diff_options diff_opts;
+		diff_setup(&diff_opts);
+		DIFF_OPT_SET(&diff_opts, RECURSIVE);
+		diff_opts.output_format |= DIFF_FORMAT_CALLBACK;
+		diff_opts.format_callback = collect_unpushed_submodules_from_revs;
+		diff_opts.format_callback_data = found_unpushed_submodule;
+		if (diff_setup_done(&diff_opts) < 0)
+			die("diff_setup_done failed");
+		diff_tree_sha1(parent->item->object.sha1, commit->object.sha1, "", &diff_opts);
+		diffcore_std(&diff_opts);
+		diff_flush(&diff_opts);
+		parent = parent->next;
+	}
+}
+
+static void tree_commits_pushed(struct commit *commit, int *found_unpushed_submodule)
+{
+	struct tree * tree;
+	struct pathspec pathspec;
+	tree = parse_tree_indirect(commit->object.sha1);
+	init_pathspec(&pathspec,NULL);
+	read_tree_recursive(tree, "", 0, 0, &pathspec, collect_unpushed_submodules_in_tree,
+			    found_unpushed_submodule);
+}
+
+int check_for_unpushed_submodule_commits(unsigned char new_sha1[20])
+{
+	struct rev_info rev;
+	struct commit *commit;
+	const char *argv[] = {NULL, NULL, "--not", "--remotes", NULL};
+	int argc = ARRAY_SIZE(argv) - 1;
+	char *sha1_copy;
+	int found_unpushed_submodule = 0;
+
+	init_revisions(&rev, NULL);
+	sha1_copy = xstrdup(sha1_to_hex(new_sha1));
+	argv[1] = sha1_copy;
+	setup_revisions(argc, argv, &rev, NULL);
+	if (prepare_revision_walk(&rev))
+		die("revision walk setup failed");
+
+	while ((commit = get_revision(&rev)) && !found_unpushed_submodule) {
+		struct commit_list *parent = commit->parents;
+		if (parent)
+			parent_commits_pushed(commit, parent, &found_unpushed_submodule);
+		else
+			tree_commits_pushed(commit, &found_unpushed_submodule);
+	}
+
+	free(sha1_copy);
+	return found_unpushed_submodule;
+}
+
 static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 {
 	int is_present = 0;
diff --git a/submodule.h b/submodule.h
index 5350b0d..0a4d395 100644
--- a/submodule.h
+++ b/submodule.h
@@ -29,5 +29,6 @@ int fetch_populated_submodules(int num_options, const char **options,
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20]);
+int check_for_unpushed_submodule_commits(unsigned char sha1[20]);
 
 #endif
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index faa2e96..d3a1789 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -32,4 +32,103 @@ test_expect_success push '
 	)
 '
 
+test_expect_success 'push if submodule has no remote' '
+	(
+		cd work/gar/bage &&
+		>junk2 &&
+		git add junk2 &&
+		git commit -m "Second junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Second commit for gar/bage" &&
+		git push --recurse-submodules=check ../pub.git master
+	)
+'
+
+test_expect_success 'push fails if submodule commit not on remote' '
+	(
+		cd work/gar &&
+		git clone --bare bage ../../submodule.git &&
+		cd bage &&
+		git remote add origin ../../../submodule.git &&
+		git fetch &&
+		>junk3 &&
+		git add junk3 &&
+		git commit -m "Third junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Third commit for gar/bage" &&
+		test_must_fail git push --recurse-submodules=check ../pub.git master
+	)
+'
+
+test_expect_success 'push succeeds after commit was pushed to remote' '
+	(
+		cd work/gar/bage &&
+		git push origin master
+	) &&
+	(
+		cd work &&
+		git push --recurse-submodules=check ../pub.git master
+	)
+'
+
+test_expect_success 'push fails when commit on multiple branches if one branch has no remote' '
+	(
+		cd work/gar/bage &&
+		>junk4 &&
+		git add junk4 &&
+		git commit -m "Fourth junk"
+	) &&
+	(
+		cd work &&
+		git branch branch2 &&
+		git add gar/bage &&
+		git commit -m "Fourth commit for gar/bage" &&
+		git checkout branch2 &&
+		(
+			cd gar/bage &&
+			git checkout HEAD~1
+		) &&
+		>junk1 &&
+		git add junk1 &&
+		git commit -m "First junk" &&
+		test_must_fail git push --recurse-submodules=check ../pub.git
+	)
+'
+
+test_expect_success 'push succeeds if submodule has no remote and is on the first superproject commit' '
+	mkdir a &&
+	(
+		cd a &&
+		git init --bare
+	) &&
+	git clone a a1 &&
+	(
+		cd a1 &&
+		mkdir b &&
+		(
+			cd b &&
+			git init &&
+			>junk &&
+			git add junk &&
+			git commit -m "initial"
+		) &&
+		git add b &&
+		git commit -m "added submodule" &&
+		git push origin master
+	)
+'
+
+test_expect_success 'push succeeds when --no-recurse-submodules is used' '
+	(
+		cd work &&
+		git push ../pub.git --no-recurse-submodules
+	)
+'
+
 test_done
diff --git a/transport.c b/transport.c
index c9c8056..9c100c9 100644
--- a/transport.c
+++ b/transport.c
@@ -10,6 +10,7 @@
 #include "refs.h"
 #include "branch.h"
 #include "url.h"
+#include "submodule.h"
 
 /* rsync support */
 
@@ -1041,6 +1042,14 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_MIRROR,
 			flags & TRANSPORT_PUSH_FORCE);
 
+		if ((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) && !is_bare_repository()) {
+			struct ref *ref = remote_refs;
+			for (; ref; ref = ref->next)
+				if (!is_null_sha1(ref->new_sha1) &&
+				    check_for_unpushed_submodule_commits(ref->new_sha1))
+					die("There are unpushed submodules, aborting.");
+		}
+
 		push_ret = transport->push_refs(transport, remote_refs, flags);
 		err = push_had_errors(remote_refs);
 		ret = push_ret | err;
diff --git a/transport.h b/transport.h
index 161d724..059b330 100644
--- a/transport.h
+++ b/transport.h
@@ -101,6 +101,7 @@ struct transport {
 #define TRANSPORT_PUSH_MIRROR 8
 #define TRANSPORT_PUSH_PORCELAIN 16
 #define TRANSPORT_PUSH_SET_UPSTREAM 32
+#define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
-- 
1.7.6.397.g23ae2.dirty
