From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 3/8] branch: add --set-publish-to option
Date: Sun, 20 Apr 2014 14:45:01 -0500
Message-ID: <1398023106-25958-4-git-send-email-felipe.contreras@gmail.com>
References: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:56:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbxqM-0006Pk-Uk
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536AbaDTTz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:55:59 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:42139 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490AbaDTTzg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:55:36 -0400
Received: by mail-yh0-f41.google.com with SMTP id i57so2998786yha.0
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CTLNq3LB+JROPQkG5qJceVR8sw55jcsLj19vDFJBs2s=;
        b=HjDag2Js41Ge7P58blWulXr6liLKu0KTNWWQOa3uXdUX2PxolzQ4kYchubQomjEOVd
         Kh8VcWp+gEVSTkWzy9x9elgHqBPC07DUWgWlP+21D1tSR7sZVAkB1Va5M59WDwiXrLK+
         v4rc1ee8x9D22kKLNi04oJv6AzE5A0hfTKXaMSerqr8CPqnhFkMOxda/+iqeBW85gEZy
         gIe1iplcx7yXh2oE70+k4qQFDuZE8EH51W+FQXtcaGnQz62Vd/njHKwN5893vAnKVBXl
         0drprRXtC5p6Ru4kbbMouV1KLJHLjoRpJQ8sEmWmxVrgvBSz7qVgcsF5UEZ8aACQaN09
         7CoQ==
X-Received: by 10.236.20.194 with SMTP id p42mr46952724yhp.56.1398023736126;
        Sun, 20 Apr 2014 12:55:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id q66sm65564817yhj.44.2014.04.20.12.55.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:55:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246570>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-branch.txt | 11 +++++++
 branch.c                     | 44 +++++++++++++++++++++++++
 branch.h                     |  2 ++
 builtin/branch.c             | 57 ++++++++++++++++++++++++++++++---
 t/t3200-branch.sh            | 76 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 185 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 311b336..914fd62 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -14,7 +14,9 @@ SYNOPSIS
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
+'git branch' (--set-publish-to=<publish> | -p <publish>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
+'git branch' --unset-publish [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
@@ -191,6 +193,15 @@ start-point is either a local or remote-tracking branch.
 	Remove the upstream information for <branchname>. If no branch
 	is specified it defaults to the current branch.
 
+-p <publish>::
+--set-publish-to=<publish>::
+	Set up <branchname>'s publish tracking information. If no
+	<branchname> is specified, then it defaults to the current branch.
+
+--unset-publish::
+	Remove the publish information for <branchname>. If no branch
+	is specified it defaults to the current branch.
+
 --edit-description::
 	Open an editor and edit the text to explain what the branch is
 	for, to be used by various other commands (e.g. `request-pull`).
diff --git a/branch.c b/branch.c
index 723a36b..090b3d1 100644
--- a/branch.c
+++ b/branch.c
@@ -144,6 +144,50 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	return 0;
 }
 
+void install_branch_publish(const char *name, const char *remote, const char *remote_ref)
+{
+	struct strbuf key = STRBUF_INIT;
+
+	if (!remote && !strcmp(name, remote_ref + 11) &&
+			starts_with(remote_ref, "refs/heads")) {
+		warning(_("Not setting branch %s as its own publish branch."), name);
+		return;
+	}
+
+	strbuf_addf(&key, "branch.%s.pushremote", name);
+	git_config_set(key.buf, remote ? remote : ".");
+
+	strbuf_reset(&key);
+	strbuf_addf(&key, "branch.%s.push", name);
+	git_config_set(key.buf, remote_ref);
+
+	strbuf_release(&key);
+}
+
+int setup_publish(const char *name, const char *ref)
+{
+	struct tracking tracking;
+	const char *remote, *remote_ref;
+
+	memset(&tracking, 0, sizeof(tracking));
+	tracking.spec.dst = (char *)ref;
+	if (for_each_remote(find_tracked_branch, &tracking))
+		return 1;
+
+	if (tracking.matches > 1)
+		return error(_("Not tracking: ambiguous information for ref %s"),
+				ref);
+
+	remote = tracking.remote;
+	remote_ref = tracking.src ? tracking.src : ref;
+
+	install_branch_publish(name, remote, remote_ref);
+
+	free(tracking.src);
+
+	return 0;
+}
+
 struct branch_desc_cb {
 	const char *config_name;
 	const char *value;
diff --git a/branch.h b/branch.h
index 64173ab..c9b6aa9 100644
--- a/branch.h
+++ b/branch.h
@@ -51,5 +51,7 @@ extern void install_branch_config(int flag, const char *local, const char *origi
  * Read branch description
  */
 extern int read_branch_desc(struct strbuf *, const char *branch_name);
+extern int setup_publish(const char *name, const char *ref);
+extern void install_branch_publish(const char *name, const char *remote, const char *remote_ref);
 
 #endif
diff --git a/builtin/branch.c b/builtin/branch.c
index b4d7716..17773d7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -793,8 +793,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int delete = 0, rename = 0, force_create = 0, list = 0;
 	int verbose = 0, abbrev = -1, detached = 0;
 	int reflog = 0, edit_description = 0;
-	int quiet = 0, unset_upstream = 0;
-	const char *new_upstream = NULL;
+	int quiet = 0, unset_upstream = 0, unset_publish = 0;
+	const char *new_upstream = NULL, *publish = NULL;
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
@@ -809,7 +809,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT( 0, "set-upstream",  &track, N_("change upstream info"),
 			BRANCH_TRACK_OVERRIDE),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "change the upstream info"),
+		OPT_STRING('p', "set-publish-to", &publish, "publish", "change the publish info"),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
+		OPT_BOOL(0, "unset-publish", &unset_publish, "Unset the publish info"),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
 		OPT_SET_INT('r', "remotes",     &kinds, N_("act on remote-tracking branches"),
 			REF_REMOTE_BRANCH),
@@ -878,14 +880,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
-	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
+	if (!delete && !rename && !edit_description && !new_upstream && !publish &&
+	    !unset_upstream && !unset_publish && argc == 0)
 		list = 1;
 
 	if (with_commit || merge_filter != NO_FILTER)
 		list = 1;
 
-	if (!!delete + !!rename + !!force_create + !!new_upstream +
-	    list + unset_upstream > 1)
+	if (!!delete + !!rename + !!force_create + !!new_upstream + !!publish +
+	    list + unset_upstream + unset_publish > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (abbrev == -1)
@@ -990,6 +993,50 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&buf, "branch.%s.merge", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, 1);
 		strbuf_release(&buf);
+	} else if (publish) {
+		struct branch *branch = branch_get(argv[0]);
+		char *real_ref = NULL;
+		unsigned char sha1[20];
+
+		if (argc > 1)
+			die(_("too many branches to set new publish branch"));
+
+		if (!branch) {
+			if (!argc || !strcmp(argv[0], "HEAD"))
+				die(_("could not set publish branch of HEAD when "
+				      "it does not point to any branch."));
+			die(_("no such branch '%s'"), argv[0]);
+		}
+
+		if (!ref_exists(branch->refname))
+			die(_("branch '%s' does not exist"), branch->name);
+
+		if (dwim_ref(publish, strlen(publish), sha1, &real_ref) != 1 ||
+				setup_publish(branch->name, real_ref))
+			die(_("Cannot setup publish branch to '%s'."), publish);
+	} else if (unset_publish) {
+		struct branch *branch = branch_get(argv[0]);
+		struct strbuf buf = STRBUF_INIT;
+
+		if (argc > 1)
+			die(_("too many branches to unset publish branch"));
+
+		if (!branch) {
+			if (!argc || !strcmp(argv[0], "HEAD"))
+				die(_("could not unset publish branch of HEAD when "
+				      "it does not point to any branch."));
+			die(_("no such branch '%s'"), argv[0]);
+		}
+
+		if (!branch->push_name)
+			die(_("Branch '%s' has no publish information"), branch->name);
+
+		strbuf_addf(&buf, "branch.%s.pushremote", branch->name);
+		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "branch.%s.push", branch->name);
+		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
 		struct branch *branch = branch_get(argv[0]);
 		int branch_existed = 0, remote_tracking = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fcdb867..8cd21d1 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -907,4 +907,80 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
 	)
 '
 
+test_expect_success '--set-publish-to fails on multiple branches' '
+	test_must_fail git branch --set-publish-to master a b c
+'
+
+test_expect_success '--set-publish-to fails on detached HEAD' '
+	test_when_finished "git checkout master" &&
+	git checkout master^{} &&
+	test_must_fail git branch --set-publish-to master
+'
+
+test_expect_success '--set-publish-to fails on a missing dst branch' '
+	test_must_fail git branch --set-publish-to master does-not-exist
+'
+
+test_expect_success '--set-publish-to fails on a missing src branch' '
+	test_must_fail git branch --set-publish-to does-not-exist master
+'
+
+test_expect_success '--set-publish-to fails on a non-ref' '
+	test_must_fail git branch --set-publish-to HEAD^{}
+'
+
+test_expect_success 'use --set-publish-to modify HEAD' '
+	git checkout master &&
+	test_config branch.master.pushremote foo &&
+	test_config branch.master.push foo &&
+	git branch -f test &&
+	git branch --set-publish-to test &&
+	test "$(git config branch.master.pushremote)" = "." &&
+	test "$(git config branch.master.push)" = "refs/heads/test"
+'
+
+test_expect_success 'use --set-publish-to modify a particular branch' '
+	git branch -f test &&
+	git branch -f test2 &&
+	git branch --set-publish-to test2 test &&
+	test "$(git config branch.test.pushremote)" = "." &&
+	test "$(git config branch.test.push)" = "refs/heads/test2"
+'
+
+test_expect_success '--unset-publish should fail if given a non-existent branch' '
+	test_must_fail git branch --unset-publish i-dont-exist
+'
+
+test_expect_success 'test --unset-publish on HEAD' '
+	git checkout master &&
+	git branch -f test &&
+	test_config branch.master.pushremote foo &&
+	test_config branch.master.push foo &&
+	git branch --set-publish-to test &&
+	git branch --unset-publish &&
+	test_must_fail git config branch.master.pushremote &&
+	test_must_fail git config branch.master.push &&
+	# fail for a branch without publish set
+	test_must_fail git branch --unset-publish
+'
+
+test_expect_success '--unset-publish should fail on multiple branches' '
+	test_must_fail git branch --unset-publish a b c
+'
+
+test_expect_success '--unset-publish should fail on detached HEAD' '
+	test_when_finished "git checkout -" &&
+	git checkout HEAD^{} &&
+	test_must_fail git branch --unset-publish
+'
+
+test_expect_success 'test --unset-publish on a particular branch' '
+	git branch -f test &&
+	git branch -f test2 &&
+	git branch --set-publish-to test2 test &&
+	git branch --unset-publish test &&
+	test_must_fail git config branch.test2.pushremote &&
+	test_must_fail git config branch.test2.push
+'
+
 test_done
-- 
1.9.1+fc3.9.gc73078e
