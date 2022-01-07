Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE2C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 12:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiAGM6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 07:58:06 -0500
Received: from ec2-54-173-99-29.compute-1.amazonaws.com ([54.173.99.29]:52444
        "EHLO localhost" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231207AbiAGM6F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 07:58:05 -0500
From:   Tom Levy <tomlevy93@gmail.com>
To:     git@vger.kernel.org
Cc:     Tom Levy <tomlevy93@gmail.com>
Subject: [PATCH] git-gui: insert menu entries for added remotes before the "All" entry
Date:   Fri,  7 Jan 2022 12:44:08 +0000
Message-Id: <20220107124408.1969-1-tomlevy93@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git-gui has a bug in the way it adds menu entries for new remotes.

When a remote is added (using Remote > Add...), menu entries for the
new remote are currently added to the end of the "Fetch from" and
"Prune from" submenus.

However, those submenus normally have a special entry "All" at the
end. Adding the new entries at the end messes up the order, and also
causes the "All" entry to be added multiple times because
'update_all_remotes_menu_entry' re-adds an "All" entry if the last
entry is not "All".

The patch below inserts the new entries before the "All" entry.

I moved the logic for checking if the "All" entry exists into a new
procedure 'has_all_remotes_menu_entry'. Note that this changes the
first condition in 'update_all_remotes_menu_entry'; previously the
negation was subtly broken.

Regards,
Tom Levy

-- >8 --

Subject: [PATCH] git-gui: insert menu entries for added remotes before the
 "All" entry

When a remote is added, the new fetch/prune menu entries need to be
inserted before the "All" entry (and its separator) rather than at the
end, so that "All" will remain the last option.

Signed-off-by: Tom Levy <tomlevy93@gmail.com>
---
 lib/remote.tcl | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/lib/remote.tcl b/lib/remote.tcl
index ef77ed7..5e94bdb 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -132,6 +132,14 @@ proc load_all_remotes {} {
 	set all_remotes [lsort -unique $all_remotes]
 }
 
+proc remote_submenu_insert_pos {sub_m} {
+	if {[has_all_remotes_menu_entry $sub_m]} {
+		return [expr {[$sub_m index end] - 1}] ; # index of separator
+	} else {
+		return end
+	}
+}
+
 proc add_fetch_entry {r} {
 	global repo_config
 	set remote_m .mbar.remote
@@ -159,13 +167,16 @@ proc add_fetch_entry {r} {
 	if {$enable} {
 		make_sure_remote_submenues_exist $remote_m
 
-		$fetch_m add command \
+		set fetch_pos [remote_submenu_insert_pos $fetch_m]
+		$fetch_m insert $fetch_pos command \
 			-label $r \
 			-command [list fetch_from $r]
-		$prune_m add command \
+		set prune_pos [remote_submenu_insert_pos $prune_m]
+		$prune_m insert $prune_pos command \
 			-label $r \
 			-command [list prune_from $r]
-		$remove_m add command \
+		set remove_pos end ; # no "All" entry, so always insert at end
+		$remove_m insert $remove_pos command \
 			-label $r \
 			-command [list remove_remote $r]
 	}
@@ -230,6 +241,11 @@ proc make_sure_remote_submenues_exist {remote_m} {
 	}
 }
 
+proc has_all_remotes_menu_entry {sub_m} {
+	expr {[$sub_m type end] eq "command" \
+			&& [$sub_m entrycget end -label] eq [mc "All"]}
+}
+
 proc update_all_remotes_menu_entry {} {
 	global all_remotes
 
@@ -245,8 +261,7 @@ proc update_all_remotes_menu_entry {} {
 	set prune_m $remote_m.prune
 	if {$have_remote > 1} {
 		make_sure_remote_submenues_exist $remote_m
-		if {[$fetch_m type end] eq "command" \
-				&& [$fetch_m entrycget end -label] ne [mc "All"]} {
+		if {![has_all_remotes_menu_entry $fetch_m]} {
 
 			$fetch_m insert end separator
 			$fetch_m insert end command \
@@ -260,8 +275,7 @@ proc update_all_remotes_menu_entry {} {
 		}
 	} else {
 		if {[winfo exists $fetch_m]} {
-			if {[$fetch_m type end] eq "command" \
-					&& [$fetch_m entrycget end -label] eq [mc "All"]} {
+			if {[has_all_remotes_menu_entry $fetch_m]} {
 
 				delete_from_menu $fetch_m end
 				delete_from_menu $fetch_m end
-- 
2.30.2

