From: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
Subject: [PATCH v2 3/4] git gui: use textconv filter for diff and blame
Date: Tue,  8 Jun 2010 15:49:17 +0200
Message-ID: <1276004958-13540-4-git-send-email-clement.poulain@ensimag.imag.fr>
References: <1276004958-13540-1-git-send-email-clement.poulain@ensimag.imag.fr>
 <1276004958-13540-2-git-send-email-clement.poulain@ensimag.imag.fr>
 <1276004958-13540-3-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 08 15:50:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLzBw-0003aO-Dh
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 15:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319Ab0FHNts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 09:49:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38067 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755259Ab0FHNtp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 09:49:45 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o58Dfwcd024966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 8 Jun 2010 15:41:58 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o58Dnes6027962;
	Tue, 8 Jun 2010 15:49:40 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o58Dnet6013682;
	Tue, 8 Jun 2010 15:49:40 +0200
Received: (from poulainc@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o58DneGw013681;
	Tue, 8 Jun 2010 15:49:40 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276004958-13540-3-git-send-email-clement.poulain@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 08 Jun 2010 15:41:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o58Dfwcd024966
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148673>

Create a checkbox "Use Textconv For Diffs and Blame" in git-gui options=
=2E
If checked and if the driver for the concerned file exists, git-gui cal=
ls diff
and blame with --textconv option

Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>=20
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>=20
---
 git-gui/git-gui.sh     |   28 +++++++++++++++++++++++++++-
 git-gui/lib/blame.tcl  |   21 +++++++++++++++++++--
 git-gui/lib/diff.tcl   |    5 ++++-
 git-gui/lib/option.tcl |    1 +
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 7d54511..59edf39 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -269,6 +269,17 @@ proc is_config_true {name} {
 	}
 }
=20
+proc is_config_false {name} {
+	global repo_config
+	if {[catch {set v $repo_config($name)}]} {
+		return 0
+	} elseif {$v eq {false} || $v eq {0} || $v eq {no}} {
+		return 1
+	} else {
+		return 0
+	}
+}
+
 proc get_config {name} {
 	global repo_config
 	if {[catch {set v $repo_config($name)}]} {
@@ -782,6 +793,7 @@ set default_config(user.email) {}
=20
 set default_config(gui.encoding) [encoding system]
 set default_config(gui.matchtrackingbranch) false
+set default_config(gui.textconv) true
 set default_config(gui.pruneduringfetch) false
 set default_config(gui.trustmtime) false
 set default_config(gui.fastcopyblame) false
@@ -3405,6 +3417,19 @@ lappend diff_actions [list $ctxmsm entryconf [$c=
txmsm index last] -state]
 $ctxmsm add separator
 create_common_diff_popup $ctxmsm
=20
+proc has_textconv {path} {
+	if {[is_config_false gui.textconv]} {
+		return 0
+	}
+	set filter [gitattr $path diff set]
+	set textconv [get_config [join [list diff $filter textconv] .]]
+	if {$filter ne {set} && $textconv ne {}} {
+		return 1
+	} else {
+		return 0
+	}
+}
+
 proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 	global current_diff_path file_states
 	set ::cursorX $x
@@ -3440,7 +3465,8 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y}=
 {
 			|| {__} eq $state
 			|| {_O} eq $state
 			|| {_T} eq $state
-			|| {T_} eq $state} {
+			|| {T_} eq $state
+			|| [has_textconv $current_diff_path]} {
 			set s disabled
 		} else {
 			set s normal
diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
index 786b50b..b0f2f23 100644
--- a/git-gui/lib/blame.tcl
+++ b/git-gui/lib/blame.tcl
@@ -449,11 +449,28 @@ method _load {jump} {
=20
 	$status show [mc "Reading %s..." "$commit:[escape_path $path]"]
 	$w_path conf -text [escape_path $path]
+
+	set do_textconv 0
+	if {![is_config_false gui.textconv]} {
+		set filter [gitattr $path diff set]
+		set textconv [get_config [join [list diff $filter textconv] .]]
+		if {$filter ne {set} && $textconv ne {}} {
+			set do_textconv 1
+		}
+	}
 	if {$commit eq {}} {
-		set fd [open $path r]
+		if {$do_textconv ne 0} {
+			set fd [open "|$textconv $path" r]
+		} else {
+			set fd [open $path r]
+		}
 		fconfigure $fd -eofchar {}
 	} else {
-		set fd [git_read cat-file blob "$commit:$path"]
+		if {$do_textconv ne 0} {
+			set fd [git_read cat-file --textconv "$commit:$path"]
+		} else {
+			set fd [git_read cat-file blob "$commit:$path"]
+		}
 	}
 	fconfigure $fd \
 		-blocking 0 \
diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index ec8c11e..c628750 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -55,7 +55,7 @@ proc handle_empty_diff {} {
=20
 	set path $current_diff_path
 	set s $file_states($path)
-	if {[lindex $s 0] ne {_M}} return
+	if {[lindex $s 0] ne {_M} || [has_textconv $path]} return
=20
 	# Prevent infinite rescan loops
 	incr diff_empty_count
@@ -280,6 +280,9 @@ proc start_show_diff {cont_info {add_opts {}}} {
 			lappend cmd diff-files
 		}
 	}
+	if {![is_config_false gui.textconv] && [git-version >=3D 1.6.1]} {
+		lappend cmd --textconv
+	}
=20
 	if {[string match {160000 *} [lindex $s 2]]
 	 || [string match {160000 *} [lindex $s 3]]} {
diff --git a/git-gui/lib/option.tcl b/git-gui/lib/option.tcl
index d4c5e45..3807c8d 100644
--- a/git-gui/lib/option.tcl
+++ b/git-gui/lib/option.tcl
@@ -148,6 +148,7 @@ proc do_options {} {
 		{b gui.trustmtime  {mc "Trust File Modification Timestamps"}}
 		{b gui.pruneduringfetch {mc "Prune Tracking Branches During Fetch"}}
 		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
+		{b gui.textconv {mc "Use Textconv For Diffs and Blames"}}
 		{b gui.fastcopyblame {mc "Blame Copy Only On Changed Files"}}
 		{i-20..200 gui.copyblamethreshold {mc "Minimum Letters To Blame Copy=
 On"}}
 		{i-0..300 gui.blamehistoryctx {mc "Blame History Context Radius (day=
s)"}}
--=20
1.7.1.202.g79415.dirty
