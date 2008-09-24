From: pasky@suse.cz
Subject: [PATCH 4/5] git-gui: Factor out URL inputbox construction to location_input
Date: Thu, 25 Sep 2008 00:12:53 +0200
Message-ID: <20080924221732.904804942@suse.cz>
References: <20080924221249.037449176@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 00:19:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KichV-0008KG-SG
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 00:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbYIXWRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 18:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbYIXWRv
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 18:17:51 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:49878 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753003AbYIXWRp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 18:17:45 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 83F222AC955; Thu, 25 Sep 2008 00:17:33 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/git-gui/ldialogs-refactor.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96701>

This will make it easier to introduce custom locators.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/lib/choose_repository.tcl    |    6 +---
 git-gui/lib/remote_add.tcl           |    6 +---
 git-gui/lib/remote_branch_delete.tcl |   11 +-------
 git-gui/lib/transport.tcl            |   46 ++++++++++++++++++++-------------
 4 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index 9091316..1c951ae 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -465,11 +465,7 @@ method _do_clone {} {
 	pack $args -fill both
 
 	label $args.origin_l -text [mc "Source Location:"]
-	entry $args.origin_t \
-		-textvariable @origin_url \
-		-borderwidth 1 \
-		-relief sunken \
-		-width 50
+	location_input $args.origin_t @origin_url
 	button $args.origin_b \
 		-text [mc "Browse"] \
 		-command [cb _open_origin]
diff --git a/git-gui/lib/remote_add.tcl b/git-gui/lib/remote_add.tcl
index 89e88ee..b4a9ede 100644
--- a/git-gui/lib/remote_add.tcl
+++ b/git-gui/lib/remote_add.tcl
@@ -49,11 +49,7 @@ constructor dialog {} {
 
 	label $w.desc.loc_l -text [mc "Location:"]
 	set w_loc $w.desc.loc_t
-	entry $w_loc \
-		-borderwidth 1 \
-		-relief sunken \
-		-width 40 \
-		-textvariable @location
+	location_input $w_loc @location
 	grid $w.desc.loc_l $w_loc -sticky we -padx {0 5}
 
 	grid columnconfigure $w.desc 1 -weight 1
diff --git a/git-gui/lib/remote_branch_delete.tcl b/git-gui/lib/remote_branch_delete.tcl
index a09b9ad..14a4c15 100644
--- a/git-gui/lib/remote_branch_delete.tcl
+++ b/git-gui/lib/remote_branch_delete.tcl
@@ -66,16 +66,7 @@ constructor dialog {} {
 		-text [mc "Arbitrary Location:"] \
 		-value url \
 		-variable @urltype
-	entry $w.dest.url_t \
-		-borderwidth 1 \
-		-relief sunken \
-		-width 50 \
-		-textvariable @url \
-		-validate key \
-		-validatecommand {
-			if {%d == 1 && [regexp {\s} %S]} {return 0}
-			return 1
-		}
+	location_input $w.dest.url_t @url
 	trace add variable @url write [cb _write_url]
 	grid $w.dest.url_r $w.dest.url_t -sticky we -padx {0 5}
 	grid columnconfigure $w.dest 1 -weight 1
diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
index e419d78..b8ceebe 100644
--- a/git-gui/lib/transport.tcl
+++ b/git-gui/lib/transport.tcl
@@ -30,6 +30,21 @@ proc push_to {remote} {
 	console::exec $w $cmd
 }
 
+proc location_input {widget urlvar} {
+	global repo_config
+
+	entry $widget \
+		-borderwidth 1 \
+		-relief sunken \
+		-width 50 \
+		-textvariable $urlvar \
+		-validate key \
+		-validatecommand {
+			if {%d == 1 && [regexp {\s} %S]} {return 0}
+			return 1
+		}
+}
+
 proc start_push_anywhere_action {w} {
 	global push_urltype push_remote push_url push_thin push_tags
 	global push_force
@@ -77,11 +92,22 @@ proc start_push_anywhere_action {w} {
 trace add variable push_remote write \
 	[list radio_selector push_urltype remote]
 
+proc push_anywhere_urltype {args} {
+	global push_urltype
+	set push_urltype url
+	warn_popup "blablabla"
+}
+
 proc do_push_anywhere {} {
 	global all_remotes current_branch
 	global push_urltype push_remote push_url push_thin push_tags
 	global push_force
 
+	set push_url {}
+	set push_force 0
+	set push_thin 0
+	set push_tags 0
+
 	set w .push_setup
 	toplevel $w
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
@@ -138,19 +164,8 @@ proc do_push_anywhere {} {
 		-text [mc "Arbitrary Location:"] \
 		-value url \
 		-variable push_urltype
-	entry $w.dest.url_t \
-		-borderwidth 1 \
-		-relief sunken \
-		-width 50 \
-		-textvariable push_url \
-		-validate key \
-		-validatecommand {
-			if {%d == 1 && [regexp {\s} %S]} {return 0}
-			if {%d == 1 && [string length %S] > 0} {
-				set push_urltype url
-			}
-			return 1
-		}
+	location_input $w.dest.url_t push_url
+	trace add variable push_url write push_anywhere_urltype
 	grid $w.dest.url_r $w.dest.url_t -sticky we -padx {0 5}
 	grid columnconfigure $w.dest 1 -weight 1
 	pack $w.dest -anchor nw -fill x -pady 5 -padx 5
@@ -171,11 +186,6 @@ proc do_push_anywhere {} {
 	grid columnconfigure $w.options 1 -weight 1
 	pack $w.options -anchor nw -fill x -pady 5 -padx 5
 
-	set push_url {}
-	set push_force 0
-	set push_thin 0
-	set push_tags 0
-
 	bind $w <Visibility> "grab $w; focus $w.buttons.create"
 	bind $w <Key-Escape> "destroy $w"
 	bind $w <Key-Return> [list start_push_anywhere_action $w]
-- 
tg: (4e2c8cc..) t/git-gui/ldialogs-refactor (depends on: t/git-gui/ldialogs-consistent t/git-gui/remote-add)
