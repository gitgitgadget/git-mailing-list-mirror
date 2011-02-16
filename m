From: Johan Herland <johan@herland.net>
Subject: [PATCH v2] branch/checkout --track: Ensure that upstream branch is
 indeed a branch
Date: Thu, 17 Feb 2011 00:12:20 +0100
Message-ID: <201102170012.20964.johan@herland.net>
References: <201102151852.03881.johan@herland.net>
 <201102161146.23749.johan@herland.net>
 <7vwrkzhc7x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 00:12:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpqXz-0004FR-9H
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 00:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab1BPXM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 18:12:29 -0500
Received: from smtp.getmail.no ([84.208.15.66]:55874 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063Ab1BPXM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 18:12:28 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGQ003YDGGPB890@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 17 Feb 2011 00:12:25 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 9F5DA1EA5787_D5C59D9B	for <git@vger.kernel.org>; Wed,
 16 Feb 2011 23:12:25 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id D6E411EA2B16_D5C59D8F	for <git@vger.kernel.org>; Wed,
 16 Feb 2011 23:12:24 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGQ00ATCGGLV820@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 17 Feb 2011 00:12:24 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <7vwrkzhc7x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167019>

When creating a new branch using the --track option, we must make sure that
we don't try to set an upstream that does not make sense to follow (using
'git pull') or update (using 'git push'). The current code checks against
using HEAD as upstream (since tracking a symref doesn't make sense). However,
tracking a tag doesn't make sense either. Indeed, tracking _any_ ref that is
not a (local or remote) branch doesn't make sense, and should be disallowed.

This patch achieves this by checking that the ref we're trying to --track
resides within refs/heads/* or refs/remotes/*. This new check replaces the
previous check against HEAD.

A couple of testcases are also added, verifying that we cannot create
branches with tags as upstreams.

Finally, some selftests relying on using a non-branch as an upstream have
been reworked or removed:

- t6040: Reverse the meaning of two tests that depend on the ability to
use (lightweight and annotated) tags as upstreams. These two tests were
originally added in commits 1be570f and 57ffc5f, and this patch reverts the
intention of those two commits.

- t7201: Remove part of a test (introduced in 9188ed8) relying on a
non-branch as upstream.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Wednesday 16 February 2011, Junio C Hamano wrote:
> Thomas's "HEAD" patch 84c1a89 (branch: do not attempt to track HEAD
> implicitly, 2010-12-14) has an extra action to reset real_ref to NULL
> when not asking for "explicit_tracking" in the same codepath.
> 
> ...
> 
> Don't we need something similar here?

Indeed. Here is v2, rebased on top of 84c1a89.

...Johan

 branch.c                 |    5 +++--
 t/t3200-branch.sh        |    5 +++++
 t/t6040-tracking-info.sh |   16 ++++++++--------
 t/t7201-co.sh            |   16 +++++++++-------
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/branch.c b/branch.c
index 19310e4..da5c03e 100644
--- a/branch.c
+++ b/branch.c
@@ -175,8 +175,9 @@ void create_branch(const char *head,
 			die("Cannot setup tracking information; starting point is not a branch.");
 		break;
 	case 1:
-		/* Unique completion -- good, only if it is a real ref */
-		if (!strcmp(real_ref, "HEAD")) {
+		/* Unique completion -- good, only if it is a real branch */
+		if (prefixcmp(real_ref, "refs/heads/") &&
+		    prefixcmp(real_ref, "refs/remotes/")) {
 			if (explicit_tracking)
 				die("Cannot setup tracking information; starting point is not a branch.");
 			else
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dce90de..55af032 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -212,6 +212,11 @@ test_expect_success \
     'branch from non-branch HEAD w/--track causes failure' \
     'test_must_fail git branch --track my10 HEAD^'
 
+test_expect_success \
+    'branch from tag w/--track causes failure' \
+    'git tag foobar &&
+     test_must_fail git branch --track my11 foobar'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 
1117150200 +0000	branch: Created from master
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 1785e17..10bf3de 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -74,20 +74,20 @@ test_expect_success 'status' '
 	grep "have 1 and 1 different" actual
 '
 
-test_expect_success 'status when tracking lightweight tags' '
+test_expect_success 'fail to track lightweight tags' '
 	git checkout master &&
 	git tag light &&
-	git branch --track lighttrack light >actual &&
-	grep "set up to track" actual &&
-	git checkout lighttrack
+	test_must_fail git branch --track lighttrack light >actual &&
+	test_must_fail grep "set up to track" actual &&
+	test_must_fail git checkout lighttrack
 '
 
-test_expect_success 'status when tracking annotated tags' '
+test_expect_success 'fail to track annotated tags' '
 	git checkout master &&
 	git tag -m heavy heavy &&
-	git branch --track heavytrack heavy >actual &&
-	grep "set up to track" actual &&
-	git checkout heavytrack
+	test_must_fail git branch --track heavytrack heavy >actual &&
+	test_must_fail grep "set up to track" actual &&
+	test_must_fail git checkout heavytrack
 '
 
 test_expect_success 'setup tracking with branch --set-upstream on existing branch' '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 1337fa5..0c002ab 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -408,6 +408,15 @@ test_expect_success 'checkout w/--track from non-branch HEAD fails' '
     test "z$(git rev-parse master^0)" = "z$(git rev-parse HEAD)"
 '
 
+test_expect_success 'checkout w/--track from tag fails' '
+    git checkout master^0 &&
+    test_must_fail git symbolic-ref HEAD &&
+    test_must_fail git checkout --track -b track frotz &&
+    test_must_fail git rev-parse --verify track &&
+    test_must_fail git symbolic-ref HEAD &&
+    test "z$(git rev-parse master^0)" = "z$(git rev-parse HEAD)"
+'
+
 test_expect_success 'detach a symbolic link HEAD' '
     git checkout master &&
     git config --bool core.prefersymlinkrefs yes &&
@@ -423,7 +432,6 @@ test_expect_success 'detach a symbolic link HEAD' '
 test_expect_success \
     'checkout with --track fakes a sensible -b <name>' '
     git update-ref refs/remotes/origin/koala/bear renamer &&
-    git update-ref refs/new/koala/bear renamer &&
 
     git checkout --track origin/koala/bear &&
     test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
@@ -439,12 +447,6 @@ test_expect_success \
 
     git checkout --track remotes/origin/koala/bear &&
     test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
-
-    git checkout master && git branch -D koala/bear &&
-
-    git checkout --track refs/new/koala/bear &&
-    test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
     test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)"
 '
 
-- 
1.7.4
