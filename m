Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA2491F461
	for <e@80x24.org>; Tue,  3 Sep 2019 14:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfICOpo (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 10:45:44 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59705 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICOpo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 10:45:44 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost.localdomain (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 374DC40012;
        Tue,  3 Sep 2019 14:45:40 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, <git@vger.kernel.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: [PATCH] git-gui: use path name instead of list index to track last clicked file
Date:   Tue,  3 Sep 2019 20:15:36 +0530
Message-Id: <20190903144536.8935-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903142252.oovvxslvvzteaqlc@yadavpratyush.com>
References: <20190903142252.oovvxslvvzteaqlc@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Birger,

You would probably want to squash this patch with yours when you send a
re-roll. Of course, I'd like some comments and tests on the patch before
considering it "done". Just letting you know that I'd like to have this
change in your original patch/commit, not as a separate commit. I put it
in a separate patch for now for easier readability.

Also, FYI, pass '--scissors' to git-am when applying this to not get the
above text in the commit message.

-- >8 --
For using the hotkeys CTRL/CMD+1/2/3/4, we save the index of the last
clicked file. This index may change if some external command changes the
repo state. So use the path name of the file instead.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui.sh | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index ce620f1..9be1b6a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2527,7 +2527,7 @@ proc toggle_or_diff {mode w args} {
 	$ui_index tag remove in_sel 0.0 end
 	$ui_workdir tag remove in_sel 0.0 end

-	set file_lists_last_clicked($w) $lno
+	set file_lists_last_clicked($w) $path

 	# Determine the state of the file
 	if {[info exists file_states($path)]} {
@@ -2648,17 +2648,15 @@ proc select_path_in {widget} {

 	set _list_length [llength $file_lists($widget)]
 	if {$_list_length > 0} {
-
-		set _index $file_lists_last_clicked($widget)
-		if {$_index eq {}} {
-			set _index 1
-		} elseif {$_index > $_list_length} {
-			set _index $_list_length
+		set path $file_lists_last_clicked($widget)
+		set index [lsearch -sorted -exact $file_lists($widget) $path]
+		if {$index < 0} {
+			set index 0
+			set path [lindex $file_lists($widget) $index]
 		}

 		focus $widget
-		set last_clicked [list $widget $_index]
-		set path [lindex $file_lists($widget) [expr $_index - 1]]
+		set last_clicked [list $widget [expr $index + 1]]
 		array unset selected_paths
 		set selected_paths($path) 1
 		show_diff $path $widget
--
2.21.0

