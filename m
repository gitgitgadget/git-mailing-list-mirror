From: pasky@suse.cz
Subject: [PATCH 4/5] git-gui: Add support for removing remotes
Date: Wed, 24 Sep 2008 22:44:02 +0200
Message-ID: <20080924204616.189163849@suse.cz>
References: <20080924204358.144077183@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 22:48:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KibHQ-0002ti-P3
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 22:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbYIXUqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 16:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbYIXUqf
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 16:46:35 -0400
Received: from [212.249.11.140] ([212.249.11.140]:46831 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752424AbYIXUq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 16:46:28 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id A789A2AC955; Wed, 24 Sep 2008 22:46:16 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/git-gui/remote-rm.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96694>

We introduce new submenu Remote -> Remove Remote, allowing to remove
remotes. In the future, we might consider a confirmation popup to avoid
misclicks, but removing a remote is not very lossy operation.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/lib/remote.tcl |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/git-gui/lib/remote.tcl b/git-gui/lib/remote.tcl
index 643f0bc..1852247 100644
--- a/git-gui/lib/remote.tcl
+++ b/git-gui/lib/remote.tcl
@@ -137,6 +137,7 @@ proc add_fetch_entry {r} {
 	set remote_m .mbar.remote
 	set fetch_m $remote_m.fetch
 	set prune_m $remote_m.prune
+	set remove_m $remote_m.remove
 	set enable 0
 	if {![catch {set a $repo_config(remote.$r.url)}]} {
 		if {![catch {set a $repo_config(remote.$r.fetch)}]} {
@@ -157,6 +158,11 @@ proc add_fetch_entry {r} {
 
 	if {$enable} {
 		if {![winfo exists $fetch_m]} {
+			menu $remove_m
+			$remote_m insert 0 cascade \
+				-label [mc "Remove Remote"] \
+				-menu $remove_m
+
 			menu $prune_m
 			$remote_m insert 0 cascade \
 				-label [mc "Prune from"] \
@@ -174,6 +180,9 @@ proc add_fetch_entry {r} {
 		$prune_m add command \
 			-label $r \
 			-command [list prune_from $r]
+		$remove_m add command \
+			-label $r \
+			-command [list remove_remote $r]
 	}
 }
 
@@ -236,3 +245,31 @@ proc add_single_remote {name location} {
 	add_fetch_entry $name
 	add_push_entry $name
 }
+
+proc delete_from_menu {menu name} {
+	if {[winfo exists $menu]} {
+		$menu delete $name
+	}
+}
+
+proc remove_remote {name} {
+	global all_remotes repo_config
+
+	git remote rm $name
+
+	catch {
+		# Missing values are ok
+		unset repo_config(remote.$name.url)
+		unset repo_config(remote.$name.fetch)
+		unset repo_config(remote.$name.push)
+	}
+
+	set i [lsearch -exact all_remotes $name]
+	lreplace all_remotes $i $i
+
+	set remote_m .mbar.remote
+	delete_from_menu $remote_m.fetch $name
+	delete_from_menu $remote_m.prune $name
+	delete_from_menu $remote_m.remove $name
+	delete_from_menu $remote_m.push $name
+}
-- 
tg: (f30d624..) t/git-gui/remote-rm (depends on: t/git-gui/remote-add)
