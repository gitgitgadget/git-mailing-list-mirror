From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 1/3] Add options to control the search for copies in blame.
Date: Thu, 17 Jul 2008 00:43:48 +0400
Organization: TEPKOM
Message-ID: <200807170043.49016.angavrilov@gmail.com>
References: <200807170042.29462.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 22:44:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDru-0003yc-R1
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191AbYGPUn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756115AbYGPUn6
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:43:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:37876 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756065AbYGPUn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:43:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2506290fgg.17
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ef4wFbKam/Iax0j6x++U2GCo7386W+qk1RZ/MfsvoZY=;
        b=l0YXMT+1DOOWmsliGtz9NPMhxU9vYoMM0NUMPOR0j+8+bfTwd0Q21Mx5rMGUXcnExZ
         3/ZkU5TNygWYF/KmGancw9RwjDWeyu9QZ4EI6S4m230crFXgERe2rwgtvMI6E6UIatL7
         MbPYKtGMXA/lMuCNb1a28hwd8g8zQH9RfMwVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Lw1gHRD/ozw7vANXT7r8oiwONhycupzgiQ26M5m5Snd5P2YiiyOo9TRLZrUyOFkC2d
         Te968LuwB92885R/vK88Bi8o3Xmg9MrvMl+LcU49afMnq6cWCSPWzBRQuVgwd+49cpq5
         lF80I1yJ9trJVvaR4l2Zl5XT1oLXUWzOCzAHA=
Received: by 10.86.96.18 with SMTP id t18mr2708616fgb.17.1216241036323;
        Wed, 16 Jul 2008 13:43:56 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id 12sm3336281fgg.0.2008.07.16.13.43.55
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 13:43:56 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807170042.29462.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88748>

On huge repositories, -C -C can be way too slow to be
unconditionally enabled, and it can also be useful to control
its precision.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh     |    2 ++
 lib/blame.tcl  |   20 ++++++++++++--------
 lib/option.tcl |    2 ++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index e3b6669..b1ed0ec 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -642,6 +642,8 @@ set default_config(user.email) {}
 set default_config(gui.matchtrackingbranch) false
 set default_config(gui.pruneduringfetch) false
 set default_config(gui.trustmtime) false
+set default_config(gui.fastcopyblame) false
+set default_config(gui.copyblamethreshold) 40
 set default_config(gui.diffcontext) 5
 set default_config(gui.commitmsgwidth) 75
 set default_config(gui.newbranchtemplate) {}
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 92fac1b..192505d 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -33,13 +33,6 @@ variable group_colors {
 	#ececec
 }
 
-# Switches for original location detection
-#
-variable original_options [list -C -C]
-if {[git-version >= 1.5.3]} {
-	lappend original_options -w ; # ignore indentation changes
-}
-
 # Current blame data; cleared/reset on each load
 #
 field commit               ; # input commit to blame
@@ -511,7 +504,6 @@ method _exec_blame {cur_w cur_d options cur_s} {
 method _read_blame {fd cur_w cur_d} {
 	upvar #0 $cur_d line_data
 	variable group_colors
-	variable original_options
 
 	if {$fd ne $current_fd} {
 		catch {close $fd}
@@ -684,6 +676,18 @@ method _read_blame {fd cur_w cur_d} {
 	if {[eof $fd]} {
 		close $fd
 		if {$cur_w eq $w_asim} {
+			# Switches for original location detection
+			set threshold [get_config gui.copyblamethreshold]
+			set original_options [list "-C$threshold"]
+
+			if {![is_config_true gui.fastcopyblame]} {
+				# thorough copy search; insert before the threshold
+				set original_options [linsert $original_options 0 -C]
+			}
+			if {[git-version >= 1.5.3]} {
+				lappend original_options -w ; # ignore indentation changes
+			}
+
 			_exec_blame $this $w_amov @amov_data \
 				$original_options \
 				[mc "Loading original location annotations..."]
diff --git a/lib/option.tcl b/lib/option.tcl
index 9270512..ffb3f00 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -123,6 +123,8 @@ proc do_options {} {
 		{b gui.trustmtime  {mc "Trust File Modification Timestamps"}}
 		{b gui.pruneduringfetch {mc "Prune Tracking Branches During Fetch"}}
 		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
+		{b gui.fastcopyblame {mc "Blame Copy Only On Changed Files"}}
+		{i-20..200 gui.copyblamethreshold {mc "Minimum Letters To Blame Copy On"}}
 		{i-0..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
 		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
-- 
1.5.6.3.17.g3f148
