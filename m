From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK,GIT-GUI,DOCS) 5/7] git-gui: Better positioning in Blame Parent Commit
Date: Sat, 23 Aug 2008 12:31:35 +0400
Organization: TEPKOM
Message-ID: <200808231231.35635.angavrilov@gmail.com>
References: <200808231225.12596.angavrilov@gmail.com> <200808231230.00397.angavrilov@gmail.com> <200808231230.51693.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 10:32:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoYJ-0004B0-Qa
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbYHWIbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbYHWIbv
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:31:51 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:5175 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbYHWIbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:31:49 -0400
Received: by fk-out-0910.google.com with SMTP id 18so488567fkq.5
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vn1lxuDMgisGItWiJAgmQjRorP5+ogbiHV2vp6MlS6I=;
        b=LwutPcJx9HzvCT0BQM4UA4sovcImAdjqStN1ZoA2E5mgcAEioaEd9ae/qBLk0psB1X
         zBbFmQjXuYUGsn1DNtKi5dpIVZmBGyJOUj2/my42ku3q/qAL0FHwKJq0FsCqrlLYRjJ3
         96fC+2tbGFqZgOQmxWS50QZqfnlx40zlGPofw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oeRoewtBtB2l5xkabAas3HSV3MDIXdLuHvqrbWRoUBTAgDhS8mcFEpysKEHBVdy4D4
         7F9y0ijA+KuelggnhB4ZPuwgR9UgIhM4VKWnpwJJtQdtak/z5zqClQMz6W27Yn43fMJn
         6InXlqxj61+SVDQWV0QbOE3raOHUlybtzyQQw=
Received: by 10.180.215.19 with SMTP id n19mr1134866bkg.35.1219480308168;
        Sat, 23 Aug 2008 01:31:48 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id 31sm2014258fkt.19.2008.08.23.01.31.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 01:31:47 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808231230.51693.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93438>

Invoke diff-tree between the commit and its parent,
and use the hunks to fix the target line number,
accounting for addition and removal of lines.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/blame.tcl |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index 8b555a1..1be8145 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -984,19 +984,76 @@ method _blameparent {} {
 	set dat [_get_click_amov_info $this]
 	if {$dat ne {}} {
 		set cmit [lindex $dat 0]
+		set new_path [lindex $dat 1]
 
 		if {[catch {set cparent [git rev-parse --verify "$cmit^"]}]} {
 			error_popup [strcat [mc "Cannot find parent commit:"] "\n\n$err"]
 			return;
 		}
 
-		_load_new_commit $this  \
-			$cparent \
-			[lindex $dat 1] \
-			[list [lindex $dat 2]]
+		_kill $this
+
+		# Generate a diff between the commit and its parent,
+		# and use the hunks to update the line number.
+		# Request zero context to simplify calculations.
+		if {[catch {set fd [eval git_read diff-tree \
+				--unified=0 $cparent $cmit $new_path]} err]} {
+			$status stop [mc "Unable to display parent"]
+			error_popup [strcat [mc "Error loading diff:"] "\n\n$err"]
+			return
+		}
+
+		set r_orig_line [lindex $dat 2]
+
+		fconfigure $fd \
+			-blocking 0 \
+			-encoding binary \
+			-translation binary
+		fileevent $fd readable [cb _read_diff_load_commit \
+			$fd $cparent $new_path $r_orig_line]
+		set current_fd $fd
 	}
 }
 
+method _read_diff_load_commit {fd cparent new_path tline} {
+	if {$fd ne $current_fd} {
+		catch {close $fd}
+		return
+	}
+
+	while {[gets $fd line] >= 0} {
+		if {[regexp {^@@ -(\d+)(,(\d+))? \+(\d+)(,(\d+))? @@} $line line \
+			old_line osz old_size new_line nsz new_size]} {
+
+			if {$osz eq {}} { set old_size 1 }
+			if {$nsz eq {}} { set new_size 1 }
+
+			if {$new_line <= $tline} {
+				if {[expr {$new_line + $new_size}] > $tline} {
+					# Target line within the hunk
+					set line_shift [expr {
+						($new_size-$old_size)*($tline-$new_line)/$new_size
+						}]
+				} else {
+					set line_shift [expr {$new_size-$old_size}]
+				}
+
+				set r_orig_line [expr {$r_orig_line - $line_shift}]
+			}
+		}
+	}
+
+	if {[eof $fd]} {
+		close $fd;
+		set current_fd {}
+
+		_load_new_commit $this  \
+			$cparent        \
+			$new_path       \
+			[list $r_orig_line]
+	}
+} ifdeleted { catch {close $fd} }
+
 method _show_tooltip {cur_w pos} {
 	if {$tooltip_wm ne {}} {
 		_open_tooltip $this $cur_w
-- 
1.6.0.rc2
