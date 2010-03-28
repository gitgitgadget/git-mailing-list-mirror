From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] Introduce is_unmerged global variable to encapsulate its 
	derivation.
Date: Sun, 28 Mar 2010 13:07:49 +1100
Message-ID: <2cfc40321003271907t6d191234p23998953a2075790@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spearce@spearce.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 28 04:08:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvhv5-000491-Qy
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 04:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209Ab0C1CHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 22:07:51 -0400
Received: from mail-pz0-f173.google.com ([209.85.222.173]:62555 "EHLO
	mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab0C1CHu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 22:07:50 -0400
Received: by pzk3 with SMTP id 3so10831pzk.33
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 19:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:cc:content-type;
        bh=ZzwPFUwJtauqRspNbi7ZQ2esQYBLVq44Sz5Zrlgf/rg=;
        b=lCI7lFC/4D5KpEYZ7Kbcw1Dsh0S82uPIHPmMc9TFRL1i4d5Pf65vl2FDWzWoTwPh9E
         gnRm9NPuAF4Cdjt09m7AxUsbhQAeXhHKaN30GnJRaDBdcZjHs9D9zkLJPIoFG2dpNb+h
         OSEGVPWBX05Ex4uHGiRTcGUd8+IetYMwhMeK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=OtVHdf7zW/DwBsHhmxBbJwJrd11A9kARHS9UY8avMNNS4tAQTUX1p06HGri5PAU7Ay
         14/XoCICwwX6Ocg/csVLL6EMYSGgA0eylxjHh1QXyCqKWsxM/9C0wmzGBRG5XrM50TFM
         S9FKufiPLypdDL0I99Jw/4V1pwKBlTUjxTGII=
Received: by 10.115.89.7 with HTTP; Sat, 27 Mar 2010 19:07:49 -0700 (PDT)
Received: by 10.114.242.20 with SMTP id p20mr2862720wah.135.1269742069848; 
	Sat, 27 Mar 2010 19:07:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143371>

Defined is_unmerged to be [expr {[string first {U} $m] >= 0}]
and then replaced uses of {[string first {U} $m] >= 0} with {$is_unmerged}.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-gui/lib/diff.tcl |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index ec8c11e..e7b1986 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -80,6 +80,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}}
{callback {}}} {
 	global ui_diff ui_index ui_workdir
 	global current_diff_path current_diff_side current_diff_header
 	global current_diff_queue
+	global is_unmerged

 	if {$diff_active || ![lock_index read]} return

@@ -98,6 +99,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}}
{callback {}}} {
 	set s $file_states($path)
 	set m [lindex $s 0]
 	set is_conflict_diff 0
+	set is_unmerged [expr {[string first {U} $m] >= 0}]
 	set current_diff_path $path
 	set current_diff_side $w
 	set current_diff_queue {}
@@ -105,7 +107,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}}
{callback {}}} {

 	set cont_info [list $scroll_pos $callback]

-	if {[string first {U} $m] >= 0} {
+	if {$is_unmerged} {
 		merge_load_stages $path [list show_unmerged_diff $cont_info]
 	} elseif {$m eq {_O}} {
 		show_other_diff $path $w $m $cont_info
@@ -258,6 +260,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	global is_3way_diff is_submodule_diff diff_active repo_config
 	global ui_diff ui_index ui_workdir
 	global current_diff_path current_diff_side current_diff_header
+	global is_unmerged

 	set path $current_diff_path
 	set w $current_diff_side
@@ -274,7 +277,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 		lappend cmd diff-index
 		lappend cmd --cached
 	} elseif {$w eq $ui_workdir} {
-		if {[string first {U} $m] >= 0} {
+	        if {$is_unmerged} {
 			lappend cmd diff
 		} else {
 			lappend cmd diff-files
-- 
1.6.6.1
