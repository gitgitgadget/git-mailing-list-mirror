From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK,GIT-GUI,DOCS) 6/7] git-gui: Allow specifying an initial line for git gui blame.
Date: Sat, 23 Aug 2008 12:32:20 +0400
Organization: TEPKOM
Message-ID: <200808231232.20592.angavrilov@gmail.com>
References: <200808231225.12596.angavrilov@gmail.com> <200808231230.51693.angavrilov@gmail.com> <200808231231.35635.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 10:33:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoZ2-0004Ov-SM
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbYHWIch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbYHWIcg
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:32:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:8683 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbYHWIce (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:32:34 -0400
Received: by fk-out-0910.google.com with SMTP id 18so488704fkq.5
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YI0l5Jb8A01iG7dnzzS7WGgBuf20TDti1Vgz+FOp07g=;
        b=uHTfGW+CfiGoWVH/ghdOHNN90jPd7q6q60mfHoqTP4O5JJ5sfHkZr0wjTCF0trQ0AH
         pvQHUxTn3nZhTg2bh6hamTPjIOp3vM2kbQ3YPQrJ+yvJamgt90yzDPb8DH8/ZG0/c8Ib
         neI4QLLbAoqebI63Qa8DVbnze/BTPzfx6N+GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=I33GuuB+s7nTjSkC6s4IkJs7Axs702cIiiJIhwWGsSwklO2qPOlrbvnTBshjW5rED8
         /pA7aUiwgLHIimnCDEc+fpvIc0jRD00mqM0nkfJa5X5u4oFR3MklkIN9itpcQp5maqP1
         dDYa5E9hiHN2W0ARCf8oaKgBW/Zzj8KXR57nw=
Received: by 10.180.254.18 with SMTP id b18mr1131370bki.43.1219480352987;
        Sat, 23 Aug 2008 01:32:32 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id f31sm2044205fkf.0.2008.08.23.01.32.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 01:32:32 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808231231.35635.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93439>

Add a command-line option to make git gui blame automatically
scroll to a specific line in the file. Useful for integration
with other tools.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh      |   13 +++++++++++--
 lib/blame.tcl   |    4 ++--
 lib/browser.tcl |    2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index b8bbcd5..e5ea9a8 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2282,10 +2282,15 @@ proc usage {} {
 switch -- $subcommand {
 browser -
 blame {
-	set subcommand_args {rev? path}
+	if {$subcommand eq "blame"} {
+		set subcommand_args {[--line=<num>] rev? path}
+	} else {
+		set subcommand_args {rev? path}
+	}
 	if {$argv eq {}} usage
 	set head {}
 	set path {}
+	set jump_spec {}
 	set is_path 0
 	foreach a $argv {
 		if {$is_path || [file exists $_prefix$a]} {
@@ -2299,6 +2304,9 @@ blame {
 				set path {}
 			}
 			set is_path 1
+		} elseif {[regexp {^--line=(\d+)$} $a a lnum]} {
+			if {$jump_spec ne {} || $head ne {}} usage
+			set jump_spec [list $lnum]
 		} elseif {$head eq {}} {
 			if {$head ne {}} usage
 			set head $a
@@ -2330,6 +2338,7 @@ blame {
 
 	switch -- $subcommand {
 	browser {
+		if {$jump_spec ne {}} usage
 		if {$head eq {}} {
 			if {$path ne {} && [file isdirectory $path]} {
 				set head $current_branch
@@ -2345,7 +2354,7 @@ blame {
 			puts stderr [mc "fatal: cannot stat path %s: No such file or directory" $path]
 			exit 1
 		}
-		blame::new $head $path
+		blame::new $head $path $jump_spec
 	}
 	}
 	return
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 1be8145..a75685d 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -58,7 +58,7 @@ field tooltip_t         {} ; # Text widget in $tooltip_wm
 field tooltip_timer     {} ; # Current timer event for our tooltip
 field tooltip_commit    {} ; # Commit(s) in tooltip
 
-constructor new {i_commit i_path} {
+constructor new {i_commit i_path i_jump} {
 	global cursor_ptr
 	variable active_color
 	variable group_colors
@@ -338,7 +338,7 @@ constructor new {i_commit i_path} {
 	wm protocol $top WM_DELETE_WINDOW "destroy $top"
 	bind $top <Destroy> [cb _kill]
 
-	_load $this {}
+	_load $this $i_jump
 }
 
 method _kill {} {
diff --git a/lib/browser.tcl b/lib/browser.tcl
index ab470d1..0410cc6 100644
--- a/lib/browser.tcl
+++ b/lib/browser.tcl
@@ -151,7 +151,7 @@ method _enter {} {
 				append p [lindex $n 1]
 			}
 			append p $name
-			blame::new $browser_commit $p
+			blame::new $browser_commit $p {}
 		}
 		}
 	}
-- 
1.6.0.rc2
