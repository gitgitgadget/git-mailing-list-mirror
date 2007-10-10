From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: offer a list of recent repositories on startup
Date: Wed, 10 Oct 2007 03:30:53 -0400
Message-ID: <20071010073053.GQ2137@spearce.org>
References: <11917925011987-git-send-email-prohaska@zib.de> <20071007233023.GE2137@spearce.org> <BE872860-40AD-4BBA-BDD5-0EC8CB9AC4B5@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 09:31:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfW2D-0007Jt-4t
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 09:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbXJJHbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 03:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbXJJHbB
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 03:31:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37526 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbXJJHbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 03:31:00 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IfW1x-0008Qf-8f; Wed, 10 Oct 2007 03:30:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DE19A20FBAE; Wed, 10 Oct 2007 03:30:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <BE872860-40AD-4BBA-BDD5-0EC8CB9AC4B5@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60472>

Steffen Prohaska <prohaska@zib.de> wrote:
> Shawn,
> I attached two patches. They should eventually be both squashed into  
> one.

Thanks.  I'm applying the patch below over both of yours, and
then squashing them all together and keeping you as the author.

I did not like how the listbox looked (or worked!) on Mac OS X.
Clicking on the item was at first a very non-obvious action, and
then when I did do it I was very shocked to see the repository open
immediately.  My brain knew the action was wired to the selection
event (I obviously read the two patches before applying them),
but it didn't expect that behavior.  Clearly the wrong UI model.

The patch below uses a text widget instead and renders each of
the repositories as a blue underlined link.  Users will generally
assume that clicking on such links will take them immediately to
that repository (much as it would take them to another webpage if
this was a web browser).

The "Open Recent Repositories" is not even shown in the UI if there
aren't any to offer to the user.  Showing them this area just looks
silly if they haven't opened or cloned anything yet.

We now add freshly created or cloned repositories to the list of
recently opened repositories.  These are just as fair game for
being recently accessed as any others.  Perhaps even more so as
users may wonder where they cloned that repository to the last time
they started git-gui.

We always store the absolute path of a repository into the config.
This avoids the mess of opening a repository twice using say a
relative path entered into the text entry field and then opening
it later via a file browser, only to find out you now have the same
repository in the recent list twice.

I fixed the --unset-all bug and also avoided the --unset-all/--add
loop you were using.  We convert the value into a "safe" expression
and then try to match on it.

---

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 4deb1ec..bdfdbae 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -80,27 +80,35 @@ constructor pick {} {
 		-text [mc "Open Existing Repository"] \
 		-variable @action \
 		-value open
-	label $w_body.space
-	label $w_body.recentlabel \
-		-anchor w \
-		-text [mc "Select Recent Repository:"]
-	set w_recentlist $w_body.recentlist
-	listbox $w_recentlist \
-		-relief flat \
-		-width 50 \
-		-height 10 \
-		-exportselection false \
-		-selectmode select
-	foreach p [_get_recentrepos] {
-		$w_recentlist insert end $p
-	}
-	bind $w_recentlist <<ListboxSelect>> [cb _open_recent]
 	pack $w_body.new -anchor w -fill x
 	pack $w_body.clone -anchor w -fill x
 	pack $w_body.open -anchor w -fill x
-	pack $w_body.space -anchor w -fill x
-	pack $w_body.recentlabel -anchor w -fill x
-	pack $w_recentlist -anchor w -fill x
+
+	set recent [_get_recentrepos]
+	if {[llength $recent] > 0} {
+		label $w_body.space
+		label $w_body.recentlabel \
+			-anchor w \
+			-text [mc "Open Recent Repository:"]
+		set w_recentlist $w_body.recentlist
+		text $w_recentlist \
+			-cursor $::cursor_ptr \
+			-wrap none \
+			-width 50 \
+			-height 10
+		$w_recentlist tag conf link \
+			-foreground blue \
+			-underline 1
+		foreach p $recent {
+			$w_recentlist insert end $p link
+			$w_recentlist insert end "\n"
+		}
+		$w_recentlist conf -state disabled
+		$w_recentlist tag bind link <1> [cb _open_recent %x,%y]
+		pack $w_body.space -anchor w -fill x
+		pack $w_body.recentlabel -anchor w -fill x
+		pack $w_recentlist -anchor w -fill x
+	}
 	pack $w_body -fill x -padx 10 -pady 10
 
 	frame $w.buttons
@@ -164,23 +172,26 @@ proc _get_recentrepos {} {
 }
 
 proc _append_recentrepos {path} {
+	set path [file normalize $path]
 	set recent [get_config gui.recentrepo]
 	if {[lsearch $recent $path] >= 0} {
 		return
 	}
+
 	lappend recent $path
-	if {[llength $recent] > 10} {
+	git config --global --add gui.recentrepo $path
+
+	while {[llength $recent] > 10} {
+		set p [lindex $recent 0]
 		set recent [lrange $recent 1 end]
-	}
-	git config --global --unset-all gui.recentrepo
-	foreach p $recent {
-		git config --global --add gui.recentrepo $p
+		regsub -all -- {([()\[\]{}\.^$+*?\\])} $p {\\\1} p
+		git config --global --unset gui.recentrepo "^$p\$"
 	}
 }
 
-method _open_recent {} {
-	set id [$w_recentlist curselection]
-	set local_path [$w_recentlist get $id]
+method _open_recent {xy} {
+	set id [lindex [split [$w_recentlist index @$xy] .] 0]
+	set local_path [$w_recentlist get $id.0 $id.end]
 	_do_open2 $this
 }
 
@@ -224,6 +235,7 @@ method _git_init {} {
 		return 0
 	}
 
+	_append_recentrepos [pwd]
 	set ::_gitdir .git
 	set ::_prefix {}
 	return 1
@@ -906,8 +918,7 @@ method _do_open2 {} {
 		return
 	}
 
-	_append_recentrepos $local_path
-
+	_append_recentrepos [pwd]
 	set ::_gitdir .git
 	set ::_prefix {}
 	set done 1

-- 
Shawn.
