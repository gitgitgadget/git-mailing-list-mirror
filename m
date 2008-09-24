From: pasky@suse.cz
Subject: [PATCH 2/5] git-gui: Squash populate_{push,fetch}_menu to populate_remotes_menu
Date: Wed, 24 Sep 2008 22:44:00 +0200
Message-ID: <20080924204614.891128345@suse.cz>
References: <20080924204358.144077183@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 22:47:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KibGr-0002ed-RC
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 22:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbYIXUqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 16:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbYIXUqa
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 16:46:30 -0400
Received: from [212.249.11.140] ([212.249.11.140]:46829 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752434AbYIXUq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 16:46:26 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 967212AC8FD; Wed, 24 Sep 2008 22:46:15 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/git-gui/populate-refactor.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96689>

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
