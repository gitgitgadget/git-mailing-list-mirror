From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK,GIT-GUI,DOCS) 4/7] git-gui: Support passing blame to a parent commit.
Date: Sat, 23 Aug 2008 12:30:51 +0400
Organization: TEPKOM
Message-ID: <200808231230.51693.angavrilov@gmail.com>
References: <200808231225.12596.angavrilov@gmail.com> <200808231230.00397.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 10:32:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoXd-00040g-G2
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbYHWIbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbYHWIbJ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:31:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:62964 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbYHWIbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:31:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so464618fgg.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 01:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FHbN916gxSgYoebvUvnUrO0WFotMkD04rEYhbVf2WpM=;
        b=euANvCq0VHzhppUH+Vcx6lRC8YBLKyzkUD0qSfrSdLsDMrWoCd6IScQFcFJadiEmsC
         5/vA4kk5wAlq9eN1usIlYLZdOEwnsnBKrx2OzmLmECopLC38RbOUtGw4KA7mtadXsTOr
         axthBH/QG1YRbnNP6cDezXQLZdu9uJQObdgak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ENw6QNK7BayP1pew8e4r4q+MomvXXlZCt7/fvulksIRaQhDpt0p3yzcAuNXMcRucJg
         ZmZpdRuSCGwpIK8TduCvgae/DPjTAJMEYUUucO36AaFOh1bOx59q80V2f2rfvXHcxN4y
         Iy3d0S47v/l/xrryvtSvak/529tnwg6gdXBDA=
Received: by 10.180.215.19 with SMTP id n19mr1134669bkg.35.1219480264160;
        Sat, 23 Aug 2008 01:31:04 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id d13sm2029450fka.3.2008.08.23.01.31.03
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 01:31:03 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808231230.00397.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93437>

Add a context menu item that switches the view to the
parent of the commit under cursor. It is useful to see
how the file looked before the change, and find older
changes in the same lines.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/blame.tcl |   48 ++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index d6c56e8..8b555a1 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -262,6 +262,9 @@ constructor new {i_commit i_path} {
 	$w.ctxm add command \
 		-label [mc "Show History Context"] \
 		-command [cb _gitkcommit]
+	$w.ctxm add command \
+		-label [mc "Blame Parent Commit"] \
+		-command [cb _blameparent]
 
 	foreach i $w_columns {
 		for {set g 0} {$g < [llength $group_colors]} {incr g} {
@@ -790,19 +793,27 @@ method _load_commit {cur_w cur_d pos} {
 	set lno [lindex [split [$cur_w index $pos] .] 0]
 	set dat [lindex $line_data $lno]
 	if {$dat ne {}} {
-		lappend history [list \
-			$commit $path \
-			$highlight_column \
-			$highlight_line \
-			[lindex [$w_file xview] 0] \
-			[lindex [$w_file yview] 0] \
-			]
-		set commit [lindex $dat 0]
-		set path   [lindex $dat 1]
-		_load $this [list [lindex $dat 2]]
+		_load_new_commit $this  \
+			[lindex $dat 0] \
+			[lindex $dat 1] \
+			[list [lindex $dat 2]]
 	}
 }
 
+method _load_new_commit {new_commit new_path jump} {
+	lappend history [list \
+		$commit $path \
+		$highlight_column \
+		$highlight_line \
+		[lindex [$w_file xview] 0] \
+		[lindex [$w_file yview] 0] \
+		]
+
+	set commit $new_commit
+	set path   $new_path
+	_load $this $jump
+}
+
 method _showcommit {cur_w lno} {
 	global repo_config
 	variable active_color
@@ -969,6 +980,23 @@ method _gitkcommit {} {
 	}
 }
 
+method _blameparent {} {
+	set dat [_get_click_amov_info $this]
+	if {$dat ne {}} {
+		set cmit [lindex $dat 0]
+
+		if {[catch {set cparent [git rev-parse --verify "$cmit^"]}]} {
+			error_popup [strcat [mc "Cannot find parent commit:"] "\n\n$err"]
+			return;
+		}
+
+		_load_new_commit $this  \
+			$cparent \
+			[lindex $dat 1] \
+			[list [lindex $dat 2]]
+	}
+}
+
 method _show_tooltip {cur_w pos} {
 	if {$tooltip_wm ne {}} {
 		_open_tooltip $this $cur_w
-- 
1.6.0.rc2
