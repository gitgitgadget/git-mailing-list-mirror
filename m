Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F17412022D
	for <e@80x24.org>; Tue,  8 Nov 2016 00:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbcKHAxI (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 19:53:08 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:46587 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbcKHAxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 19:53:06 -0500
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
        by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with esmtp
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c3ueu-0003Jx-QV; Tue, 08 Nov 2016 00:53:04 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
To:     git@vger.kernel.org
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH GITK 3/6] gitk: drawtags: Introduce concept of unabbreviated marks
Date:   Tue,  8 Nov 2016 00:52:39 +0000
Message-Id: <20161108005241.19888-4-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are going to want to show some tags in full, even if they are long
or there are other tags.  Do this by filtering the tags into
`marks_unabbrev' and `marks'.  `marks_unabbrev' bypasses the tag
abbreviation, and is put on the front of the marks array after any
abbreviation has been done.

No functional change right now because no tags are considered
`unabbrev'.

Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
---
 gitk | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 31aecda..d76f1e3 100755
--- a/gitk
+++ b/gitk
@@ -6546,6 +6546,10 @@ proc totalwidth {l font extra} {
     return $tot
 }
 
+proc tag_want_unabbrev {tag} {
+    return 0
+}
+
 proc drawtags {id x xt y1} {
     global idtags idheads idotherrefs mainhead
     global linespc lthickness
@@ -6564,8 +6568,16 @@ proc drawtags {id x xt y1} {
     set delta [expr {int(0.5 * ($linespc - $lthickness))}]
     set extra [expr {$delta + $lthickness + $linespc}]
 
+    set marks_unabbrev {}
     if {[info exists idtags($id)]} {
-	set marks $idtags($id)
+	set marks {}
+	foreach tag $idtags($id) {
+	    if {[tag_want_unabbrev $tag]} {
+		lappend marks_unabbrev $tag
+	    } else {
+		lappend marks $tag
+	    }
+	}
 	set ntags [llength $marks]
 	if {$ntags > $maxtags ||
 	    [totalwidth $marks mainfont $extra] > $maxwidth} {
@@ -6577,6 +6589,7 @@ proc drawtags {id x xt y1} {
 	    }
 	}
     }
+    set marks [concat $marks_unabbrev $marks]
     set ntags [llength $marks]
 
     if {[info exists idheads($id)]} {
-- 
2.10.1

