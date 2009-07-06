From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC/PATCH] git-gui: display summary when showing diff of a submodule
Date: Mon, 06 Jul 2009 23:31:01 +0200
Message-ID: <4A526D15.3090202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 23:31:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNvmf-0000xv-0N
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 23:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbZGFVbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 17:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbZGFVbA
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 17:31:00 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:38159 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbZGFVbA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 17:31:00 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id C19E0108BAA07;
	Mon,  6 Jul 2009 23:31:02 +0200 (CEST)
Received: from [80.128.125.148] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #277)
	id 1MNvmA-0006w9-00; Mon, 06 Jul 2009 23:31:02 +0200
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19oWeEiH+rZ/bFf9zgIbxQj9kK/uWzwoyZpbJsW
	w0lQnsdq8XlBURMYkamceSUF+pidMBwp+krqEyQdr9cM8Uh6to
	OaZ25u85zFasNnsbl+Tw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122797>

As it is hard to say what changed in a submodule by looking at the hashes,
let's show the colored submodule summary instead.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

While starting to work productively with submodules a few weeks ago i
noticed that it is very inconvenient not to know what really changed
in a submodule when looking at it through git gui in the supermodule.
So i wrote this patch as a starting point for a discussion of how a
solution might look like.

Basically i would like to see what happened in the submodule between the
two hashes, so it seemed like git submodule summary will provide exactly
that information and should be preferred over git diff in that case.
(I also thought about teaching git diff to provide the information, but
came to the conclusion that it would be better to do that in git gui)

As i don't have that much experience with submodules yet i'm not sure to
have taken all corner cases into account ... so a few more eyeballs really
are appreciated!

 git-gui/lib/diff.tcl |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 925b3f5..67bc49f 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -255,7 +255,7 @@ proc show_other_diff {path w m cont_info} {

 proc start_show_diff {cont_info {add_opts {}}} {
 	global file_states file_lists
-	global is_3way_diff diff_active repo_config
+	global is_3way_diff is_submodule_diff diff_active repo_config
 	global ui_diff ui_index ui_workdir
 	global current_diff_path current_diff_side current_diff_header

@@ -265,6 +265,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	set s $file_states($path)
 	set m [lindex $s 0]
 	set is_3way_diff 0
+	set is_submodule_diff 0
 	set diff_active 1
 	set current_diff_header {}

@@ -295,6 +296,10 @@ proc start_show_diff {cont_info {add_opts {}}} {
 		lappend cmd $path
 	}

+	if {[string match {160000 *} [lindex $s 3]]} {
+		set cmd {submodule summary -- $current_diff_path}
+	}
+
 	if {[catch {set fd [eval git_read --nice $cmd]} err]} {
 		set diff_active 0
 		unlock_index
@@ -312,7 +317,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 }

 proc read_diff {fd cont_info} {
-	global ui_diff diff_active
+	global ui_diff diff_active is_submodule_diff
 	global is_3way_diff is_conflict_diff current_diff_header
 	global current_diff_queue
 	global diff_empty_count
@@ -337,6 +342,9 @@ proc read_diff {fd cont_info} {
 		}
 		set ::current_diff_inheader 0

+		if {[regexp {^\* } $line]} {
+			set is_submodule_diff 1
+		}
 		# -- Automatically detect if this is a 3 way diff.
 		#
 		if {[string match {@@@ *} $line]} {set is_3way_diff 1}
@@ -374,6 +382,21 @@ proc read_diff {fd cont_info} {
 				set tags {}
 			}
 			}
+		} elseif {$is_submodule_diff} {
+			if {$line == ""} continue
+			if {[regexp {^\* } $line]} {
+				set tags {}
+			} else {
+				set op [string range $line 0 2]
+				switch -- $op {
+				{  <} {set tags d_+}
+				{  >} {set tags d_-}
+				default {
+					puts "error: Unhandled submodule diff marker: {$op}"
+					set tags {}
+				}
+				}
+			}
 		} else {
 			set op [string index $line 0]
 			switch -- $op {
-- 
1.6.3.3.386.g1d0c9.dirty
