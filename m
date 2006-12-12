X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t6024: fix timing problem
Date: Tue, 12 Dec 2006 23:49:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207101707.GA19139@spearce.org>
 <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 22:49:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34160>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGRP-0007rb-W0 for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932521AbWLLWth (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWLLWth
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:49:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:47115 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932521AbWLLWtg
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 17:49:36 -0500
Received: (qmail invoked by alias); 12 Dec 2006 22:49:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 12 Dec 2006 23:49:34 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


This script tests a complicated merge, where _all_ files conflict. In
these circumstances, the ordering of the commits -- which is affected
not by the timestamps in the commit message -- becomes a deciding factor
of the merge result.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Sat, 9 Dec 2006, Junio C Hamano wrote:

	> There seem to be cases where stage #1 contains blob 'B' or 'A'
	> or nothing depending on something totally random.  Ring a bell?

	This patch fixes it..

	Depending on the order, an add/add conflict _removes_ the file
	from the index, and as a consequence stage 1 is missing in the
	final merge (which still fails, because the return value of the
	previous merge is remembered).

	How about this: if there is an add/add conflict, we treat it as
	if there _was_ an empty file, and we let the shiny new xdl_merge()
	find the _true_ conflicts, _instead of_ removing the file from
	the index, adding both files with different "~blabla" markers
	appended to their file names to the working directory.

	Hmm?

 t/t6024-recursive-merge.sh |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 5f821fb..9416c27 100644
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -11,54 +11,56 @@ test_description='Test merge without common ancestors'
 #       X   \
 # 2 - C - E - G
 
+export GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
 echo 1 > a1
 git add a1
-git commit -m 1 a1
+GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1
 
 git checkout -b A master
 echo A > a1
-git commit -m A a1
+GIT_AUTHOR_DATE="2006-12-12 23:00:01" git commit -m A a1
 
 git checkout -b B master
 echo B > a1
-git commit -m B a1
+GIT_AUTHOR_DATE="2006-12-12 23:00:02" git commit -m B a1
 
 git checkout -b D A
 git-rev-parse B > .git/MERGE_HEAD
 echo D > a1
 git update-index a1
-git commit -m D
+GIT_AUTHOR_DATE="2006-12-12 23:00:03" git commit -m D
 
 git symbolic-ref HEAD refs/heads/other
 echo 2 > a1
-git commit -m 2 a1
+GIT_AUTHOR_DATE="2006-12-12 23:00:04" git commit -m 2 a1
 
 git checkout -b C
 echo C > a1
-git commit -m C a1
+GIT_AUTHOR_DATE="2006-12-12 23:00:05" git commit -m C a1
 
 git checkout -b E C
 git-rev-parse B > .git/MERGE_HEAD
 echo E > a1
 git update-index a1
-git commit -m E
+GIT_AUTHOR_DATE="2006-12-12 23:00:06" git commit -m E
 
 git checkout -b G E
 git-rev-parse A > .git/MERGE_HEAD
 echo G > a1
 git update-index a1
-git commit -m G
+GIT_AUTHOR_DATE="2006-12-12 23:00:07" git commit -m G
 
 git checkout -b F D
 git-rev-parse C > .git/MERGE_HEAD
 echo F > a1
 git update-index a1
-git commit -m F
+GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
 
 test_expect_failure "combined merge conflicts" "git merge -m final G"
 
 git ls-files --stage > out
 cat > expect << EOF
+100644 f70f10e4db19068f79bc43844b49f3eece45c4e8 1	a1
 100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
 100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
 EOF
-- 
1.4.4.2.g473fa0-dirty
