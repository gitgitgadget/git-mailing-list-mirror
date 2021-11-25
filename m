Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09510C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 13:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352040AbhKYNgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:36:31 -0500
Received: from vmi563313.contaboserver.net ([62.171.181.13]:48884 "EHLO
        vmi563313.contaboserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355186AbhKYNea (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Nov 2021 08:34:30 -0500
X-Greylist: delayed 1113 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Nov 2021 08:34:30 EST
Received: from inspiro.localdomain (unknown [182.253.127.221])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vmi563313.contaboserver.net (Postfix) with ESMTPSA id AF5C7AC05E0;
        Thu, 25 Nov 2021 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kilabit.info;
        s=20210411-1; t=1637845093;
        bh=91ylcvv5bp+LmNOH9JlRCTKgHMWC2abA4h9xBxfx1iI=;
        h=From:To:Cc:Subject:Date;
        b=HfBY2hZlRJwLtH2aL/7EnYIOI7ez2gOfxXHn9Bn2dpiEetwoOzVmEGHBZqKyHu+5G
         EbPNrAdwGzIPWwcpqvTov5sLSMR6IxClG38QChA1w9qWWts00tSY/eBzUYtLXgx+sO
         PcuJloduw/nK1p14LY60SufYCgqMymb381bO/Nko=
From:   Shulhan <ms@kilabit.info>
To:     git@vger.kernel.org
Cc:     paulus@ozlabs.org, Shulhan <ms@kilabit.info>
Subject: [PATCH] gitk: fix error when resizing gitk
Date:   Thu, 25 Nov 2021 19:57:20 +0700
Message-Id: <20211125125720.231039-1-ms@kilabit.info>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using gitk run on Wayland (in this case using sway window manager)
and the window is vertical split, trying to resize the split will thrown
the following error,

	expected integer but got ""
	expected integer but got ""
	    while executing
	"$win sash place 0 $sash0 [lindex $s0 1]"
	    (procedure "resizeclistpanes" line 38)
	    invoked from within
	"resizeclistpanes .tf.histframe.pwclist 983"
	    (command bound to event)

The issue is confirmed by Anders Kaseorg on the list [1].

This commit fix this issue by checking if the $s0 or $s1 is empty
string, if its true set it to 0.

PS: I have send this patch to paulus@ozlabs.org, and it seems like there
is no reply since 7 Oct. Either the email is not received or somethings
in between.

[1] https://public-inbox.org/git/1f6e179c-d9c3-e503-3218-0acf4ff27cca@mit.edu/

Signed-off-by: Shulhan <ms@kilabit.info>
---
 gitk-git/gitk | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0..fc2add49b4 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2989,8 +2989,16 @@ proc resizeclistpanes {win w} {
             $win sashpos 0 $sash0
             $win sashpos 1 $sash1
         } else {
-            $win sash place 0 $sash0 [lindex $s0 1]
-            $win sash place 1 $sash1 [lindex $s1 1]
+            set p0 [lindex $s0 1]
+            set p1 [lindex $s1 1]
+            if {$p0 eq ""} {
+                set p0 0
+            }
+            if {$p1 eq ""} {
+                set p1 0
+            }
+            $win sash place 0 $sash0 $p0
+            $win sash place 1 $sash1 $p1
         }
 	set oldsash($win) [list $sash0 $sash1]
     }
-- 
2.34.0

