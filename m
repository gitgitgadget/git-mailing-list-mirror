From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Allow cherry-picking root commits
Date: Fri, 4 Jul 2008 16:19:52 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807041617320.9925@racer>
References: <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net>
 <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net> <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness> <20080704003857.GG6677@leksak.fem-net> <alpine.DEB.1.00.0807040252490.2849@eeepc-johanness>
 <20080704015326.GI6677@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 04 17:22:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEn7W-0003AJ-0m
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 17:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbYGDPVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 11:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbYGDPVs
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 11:21:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:34605 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751149AbYGDPVr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 11:21:47 -0400
Received: (qmail invoked by alias); 04 Jul 2008 15:21:45 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp006) with SMTP; 04 Jul 2008 17:21:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jLK1mPApjmOOqZ94a0L2Fkuzm3cFq+qeZewhxh3
	P0Lsi1mvmiWlJV
X-X-Sender: gene099@racer
In-Reply-To: <20080704015326.GI6677@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87396>


There is no good reason why cherry-picking root commits should not be 
allowed.

Further, since cherry-pick is the working horse of git-rebase, we _should_ 
allow picking root commits, so that you can rebase originally independent 
branches on top of another branch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 4 Jul 2008, Stephan Beyer wrote:

	> On Fri, Jul 04, 2008 at 03:03:37AM +0200, Johannes Schindelin 
	> wrote:
	> 
	> > Well, logically, it should come _before_ you use it in 
	> > sequencer.  And you should use it in sequencer.
	> 
	> Yet nobody seems to have asked for a cherry-pick that is able to 
	> pick root commits and sequencer is not closed source after GSoC, so 
	> this can be added whenever there is need and time for it.

	However, this is the wrong sequence.

	Anyhow, I give up on trying to convince you.

 builtin-revert.c            |   26 ++++++++++++++++----------
 t/t3503-cherry-pick-root.sh |   30 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 10 deletions(-)
 create mode 100755 t/t3503-cherry-pick-root.sh

diff --git a/builtin-revert.c b/builtin-revert.c
index 0270f9b..f3d4524 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -206,6 +206,7 @@ static int merge_recursive(const char *base_sha1,
 {
 	char buffer[256];
 	const char *argv[6];
+	int i = 0;
 
 	sprintf(buffer, "GITHEAD_%s", head_sha1);
 	setenv(buffer, head_name, 1);
@@ -218,12 +219,13 @@ static int merge_recursive(const char *base_sha1,
 	 * and $prev on top of us (when reverting), or the change between
 	 * $prev and $commit on top of us (when cherry-picking or replaying).
 	 */
-	argv[0] = "merge-recursive";
-	argv[1] = base_sha1;
-	argv[2] = "--";
-	argv[3] = head_sha1;
-	argv[4] = next_sha1;
-	argv[5] = NULL;
+	argv[i++] = "merge-recursive";
+	if (base_sha1)
+		argv[i++] = base_sha1;
+	argv[i++] = "--";
+	argv[i++] = head_sha1;
+	argv[i++] = next_sha1;
+	argv[i++] = NULL;
 
 	return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD);
 }
@@ -297,9 +299,12 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		discard_cache();
 	}
 
-	if (!commit->parents)
-		die ("Cannot %s a root commit", me);
-	if (commit->parents->next) {
+	if (!commit->parents) {
+		if (action == REVERT)
+			die ("Cannot revert a root commit");
+		parent = NULL;
+	}
+	else if (commit->parents->next) {
 		/* Reverting or cherry-picking a merge commit */
 		int cnt;
 		struct commit_list *p;
@@ -368,7 +373,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 	}
 
-	if (merge_recursive(sha1_to_hex(base->object.sha1),
+	if (merge_recursive(base == NULL ?
+				NULL : sha1_to_hex(base->object.sha1),
 				sha1_to_hex(head), "HEAD",
 				sha1_to_hex(next->object.sha1), oneline) ||
 			write_cache_as_tree(head, 0, NULL)) {
diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
new file mode 100755
index 0000000..b0faa29
--- /dev/null
+++ b/t/t3503-cherry-pick-root.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='test cherry-picking a root commit'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	echo first > file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m "first" &&
+
+	git symbolic-ref HEAD refs/heads/second &&
+	rm .git/index file1 &&
+	echo second > file2 &&
+	git add file2 &&
+	test_tick &&
+	git commit -m "second"
+
+'
+
+test_expect_success 'cherry-pick a root commit' '
+
+	git cherry-pick master &&
+	test first = $(cat file1)
+
+'
+
+test_done
-- 
1.5.6.1.376.g6b0fd
