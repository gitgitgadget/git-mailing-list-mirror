Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C73C3F2D7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEE9208C3
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgCCWqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:46:35 -0500
Received: from p3plsmtpa09-04.prod.phx3.secureserver.net ([173.201.193.233]:47884
        "EHLO p3plsmtpa09-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726766AbgCCWqf (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Mar 2020 17:46:35 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 17:46:35 EST
Received: from jessie.Home ([80.220.91.246])
        by :SMTPAUTH: with ESMTPSA
        id 9GBxjJACfaXtR9GC3jp4pB; Tue, 03 Mar 2020 15:39:17 -0700
X-CMAE-Analysis: v=2.3 cv=IYL5plia c=1 sm=1 tr=0
 a=yP90ucBkoKaMz4WYbbLXtQ==:117 a=yP90ucBkoKaMz4WYbbLXtQ==:17 a=xwstyAmMAAAA:8
 a=jZdU3pb_BEzyYBZ1ZXQA:9 a=LlgVSj9pQ0SBo81MGDdQ:22
X-SECURESERVER-ACCT: max@max630.net
From:   Max Kirillov <max@max630.net>
To:     Paul Mackerras <paulus@ozlabs.org>, Markus Hitter <mah@jump-ing.de>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org
Subject: [PATCH] gitk: fix fatal error by dropping duplicated requests
Date:   Wed,  4 Mar 2020 00:39:07 +0200
Message-Id: <20200303223907.5308-1-max@max630.net>
X-Mailer: git-send-email 2.19.0.1202.g68e1e8f04e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBGKBG8O1qOcMo+oiyGuzz5pY3R164/Kgx5Z/r3VTJZsHGFNn6koLkRgUb0kn51bhn97QL1gADr8mDfbay+ksJzMZQDFtozFM6IouxCEQRkVYQ97xhs0
 o+4WhnvCllsTwOMCHdd+kegJcTSOpYFUAVe2nve87NgQZ4YssZqqio3voGAQoQzNaf4ZTkZ8cMV7onflDkf/+TzZ0ejbsZ9Dy8l7U1q14VLOD25nv6S6TRc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During fast UI actions there may happen a fatal error message due to undefined
$blobdifffd($ids). It happens because 2 same requests happen to be started.
Then first one to complete wipes the $ids from blobdifffd, causing the second
to fail. Then no diff is displayed in that gitk process anymore, so it has
to be restarted. To reproduce one could fast click a big commit line twice, for
example, but I believe it is not the only case.

Fix by not starting a request if there is already one with the same $ids.
It does not seem to cause any malfunctioning when triggered.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index da84e22dd4..3919ba85b1 100755
--- a/gitk
+++ b/gitk
@@ -8009,6 +8009,10 @@ proc getblobdiffs {ids} {
     global limitdiffs vfilelimit curview
     global git_version
 
+    if {[info exists blobdifffd($ids)]} {
+	return
+    }
+
     set textconv {}
     if {[package vcompare $git_version "1.6.1"] >= 0} {
 	set textconv "--textconv"
@@ -9145,6 +9149,11 @@ proc do_cmp_commits {a b} {
 proc diffcommits {a b} {
     global diffcontext diffids blobdifffd diffinhdr currdiffsubmod
 
+    set diffids [list commits $a $b]
+    if {[info exists blobdifffd($diffids)]} {
+	return
+    }
+
     set tmpdir [gitknewtmpdir]
     set fna [file join $tmpdir "commit-[string range $a 0 7]"]
     set fnb [file join $tmpdir "commit-[string range $b 0 7]"]
@@ -9161,7 +9170,6 @@ proc diffcommits {a b} {
 	error_popup [mc "Error diffing commits: %s" $err]
 	return
     }
-    set diffids [list commits $a $b]
     set blobdifffd($diffids) $fd
     set diffinhdr 0
     set currdiffsubmod ""
-- 
2.19.0.1202.g68e1e8f04e

