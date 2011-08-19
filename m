From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v4 2/2] push: teach --recurse-submodules the on-demand option
Date: Sat, 20 Aug 2011 00:08:48 +0200
Message-ID: <1313791728-11328-3-git-send-email-iveqy@iveqy.com>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
Cc: iveqy@iveqy.com, hvoigt@hvoigt.net, jens.lehmann@web.de,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 00:08:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuXFH-0002Ow-6c
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 00:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab1HSWIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 18:08:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62155 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496Ab1HSWIs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 18:08:48 -0400
Received: by fxh19 with SMTP id 19so2201003fxh.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=f5Rxy4kpO44xTLCG8vaTcbvNLr7nTy/A6kS38NMeZHU=;
        b=eeBozPdF39bfAIUUkeDsUv4jsBvgFqpmrt3+wy9ZwpC4ZHFs3QNrGMQ6DImo5X5nJ5
         gdm3t45kM3GIjEFLMtopjuCqJmJZLWVi8wg/a3KSYR5+9I4qx1HJyxWUXwKe8VA5cFW8
         CjZ56BbI0K0i+TZMiNPdhbbj3NhuDk1fMkZFg=
Received: by 10.223.44.198 with SMTP id b6mr266831faf.141.1313791727046;
        Fri, 19 Aug 2011 15:08:47 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id u8sm68036fah.5.2011.08.19.15.08.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Aug 2011 15:08:45 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QuXFG-0002xT-Hj; Sat, 20 Aug 2011 00:08:54 +0200
X-Mailer: git-send-email 1.7.6.551.gfb18e
In-Reply-To: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179732>

When using this option git will search for all submodules that
have changed in the revisions to be send. It will then try to
push the currently checked out branch of each submodule.

This helps when a user has finished working on a change which
involves submodules and just wants to push everything in one go.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/git-push.txt     |   13 ++++--
 builtin/push.c                 |    7 +++
 submodule.c                    |   89 ++++++++++++++++++++++++++++++++--------
 submodule.h                    |    1 +
 t/t5531-deep-submodule-push.sh |   24 +++++++++++
 transport.c                    |   10 ++++-
 transport.h                    |    1 +
 7 files changed, 121 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index aede488..fe60d28 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -162,11 +162,14 @@ useful if you write an alias or script around 'git push'.
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
---recurse-submodules=check::
-	Check whether all submodule commits used by the revisions to be
-	pushed are available on a remote tracking branch. Otherwise the
-	push will be aborted and the command will exit with non-zero status.
-
+--recurse-submodules=<check|on-demand>::
+	Check whether all submodule commits used by the revisions to be pushed
+	are available on a remote tracking branch. If check is used the push
+	will be aborted and the command will exit with non-zero status.
+	If on-demand is used all submodules that changed in the
+	to be pushed will be pushed. If on-demand was not able
+	to push all necessary revisions it will also be aborted and exit
+	with non-zero status.
 
 include::urls-remotes.txt[]
 
diff --git a/builtin/push.c b/builtin/push.c
index 35cce53..f2ef8dd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -224,9 +224,16 @@ static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
 {
 	int *flags = opt->value;
+
+	if (*flags & (TRANSPORT_RECURSE_SUBMODULES_CHECK |
+		      TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND))
+		die("%s can only be used once.", opt->long_name);
+
 	if (arg) {
 		if (!strcmp(arg, "check"))
 			*flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
+		else if (!strcmp(arg, "on-demand"))
+			*flags |= TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND;
 		else
 			die("bad %s argument: %s", opt->long_name, arg);
 	} else
diff --git a/submodule.c b/submodule.c
index 45f508c..dc95498 100644
--- a/submodule.c
+++ b/submodule.c
@@ -8,7 +8,10 @@
 #include "diffcore.h"
 #include "refs.h"
 #include "string-list.h"
+#include "transport.h"
 
+typedef int (*needs_push_func_t)(const char *path, const unsigned char sha1[20],
+		void *data);
 static struct string_list config_name_for_path;
 static struct string_list config_fetch_recurse_submodules_for_name;
 static struct string_list config_ignore_for_name;
@@ -308,21 +311,24 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
+typedef int (*module_func_t)(const char *path, const unsigned char sha1[20], void *data);
+
 static int has_remote(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	return 1;
 }
 
-static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
+int submodule_needs_pushing(const char *path, const unsigned char sha1[20], void *data)
 {
+	int *needs_pushing = data;
+
 	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
-		return 0;
+		return 1;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp;
 		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
 		struct strbuf buf = STRBUF_INIT;
-		int needs_pushing = 0;
 
 		argv[1] = sha1_to_hex(sha1);
 		memset(&cp, 0, sizeof(cp));
@@ -336,41 +342,74 @@ static int submodule_needs_pushing(const char *path, const unsigned char sha1[20
 			die("Could not run 'git rev-list %s --not --remotes -n 1' command in submodule %s",
 				sha1_to_hex(sha1), path);
 		if (strbuf_read(&buf, cp.out, 41))
-			needs_pushing = 1;
+			*needs_pushing = 1;
 		finish_command(&cp);
 		close(cp.out);
 		strbuf_release(&buf);
-		return needs_pushing;
+		return !*needs_pushing;
 	}
 
-	return 0;
+	return 1;
+}
+
+int push_submodule(const char *path, const unsigned char sha1[20], void *data)
+{
+	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
+		return 1;
+
+	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
+		struct child_process cp;
+		const char *argv[] = {"push", NULL};
+
+		memset(&cp, 0, sizeof(cp));
+		cp.argv = argv;
+		cp.env = local_repo_env;
+		cp.git_cmd = 1;
+		cp.no_stdin = 1;
+		cp.out = -1;
+		cp.dir = path;
+		if (run_command(&cp))
+			die("Could not run 'git push' command in submodule %s", path);
+		close(cp.out);
+	}
+
+	return 1;
 }
 
+struct collect_submodules_data {
+	module_func_t func;
+	void *data;
+	int ret;
+};
+
 static void collect_submodules_from_diff(struct diff_queue_struct *q,
 					 struct diff_options *options,
 					 void *data)
 {
 	int i;
-	int *needs_pushing = data;
+	struct collect_submodules_data *me = data;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
-		if (submodule_needs_pushing(p->two->path, p->two->sha1)) {
-			*needs_pushing = 1;
+		if (!(me->ret = me->func(p->two->path, p->two->sha1, me->data)))
 			break;
-		}
 	}
 }
 
-
-static void commit_need_pushing(struct commit *commit, struct commit_list *parent, int *needs_pushing)
+static int commit_need_pushing(struct commit *commit, struct commit_list *parent,
+	module_func_t func, void *data)
 {
 	const unsigned char (*parents)[20];
 	unsigned int i, n;
 	struct rev_info rev;
 
+	struct collect_submodules_data cb;
+	cb.func = func;
+	cb.data = data;
+	cb.ret = 1;
+
 	n = commit_list_count(parent);
 	parents = xmalloc(n * sizeof(*parents));
 
@@ -382,21 +421,23 @@ static void commit_need_pushing(struct commit *commit, struct commit_list *paren
 	init_revisions(&rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = collect_submodules_from_diff;
-	rev.diffopt.format_callback_data = needs_pushing;
+	rev.diffopt.format_callback_data = &cb;
 	diff_tree_combined(commit->object.sha1, parents, n, 1, &rev);
 
 	free(parents);
+	return cb.ret;
 }
 
-int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name)
+static int inspect_superproject_commits(unsigned char new_sha1[20], const char *remotes_name,
+	module_func_t func, void *data)
 {
 	struct rev_info rev;
 	struct commit *commit;
 	const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};
 	int argc = ARRAY_SIZE(argv) - 1;
 	char *sha1_copy;
-	int needs_pushing = 0;
 	struct strbuf remotes_arg = STRBUF_INIT;
+	int do_continue = 1;
 
 	strbuf_addf(&remotes_arg, "--remotes=%s", remotes_name);
 	init_revisions(&rev, NULL);
@@ -407,13 +448,25 @@ int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remote
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
 
-	while ((commit = get_revision(&rev)) && !needs_pushing)
-		commit_need_pushing(commit, commit->parents, &needs_pushing);
+	while ((commit = get_revision(&rev)) && do_continue)
+		do_continue = commit_need_pushing(commit, commit->parents, func, data);
 
 	free(sha1_copy);
 	strbuf_release(&remotes_arg);
 
-	return needs_pushing;
+	return do_continue;
+}
+
+int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name)
+{
+	int needs_push = 0;
+	inspect_superproject_commits(new_sha1, remotes_name, submodule_needs_pushing, &needs_push);
+	return needs_push;
+}
+
+void push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name)
+{
+	inspect_superproject_commits(new_sha1, remotes_name, push_submodule, NULL);
 }
 
 static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
diff --git a/submodule.h b/submodule.h
index 799c22d..a0074aa 100644
--- a/submodule.h
+++ b/submodule.h
@@ -30,5 +30,6 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20]);
 int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name);
+void push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
 
 #endif
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 30bec4b..35820ec 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -119,4 +119,28 @@ test_expect_success 'push succeeds if submodule has no remote and is on the firs
 	)
 '
 
+test_expect_success 'push unpushed submodules' '
+	(
+		cd work &&
+		git checkout master &&
+		git push --recurse-submodules=on-demand ../pub.git master
+	)
+'
+
+test_expect_success 'push unpushed submodules when not needed' '
+	(
+		cd work &&
+		(
+			cd gar/bage &&
+			>junk4 &&
+			git add junk4 &&
+			git commit -m "junk4" &&
+			git push
+		) &&
+		git add gar/bage &&
+		git commit -m "updated submodule" &&
+		git push --recurse-submodules=on-demand ../pub.git master
+	)
+'
+
 test_done
diff --git a/transport.c b/transport.c
index d2725e5..59c90c7 100644
--- a/transport.c
+++ b/transport.c
@@ -1046,7 +1046,15 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_MIRROR,
 			flags & TRANSPORT_PUSH_FORCE);
 
-		if ((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) && !is_bare_repository()) {
+		if ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) && !is_bare_repository()) {
+			struct ref *ref = remote_refs;
+			for (; ref; ref = ref->next)
+				if (!is_null_sha1(ref->new_sha1))
+				    push_unpushed_submodules(ref->new_sha1,transport->remote->name);
+		}
+
+		if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
+			      TRANSPORT_RECURSE_SUBMODULES_CHECK)) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			for (; ref; ref = ref->next)
 				if (!is_null_sha1(ref->new_sha1) &&
diff --git a/transport.h b/transport.h
index 059b330..9d19c78 100644
--- a/transport.h
+++ b/transport.h
@@ -102,6 +102,7 @@ struct transport {
 #define TRANSPORT_PUSH_PORCELAIN 16
 #define TRANSPORT_PUSH_SET_UPSTREAM 32
 #define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
+#define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 128
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
-- 
1.7.6.551.gfb18e
