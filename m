From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 7/8] git-gui: Make F5 reselect a diff, if an untracked file is selected.
Date: Sun, 31 Aug 2008 01:04:10 +0400
Organization: TEPKOM
Message-ID: <200808310104.11048.angavrilov@gmail.com>
References: <200808310052.21595.angavrilov@gmail.com> <200808310100.49998.angavrilov@gmail.com> <200808310102.56795.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 23:16:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXo9-00089f-No
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508AbYH3VOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 17:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755031AbYH3VOq
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:14:46 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:59109 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbYH3VOc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 17:14:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so883449fkq.5
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 14:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pm+foTaMmucQXI1e6OoCHcvN+86EmbJZnsnHe9Q/xuQ=;
        b=VvP7ifJpkDI/QE5dUfyYgdy6ghVIDMm9IxoOX1jDki4nDC7tW898NJK29HegFuvfg7
         PRcSmwNJTzFu0OKZoYUfdKM/g1K5uwsYleWbKEyJxxayOSm/elA9wdEwZbpLTc68UM+j
         6AipENXxAlW16lIVoknN7jHk6HogEoqNrGJhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TfDeIGE2uy8E/47zR/Laj7NCG/ShzRvgfBPD5NqSJExuPU6HbvNK/0zdcHQRcn2mWO
         sfGULQdPdU0kDB+Iip7O7A/UpDaYsT/m/YGsLNFMy+nWHs+5xfRk2/uSeNmENXPZv2S8
         PuKlSAAFQ/ERU4CG9uD+UWYEhutMsOvukDrKo=
Received: by 10.180.247.17 with SMTP id u17mr4097244bkh.66.1220130871233;
        Sat, 30 Aug 2008 14:14:31 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id d13sm4092560fka.3.2008.08.30.14.14.30
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 14:14:30 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808310102.56795.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94434>

If an untracked file is selected, F5 and other manual rescan synonyms
would try to select a tracked file instead. Also, clicking on an icon
in the unstaged changes list skips over untracked files, unless the
file clicked is untracked itself.

The objective is to make it easier to ignore untracked files showing
up in the Unstaged Changes list, and ensure that no modifications
to tracked objects are left unstaged.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh |   44 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index f84f436..fde44a6 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1817,6 +1817,10 @@ proc do_rescan {} {
 	rescan ui_ready
 }
 
+proc ui_do_rescan {} {
+	rescan {force_first_diff; ui_ready}
+}
+
 proc do_commit {} {
 	commit_tree
 }
@@ -1917,6 +1921,18 @@ proc select_first_diff {} {
 	}
 }
 
+proc force_first_diff {} {
+	global current_diff_path
+
+	if {[info exists file_states($current_diff_path)]} {
+		set state [lindex $file_states($current_diff_path) 0]
+
+		if {[string index $state 1] ne {O}} return
+	}
+
+	select_first_diff
+}
+
 proc toggle_or_diff {w x y} {
 	global file_states file_lists current_diff_path ui_index ui_workdir
 	global last_clicked selected_paths
@@ -1938,13 +1954,23 @@ proc toggle_or_diff {w x y} {
 	# Do not stage files with conflicts
 	if {[info exists file_states($path)]} {
 		set state [lindex $file_states($path) 0]
-		if {[string first {U} $state] >= 0} {
-			set col 1
-		}
+	} else {
+		set state {__}
+	}
+
+	if {[string first {U} $state] >= 0} {
+		set col 1
 	}
 
+	# Restage the file, or simply show the diff
 	if {$col == 0 && $y > 1} {
-		set after [next_diff_after_action $w $path $lno]
+		if {[string index $state 1] eq {O}} {
+			set mmask {}
+		} else {
+			set mmask {[^O]}
+		}
+
+		set after [next_diff_after_action $w $path $lno $mmask]
 
 		if {$w eq $ui_index} {
 			update_indexinfo \
@@ -2208,7 +2234,7 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 	.mbar.commit add separator
 
 	.mbar.commit add command -label [mc Rescan] \
-		-command do_rescan \
+		-command ui_do_rescan \
 		-accelerator F5
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
@@ -2564,7 +2590,7 @@ pack .vpane.lower.commarea.buttons.l -side top -fill x
 pack .vpane.lower.commarea.buttons -side left -fill y
 
 button .vpane.lower.commarea.buttons.rescan -text [mc Rescan] \
-	-command do_rescan
+	-command ui_do_rescan
 pack .vpane.lower.commarea.buttons.rescan -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.rescan conf -state}
@@ -2985,9 +3011,9 @@ if {[is_enabled transport]} {
 	bind . <$M1B-Key-P> do_push_anywhere
 }
 
-bind .   <Key-F5>     do_rescan
-bind .   <$M1B-Key-r> do_rescan
-bind .   <$M1B-Key-R> do_rescan
+bind .   <Key-F5>     ui_do_rescan
+bind .   <$M1B-Key-r> ui_do_rescan
+bind .   <$M1B-Key-R> ui_do_rescan
 bind .   <$M1B-Key-s> do_signoff
 bind .   <$M1B-Key-S> do_signoff
 bind .   <$M1B-Key-t> do_add_selection
-- 
1.6.0.20.g6148bc
