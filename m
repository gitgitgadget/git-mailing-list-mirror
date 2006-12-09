X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] add test case for recursive merge
Date: Sun, 10 Dec 2006 00:56:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207101707.GA19139@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 9 Dec 2006 23:56:42 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061207101707.GA19139@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33852>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtC3a-0001Iw-CY for gcvg-git@gmane.org; Sun, 10 Dec
 2006 00:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759856AbWLIX4f (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 18:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759860AbWLIX4f
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 18:56:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:59880 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1759851AbWLIX4f
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 18:56:35 -0500
Received: (qmail invoked by alias); 09 Dec 2006 23:56:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp010) with SMTP; 10 Dec 2006 00:56:33 +0100
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org


This test case is based on the bug report by Shawn Pearce.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 t/t6024-recursive-merge.sh |   68 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
new file mode 100644
index 0000000..5f821fb
--- /dev/null
+++ b/t/t6024-recursive-merge.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description='Test merge without common ancestors'
+. ./test-lib.sh
+
+# This scenario is based on a real-world repository of Shawn Pearce.
+
+# 1 - A - D - F
+#   \   X   /
+#     B   X
+#       X   \
+# 2 - C - E - G
+
+echo 1 > a1
+git add a1
+git commit -m 1 a1
+
+git checkout -b A master
+echo A > a1
+git commit -m A a1
+
+git checkout -b B master
+echo B > a1
+git commit -m B a1
+
+git checkout -b D A
+git-rev-parse B > .git/MERGE_HEAD
+echo D > a1
+git update-index a1
+git commit -m D
+
+git symbolic-ref HEAD refs/heads/other
+echo 2 > a1
+git commit -m 2 a1
+
+git checkout -b C
+echo C > a1
+git commit -m C a1
+
+git checkout -b E C
+git-rev-parse B > .git/MERGE_HEAD
+echo E > a1
+git update-index a1
+git commit -m E
+
+git checkout -b G E
+git-rev-parse A > .git/MERGE_HEAD
+echo G > a1
+git update-index a1
+git commit -m G
+
+git checkout -b F D
+git-rev-parse C > .git/MERGE_HEAD
+echo F > a1
+git update-index a1
+git commit -m F
+
+test_expect_failure "combined merge conflicts" "git merge -m final G"
+
+git ls-files --stage > out
+cat > expect << EOF
+100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
+100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
+EOF
+
+test_expect_success "virtual trees were processed" "diff -u expect out"
+
+test_done
-- 
1.4.4.2.g0f32-dirty

