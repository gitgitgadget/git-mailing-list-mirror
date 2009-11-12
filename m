From: rocketraman@fastmail.fm
Subject: [PATCHv3] Add branch management for releases to gitworkflows
Date: Thu, 12 Nov 2009 14:46:04 -0500
Message-ID: <1258055164-11876-2-git-send-email-rocketraman@fastmail.fm>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>
Cc: trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 20:46:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8fcd-0007Au-D8
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 20:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbZKLTqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 14:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbZKLTqN
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 14:46:13 -0500
Received: from smtp123.rog.mail.re2.yahoo.com ([206.190.53.28]:36905 "HELO
	smtp123.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753739AbZKLTqK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 14:46:10 -0500
Received: (qmail 61823 invoked from network); 12 Nov 2009 19:46:16 -0000
Received: from CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com (rocketraman@99.224.155.40 with login)
        by smtp123.rog.mail.re2.yahoo.com with SMTP; 12 Nov 2009 11:46:15 -0800 PST
X-Yahoo-SMTP: 5CKRlKeswBAtrcX.EVB04BFKSgZiN0yKOK0iylIm064Zdzo-
X-YMail-OSG: fhFZ2nwVM1ky2Kx0BXpqw5TfDxnMsuQHkgevGSNrDf0ocIHlSaoH29hH5jqRB214Tw--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 6B55C21C05CB;
	Thu, 12 Nov 2009 14:46:15 -0500 (EST)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 88lb2lp24evv; Thu, 12 Nov 2009 14:46:07 -0500 (EST)
Received: from zeus (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with SMTP id 1571021C05CC;
	Thu, 12 Nov 2009 14:46:06 -0500 (EST)
Received: by zeus (sSMTP sendmail emulation); Thu, 12 Nov 2009 14:46:06 -0500
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132793>

From: Raman Gupta <raman@rocketraman.com>

The current man page does a reasonable job at describing branch management
during the development process, but it does not contain any guidance as to
how the branches are affected by releases.

Add a basic introduction to the branch management undertaken during a
git.git release, so that a reader may gain some insight into how the
integration, maintenance, and topic branches are affected during the
release transition, and is thus able to better design the process for their
own project.

Other release activities such as reviews, testing, and creating
distributions are currently out of scope.
---
 Documentation/gitworkflows.txt |  108 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 2b021e3..7000930 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -209,6 +209,114 @@ chance to see if their in-progress work will be compatible.  `git.git`
 has such an official throw-away integration branch called 'pu'.
 
 
+Branch management for a release
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Assuming you are using the merge approach discussed above, when you
+are releasing your project you will need to do some additional branch
+management work.
+
+Creating a release is easy. Since 'master' is tracking the commits
+that should go into the next feature release, simply tag the tip of
+'master' with a tag indicating the release version.
+
+.Release tagging
+[caption="Recipe: "]
+=====================================
+`git tag -s -m "GIT X.Y.Z" vX.Y.Z master`
+=====================================
+
+Similarly, for a maintenance release, 'maint' is tracking the commits
+to be released. Therefore, simply replace 'master' above with
+'maint'.
+
+Generally, you should push the new tag to a public git server (see
+"DISTRIBUTED WORKFLOWS" below). This push makes the tag available to
+others tracking your project. The push could also trigger a
+post-update hook to perform release-related items such as building
+documentation.
+
+
+Maintenance branch management after a feature release
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+After a feature release, you need to manage your maintenance branches.
+
+First, if you wish to continue to release maintenance fixes for the
+feature release made before the recent one, then you must create
+another branch to track commits for that previous release.
+
+To do this, the current maintenance branch is copied to another branch
+named with the previous release version number (e.g. maint-X.Y.(Z-1)
+where X.Y.Z is the current release).
+
+.Copy maint
+[caption="Recipe: "]
+=====================================
+`git branch maint-X.Y.(Z-1) maint`
+=====================================
+
+The 'maint' branch should now be fast forwarded to the newly released
+code so that maintenance fixes can be tracked for the current release:
+
+.Update maint to new release
+[caption="Recipe: "]
+=====================================
+* `git checkout maint`
+* `git merge master`
+=====================================
+
+This 'should' fast forward 'maint' from 'master'. If it is not a fast
+forward, then 'maint' contained some commits that were not included on
+'master', which means that the recent feature release could be missing
+some fixes made on 'maint'. The exception is if there were any commits
+that were cherry-picked to 'maint' as described above in "Merging
+upwards". In this case, the merge will not be a fast forward.
+
+An alternative approach to updating the 'maint' branch, though one
+not used in git.git, is to rename the current 'maint' branch to track
+maintenance fixes for the older release and then to recreate 'maint'
+from 'master':
+
+  $ git branch -m maint maint-X.Y.(Z-1)
+  $ git branch maint master
+
+The latter step will create a new 'maint' branch based on 'master'. If
+commits were cherry-picked to 'maint', then this will create a new
+'maint' branch without a merge commit.
+
+
+Branch management for next and pu after a feature release
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+After a feature release, the 'next' testing branch may optionally be
+rewound and rebuilt from the tip of 'master' using the surviving
+topics on 'next':
+
+.Update maint to new release
+[caption="Recipe: "]
+=====================================
+* `git branch -f next master`
+* `git merge ai/topic_in_next1`
+* `git merge ai/topic_in_next2`
+* ...
+=====================================
+
+The advantage of doing this is that the history of 'next' will be
+clean. For example, some topics merged into 'next' may have initially
+looked promising, but were later found to be undesirable or premature.
+In such a case, the topic is reverted out of 'next' but the fact
+remains in the history that it was once merged and reverted. By
+recreating 'next', you give another incarnation of such topics a clean
+slate to retry, and a feature release is a good point in history to do
+so.
+
+If you do this, then you should make a public announcement indicating
+that 'next' was rewound and rebuilt.
+
+The same process may be followed for 'pu'.
+
+
 DISTRIBUTED WORKFLOWS
 ---------------------
 
-- 
1.6.2
