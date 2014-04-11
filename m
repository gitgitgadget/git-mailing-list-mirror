From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/8] Introduce publish tracking branch
Date: Fri, 11 Apr 2014 12:59:03 -0500
Message-ID: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 20:09:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYftC-0006oL-9P
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 20:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbaDKSJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 14:09:14 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:41765 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbaDKSJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 14:09:12 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so6524841oag.37
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ud9RMyelDDGmM7hv+qRS1tmuACOo0O19dLhCss7RKzg=;
        b=KoxcNBK91vsaAOlBI3XnnPBcsc43m1bxPOEVqOwObgJ5E9zibC53by+axa0ATG13Cb
         2VOgI0T1y20YrrzEiefb1qQ0VzvFMZMk+3NFezU31Llrk5XxhilCsFQI2gxHadd9Y16d
         +MfAE/OGofVgbVlEaa8NXGStqTCm0O0Q6EC923uRCdCqqAddfI64wUfh/vv+iPFzTF9w
         Git3SxUvVGZJtrx+fMW3YpV/IAgwaeK9UzSru4ydSyuL+9WQGMww5TLHhOLKu3aorvXJ
         Ax03UVlGiGZGAVAWuW8iWvnS1e6ncKm5vXI4XVASWnx6ZepYca+qXleNvzuonnZOJdhC
         oXOw==
X-Received: by 10.60.92.170 with SMTP id cn10mr1449279oeb.76.1397239752313;
        Fri, 11 Apr 2014 11:09:12 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ii8sm13455102obb.11.2014.04.11.11.09.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 11:09:10 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246116>

As it has been discussed before, our support for triangular workflows is
lacking, and the following patch series aims to improve that situation.

We have the concept of upstream branch (e.g. 'origin/master') which is to where
our topic branches eventually should be merged to, so it makes sense that
'git rebase' uses that as the destination, but most people would not push to
such upstream branch, they would push to a publish branch
(e.g. 'github/feature-a'). We could set our upstream to the place we push, and
'git push' would be able to use that as default, and 'git branch --vv' would
show how ahead/behind we are in comparisson to that branch, but then
'git rebase' (or 'git merge') would be using the wrong branch.

So, let's introduce the concept of a publish branch (similar to upstream),
which is used by push to determine the branch to push to, if the user hasn't
specified any manually, and overrides other configurations, such as
(push.default, and remote.$name.push).

This patch series adds:

 1) git push --set-publish
 2) git branch --set-publish
 3) git branch -vv # uses and shows the publish branch when configured
 4) @{publish} and @{p} marks
 5) branch.$name.{push,pushremote} configurations

After this, it becomes much easier to track branches in a triangular workflow.

The publish branch is used instead of the upstream branch for tracking
information in 'git branch --vv' and 'git status' if present, otherwise there
are no changes (upstream is used).

  master          e230c56 [origin/master, gh/master] Git 1.8.4
* fc/publish      0a105fd [master, gh/fc/publish: ahead 1] branch: display publish branch
  fc/branch/fast  177dcad [master, gh/fc/branch/fast] branch: reorganize verbose options
  fc/trivial      f289b9a [master: ahead 7] branch: trivial style fix
  fc/leaks        d101af4 [master: ahead 2] read-cache: plug a possible leak
  stable          e230c56 Git 1.8.4

Changes since v2:

 * Added documentation for branch.$name.push
 * Override other configurations (such as push.default)
 * Fix crash when branch.$name.pushremote is not present
 * Added push tests
 * Remove unnecessary cleanups
 * Other test fixes
 * Fixes from Junio

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f4d793..1569353 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -764,6 +764,13 @@ branch.<name>.mergeoptions::
 	option values containing whitespace characters are currently not
 	supported.
 
+branch.<name>.push::
+	Defines, together with branch.<name>.pushremote, the publish branch for
+	the given branch. It tells 'git push' which branch to push to, and
+	overrides any other configurations, such as push.default. It also tells
+	commands such as 'git status' and 'git branch' which remote branch to
+	use for tracking information (commits ahead and behind).
+
 branch.<name>.rebase::
 	When true, rebase the branch <name> on top of the fetched branch,
 	instead of merging the default branch from the default remote when
diff --git a/builtin/push.c b/builtin/push.c
index 9e61b8f..172e843 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -155,11 +155,20 @@ static NORETURN int die_push_simple(struct branch *branch, struct remote *remote
 	    remote->name, branch->name, advice_maybe);
 }
 
+static const char message_detached_head_die[] =
+	N_("You are not currently on a branch.\n"
+	   "To push the history leading to the current (detached HEAD)\n"
+	   "state now, use\n"
+	   "\n"
+	   "    git push %s HEAD:<name-of-remote-branch>\n");
+
 static void setup_push_upstream(struct remote *remote, struct branch *branch,
 				int triangular)
 {
 	struct strbuf refspec = STRBUF_INIT;
 
+	if (!branch)
+		die(_(message_detached_head_die), remote->name);
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
@@ -189,23 +198,11 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 
 static void setup_push_current(struct remote *remote, struct branch *branch)
 {
+	if (!branch)
+		die(_(message_detached_head_die), remote->name);
 	add_refspec(branch->name);
 }
 
-static void setup_push_simple(struct remote *remote, struct branch *branch,
-		int triangular)
-{
-	if (branch->push_name) {
-		struct strbuf refspec = STRBUF_INIT;
-		strbuf_addf(&refspec, "%s:%s", branch->name, branch->push_name);
-		add_refspec(refspec.buf);
-	} else if (triangular) {
-		setup_push_current(remote, branch);
-	} else {
-		setup_push_upstream(remote, branch, triangular);
-	}
-}
-
 static char warn_unspecified_push_default_msg[] =
 N_("push.default is unset; its implicit value is changing in\n"
    "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
@@ -243,23 +240,9 @@ static int is_workflow_triangular(struct remote *remote)
 	return (fetch_remote && fetch_remote != remote);
 }
 
-static const char message_detached_head_die[] =
-	N_("You are not currently on a branch.\n"
-	   "To push the history leading to the current (detached HEAD)\n"
-	   "state now, use\n"
-	   "\n"
-	   "    git push %s HEAD:<name-of-remote-branch>\n");
-
-static struct branch *get_current_branch(struct remote *remote)
-{
-	struct branch *branch = branch_get(NULL);
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
-	return branch;
-}
-
 static void setup_default_push_refspecs(struct remote *remote)
 {
+	struct branch *branch = branch_get(NULL);
 	int triangular = is_workflow_triangular(remote);
 
 	switch (push_default) {
@@ -273,15 +256,18 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_SIMPLE:
-		setup_push_simple(remote, get_current_branch(remote), triangular);
+		if (triangular)
+			setup_push_current(remote, branch);
+		else
+			setup_push_upstream(remote, branch, triangular);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote, get_current_branch(remote), triangular);
+		setup_push_upstream(remote, branch, triangular);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-		setup_push_current(remote, get_current_branch(remote));
+		setup_push_current(remote, branch);
 		break;
 
 	case PUSH_DEFAULT_NOTHING:
@@ -455,7 +441,14 @@ static int do_push(const char *repo, int flags)
 	}
 
 	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
-		if (remote->push_refspec_nr) {
+		struct branch *branch = branch_get(NULL);
+		/* Is there a publish branch */
+		if (branch->pushremote_name && !strcmp(remote->name, branch->pushremote_name) &&
+				branch && branch->push_name) {
+			struct strbuf refspec = STRBUF_INIT;
+			strbuf_addf(&refspec, "%s:%s", branch->name, branch->push_name);
+			add_refspec(refspec.buf);
+		} else if (remote->push_refspec_nr) {
 			refspec = remote->push_refspec;
 			refspec_nr = remote->push_refspec_nr;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
diff --git a/remote.c b/remote.c
index 3437d1f..eda6192 100644
--- a/remote.c
+++ b/remote.c
@@ -1566,7 +1566,7 @@ struct branch *branch_get(const char *name)
 			}
 		}
 	}
-	if (ret && ret->pushremote_name) {
+	if (ret && ret->pushremote_name && ret->push_name) {
 		struct remote *pushremote;
 		pushremote = pushremote_get(ret->pushremote_name);
 		ret->push.src = xstrdup(ret->push_name);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 67e0ab3..f9c528d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1261,6 +1261,8 @@ test_expect_success 'push --follow-tag only pushes relevant tags' '
 '
 
 test_expect_success 'push --no-thin must produce non-thin pack' '
+	test_when_finished "git reset --hard v1.0" &&
+
 	cat >>path1 <<\EOF &&
 keep base version of path1 big enough, compared to the new changes
 later, in order to pass size heuristics in
@@ -1277,4 +1279,66 @@ EOF
 	git push --no-thin --receive-pack="$rcvpck" no-thin/.git refs/heads/master:refs/heads/foo
 '
 
+test_expect_success 'push with publish branch' '
+	mk_test up_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.pushremote down &&
+	test_config branch.master.push for-john &&
+	git push &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/for-john
+'
+
+test_expect_success 'push with publish branch for different remote' '
+	mk_test up_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.pushremote down &&
+	test_config branch.master.push for-john &&
+	git push up &&
+	check_push_result up_repo $the_commit heads/master &&
+	check_push_result down_repo $the_first_commit heads/master
+'
+
+test_expect_success 'push with publish branch with pushdefault' '
+	mk_test up_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config remote.pushdefault up &&
+	test_config branch.master.pushremote down &&
+	test_config branch.master.push for-john &&
+	git push &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/for-john
+'
+
+test_expect_success 'push with publish branch with remote refspec' '
+	mk_test up_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config remote.down.push refs/heads/master:refs/heads/bad &&
+	test_config branch.master.pushremote down &&
+	test_config branch.master.push for-john &&
+	git push &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/for-john
+'
+
+test_expect_success 'push with publish branch with manual refspec' '
+	mk_test up_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.pushremote down &&
+	test_config branch.master.push for-john &&
+	git push down master:good &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/good
+'
+
 test_done


Felipe Contreras (8):
  t5516 (fetch-push): fix test restoration
  Add concept of 'publish' branch
  branch: add --set-publish-to option
  push: add --set-publish option
  branch: display publish branch
  sha1_name: cleanup interpret_branch_name()
  sha1_name: simplify track finding
  sha1_name: add support for @{publish} marks

 Documentation/config.txt     |  7 ++++
 Documentation/git-branch.txt | 11 +++++++
 Documentation/git-push.txt   |  9 +++++-
 Documentation/revisions.txt  |  4 +++
 branch.c                     | 44 +++++++++++++++++++++++++
 branch.h                     |  2 ++
 builtin/branch.c             | 74 ++++++++++++++++++++++++++++++++++++++----
 builtin/push.c               | 11 ++++++-
 remote.c                     | 34 ++++++++++++++++----
 remote.h                     |  4 +++
 sha1_name.c                  | 62 ++++++++++++++++++++++--------------
 t/t1508-at-combinations.sh   |  5 +++
 t/t3200-branch.sh            | 76 ++++++++++++++++++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh        | 64 +++++++++++++++++++++++++++++++++++++
 t/t5534-push-publish.sh      | 70 ++++++++++++++++++++++++++++++++++++++++
 t/t6040-tracking-info.sh     |  5 +--
 transport.c                  | 28 ++++++++++------
 transport.h                  |  1 +
 18 files changed, 463 insertions(+), 48 deletions(-)
 create mode 100755 t/t5534-push-publish.sh

-- 
1.9.1+fc1
