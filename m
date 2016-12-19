Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1441FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbcLSQp0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:45:26 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:61893 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933195AbcLSQpY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:24 -0500
X-AuditID: 12074411-fbbff700000009b7-37-58580ea3cd77
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id F4.97.02487.3AE08585; Mon, 19 Dec 2016 11:45:23 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKQs011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:22 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/13] gitk: when processing tag labels, don't use `marks` as scratch space
Date:   Mon, 19 Dec 2016 17:45:00 +0100
Message-Id: <3f3d03e45f75acfdbbe8b51040b7e0932c926acb.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsUixO6iqLuYLyLCYNFrJYuuK91MFrdXzGe2
        WHNkMbsDs8ff9x+YPObu6mP0+LxJLoA5issmJTUnsyy1SN8ugSvj0fef7AUnOCrunL3N3sC4
        hK2LkZNDQsBE4vDWOUA2F4eQwGVGif7fD1khnFNMEp9+vwKrYhPQlVjU08zUxcjBISKgKrH+
        ghBImFnAQWLz50ZGEFtYIFriwNxDYOUsQCUH9l1iArF5BaIkLjy4wgqxTE7i0rYvzCA2p4CF
        xM35V9hBbCEBc4kNz36zTGDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11QvN7NELzWl
        dBMjJCQEdzDOOCl3iFGAg1GJh7fgfViEEGtiWXFl7iFGSQ4mJVHe/TwREUJ8SfkplRmJxRnx
        RaU5qcWHGCU4mJVEeL/xAuV4UxIrq1KL8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwc
        ShK890EaBYtS01Mr0jJzShDSTBycIMN5gIY/ABteXJCYW5yZDpE/xagoJc7rCJIQAElklObB
        9cJi9hWjONArwrycwAgW4gHGO1z3K6DBTECDF3aHgwwuSURISTUwyp2NPuLydg/Tu8rWFZOP
        Gfb8nP5GTX514JnQ9XFMsj/jTVi8BDRexppZl+aoFyeoalYcWpedcnx7S1lXU8bVtn9MV0Q/
        W6XO2JkY5uGTH9AnWb7x94Xt8v3tN3Tj7F5O3hI2e8JuK9cdN+56RM0oWXp2w7HVRUInre7w
        9eQU3+I9L+HWlHhMiaU4I9FQi7moOBEAyVpRALQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead, just append to it as necessary.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index a14d7a1..296efb3 100755
--- a/gitk
+++ b/gitk
@@ -6570,18 +6570,20 @@ proc drawtags {id x xt y1} {
     set extra [expr {$delta + $lthickness + $linespc}]
 
     if {[info exists idtags($id)]} {
-	set marks $idtags($id)
-	set ntags [llength $marks]
+	set tags $idtags($id)
+	set ntags [llength $tags]
 	if {$ntags > $maxtags ||
-	    [totalwidth $marks mainfont $extra] > $maxwidth} {
+	    [totalwidth $tags mainfont $extra] > $maxwidth} {
 	    # show just a single "n tags..." tag
 	    set singletag 1
 	    if {$ntags == 1} {
-		set marks [list "tag..."]
+		lappend marks "tag..."
 	    } else {
-		set marks [list [format "%d tags..." $ntags]]
+		lappend marks [format "%d tags..." $ntags]
+		set ntags 1
 	    }
-	    set ntags 1
+	} else {
+	    set marks [concat $marks $tags]
 	}
     }
     if {[info exists idheads($id)]} {
-- 
2.9.3

