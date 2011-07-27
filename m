From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v2 2/3] push: Don't push a repository with unpushed submodules
Date: Wed, 27 Jul 2011 20:10:49 +0200
Message-ID: <1311790250-32454-3-git-send-email-iveqy@iveqy.com>
References: <1311790250-32454-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, iveqy@iveqy.com, jens.lehmann@web.de,
	hvoigt@hvoigt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 20:10:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm8ZM-0000Fh-9q
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 20:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712Ab1G0SKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 14:10:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64048 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688Ab1G0SKo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 14:10:44 -0400
Received: by ewy4 with SMTP id 4so1448469ewy.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=i7+GDXct9L9oa6rcVCWoZ/9xrZh4klnZFi0xo6ZHq3o=;
        b=Ucfp+qnDLCR44ultQhmOX5uQsvi7F+2y7oK4jzBNVhROWD3nGV95NR29hrnRfwzNL9
         6oaEcsYCkwWBB7u0xITOISOR75j8nZ3sY0Lmr07s5kKX+8unpKDKDriwPYMAgtk0KYJ6
         Dpj1DAGL4h7jWVFcFwJi2M/3iBaY9f5XsNi9U=
Received: by 10.204.15.82 with SMTP id j18mr40870bka.90.1311790243278;
        Wed, 27 Jul 2011 11:10:43 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id s14sm38135bkw.19.2011.07.27.11.10.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 11:10:42 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qm8ZH-0008S5-I6; Wed, 27 Jul 2011 20:10:51 +0200
X-Mailer: git-send-email 1.7.6.236.g7ad21
In-Reply-To: <1311790250-32454-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177990>

When working with submodules it is easy to forget to push a submodule
to the server but pushing a super-project that contains a commit for
that submodule. The result is that the superproject points at a
submodule commit that is not avaliable on the server.

Check that all submodule commits that are about to be pushed are present
on a remote of the submodule and require forcing if that is not the
case.

This does not guarantee that all submodules a super-project needs will be
available on the server. In that case both the super-project and the
submodules would need an atomic push. This does however prevent the
human error of forgetting to push a submodule.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c                    |  115 ++++++++++++++++++++++++++++++++++++++++
 submodule.h                    |    1 +
 t/t5531-deep-submodule-push.sh |   54 ++++++++++++++++++-
 transport.c                    |    8 +++
 4 files changed, 175 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 1ba9646..3820f1b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -308,6 +308,121 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
+static int is_submodule_commit_pushed(const char *path, const unsigned char sha1[20])
+{
+	int is_pushed = 0;
+	if (!add_submodule_odb(path) && lookup_commit_reference(sha1)) {
+		struct child_process cp;
+		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
+		struct strbuf buf = STRBUF_INIT;
+
+		argv[1] = sha1_to_hex(sha1);
+		memset(&cp, 0, sizeof(cp));
+		cp.argv = argv;
+		cp.env = local_repo_env;
+		cp.git_cmd = 1;
+		cp.no_stdin = 1;
+		cp.out = -1;
+		cp.dir = path;
+		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 41))
+			is_pushed = 1;
+		close(cp.out);
+		strbuf_release(&buf);
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
+static int collect_unpushed_submodules_in_tree(const unsigned char *sha1, const char *base, int baselen,
+						const char *pathname, unsigned mode, int stage, void *context)
+{
+	int *found_unpushed_submodules = context;
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_add(&path,base,strlen(base));
+	strbuf_add(&path,pathname,strlen(pathname));
+
+	if (S_ISGITLINK(mode)) {
+		if(!is_submodule_commit_pushed(path.buf,sha1))
+			*found_unpushed_submodules = 1;
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
+		if(parent)
+			parent_commits_pushed(commit,parent,&found_unpushed_submodule);
+		else
+			tree_commits_pushed(commit,&found_unpushed_submodule);
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
index 0b55466..15474c1 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -32,7 +32,7 @@ test_expect_success push '
 	)
 '
 
-test_expect_failure 'push fails if submodule has no remote' '
+test_expect_success 'push fails if submodule has no remote' '
 	(
 		cd work/gar/bage &&
 		>junk2 &&
@@ -47,7 +47,7 @@ test_expect_failure 'push fails if submodule has no remote' '
 	)
 '
 
-test_expect_failure 'push fails if submodule commit not on remote' '
+test_expect_success 'push fails if submodule commit not on remote' '
 	(
 		cd work/gar &&
 		git clone --bare bage ../../submodule.git &&
@@ -66,7 +66,7 @@ test_expect_failure 'push fails if submodule commit not on remote' '
 	)
 '
 
-test_expect_failure 'push succeeds after commit was pushed to remote' '
+test_expect_success 'push succeeds after commit was pushed to remote' '
 	(
 		cd work/gar/bage &&
 		git push origin master
@@ -76,4 +76,52 @@ test_expect_failure 'push succeeds after commit was pushed to remote' '
 		git push ../pub.git master
 	)
 '
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
+		test_must_fail git push ../pub.git
+	)
+'
+
+test_expect_success 'push fails if submodule has no remote and is on the first superproject commit' '
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
+		test_must_fail git push origin master
+	)
+'
+
 test_done
diff --git a/transport.c b/transport.c
index c9c8056..e0fd435 100644
--- a/transport.c
+++ b/transport.c
@@ -10,6 +10,7 @@
 #include "refs.h"
 #include "branch.h"
 #include "url.h"
+#include "submodule.h"
 
 /* rsync support */
 
@@ -1041,6 +1042,13 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_MIRROR,
 			flags & TRANSPORT_PUSH_FORCE);
 
+		if(!(flags & TRANSPORT_PUSH_FORCE) && !is_bare_repository()) {
+			struct ref *ref = remote_refs;
+			for (; ref; ref = ref->next)
+				if(!is_null_sha1(ref->new_sha1) && check_for_unpushed_submodule_commits(ref->new_sha1))
+					die("There are unpushed submodules, aborting. Use -f to force a push");
+		}
+
 		push_ret = transport->push_refs(transport, remote_refs, flags);
 		err = push_had_errors(remote_refs);
 		ret = push_ret | err;
-- 
1.7.6.236.g7ad21
