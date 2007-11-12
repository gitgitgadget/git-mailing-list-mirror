From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase: brown paper bag fix after the detached HEAD patch
Date: Mon, 12 Nov 2007 13:11:46 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121310160.4362@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
 <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711121203150.4362@racer.site> <20071112122652.GC20482@artemis.corp>
 <Pine.LNX.4.64.0711121232370.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 14:12:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrZ5R-0000Vq-Dz
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 14:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758256AbXKLNMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 08:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbXKLNMF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 08:12:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:43115 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754253AbXKLNMC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 08:12:02 -0500
Received: (qmail invoked by alias); 12 Nov 2007 13:12:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 12 Nov 2007 14:12:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JCiQnfwMJ+t0XXsyKAG/PquTmNR03A/Kofqa9rm
	72FJ/VdH+EZ/Q/
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711121232370.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64617>


The --skip case was handled properly when rebasing without --merge,
but the --continue case was not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 12 Nov 2007, Johannes Schindelin wrote:

	> On Mon, 12 Nov 2007, Pierre Habouzit wrote:
	> 
	> > On Mon, Nov 12, 2007 at 12:21:34PM +0000, Johannes Schindelin 
	> > wrote:
	> > 
	> > > On Sun, 11 Nov 2007, Junio C Hamano wrote:
	> > > 
	> > > > * js/rebase-detached (Thu Nov 8 18:19:08 2007 +0000) 1 commit
	> > > >  + rebase: operate on a detached HEAD
	> > > 
	> > > Note: this might have a subtle bug when the last patch in 
	> > > the series failed.  If I was not too tired this morning 
	> > > (which might well have been the case), rebase could not 
	> > > switch back to the branch correctly with this.
	> > 
	> > OOOH so this was what happened to me today then. I did a 
	> > rebase, there was a commit to skip, the last one, and I ended 
	> > up on a detached head. As I didn't had my coffee yet, I 
	> > assumed this was my fault and did something stupid. So after 
	> > all it seems it wasn't the case then :)
	> 
	> Thanks for acknowleding, and sorry for the bug.
	> 
	> Will work on a fix,

	Here you are.  Sorry again.

 git-rebase.sh          |    6 +++++-
 t/t3403-rebase-skip.sh |   17 +++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 7a45e27..c9034b8 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -171,7 +171,11 @@ do
 			finish_rb_merge
 			exit
 		fi
-		git am --resolved --3way --resolvemsg="$RESOLVEMSG"
+		head_name=$(cat .dotest/head-name) &&
+		onto=$(cat .dotest/onto) &&
+		orig_head=$(cat .dotest/orig-head) &&
+		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
+		move_to_original_branch
 		exit
 		;;
 	--skip)
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index becabfc..657f681 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -38,6 +38,19 @@ test_expect_failure 'rebase with git am -3 (default)' '
 test_expect_success 'rebase --skip with am -3' '
 	git rebase --skip
 	'
+
+test_expect_success 'rebase moves back to skip-reference' '
+	test refs/heads/skip-reference = $(git symbolic-ref HEAD) &&
+	git branch post-rebase &&
+	git reset --hard pre-rebase &&
+	! git rebase master &&
+	echo "hello" > hello &&
+	git add hello &&
+	git rebase --continue &&
+	test refs/heads/skip-reference = $(git symbolic-ref HEAD) &&
+	git reset --hard post-rebase
+'
+
 test_expect_success 'checkout skip-merge' 'git checkout -f skip-merge'
 
 test_expect_failure 'rebase with --merge' 'git rebase --merge master'
@@ -49,6 +62,10 @@ test_expect_success 'rebase --skip with --merge' '
 test_expect_success 'merge and reference trees equal' \
 	'test -z "`git diff-tree skip-merge skip-reference`"'
 
+test_expect_success 'moved back to branch correctly' '
+	test refs/heads/skip-merge = $(git symbolic-ref HEAD)
+'
+
 test_debug 'gitk --all & sleep 1'
 
 test_done
-- 
1.5.3.5.1738.g5c070
