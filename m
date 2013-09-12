From: Joergen Edelbo <jed@napatech.com>
Subject: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Thu, 12 Sep 2013 11:21:40 +0200
Message-ID: <20130912093535.421691218BA@jed-dev-01.labnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: j.sixt@viscovery.net, gitster@pobox.com, hvoigt@hvoigt.net,
	patthoyts@gmail.com, jed@napatech.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 11:35:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK3JP-0006HV-0k
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 11:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab3ILJfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 05:35:39 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from nat.napatech.com ([188.120.77.114]:1764 "EHLO jed-dev-01.labnet"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750914Ab3ILJfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 05:35:38 -0400
Received: by jed-dev-01.labnet (Postfix, from userid 1000)
	id 421691218BA; Thu, 12 Sep 2013 11:35:35 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234633>

Problem: It is not possible to push for Gerrit review as you will
always try to push to "refs/heads/..." on the remote.

Changes done:

Add an option in the Push dialog to select "Gerrit review" and a
corresponding entry for a branch name. If this option is selected,
push the changes to "refs/for/<gerrit-branch>/<local branch>". In
this way the local branch names will be used as topic branches on
Gerrit.

If you are on a detached HEAD, then add a "HEAD" entry in the branch
selection list. If this is selected, push HEAD:HEAD in the normal
case and HEAD:refs/for/<gerrit_branch> in the Gerrit case.

The Gerrit branch to push to is controlled by gerrit.reviewbranch
configuration option.
---
Hi again,

Seems like this discussion has died out. Is there no perspective in
changing git-gui to support Gerrit better?

Anyway here is what I consider my final shot at a solution. Compared
to the last one, this commit can handle the case when you work on a=20
detached HEAD, and the Gerrit branch to push to is handled by a
configuration option.

BR J=C3=B8rgen Edelbo

 git-gui.sh        |    1 +
 lib/option.tcl    |    1 +
 lib/transport.tcl |   48 +++++++++++++++++++++++++++++++++++++++++++++=
---
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index b62ae4a..3228654 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -901,6 +901,7 @@ set default_config(gui.diffcontext) 5
 set default_config(gui.diffopts) {}
 set default_config(gui.commitmsgwidth) 75
 set default_config(gui.newbranchtemplate) {}
+set default_config(gerrit.reviewbranch) {}
 set default_config(gui.spellingdictionary) {}
 set default_config(gui.fontui) [font configure font_ui]
 set default_config(gui.fontdiff) [font configure font_diff]
diff --git a/lib/option.tcl b/lib/option.tcl
index 23c9ae7..ffa4226 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -157,6 +157,7 @@ proc do_options {} {
 		{t gui.diffopts {mc "Additional Diff Parameters"}}
 		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
+		{t gerrit.reviewbranch {mc "Gerrit Review Branch"}}
 		{c gui.encoding {mc "Default File Contents Encoding"}}
 		{b gui.warndetachedcommit {mc "Warn before committing to a detached =
head"}}
 		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes" =
"no" "ask"}}
diff --git a/lib/transport.tcl b/lib/transport.tcl
index e5d211e..9b1cfc5 100644
--- a/lib/transport.tcl
+++ b/lib/transport.tcl
@@ -61,6 +61,7 @@ proc push_to {remote} {
=20
 proc start_push_anywhere_action {w} {
 	global push_urltype push_remote push_url push_thin push_tags
+	global gerrit_review gerrit_branch
 	global push_force
 	global repo_config
=20
@@ -95,7 +96,19 @@ proc start_push_anywhere_action {w} {
 		set cnt 0
 		foreach i [$w.source.l curselection] {
 			set b [$w.source.l get $i]
-			lappend cmd "refs/heads/$b:refs/heads/$b"
+			if {$gerrit_review && $gerrit_branch ne {}} {
+				switch $b {
+				$gerrit_branch	{ lappend cmd "refs/heads/$b:refs/for/$gerrit_branc=
h" }
+				HEAD		{ lappend cmd "HEAD:refs/for/$gerrit_branch" }
+				default		{ lappend cmd "refs/heads/$b:refs/for/$gerrit_branch/$b" =
}
+				}
+			} else {
+				if {$b eq HEAD} {
+					lappend cmd "HEAD:HEAD"
+				} else {
+					lappend cmd "refs/heads/$b:refs/heads/$b"
+				}
+			}
 			incr cnt
 		}
 		if {$cnt =3D=3D 0} {
@@ -118,9 +131,10 @@ trace add variable push_remote write \
 	[list radio_selector push_urltype remote]
=20
 proc do_push_anywhere {} {
-	global all_remotes current_branch
+	global all_remotes current_branch is_detached
 	global push_urltype push_remote push_url push_thin push_tags
-	global push_force use_ttk NS
+	global gerrit_review gerrit_branch
+	global push_force use_ttk NS repo_config
=20
 	set w .push_setup
 	toplevel $w
@@ -149,6 +163,11 @@ proc do_push_anywhere {} {
 		-height 10 \
 		-width 70 \
 		-selectmode extended
+	if {$is_detached} {
+		$w.source.l insert end HEAD
+		$w.source.l select set end
+		$w.source.l yview end
+	}
 	foreach h [load_all_heads] {
 		$w.source.l insert end $h
 		if {$h eq $current_branch} {
@@ -215,13 +234,36 @@ proc do_push_anywhere {} {
 		-text [mc "Include tags"] \
 		-variable push_tags
 	grid $w.options.tags -columnspan 2 -sticky w
+	${NS}::checkbutton $w.options.gerrit \
+		-text [mc "Gerrit review.  Branch: "] \
+		-variable gerrit_review
+	${NS}::entry $w.options.gerrit_br \
+		-width 50 \
+		-textvariable gerrit_branch \
+		-validate key \
+		-validatecommand {
+			if {%d =3D=3D 1 && [regexp {\s} %S]} {return 0}
+			if {%d =3D=3D 1 && [string length %S] > 0} {
+				set gerrit_review 1
+			}
+			if {[string length %P] =3D=3D 0} {
+				set gerrit_review 0
+			}
+			return 1
+		}
+	grid $w.options.gerrit $w.options.gerrit_br -sticky we -padx {0 5}
 	grid columnconfigure $w.options 1 -weight 1
 	pack $w.options -anchor nw -fill x -pady 5 -padx 5
=20
+	if ![info exists gerrit_branch] {=20
+		set gerrit_branch {}
+		catch {set gerrit_branch $repo_config(gerrit.reviewbranch)}
+	}
 	set push_url {}
 	set push_force 0
 	set push_thin 0
 	set push_tags 0
+	set gerrit_review [expr {$gerrit_branch ne {}}]
=20
 	bind $w <Visibility> "grab $w; focus $w.buttons.create"
 	bind $w <Key-Escape> "destroy $w"
--=20
1.7.9.5
