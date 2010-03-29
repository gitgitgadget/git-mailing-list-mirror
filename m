From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 1/2] git-gui: Introduce is_unmerged global variable to 
	encapsulate its derivation.
Date: Tue, 30 Mar 2010 10:01:05 +1100
Message-ID: <2cfc40321003291601x2b79f816u1cf1f46ccf1a6cb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spearce@spearce.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 01:01:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwNxK-00062P-2S
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 01:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab0C2XBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 19:01:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34894 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab0C2XBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 19:01:05 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so7149816pwi.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:cc:content-type;
        bh=UOkPjLMe/TNvIVhsB1axjzz6CCSmIgEXJfSUPPAH2rI=;
        b=Pol3Z4sWvLnSYwtTjMav4WDlnfZyTa0BKlp0AK+7xtmyBGDAlPvLdQb9a8sVB0Nhw2
         vDVCGDfz+bhEegKTviKdcq5P1BdNlnkVmMFEBJlNc2gEebBCvTWC/lOrurCbQ2KxT0i2
         B0FZmP8J32yHthq7p6+t6diRgAxEJANO3T/hU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=OznvV/VORhJGKcsA/sdO5CYuTA/F7o8snNMUuL4qX88EKDE/YJJTCniPnJkN95qnGB
         VSp7GzRhtt4stxZCduAAh37jibVQ6NKVu4WU3haNbsMYeZumojWCurvezhmClOyA2Zep
         JsyD+4kkn0d/2i0NWzuaeSdlFpK4L3Tk3PWXQ=
Received: by 10.114.13.5 with HTTP; Mon, 29 Mar 2010 16:01:05 -0700 (PDT)
Received: by 10.114.11.1 with SMTP id 1mr5658172wak.52.1269903665658; Mon, 29 
	Mar 2010 16:01:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143527>

Defined is_unmerged to be [expr {[string first {U} $m] >= 0}]
and then replaced uses of {[string first {U} $m] >= 0} with {$is_unmerged}.

This change is made because the subsequent patch will introduce a 3rd
use of this expression.

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
