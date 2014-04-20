From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/8] Introduce publish tracking branch
Date: Sun, 20 Apr 2014 14:44:58 -0500
Message-ID: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:55:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbxqH-0006IQ-17
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbaDTTz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:55:29 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:40586 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412AbaDTTz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:55:27 -0400
Received: by mail-yh0-f46.google.com with SMTP id b6so2930008yha.5
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ree5twva62b/ZCTqNKnwV+ZxqzN6IZqIvPy2liJmHcw=;
        b=u/JVEFSyMUZ/XTRUcX+aKhqrPJ00ghkv3mzUU4e8pAGf+Yg91BY1u5Fp4Ryqi1REx9
         kbp4ck8gt1ArnKU6RcN8ByTaKKbk6GY+pPTY6pp0a+o/m1htgAIPsA3cEt7ZWfYnlP52
         lPyTnRsZm82WtAM96TF5GSWUay3w6jwB2dVlraDGhuNPmExoP/ZRCuDyOeqOO5rPPF9T
         Uj1hgCcq1OtBowIlpoKER4YThyhfa74XXxdKPYOgE4q0CPrw6Z+2tTt0O5PeR7/flAsm
         SdcD7XDCxJsZLMlm9943WLz0MCOswV/NX32fH1NMjfS7fhPAxZ9Bpacg2w/rLsT85T8s
         IZug==
X-Received: by 10.236.66.135 with SMTP id h7mr46449452yhd.60.1398023727053;
        Sun, 20 Apr 2014 12:55:27 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id s26sm61227019yhg.4.2014.04.20.12.55.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:55:25 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246568>

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

Changes since v3:

 * Fix a possible crash
 * Improve tests so they work with newer push.default

diff --git a/builtin/push.c b/builtin/push.c
index 172e843..1beed0c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -443,8 +443,8 @@ static int do_push(const char *repo, int flags)
 	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
 		struct branch *branch = branch_get(NULL);
 		/* Is there a publish branch */
-		if (branch->pushremote_name && !strcmp(remote->name, branch->pushremote_name) &&
-				branch && branch->push_name) {
+		if (branch && branch->pushremote_name && !strcmp(remote->name, branch->pushremote_name) &&
+				branch->push_name) {
 			struct strbuf refspec = STRBUF_INIT;
 			strbuf_addf(&refspec, "%s:%s", branch->name, branch->push_name);
 			add_refspec(refspec.buf);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f9c528d..80a00e3 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1279,63 +1279,49 @@ EOF
 	git push --no-thin --receive-pack="$rcvpck" no-thin/.git refs/heads/master:refs/heads/foo
 '
 
-test_expect_success 'push with publish branch' '
+mk_publish_test () {
 	mk_test up_repo heads/master &&
 	mk_test down_repo heads/master &&
 	test_config remote.up.url up_repo &&
 	test_config remote.down.url down_repo &&
 	test_config branch.master.pushremote down &&
 	test_config branch.master.push for-john &&
+	test_config branch.master.remote up &&
+	test_config branch.master.merge master
+}
+
+test_expect_success 'push with publish branch' '
+	mk_publish_test &&
 	git push &&
 	check_push_result up_repo $the_first_commit heads/master &&
 	check_push_result down_repo $the_commit heads/for-john
 '
 
 test_expect_success 'push with publish branch for different remote' '
-	mk_test up_repo heads/master &&
-	mk_test down_repo heads/master &&
-	test_config remote.up.url up_repo &&
-	test_config remote.down.url down_repo &&
-	test_config branch.master.pushremote down &&
-	test_config branch.master.push for-john &&
+	mk_publish_test &&
 	git push up &&
 	check_push_result up_repo $the_commit heads/master &&
 	check_push_result down_repo $the_first_commit heads/master
 '
 
 test_expect_success 'push with publish branch with pushdefault' '
-	mk_test up_repo heads/master &&
-	mk_test down_repo heads/master &&
-	test_config remote.up.url up_repo &&
-	test_config remote.down.url down_repo &&
+	mk_publish_test &&
 	test_config remote.pushdefault up &&
-	test_config branch.master.pushremote down &&
-	test_config branch.master.push for-john &&
 	git push &&
 	check_push_result up_repo $the_first_commit heads/master &&
 	check_push_result down_repo $the_commit heads/for-john
 '
 
 test_expect_success 'push with publish branch with remote refspec' '
-	mk_test up_repo heads/master &&
-	mk_test down_repo heads/master &&
-	test_config remote.up.url up_repo &&
-	test_config remote.down.url down_repo &&
+	mk_publish_test &&
 	test_config remote.down.push refs/heads/master:refs/heads/bad &&
-	test_config branch.master.pushremote down &&
-	test_config branch.master.push for-john &&
 	git push &&
 	check_push_result up_repo $the_first_commit heads/master &&
 	check_push_result down_repo $the_commit heads/for-john
 '
 
 test_expect_success 'push with publish branch with manual refspec' '
-	mk_test up_repo heads/master &&
-	mk_test down_repo heads/master &&
-	test_config remote.up.url up_repo &&
-	test_config remote.down.url down_repo &&
-	test_config branch.master.pushremote down &&
-	test_config branch.master.push for-john &&
+	mk_publish_test &&
 	git push down master:good &&
 	check_push_result up_repo $the_first_commit heads/master &&
 	check_push_result down_repo $the_commit heads/good

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
 t/t5516-fetch-push.sh        | 50 +++++++++++++++++++++++++++++
 t/t5534-push-publish.sh      | 70 ++++++++++++++++++++++++++++++++++++++++
 t/t6040-tracking-info.sh     |  5 +--
 transport.c                  | 28 ++++++++++------
 transport.h                  |  1 +
 18 files changed, 449 insertions(+), 48 deletions(-)
 create mode 100755 t/t5534-push-publish.sh

-- 
1.9.1+fc3.9.gc73078e
