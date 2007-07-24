From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: fix interrupted squashing
Date: Tue, 24 Jul 2007 21:43:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707242139370.14781@racer.site>
References: <20070723225402.GB22513@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0707240005240.14781@racer.site> <20070724200510.GA27610@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1339877507-1185309789=:14781"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:43:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDREE-0006Iz-KW
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 22:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbXGXUn3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 16:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765139AbXGXUn3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 16:43:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:53671 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765098AbXGXUn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 16:43:27 -0400
Received: (qmail invoked by alias); 24 Jul 2007 20:43:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 24 Jul 2007 22:43:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18fhmAopfEf1iqwiNMisj60OV8RCp8EmAg/CebtdJ
	x/j8YPv6tVBXsb
X-X-Sender: gene099@racer.site
In-Reply-To: <20070724200510.GA27610@informatik.uni-freiburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53641>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1339877507-1185309789=:14781
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


When a squashing merge failed, the first commit would not be replaced,
due to "git reset --soft" being called with an unmerged index.

Noticed by Uwe Kleine-König.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 24 Jul 2007, Uwe Kleine-K?nig wrote:

	> Johannes Schindelin wrote:
	>
	> > I'd appreciate if you prepared a patch with better 
	> > explanations, and also reviewed the man page, if it is in good 
	> > shape (and does not lie about the current behaviour).
	>
	> It's on my todo list, but not the top item for git.

	Please come around to do it.

	> In the mean-time I found another nuisance:
	> 
	> [outlines the test case provided in this patch]

	It would have been a bit less work for me, if you would have used 
	t/trash/ instead of /tmp/, and provided a patch for t3404 for me 
	to work with.

	Alas, the bug was squashed in 5 minutes.  It took me 15 minutes to 
	write (and test) the test.

	What a difference order can make...

 git-rebase--interactive.sh    |    2 +-
 t/t3404-rebase-interactive.sh |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 93289c0..78ae51e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -258,8 +258,8 @@ do_next () {
 		esac
 
 		failed=f
-		pick_one -n $sha1 || failed=t
 		output git reset --soft HEAD^
+		pick_one -n $sha1 || failed=t
 		author_script=$(get_author_ident_from_commit $sha1)
 		echo "$author_script" > "$DOTEST"/author-script
 		case $failed in
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8206436..817f614 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -221,4 +221,34 @@ test_expect_success 'multi-squash only fires up editor once' '
 	test 1 = $(git show | grep ONCE | wc -l)
 '
 
+test_expect_success 'squash works as expected' '
+	for n in one two three four
+	do
+		echo $n >> file$n &&
+		git add file$n &&
+		git commit -m $n
+	done &&
+	one=$(git rev-parse HEAD~3) &&
+	FAKE_LINES="1 squash 3 2" git rebase -i HEAD~3 &&
+	test $one = $(git rev-parse HEAD~2)
+'
+
+test_expect_success 'interrupted squash works as expected' '
+	for n in one two three four
+	do
+		echo $n >> conflict &&
+		git add conflict &&
+		git commit -m $n
+	done &&
+	one=$(git rev-parse HEAD~3) &&
+	! FAKE_LINES="1 squash 3 2" git rebase -i HEAD~3 &&
+	(echo one; echo two; echo four) > conflict &&
+	git add conflict &&
+	! git rebase --continue &&
+	echo resolved > conflict &&
+	git add conflict &&
+	git rebase --continue &&
+	test $one = $(git rev-parse HEAD~2)
+'
+
 test_done
-- 
1.5.3.rc2.42.gda8d

--8323584-1339877507-1185309789=:14781--
