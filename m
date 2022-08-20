Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD27C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 07:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344224AbiHTHVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 03:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbiHTHVr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 03:21:47 -0400
X-Greylist: delayed 575 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 Aug 2022 00:21:44 PDT
Received: from server43.webgo24.de (server43.webgo24.de [185.30.32.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A13C993C
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 00:21:44 -0700 (PDT)
Received: from earendil.localnet (dynamic-002-244-155-001.2.244.pool.telefonica.de [2.244.155.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by server43.webgo24.de (Postfix) with ESMTPSA id AF3CC1208134D
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 09:12:05 +0200 (CEST)
From:   Thorsten Otto <admin@tho-otto.de>
To:     git@vger.kernel.org
Subject: [BUG] "git am" gets confused when commit message contains text looking like a diff
Date:   Sat, 20 Aug 2022 09:12:04 +0200
Message-ID: <16297305.cDA1TJNmNo@earendil>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart9397258.AdqulDh7t1"
Content-Transfer-Encoding: 7Bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart9397258.AdqulDh7t1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Observed on the releases/gcc-6 branch of https://github.com/gcc-mirror/gcc . 
There is a commit backported from the main branch, which looks like the 
attached file when extracting it with "git format-patch -1 
c86135dec7521ca3a877fa455b449dd8aa068a9c".

When trying to apply that patch with "git am", you get an error message:

error: config/rs6000/rs6000.md (working copy): does not exist in index

Apparently git tries to apply the diff from the git commit message, instead of 
the real diff.

--nextPart9397258.AdqulDh7t1
Content-Disposition: attachment; filename="0001-This-showed-up-in-power9-code-for-__divkf3-software-.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-This-showed-up-in-power9-code-for-__divkf3-software-.patch"

From c86135dec7521ca3a877fa455b449dd8aa068a9c Mon Sep 17 00:00:00 2001
From: Aaron Sawdey <acsawdey@linux.vnet.ibm.com>
Date: Tue, 14 Mar 2017 14:43:03 +0000
Subject: [PATCH] This showed up in power9 code for __divkf3 software float
 support and caused a...

This showed up in power9 code for __divkf3 software float support and
caused a divd to be emitted where we needed a divdu.

Index: gcc/config/rs6000/rs6000.md
===================================================================
--- gcc/config/rs6000/rs6000.md (revision 246123)
+++ gcc/config/rs6000/rs6000.md (working copy)
@@ -3063,8 +3063,8 @@
    && ! reg_mentioned_p (operands[3], operands[1])
    && ! reg_mentioned_p (operands[3], operands[2])"
   [(set (match_dup 0)
-       (div:GPR (match_dup 1)
-                (match_dup 2)))
+       (udiv:GPR (match_dup 1)
+                 (match_dup 2)))
    (set (match_dup 3)
        (mult:GPR (match_dup 0)
                  (match_dup 2)))

2017-03-14  Aaron Sawdey  <acsawdey@linux.vnet.ibm.com>

	Backport from mainline
	2017-02-28  Aaron Sawdey  <acsawdey@linux.vnet.ibm.com>

	PR target/79752
        * config/rs6000/rs6000.md (peephole2 for udiv/umod): Should emit
        udiv rather than div since input pattern is unsigned.

From-SVN: r246127
---
 gcc/ChangeLog               | 9 +++++++++
 gcc/config/rs6000/rs6000.md | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/gcc/ChangeLog b/gcc/ChangeLog
index a65effcebc2..9a9858ce86e 100644
--- a/gcc/ChangeLog
+++ b/gcc/ChangeLog
@@ -1,3 +1,12 @@
+2017-03-14  Aaron Sawdey  <acsawdey@linux.vnet.ibm.com>
+
+	Backport from mainline
+	2017-02-28  Aaron Sawdey  <acsawdey@linux.vnet.ibm.com>
+
+	PR target/79752
+        * config/rs6000/rs6000.md (peephole2 for udiv/umod): Should emit
+        udiv rather than div since input pattern is unsigned.
+
 2017-03-14  Richard Biener  <rguenther@suse.de>
 
 	Backport from mainline
diff --git a/gcc/config/rs6000/rs6000.md b/gcc/config/rs6000/rs6000.md
index b2592b55a25..c54e7271302 100644
--- a/gcc/config/rs6000/rs6000.md
+++ b/gcc/config/rs6000/rs6000.md
@@ -3063,8 +3063,8 @@
    && ! reg_mentioned_p (operands[3], operands[1])
    && ! reg_mentioned_p (operands[3], operands[2])"
   [(set (match_dup 0)
-	(div:GPR (match_dup 1)
-		 (match_dup 2)))
+	(udiv:GPR (match_dup 1)
+		  (match_dup 2)))
    (set (match_dup 3)
 	(mult:GPR (match_dup 0)
 		  (match_dup 2)))
-- 
2.24.0


--nextPart9397258.AdqulDh7t1--



