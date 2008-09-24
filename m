From: pasky@suse.cz
Subject: [PATCH 5/5] git-gui: Support for user-provided locator templates
Date: Thu, 25 Sep 2008 00:12:54 +0200
Message-ID: <20080924221733.552292124@suse.cz>
References: <20080924221249.037449176@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 00:19:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KichW-0008KG-LR
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 00:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbYIXWRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 18:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbYIXWRy
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 18:17:54 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:49880 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753047AbYIXWRq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 18:17:46 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 31D192AC8AA; Thu, 25 Sep 2008 00:17:33 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/git-gui/locators.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96703>

Users can now configure their own 'locator' templates, which they
can use to easen entering of common URLs; in all location inputs,
they can choose from the defined locators (and raw URL entry) and
their input is then substituted to the locator template.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 Documentation/config.txt             |   25 ++++++++++++++++
 git-gui/lib/choose_repository.tcl    |    7 ++++-
 git-gui/lib/remote_add.tcl           |    2 +-
 git-gui/lib/remote_branch_delete.tcl |    2 +-
 git-gui/lib/transport.tcl            |   52 +++++++++++++++++++++++++++++++--
 5 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bea867d..f3e82c6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -788,6 +788,21 @@ gui.pruneduringfetch::
 	"true" if linkgit:git-gui[1] should prune tracking branches when
 	performing a fetch. The default value is "false".
 
+gui.pulllocator::
+	Specifies the locator pre-selected for cloning and pulling
+	in case any locator templates (see 'locator.*.template')
+	are available. Set to 'URL' to default to the URL entry.
+
+gui.pushlocator::
+	Specifies the locator pre-selected for pushing
+	in case any locator templates (see 'locator.*.template')
+	are available. Set to 'URL' to default to the URL entry.
+
+gui.remotelocator::
+	Specifies the locator pre-selected when adding remotes
+	in case any locator templates (see 'locator.*.template')
+	are available. Set to 'URL' to default to the URL entry.
+
 gui.trustmtime::
 	Determines if linkgit:git-gui[1] should trust the file modification
 	timestamp or not. By default the timestamps are not trusted.
@@ -891,6 +906,16 @@ instaweb.port::
 	The port number to bind the gitweb httpd to. See
 	linkgit:git-instaweb[1].
 
+locator.<name>.template::
+	Normally, you specify repository locations e.g. when cloning
+	or adding remotes by some kind of full-fledged URL-ish specifier.
+	This option lets you specify templates for the most common locations
+	so that you do not have to type out the full URLs all the time;
+	'%s' in the template is substituted by user input. Thus, for example
+	'locator.ror.template = "git://git.kernel.org/%s"' would let you
+	easily refer to kernel.org projects. Currently, the user-defined
+	locators are supported only by linkgit:git-gui[1].
+
 log.date::
 	Set default date-time mode for the log command. Setting log.date
 	value is similar to using 'git-log'\'s --date option. The value is one of the
diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index 1c951ae..e05d3a9 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -465,7 +465,7 @@ method _do_clone {} {
 	pack $args -fill both
 
 	label $args.origin_l -text [mc "Source Location:"]
-	location_input $args.origin_t @origin_url
+	location_input $args.origin_t @origin_url pull
 	button $args.origin_b \
 		-text [mc "Browse"] \
 		-command [cb _open_origin]
@@ -541,6 +541,11 @@ method _open_origin {} {
 		return
 	}
 	set origin_url $p
+
+	# Fix up locators in case we use them
+	global _locator_template _locator_input
+	set _locator_template URL
+	set _locator_input $p
 }
 
 method _update_clone {args} {
diff --git a/git-gui/lib/remote_add.tcl b/git-gui/lib/remote_add.tcl
index b4a9ede..dec9dcb 100644
--- a/git-gui/lib/remote_add.tcl
+++ b/git-gui/lib/remote_add.tcl
@@ -49,7 +49,7 @@ constructor dialog {} {
 
 	label $w.desc.loc_l -text [mc "Location:"]
 	set w_loc $w.desc.loc_t
-	location_input $w_loc @location
+	location_input $w_loc @location remote
 	grid $w.desc.loc_l $w_loc -sticky we -padx {0 5}
 
 	grid columnconfigure $w.desc 1 -weight 1
diff --git a/git-gui/lib/remote_branch_delete.tcl b/git-gui/lib/remote_branch_delete.tcl
index 14a4c15..5cdab49 100644
--- a/git-gui/lib/remote_branch_delete.tcl
+++ b/git-gui/lib/remote_branch_delete.tcl
@@ -66,7 +66,7 @@ constructor dialog {} {
 		-text [mc "Arbitrary Location:"] \
 		-value url \
 		-variable @urltype
-	location_input $w.dest.url_t @url
+	location_input $w.dest.url_t @url push
 	trace add variable @url write [cb _write_url]
 	grid $w.dest.url_r $w.dest.url_t -sticky we -padx {0 5}
 	grid columnconfigure $w.dest 1 -weight 1
diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
index b8ceebe..277e6b8 100644
--- a/git-gui/lib/transport.tcl
+++ b/git-gui/lib/transport.tcl
@@ -30,19 +30,63 @@ proc push_to {remote} {
 	console::exec $w $cmd
 }
 
-proc location_input {widget urlvar} {
+proc locator_update {args} {
 	global repo_config
+	global _locator_template _locator_input _locator_var
+	regsub -all %s "$repo_config(locator.$_locator_template.template)" \
+		$_locator_input $_locator_var
+}
+
+proc location_input {widget urlvar op} {
+	global repo_config all_locators
+	set all_locators [list]
+
+	set repo_config(locator.URL.template) "%s"
+	foreach line [array names repo_config locator.*.template] {
+		if {![regexp ^locator\.(.*)\.template\$ $line line name]} continue
+		lappend all_locators $name
+	}
+
+	# 1 == just the default URL locator
+	if {[llength $all_locators] == 1} {
+		entry $widget \
+			-borderwidth 1 \
+			-relief sunken \
+			-width 50 \
+			-textvariable $urlvar \
+			-validate key \
+			-validatecommand {
+				if {%d == 1 && [regexp {\s} %S]} {return 0}
+				return 1
+			}
+		return 0
+	}
+
+	if {[catch {set default_locator $repo_config(gui.${op}locator)}]} {
+		set default_locator [lindex $all_locators 0]
+	}
+
+	global _locator_template _locator_input _locator_var
+	trace remove variable _locator_input write locator_update
+	set _locator_template $default_locator
+	set _locator_input {}
+	set _locator_var $urlvar
+	trace add variable _locator_input write locator_update
 
-	entry $widget \
+	frame $widget
+	eval tk_optionMenu $widget.l _locator_template $all_locators
+	entry $widget.s \
 		-borderwidth 1 \
 		-relief sunken \
 		-width 50 \
-		-textvariable $urlvar \
+		-textvariable _locator_input \
 		-validate key \
 		-validatecommand {
 			if {%d == 1 && [regexp {\s} %S]} {return 0}
 			return 1
 		}
+	pack $widget.l -side left
+	pack $widget.s -side right -fill x
 }
 
 proc start_push_anywhere_action {w} {
@@ -164,7 +208,7 @@ proc do_push_anywhere {} {
 		-text [mc "Arbitrary Location:"] \
 		-value url \
 		-variable push_urltype
-	location_input $w.dest.url_t push_url
+	location_input $w.dest.url_t push_url push
 	trace add variable push_url write push_anywhere_urltype
 	grid $w.dest.url_r $w.dest.url_t -sticky we -padx {0 5}
 	grid columnconfigure $w.dest 1 -weight 1
-- 
tg: (d617ccd..) t/git-gui/locators (depends on: t/git-gui/ldialogs-refactor)
