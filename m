From: pasky@suse.cz
Subject: [PATCH 3/5] git-gui: Squash populate_{push,fetch}_menu to populate_remotes_menu
Date: Thu, 25 Sep 2008 00:12:52 +0200
Message-ID: <20080924221732.257739465@suse.cz>
References: <20080924221249.037449176@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 00:19:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KichV-0008KG-2j
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 00:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbYIXWRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 18:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752992AbYIXWRt
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 18:17:49 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:49870 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752936AbYIXWRo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 18:17:44 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id D9F702AC954; Thu, 25 Sep 2008 00:17:32 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/git-gui/populate-refactor.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96702>

The meat of the routines is now separated to add_fetch_entry() and
add_push_entry(). This refactoring will allow easy implementation of adding
individual remotes later.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/git-gui.sh     |    3 +-
 git-gui/lib/remote.tcl |  137 ++++++++++++++++++++++++------------------------
 2 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 10d8a44..75bd460 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3100,8 +3100,7 @@ if {[is_enabled transport]} {
 	load_all_remotes
 
 	set n [.mbar.remote index end]
-	populate_push_menu
-	populate_fetch_menu
+	populate_remotes_menu
 	set n [expr {[.mbar.remote index end] - $n}]
 	if {$n > 0} {
 		if {[.mbar.remote type 0] eq "tearoff"} { incr n }
diff --git a/git-gui/lib/remote.tcl b/git-gui/lib/remote.tcl
index 0e86dda..d97c851 100644
--- a/git-gui/lib/remote.tcl
+++ b/git-gui/lib/remote.tcl
@@ -132,91 +132,92 @@ proc load_all_remotes {} {
 	set all_remotes [lsort -unique $all_remotes]
 }
 
-proc populate_fetch_menu {} {
-	global all_remotes repo_config
-
+proc add_fetch_entry {r} {
+	global repo_config
 	set remote_m .mbar.remote
 	set fetch_m $remote_m.fetch
 	set prune_m $remote_m.prune
-
-	foreach r $all_remotes {
-		set enable 0
-		if {![catch {set a $repo_config(remote.$r.url)}]} {
-			if {![catch {set a $repo_config(remote.$r.fetch)}]} {
-				set enable 1
-			}
-		} else {
-			catch {
-				set fd [open [gitdir remotes $r] r]
-				while {[gets $fd n] >= 0} {
-					if {[regexp {^Pull:[ \t]*([^:]+):} $n]} {
-						set enable 1
-						break
-					}
+	set enable 0
+	if {![catch {set a $repo_config(remote.$r.url)}]} {
+		if {![catch {set a $repo_config(remote.$r.fetch)}]} {
+			set enable 1
+		}
+	} else {
+		catch {
+			set fd [open [gitdir remotes $r] r]
+			while {[gets $fd n] >= 0} {
+				if {[regexp {^Pull:[ \t]*([^:]+):} $n]} {
+					set enable 1
+					break
 				}
-				close $fd
 			}
+			close $fd
 		}
+	}
 
-		if {$enable} {
-			if {![winfo exists $fetch_m]} {
-				menu $prune_m
-				$remote_m insert 0 cascade \
-					-label [mc "Prune from"] \
-					-menu $prune_m
-
-				menu $fetch_m
-				$remote_m insert 0 cascade \
-					-label [mc "Fetch from"] \
-					-menu $fetch_m
-			}
-
-			$fetch_m add command \
-				-label $r \
-				-command [list fetch_from $r]
-			$prune_m add command \
-				-label $r \
-				-command [list prune_from $r]
+	if {$enable} {
+		if {![winfo exists $fetch_m]} {
+			menu $prune_m
+			$remote_m insert 0 cascade \
+				-label [mc "Prune from"] \
+				-menu $prune_m
+
+			menu $fetch_m
+			$remote_m insert 0 cascade \
+				-label [mc "Fetch from"] \
+				-menu $fetch_m
 		}
+
+		$fetch_m add command \
+			-label $r \
+			-command [list fetch_from $r]
+		$prune_m add command \
+			-label $r \
+			-command [list prune_from $r]
 	}
 }
 
-proc populate_push_menu {} {
-	global all_remotes repo_config
-
+proc add_push_entry {r} {
+	global repo_config
 	set remote_m .mbar.remote
 	set push_m $remote_m.push
-
-	foreach r $all_remotes {
-		set enable 0
-		if {![catch {set a $repo_config(remote.$r.url)}]} {
-			if {![catch {set a $repo_config(remote.$r.push)}]} {
-				set enable 1
-			}
-		} else {
-			catch {
-				set fd [open [gitdir remotes $r] r]
-				while {[gets $fd n] >= 0} {
-					if {[regexp {^Push:[ \t]*([^:]+):} $n]} {
-						set enable 1
-						break
-					}
+	set enable 0
+	if {![catch {set a $repo_config(remote.$r.url)}]} {
+		if {![catch {set a $repo_config(remote.$r.push)}]} {
+			set enable 1
+		}
+	} else {
+		catch {
+			set fd [open [gitdir remotes $r] r]
+			while {[gets $fd n] >= 0} {
+				if {[regexp {^Push:[ \t]*([^:]+):} $n]} {
+					set enable 1
+					break
 				}
-				close $fd
 			}
+			close $fd
 		}
+	}
 
-		if {$enable} {
-			if {![winfo exists $push_m]} {
-				menu $push_m
-				$remote_m insert 0 cascade \
-					-label [mc "Push to"] \
-					-menu $push_m
-			}
-
-			$push_m add command \
-				-label $r \
-				-command [list push_to $r]
+	if {$enable} {
+		if {![winfo exists $push_m]} {
+			menu $push_m
+			$remote_m insert 0 cascade \
+				-label [mc "Push to"] \
+				-menu $push_m
 		}
+
+		$push_m add command \
+			-label $r \
+			-command [list push_to $r]
+	}
+}
+
+proc populate_remotes_menu {} {
+	global all_remotes
+
+	foreach r $all_remotes {
+		add_fetch_entry $r
+		add_push_entry $r
 	}
 }
-- 
tg: (c427559..) t/git-gui/populate-refactor (depends on: vanilla/master)
