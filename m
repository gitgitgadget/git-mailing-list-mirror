From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 2/2] git-gui: teach fetch/prune menu to do it for all
	remotes
Date: Sun, 13 Feb 2011 14:57:15 +0100
Message-ID: <20110213135714.GE31986@book.hvoigt.net>
References: <20110212164344.GA19433@book.hvoigt.net> <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com> <20110213134753.GC31986@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 14:58:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PocSn-0005Ze-PD
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 14:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab1BMN5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 08:57:35 -0500
Received: from darksea.de ([83.133.111.250]:59447 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754586Ab1BMN5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 08:57:18 -0500
Received: (qmail 14007 invoked from network); 13 Feb 2011 14:57:15 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 13 Feb 2011 14:57:15 +0100
Content-Disposition: inline
In-Reply-To: <20110213134753.GC31986@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166668>

The commandline fetch already has this option for some time.  Since this
was not available at the time git gui was written lets implement it now.

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
It just came to my mind that I probably should implement a version check
of the commandline to ensure that this option is available. Thats why I
tagged only this patch with RFC.

Cheers Heiko

 lib/remote.tcl    |   45 +++++++++++++++++++++++++++++++++++++++++++++
 lib/transport.tcl |   29 +++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/lib/remote.tcl b/lib/remote.tcl
index d9eab78..7011681 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -230,6 +230,45 @@ proc make_sure_remote_submenues_exist {remote_m} {
 	}
 }
 
+proc update_all_remotes_menu_entry {} {
+	global all_remotes
+
+	set have_remote 0
+	foreach r $all_remotes {
+		set have_remote 1
+	}
+
+	set remote_m .mbar.remote
+	set fetch_m $remote_m.fetch
+	set prune_m $remote_m.prune
+	if {$have_remote} {
+		make_sure_remote_submenues_exist $remote_m
+		if {[$fetch_m entrycget 0 -label] ne "All"} {
+
+			$fetch_m insert 0 separator
+			$fetch_m insert 0 command \
+				-label "All" \
+				-command fetch_from_all
+
+			$prune_m insert 0 separator
+			$prune_m insert 0 command \
+	  			-label "All" \
+				-command prune_from_all
+		}
+	} else {
+		if {[winfo exists $fetch_m]} {
+			if {[$fetch_m type end] eq "separator"} {
+
+				delete_from_menu $fetch_m 0
+				delete_from_menu $fetch_m 0
+
+				delete_from_menu $prune_m 0
+				delete_from_menu $prune_m 0
+			}
+		}
+	}
+}
+
 proc populate_remotes_menu {} {
 	global all_remotes
 
@@ -237,6 +276,8 @@ proc populate_remotes_menu {} {
 		add_fetch_entry $r
 		add_push_entry $r
 	}
+
+	update_all_remotes_menu_entry
 }
 
 proc add_single_remote {name location} {
@@ -252,6 +293,8 @@ proc add_single_remote {name location} {
 
 	add_fetch_entry $name
 	add_push_entry $name
+
+	update_all_remotes_menu_entry
 }
 
 proc delete_from_menu {menu name} {
@@ -281,4 +324,6 @@ proc remove_remote {name} {
 	delete_from_menu $remote_m.remove $name
 	# Not all remotes are in the push menu
 	catch { delete_from_menu $remote_m.push $name }
+
+	update_all_remotes_menu_entry
 }
diff --git a/lib/transport.tcl b/lib/transport.tcl
index 3067058..7fad9b7 100644
--- a/lib/transport.tcl
+++ b/lib/transport.tcl
@@ -20,6 +20,35 @@ proc prune_from {remote} {
 	console::exec $w [list git remote prune $remote]
 }
 
+proc fetch_from_all {} {
+	set w [console::new \
+		[mc "fetch all remotes"] \
+		[mc "Fetching new changes from all remotes"]]
+
+	set cmd [list git fetch --all]
+	if {[is_config_true gui.pruneduringfetch]} {
+		lappend cmd --prune
+	}
+
+	console::exec $w $cmd
+}
+
+proc prune_from_all {} {
+	global all_remotes
+
+	set w [console::new \
+		[mc "remote prune all remotes"] \
+		[mc "Pruning tracking branches deleted from all remotes"]]
+
+	set cmd [list git remote prune]
+
+	foreach r $all_remotes {
+		lappend cmd $r
+	}
+
+	console::exec $w $cmd
+}
+
 proc push_to {remote} {
 	set w [console::new \
 		[mc "push %s" $remote] \
-- 
1.7.4.rc3.4.g155c4
