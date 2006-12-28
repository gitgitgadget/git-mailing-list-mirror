From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] xdl_merge(): fix a segmentation fault when refining conflicts
Date: Thu, 28 Dec 2006 17:13:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612281710350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061227041644.GA22449@spearce.org>
 <Pine.LNX.4.63.0612271214120.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <87fyb11ouy.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 17:13:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzxsz-00056N-66
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 17:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbWL1QNh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 11:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754885AbWL1QNh
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 11:13:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:52265 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754870AbWL1QNg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 11:13:36 -0500
Received: (qmail invoked by alias); 28 Dec 2006 16:13:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 28 Dec 2006 17:13:34 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alexandre Julliard <julliard@winehq.org>
In-Reply-To: <87fyb11ouy.fsf@wine.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35558>


The function xdl_refine_conflicts() tries to break down huge
conflicts by doing a diff on the conflicting regions. However,
this does not make sense when one side is empty.

Worse, when one side is not only empty, but after EOF, the code
accessed unmapped memory.

Noticed by Luben Tuikov, Shawn Pearce and Alexandre Julliard, the
latter providing a test case.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	Thank you Alexandre! I looked for the bug for quite some time, but 
	was never close to the real culprit.

 t/t6023-merge-file.sh |   22 ++++++++++++++++++++++
 xdiff/xmerge.c        |    4 ++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 5d9b6f3..1c21d8c 100644
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -112,5 +112,27 @@ EOF
 test_expect_success "expected conflict markers, with -L" \
 	"diff -u test.txt expect.txt"
 
+sed "s/ tu / TU /" < new1.txt > new5.txt
+test_expect_failure "conflict in removed tail" \
+	"git-merge-file -p orig.txt new1.txt new5.txt > out"
+
+cat > expect << EOF
+Dominus regit me,
+et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
+<<<<<<< orig.txt
+=======
+Nam et si ambulavero in medio umbrae mortis,
+non timebo mala, quoniam TU mecum es:
+virga tua et baculus tuus ipsa me consolata sunt.
+>>>>>>> new5.txt
+EOF
+
+test_expect_success "expected conflict markers" "diff -u expect out"
+
 test_done
 
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 352207e..294450b 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -190,6 +190,10 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 		if (m->mode)
 			continue;
 
+		/* no sense refining a conflict when one side is empty */
+		if (m->chg1 == 0 || m->chg2 == 0)
+			continue;
+
 		/*
 		 * This probably does not work outside git, since
 		 * we have a very simple mmfile structure.
-- 
1.5.0.rc0.g09372-dirty
