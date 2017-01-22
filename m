Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2425520A17
	for <e@80x24.org>; Sun, 22 Jan 2017 19:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdAVTxM (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 14:53:12 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:16811 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdAVTxK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 14:53:10 -0500
Received: from localhost.localdomain ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id VOCIcRFMZHGLwVOCLca3TU; Sun, 22 Jan 2017 19:53:09 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=xtxXYLxNAAAA:8 a=CWwGKnIJ3NzC99B_ibgA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.org>
Subject: [PATCH v3 3/4] git gui: de-dup selected repo from recentrepo history
Date:   Sun, 22 Jan 2017 19:53:00 +0000
Message-Id: <20170122195301.1784-4-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1.323.g0305acf
In-Reply-To: <20170122195301.1784-1-philipoakley@iee.org>
References: <20170122195301.1784-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfIyb42WxosabUrMQ8QqD3viNe5kuTWnxpLIfT6/7mzi4Z1oUfYImx9gwaepjWkI4nsHvIr02a3NxbgWHWpkiKT4fN8UHPW6cgYMk6mG3ia3lbUxLL6xE
 RMvmICa0lLZfPGu7qziNLQOHX38hwB3vhKVH3IvkfQclKdWouJc2wMz25iL7neKbT5t1tZmYViqcYvQqtGMnFod39kUnEKwcAmI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the gui/user selects a repo for display, that repo is brought to
the end of the recentrepo config list. The logic can fail if there are
duplicate old entries for the repo (you cannot unset a single config
entry when duplicates are present).

Similarly, the maxrecentrepo logic could fail if older duplicate entries
are present.

The first commit of this series ({this}~2) fixed the config unsetting
issue. Rather than manipulating a local copy of the $recent list (one
cannot know how many entries were removed), simply re-read it.

We must also catch the error when the attempt to remove the second copy
from the re-read list is performed.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 lib/choose_repository.tcl | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index aa87bcc..f39636f 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -247,7 +247,7 @@ proc _get_recentrepos {} {
 
 proc _unset_recentrepo {p} {
 	regsub -all -- {([()\[\]{}\.^$+*?\\])} $p {\\\1} p
-	git config --global --unset-all gui.recentrepo "^$p\$"
+	catch {git config --global --unset-all gui.recentrepo "^$p\$"}
 	load_config 1
 }
 
@@ -262,12 +262,11 @@ proc _append_recentrepos {path} {
 	set i [lsearch $recent $path]
 	if {$i >= 0} {
 		_unset_recentrepo $path
-		set recent [lreplace $recent $i $i]
 	}
 
-	lappend recent $path
 	git config --global --add gui.recentrepo $path
 	load_config 1
+	set recent [get_config gui.recentrepo]
 
 	if {[set maxrecent [get_config gui.maxrecentrepo]] eq {}} {
 		set maxrecent 10
@@ -275,7 +274,7 @@ proc _append_recentrepos {path} {
 
 	while {[llength $recent] > $maxrecent} {
 		_unset_recentrepo [lindex $recent 0]
-		set recent [lrange $recent 1 end]
+		set recent [get_config gui.recentrepo]
 	}
 }
 
-- 
2.9.0.windows.1.323.g0305acf

