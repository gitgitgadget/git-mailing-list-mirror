From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 3/3] Add a menu item to invoke full copy detection in blame.
Date: Thu, 17 Jul 2008 00:51:20 +0400
Organization: TEPKOM
Message-ID: <200807170051.20337.angavrilov@gmail.com>
References: <200807170042.29462.angavrilov@gmail.com> <200807170043.49016.angavrilov@gmail.com> <200807170048.08909.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 22:52:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDzB-0006Zb-9k
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756962AbYGPUva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756079AbYGPUva
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:51:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:50059 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756900AbYGPUv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:51:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2507266fgg.17
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tMBNHaHbr8m6AXH3Fk4YE3eFiPArqY2kT4zTJwj7q+Y=;
        b=rHIqq1AgoxGtpobniAIYq2LtLFoTfRJ6v/+9dch02UayJ+8qOgO56gPARJalnaa65V
         Uq+owahdQvIk0d0qWE71//qEa909M0gQdCRn/jd5jfK5Lkhf8Nv6agSRQvoJYT5s6jzC
         GCLArCXpbQMJrHwPeriQ/bDM1CmB3Zg9JA3CI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tGMqZqBSCBBL91QWNhKSJU7emLvyh8eTYHLW+tLdBWJwdmqvyE/fJkVc1c02p/KZPF
         2CeE9LbPlEgWR3qCjdmOgE1qvpUQTRbVqvLpE4y/KYRrg7AUhxhohUehQIBWXBJoRrpv
         mh95gsy+y+PtGlZMwbnU7Eyr3h+6CqYPbYGLo=
Received: by 10.86.33.19 with SMTP id g19mr2672446fgg.67.1216241487670;
        Wed, 16 Jul 2008 13:51:27 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id l19sm2441276fgb.7.2008.07.16.13.51.27
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 13:51:27 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807170048.08909.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88757>

Add a context menu item to invoke blame -C -C -C on a chunk
of the file. The results are used to update the 'original
location' column of the blame display.

The chunk is computed as the smallest line range that covers
both the 'last change' and 'original location' ranges of the
line that was clicked to open the menu.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	This is my most complex Tcl/Tk code so far, so I might have
	done some stupid things.

	-- Alexander

 lib/blame.tcl |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index 2c19048..b6e42cb 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -256,6 +256,9 @@ constructor new {i_commit i_path} {
 	$w.ctxm add command \
 		-label [mc "Copy Commit"] \
 		-command [cb _copycommit]
+	$w.ctxm add command \
+		-label [mc "Do Full Copy Detection"] \
+		-command [cb _fullcopyblame]
 
 	foreach i $w_columns {
 		for {set g 0} {$g < [llength $group_colors]} {incr g} {
@@ -708,6 +711,72 @@ method _read_blame {fd cur_w cur_d} {
 	}
 } ifdeleted { catch {close $fd} }
 
+method _find_commit_bound {data_list start_idx delta} {
+	upvar #0 $data_list line_data
+	set pos $start_idx
+	set limit       [expr {[llength $line_data] - 1}]
+	set base_commit [lindex $line_data $pos 0]
+
+	while {$pos > 0 && $pos < $limit} {
+		set new_pos [expr {$pos + $delta}]
+		if {[lindex $line_data $new_pos 0] ne $base_commit} {
+			return $pos
+		}
+
+		set pos $new_pos
+	}
+
+	return $pos
+}
+
+method _fullcopyblame {} {
+	if {$current_fd ne {}} {
+		tk_messageBox \
+			-icon error \
+			-type ok \
+			-title [mc "Busy"] \
+			-message [mc "Annotation process is already running."]
+
+		return
+	}
+
+	# Switches for original location detection
+	set threshold [get_config gui.copyblamethreshold]
+	set original_options [list -C -C "-C$threshold"]
+
+	if {[git-version >= 1.5.3]} {
+		lappend original_options -w ; # ignore indentation changes
+	}
+
+	# Find the line range
+	set pos @$::cursorX,$::cursorY
+	set lno [lindex [split [$::cursorW index $pos] .] 0]
+	set min_amov_lno [_find_commit_bound $this @amov_data $lno -1]
+	set max_amov_lno [_find_commit_bound $this @amov_data $lno 1]
+	set min_asim_lno [_find_commit_bound $this @asim_data $lno -1]
+	set max_asim_lno [_find_commit_bound $this @asim_data $lno 1]
+
+	if {$min_asim_lno < $min_amov_lno} {
+		set min_amov_lno $min_asim_lno
+	}
+
+	if {$max_asim_lno > $max_amov_lno} {
+		set max_amov_lno $max_asim_lno
+	}
+
+	lappend original_options -L "$min_amov_lno,$max_amov_lno"
+
+	# Clear lines
+	for {set i $min_amov_lno} {$i <= $max_amov_lno} {incr i} {
+		lset amov_data $i [list ]
+	}
+
+	# Start the back-end process
+	_exec_blame $this $w_amov @amov_data \
+		$original_options \
+		[mc "Running thorough copy detection..."]
+}
+
 method _click {cur_w pos} {
 	set lno [lindex [split [$cur_w index $pos] .] 0]
 	_showcommit $this $cur_w $lno
-- 
1.5.6.3.17.g3f148
