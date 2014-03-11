From: Henri GEIST <geist.henri@laposte.net>
Subject: [PATCH v2] git-gui: Add a 'recursive' checkbox in the clone menu.
Date: Tue, 11 Mar 2014 19:21:01 +0100
Message-ID: <1394562061.7891.64.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 19:21:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNRIg-0006in-FD
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 19:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098AbaCKSVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 14:21:09 -0400
Received: from smtpout5.laposte.net ([193.253.67.230]:24271 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080AbaCKSVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 14:21:08 -0400
Received: from [192.168.0.8] ([82.242.149.125])
	by mwinf8509-out with ME
	id cJM11n0062iaXuy03JM1qh; Tue, 11 Mar 2014 19:21:03 +0100
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243877>

Permit to do a 'git clone --recursive' through git-gui.
Add a 'recursive' checkbox in the clone menu which allows
users to clone a repository and all its submodules in one
go (unless the 'update' flag is set to "none" in the
.gitmodules file for a submodule, in that case that
specific submodule is not cloned automatically).

Enable this new option per default, as most users want to
clone all submodules too when cloning the superproject
(This is currently not possible without leaving git gui
or adding a custom tool entry for that).

Signed-off-by: Henri GEIST <geist.henri@laposte.net>
Thanks-to: Jens Lehmann <Jens.Lehmann@web.de>
---
 lib/choose_repository.tcl |   34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 3c10bc6..1209fa6 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -18,6 +18,7 @@ field local_path       {} ; # Where this repository is locally
 field origin_url       {} ; # Where we are cloning from
 field origin_name  origin ; # What we shall call 'origin'
 field clone_type hardlink ; # Type of clone to construct
+field recursive      true ; # Recursive cloning flag
 field readtree_err        ; # Error output from read-tree (if any)
 field sorted_recent       ; # recent repositories (sorted)
 
@@ -525,6 +526,11 @@ method _do_clone {} {
 	foreach r $w_types {
 		pack $r -anchor w
 	}
+	${NS}::checkbutton $args.type_f.recursive \
+		-text [mc "Recursively clone submodules too"] \
+		-variable @recursive \
+		-onvalue true -offvalue false
+	pack $args.type_f.recursive
 	grid $args.type_l $args.type_f -sticky new
 
 	grid columnconfigure $args 1 -weight 1
@@ -952,6 +958,30 @@ method _do_clone_checkout {HEAD} {
 	fileevent $fd readable [cb _readtree_wait $fd]
 }
 
+method _do_validate_submodule_cloning {ok} {
+	if {$ok} {
+		$o_cons done $ok
+		set done 1
+	} else {
+		_clone_failed $this [mc "Cannot clone submodules."]
+	}
+}
+
+method _do_clone_submodules {} {
+	if {$recursive eq {true}} {
+		destroy $w_body
+		set o_cons [console::embed \
+			$w_body \
+			[mc "Cloning submodules"]]
+		pack $w_body -fill both -expand 1 -padx 10
+		$o_cons exec \
+			[list git submodule update --init --recursive] \
+			[cb _do_validate_submodule_cloning]
+	} else {
+		set done 1
+	}
+}
+
 method _readtree_wait {fd} {
 	set buf [read $fd]
 	$o_cons update_meter $buf
@@ -982,7 +1012,7 @@ method _readtree_wait {fd} {
 		fconfigure $fd_ph -blocking 0 -translation binary -eofchar {}
 		fileevent $fd_ph readable [cb _postcheckout_wait $fd_ph]
 	} else {
-		set done 1
+		_do_clone_submodules $this
 	}
 }
 
@@ -996,7 +1026,7 @@ method _postcheckout_wait {fd_ph} {
 			hook_failed_popup post-checkout $pch_error 0
 		}
 		unset pch_error
-		set done 1
+		_do_clone_submodules $this
 		return
 	}
 	fconfigure $fd_ph -blocking 0
-- 
1.7.9.3.369.gd715.dirty
