From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: squash should retain the authorship of the _first_
 commit
Date: Sun, 30 Sep 2007 00:34:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709300032520.28395@racer.site>
References: <Pine.LNX.4.64.0709290231300.28395@racer.site> <46FE7D0B.4060806@qumranet.com>
 <Pine.LNX.4.64.0709292156090.28395@racer.site> <46FEC00B.7050208@qumranet.com>
 <Pine.LNX.4.64.0709292243280.28395@racer.site> <7vzlz5jfa1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avi Kivity <avi@qumranet.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 01:35:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iblqc-0000cL-SP
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 01:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbXI2Xfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 19:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbXI2Xfe
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 19:35:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:44684 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752656AbXI2Xfd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 19:35:33 -0400
Received: (qmail invoked by alias); 29 Sep 2007 23:35:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 30 Sep 2007 01:35:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dOKF/PqBdhNLIv0l1+693zGfgvW+MRKtcDTF/9J
	z1gJzX9LRY38Kf
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzlz5jfa1.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59510>


It was determined on the mailing list, that it makes more sense for a 
"squash" to keep the author of the first commit as the author for the 
result of the squash.

Make it so.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sat, 29 Sep 2007, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > On Sat, 29 Sep 2007, Avi Kivity wrote:
	> >
	> >> > > Can we make "amend" like squash, except that it keeps the 
	> >> > > first commit's authorship instead of the second?  I often 
	> >> > > merge a commit with some minor fix that comes later, and 
	> >> > > usually want to keep the original author record.
	> >
	> > Thinking about this again... Maybe it is a better semantics 
	> > anyway? What do others think?
	> 
	> I never thought about whose commit the squashed ones become
	> before this thread, but making squash quack as if "commit
	> --amend" was done after running "cherry-pick -n" the second and
	> later ones feels like the most natural semantics to me.

	Here you are.

 Documentation/git-rebase.txt  |    2 +-
 git-rebase--interactive.sh    |    2 +-
 t/t3404-rebase-interactive.sh |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0858fa8..e8e7579 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -298,7 +298,7 @@ rebasing.
 If you want to fold two or more commits into one, replace the command
 "pick" with "squash" for the second and subsequent commit.  If the
 commits had different authors, it will attribute the squashed commit to
-the author of the last commit.
+the author of the first commit.
 
 In both cases, or when a "pick" does not succeed (because of merge
 errors), the loop will stop to let you fix things, and you can continue
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7a5aaa5..050140d 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -276,9 +276,9 @@ do_next () {
 		esac
 
 		failed=f
+		author_script=$(get_author_ident_from_commit HEAD)
 		output git reset --soft HEAD^
 		pick_one -n $sha1 || failed=t
-		author_script=$(get_author_ident_from_commit $sha1)
 		echo "$author_script" > "$DOTEST"/author-script
 		case $failed in
 		f)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f2214dd..1113904 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -180,7 +180,7 @@ test_expect_success 'squash' '
 '
 
 test_expect_success 'retain authorship when squashing' '
-	git show HEAD | grep "^Author: Nitfol"
+	git show HEAD | grep "^Author: Twerp Snog"
 '
 
 test_expect_success 'preserve merges with -p' '
-- 
1.5.3.2.1102.g9487
