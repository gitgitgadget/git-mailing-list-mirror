From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v4 2/2] push: Don't push a repository with unpushed submodules
Date: Sun, 14 Aug 2011 10:57:42 +0200
Message-ID: <1313312262-2460-3-git-send-email-iveqy@iveqy.com>
References: <1313312262-2460-1-git-send-email-iveqy@iveqy.com>
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net,
	iveqy@iveqy.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 14 10:58:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsWWa-0002NJ-2G
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab1HNI6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 04:58:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42814 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab1HNI6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 04:58:18 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2448236bke.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=TcxFrJ2ceNJtaDmzeW0cYMhdaOhSlOwdnWp8CRiZUZQ=;
        b=ovEKEvWct1V3QA11c8emwcVyO9iWuUeV98Ho1n+apu3WUSeIqrPu07CXZi6j7jPidU
         CCJzX0ByeVjSL+YcPgVQN+5431aoCEAE21AS4jV/Ncex6Xxa0JFMZycA94N7a7W6mCAs
         oZb3NEF2ivFCyZgIyg5jYKjDCS/+4xOB2/acI=
Received: by 10.204.187.1 with SMTP id cu1mr532180bkb.48.1313312297827;
        Sun, 14 Aug 2011 01:58:17 -0700 (PDT)
Received: from kolya (1-1-3-35a.mfb.mlm.bostream.se [82.182.194.253])
        by mx.google.com with ESMTPS id zw12sm945839bkb.27.2011.08.14.01.58.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 01:58:16 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QsWWA-0000eM-5S; Sun, 14 Aug 2011 10:58:02 +0200
X-Mailer: git-send-email 1.7.6.398.g2f0e9
In-Reply-To: <1313312262-2460-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179316>

When working with submodules it is easy to forget to push a
submodule to the server but pushing a super-project that
contains a commit for that submodule. The result is that the
superproject points at a submodule commit that is not available
on the server.

This adds the option --recurse-submodules=check to push. When
using this option git will check that all submodule commits that
are about to be pushed are present on a remote of the submodule.

To be able to use a combined diff, disabling a diff callback has
been removed from combined-diff.c.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
I am not sure whether the change required for the diff callback
has other side effects. Another pair of eyes appreciated.

 Documentation/git-push.txt     |    6 ++
 builtin/push.c                 |   17 ++++++
 combine-diff.c                 |    2 +-
 submodule.c                    |  108 ++++++++++++++++++++++++++++++++++++++++
 submodule.h                    |    1 +
 t/t5531-deep-submodule-push.sh |   94 ++++++++++++++++++++++++++++++++++
 transport.c                    |    9 +++
 transport.h                    |    1 +
 8 files changed, 237 insertions(+), 1 deletions(-)

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
diff --git a/combine-diff.c b/combine-diff.c
index be67cfc..e5a0d84 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1068,7 +1068,7 @@ void diff_tree_combined(const unsigned char *sha1,
 		 * when doing combined diff.
 		 */
 		int stat_opt = (opt->output_format &
-				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));
+				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_CALLBACK));
 		if (i == 0 && stat_opt)
 			diffopts.output_format = stat_opt;
 		else
diff --git a/submodule.c b/submodule.c
index 1ba9646..45f508c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -308,6 +308,114 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
+static int has_remote(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+{
+	return 1;
+}
+
+static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
+{
+	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
+		return 0;
+
+	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
+		struct child_process cp;
+		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
+		struct strbuf buf = STRBUF_INIT;
+		int needs_pushing = 0;
+
+		argv[1] = sha1_to_hex(sha1);
+		memset(&cp, 0, sizeof(cp));
+		cp.argv = argv;
+		cp.env = local_repo_env;
+		cp.git_cmd = 1;
+		cp.no_stdin = 1;
+		cp.out = -1;
+		cp.dir = path;
+		if (start_command(&cp))
+			die("Could not run 'git rev-list %s --not --remotes -n 1' command in submodule %s",
+				sha1_to_hex(sha1), path);
+		if (strbuf_read(&buf, cp.out, 41))
+			needs_pushing = 1;
+		finish_command(&cp);
+		close(cp.out);
+		strbuf_release(&buf);
+		return needs_pushing;
+	}
+
+	return 0;
+}
+
+static void collect_submodules_from_diff(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
+{
+	int i;
+	int *needs_pushing = data;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (!S_ISGITLINK(p->two->mode))
+			continue;
+		if (submodule_needs_pushing(p->two->path, p->two->sha1)) {
+			*needs_pushing = 1;
+			break;
+		}
+	}
+}
+
+
+static void commit_need_pushing(struct commit *commit, struct commit_list *parent, int *needs_pushing)
+{
+	const unsigned char (*parents)[20];
+	unsigned int i, n;
+	struct rev_info rev;
+
+	n = commit_list_count(parent);
+	parents = xmalloc(n * sizeof(*parents));
+
+	for (i = 0; i < n; i++) {
+		hashcpy((unsigned char *)(parents + i), parent->item->object.sha1);
+		parent = parent->next;
+	}
+
+	init_revisions(&rev, NULL);
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = collect_submodules_from_diff;
+	rev.diffopt.format_callback_data = needs_pushing;
+	diff_tree_combined(commit->object.sha1, parents, n, 1, &rev);
+
+	free(parents);
+}
+
+int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name)
+{
+	struct rev_info rev;
+	struct commit *commit;
+	const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};
+	int argc = ARRAY_SIZE(argv) - 1;
+	char *sha1_copy;
+	int needs_pushing = 0;
+	struct strbuf remotes_arg = STRBUF_INIT;
+
+	strbuf_addf(&remotes_arg, "--remotes=%s", remotes_name);
+	init_revisions(&rev, NULL);
+	sha1_copy = xstrdup(sha1_to_hex(new_sha1));
+	argv[1] = sha1_copy;
+	argv[3] = remotes_arg.buf;
+	setup_revisions(argc, argv, &rev, NULL);
+	if (prepare_revision_walk(&rev))
+		die("revision walk setup failed");
+
+	while ((commit = get_revision(&rev)) && !needs_pushing)
+		commit_need_pushing(commit, commit->parents, &needs_pushing);
+
+	free(sha1_copy);
+	strbuf_release(&remotes_arg);
+
+	return needs_pushing;
+}
+
 static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 {
 	int is_present = 0;
diff --git a/submodule.h b/submodule.h
index 5350b0d..799c22d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -29,5 +29,6 @@ int fetch_populated_submodules(int num_options, const char **options,
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20]);
+int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name);
 
 #endif
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index faa2e96..4dda8b8 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -32,4 +32,98 @@ test_expect_success push '
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
+	git init --bare a
+	git clone a a1 &&
+	(
+		cd a1 &&
+		git init b
+		(
+			cd b &&
+			>junk &&
+			git add junk &&
+			git commit -m "initial"
+		) &&
+		git add b &&
+		git commit -m "added submodule" &&
+		git push --recurse-submodule=check origin master
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
index c9c8056..fa279d5 100644
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
+				    check_submodule_needs_pushing(ref->new_sha1,transport->remote->name))
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
1.7.6.398.g64865.dirty
