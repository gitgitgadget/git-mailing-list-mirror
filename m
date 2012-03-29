From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v6 4/4] push: teach --recurse-submodules the on-demand option
Date: Thu, 29 Mar 2012 09:21:24 +0200
Message-ID: <d8c60e8b0b884e62bd445c238633b67b76e5e4a6.1332968667.git.hvoigt@hvoigt.net>
References: <cover.1332968667.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>,
	Zbigniew J??drzejewski-Szmek <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 09:22:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD9ga-0002aX-3n
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 09:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758753Ab2C2HWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 03:22:14 -0400
Received: from darksea.de ([83.133.111.250]:34927 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758717Ab2C2HWM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 03:22:12 -0400
Received: (qmail 32104 invoked from network); 29 Mar 2012 09:22:10 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 29 Mar 2012 09:22:10 +0200
X-Mailer: git-send-email 1.7.10.rc2.31.gd8c60
In-Reply-To: <cover.1332968667.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1332968667.git.hvoigt@hvoigt.net>
References: <cover.1332968667.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194240>

When using this option git will search for all submodules that
have changed in the revisions to be send. It will then try to
push the currently checked out branch of each submodule.

This helps when a user has finished working on a change which
involves submodules and just wants to push everything in one go.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/git-push.txt     |   14 ++++--
 builtin/push.c                 |   10 ++++-
 submodule.c                    |   48 ++++++++++++++++++++
 submodule.h                    |    1 +
 t/t5531-deep-submodule-push.sh |   94 ++++++++++++++++++++++++++++++++++++++++
 transport.c                    |   17 +++++++-
 transport.h                    |    1 +
 7 files changed, 179 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 48760db..a52b7b1 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -170,10 +170,16 @@ useful if you write an alias or script around 'git push'.
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
---recurse-submodules=check::
-	Check whether all submodule commits used by the revisions to be
-	pushed are available on a remote tracking branch. Otherwise the
-	push will be aborted and the command will exit with non-zero status.
+--recurse-submodules=check|on-demand::
+	Make sure all submodule commits used by the revisions to be
+	pushed are available on a remote tracking branch. If 'check' is
+	used git will verify that all submodule commits that changed in
+	the revisions to be pushed are available on at least one remote
+	of the submodule. If any commits are missing the push will be
+	aborted and exit with non-zero status. If 'on-demand' is used
+	all submodules that changed in the revisions to be pushed will
+	be pushed. If on-demand was not able to push all necessary
+	revisions it will also be aborted and exit with non-zero status.
 
 
 include::urls-remotes.txt[]
diff --git a/builtin/push.c b/builtin/push.c
index d315475..f3abec8 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -224,13 +224,21 @@ static int option_parse_recurse_submodules(const struct option *opt,
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
-		die("option %s needs an argument (check)", opt->long_name);
+		die("option %s needs an argument (check|on-demand)",
+				opt->long_name);
 
 	return 0;
 }
diff --git a/submodule.c b/submodule.c
index fa7d5f4..784b580 100644
--- a/submodule.c
+++ b/submodule.c
@@ -410,6 +410,54 @@ int find_unpushed_submodules(unsigned char new_sha1[20],
 	return needs_pushing->nr;
 }
 
+static int push_submodule(const char *path)
+{
+	if (add_submodule_odb(path))
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
+		cp.dir = path;
+		if (run_command(&cp))
+			return 0;
+		close(cp.out);
+	}
+
+	return 1;
+}
+
+int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name)
+{
+	int i, ret = 1;
+	struct string_list needs_pushing;
+
+	memset(&needs_pushing, 0, sizeof(struct string_list));
+	needs_pushing.strdup_strings = 1;
+
+	if (!find_unpushed_submodules(new_sha1, remotes_name, &needs_pushing))
+		return 1;
+
+	for (i = 0; i < needs_pushing.nr; i++) {
+		const char *path = needs_pushing.items[i].string;
+		fprintf(stderr, "Pushing submodule '%s'\n", path);
+		if (!push_submodule(path)) {
+			fprintf(stderr, "Unable to push submodule '%s'\n", path);
+			ret = 0;
+		}
+	}
+
+	string_list_clear(&needs_pushing, 0);
+
+	return ret;
+}
+
 static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 {
 	int is_present = 0;
diff --git a/submodule.h b/submodule.h
index fd58690..6633b53 100644
--- a/submodule.h
+++ b/submodule.h
@@ -31,5 +31,6 @@ int merge_submodule(unsigned char result[20], const char *path, const unsigned c
 		    const unsigned char a[20], const unsigned char b[20], int search);
 int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
 		struct string_list *needs_pushing);
+int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
 
 #endif
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 30bec4b..1947c28 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -119,4 +119,98 @@ test_expect_success 'push succeeds if submodule has no remote and is on the firs
 	)
 '
 
+test_expect_success 'push unpushed submodules when not needed' '
+	(
+		cd work &&
+		(
+			cd gar/bage &&
+			git checkout master &&
+			>junk5 &&
+			git add junk5 &&
+			git commit -m "Fifth junk" &&
+			git push &&
+			git rev-parse origin/master >../../../expected
+		) &&
+		git checkout master &&
+		git add gar/bage &&
+		git commit -m "Fifth commit for gar/bage" &&
+		git push --recurse-submodules=on-demand ../pub.git master
+	) &&
+	(
+		cd submodule.git &&
+		git rev-parse master >../actual
+	) &&
+	test_cmp expected actual
+'
+
+test_expect_success 'push unpushed submodules when not needed 2' '
+	(
+		cd submodule.git &&
+		git rev-parse master >../expected
+	) &&
+	(
+		cd work &&
+		(
+			cd gar/bage &&
+			>junk6 &&
+			git add junk6 &&
+			git commit -m "Sixth junk"
+		) &&
+		>junk2 &&
+		git add junk2 &&
+		git commit -m "Second junk for work" &&
+		git push --recurse-submodules=on-demand ../pub.git master
+	) &&
+	(
+		cd submodule.git &&
+		git rev-parse master >../actual
+	) &&
+	test_cmp expected actual
+'
+
+test_expect_success 'push unpushed submodules recursively' '
+	(
+		cd work &&
+		(
+			cd gar/bage &&
+			git checkout master &&
+			> junk7 &&
+			git add junk7 &&
+			git commit -m "Seventh junk" &&
+			git rev-parse master >../../../expected
+		) &&
+		git checkout master &&
+		git add gar/bage &&
+		git commit -m "Seventh commit for gar/bage" &&
+		git push --recurse-submodules=on-demand ../pub.git master
+	) &&
+	(
+		cd submodule.git &&
+		git rev-parse master >../actual
+	) &&
+	test_cmp expected actual
+'
+
+test_expect_success 'push unpushable submodule recursively fails' '
+	(
+		cd work &&
+		(
+			cd gar/bage &&
+			git rev-parse origin/master >../../../expected &&
+			git checkout master~0 &&
+			> junk8 &&
+			git add junk8 &&
+			git commit -m "Eighth junk"
+		) &&
+		git add gar/bage &&
+		git commit -m "Eighth commit for gar/bage" &&
+		test_must_fail git push --recurse-submodules=on-demand ../pub.git master
+	) &&
+	(
+		cd submodule.git &&
+		git rev-parse master >../actual
+	) &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/transport.c b/transport.c
index a095290..7bd4f46 100644
--- a/transport.c
+++ b/transport.c
@@ -1013,6 +1013,11 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 			"not be found on any remote:\n");
 	for (i = 0; i < needs_pushing->nr; i++)
 		printf("  %s\n", needs_pushing->items[i].string);
+	fprintf(stderr, "\nPlease try\n\n"
+			"	git push --recurse-submodules=on-demand\n\n"
+			"or cd to the path and use\n\n"
+			"	git push\n\n"
+			"to push them to a remote.\n\n");
 
 	string_list_clear(needs_pushing, 0);
 
@@ -1059,7 +1064,17 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_MIRROR,
 			flags & TRANSPORT_PUSH_FORCE);
 
-		if ((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) && !is_bare_repository()) {
+		if ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) && !is_bare_repository()) {
+			struct ref *ref = remote_refs;
+			for (; ref; ref = ref->next)
+				if (!is_null_sha1(ref->new_sha1) &&
+				    !push_unpushed_submodules(ref->new_sha1,
+					    transport->remote->name))
+				    die ("Failed to push all needed submodules!");
+		}
+
+		if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
+			      TRANSPORT_RECURSE_SUBMODULES_CHECK)) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			struct string_list needs_pushing;
 
diff --git a/transport.h b/transport.h
index ce99ef8..eb6d38d 100644
--- a/transport.h
+++ b/transport.h
@@ -103,6 +103,7 @@ struct transport {
 #define TRANSPORT_PUSH_SET_UPSTREAM 32
 #define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
 #define TRANSPORT_PUSH_PRUNE 128
+#define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 256
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
-- 
1.7.10.rc2.31.gd8c60
