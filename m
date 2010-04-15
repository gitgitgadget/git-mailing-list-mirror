From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] git-gui: use textconv filter
Date: Thu, 15 Apr 2010 21:39:44 +0200
Message-ID: <20100415193944.GA5848@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:40:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2UvE-0003mE-B6
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab0DOTkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:40:14 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:44864 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab0DOTkL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 15:40:11 -0400
Received: by ewy20 with SMTP id 20so680799ewy.1
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=sqThiMhUjTt3kjC8r0pKw2ivnKL9MiTzijFbV/TimoI=;
        b=VpLEqCSqy8AkiLvLDGCjl+jJ54FGREh26Q+GETW3CQ1L0OtRjNOLtGH2ePvgSbfmw1
         P26pHKqGSCHVl91Cf8Sj8d3PBcfernU+vDDI1ivtiOgHYjZl6ef9spDmkWG5fi6nbBOM
         Ijded0gLdSi2xeb1czuzjsznT4+x26kVGtPYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        b=pC+Nmy3e1VLE+DRdWD2IKfcxgE6KplASR7NuLqJvce94Mw1zhvCE8Ocp0+DZmLV1aU
         QzAvpl0DBGgcTBBNobprQ+lkV6EJbhqlGhv7JZzsPdSXlXqjKrsE7TtjMXdllARIbPt7
         3Yz9s98MnhLKfdscPlrveDnenh0ao8dHqiAOA=
Received: by 10.213.1.215 with SMTP id 23mr4950951ebg.88.1271360409018;
        Thu, 15 Apr 2010 12:40:09 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 14sm1239276ewy.2.2010.04.15.12.40.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 12:40:07 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1O2Uue-0001Yz-NZ; Thu, 15 Apr 2010 21:39:44 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145015>

Use of the textconv filter in git-gui can be disabled by setting
gui.textconv to false.

Staging hunks is disabled for converted diffs.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

This patch applies to git://repo.or.cz/git-gui.

 git-gui.sh     |   28 +++++++++++++++++++++++++++-
 lib/diff.tcl   |    5 ++++-
 lib/option.tcl |    1 +
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8996d2d..204bfea 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -269,6 +269,17 @@ proc is_config_true {name} {
 	}
 }
 
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
@@ -785,6 +796,7 @@ set default_config(user.email) {}
 
 set default_config(gui.encoding) [encoding system]
 set default_config(gui.matchtrackingbranch) false
+set default_config(gui.textconv) true
 set default_config(gui.pruneduringfetch) false
 set default_config(gui.trustmtime) false
 set default_config(gui.fastcopyblame) false
@@ -3408,6 +3420,19 @@ lappend diff_actions [list $ctxmsm entryconf [$ctxmsm index last] -state]
 $ctxmsm add separator
 create_common_diff_popup $ctxmsm
 
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
@@ -3443,7 +3468,8 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 			|| {__} eq $state
 			|| {_O} eq $state
 			|| {_T} eq $state
-			|| {T_} eq $state} {
+			|| {T_} eq $state
+			|| [has_textconv $current_diff_path]} {
 			set s disabled
 		} else {
 			set s normal
diff --git a/lib/diff.tcl b/lib/diff.tcl
index ec8c11e..c628750 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -55,7 +55,7 @@ proc handle_empty_diff {} {
 
 	set path $current_diff_path
 	set s $file_states($path)
-	if {[lindex $s 0] ne {_M}} return
+	if {[lindex $s 0] ne {_M} || [has_textconv $path]} return
 
 	# Prevent infinite rescan loops
 	incr diff_empty_count
@@ -280,6 +280,9 @@ proc start_show_diff {cont_info {add_opts {}}} {
 			lappend cmd diff-files
 		}
 	}
+	if {![is_config_false gui.textconv] && [git-version >= 1.6.1]} {
+		lappend cmd --textconv
+	}
 
 	if {[string match {160000 *} [lindex $s 2]]
 	 || [string match {160000 *} [lindex $s 3]]} {
diff --git a/lib/option.tcl b/lib/option.tcl
index d4c5e45..fe9d484 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -148,6 +148,7 @@ proc do_options {} {
 		{b gui.trustmtime  {mc "Trust File Modification Timestamps"}}
 		{b gui.pruneduringfetch {mc "Prune Tracking Branches During Fetch"}}
 		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
+		{b gui.textconv {mc "Use Textconv For Diffs"}}
 		{b gui.fastcopyblame {mc "Blame Copy Only On Changed Files"}}
 		{i-20..200 gui.copyblamethreshold {mc "Minimum Letters To Blame Copy On"}}
 		{i-0..300 gui.blamehistoryctx {mc "Blame History Context Radius (days)"}}
-- 
1.7.1.rc0.27.g3b0c
