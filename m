From: Astril Hayato <astrilhayato@gmail.com>
Subject: [PATCH] gitk: Comply with XDG base directory specification
Date: Fri, 13 Dec 2013 19:46:36 +0000
Message-ID: <1386963996-5481-1-git-send-email-astrilhayato@gmail.com>
Cc: paulus@samba.org, Astril Hayato <astrilhayato@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 13 20:47:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrYha-0008Kj-4n
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 20:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab3LMTrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 14:47:04 -0500
Received: from mail-wi0-f196.google.com ([209.85.212.196]:51349 "EHLO
	mail-wi0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab3LMTrD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 14:47:03 -0500
Received: by mail-wi0-f196.google.com with SMTP id hi5so428083wib.7
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 11:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=76zBwpECd67Vadu3v03fiyZESGWlykRyELirA/nsCtc=;
        b=AFWedambdht3Whkm8uCD6904ivdCO+Znr+gw/PsAaRr5x8u2FYUV6r0vd3F6URFEX9
         F3t+OFbQkqPhxaoTOMKdHrL3Na+r+Q+vnGelTaIqbLV8su3XWqxEd8/RYkrbQM20LOkf
         5jYRrKYr95ZlBqfIkkKDKzgP8+iQeydtpgwmgc/62My3e5AiHgV2zvnOMpciTXhJeRSy
         i2suqgZ0anR2L9g7yBH6i00A4Y+50ddK3GcrLpEq24Qmgd2J3XO1KNA1WO+Cd8MxD2gF
         ddpKnFITJUOcVvLrhoWs/7BwJWTyIQuDVCT/PwGCJ+jtVZiSUwjAN9Xr5LNE1IdDNCpt
         2fSQ==
X-Received: by 10.194.119.132 with SMTP id ku4mr3700056wjb.51.1386964021765;
        Fri, 13 Dec 2013 11:47:01 -0800 (PST)
Received: from localhost.localdomain (cpc4-blbn8-2-0-cust14.10-1.cable.virginm.net. [86.22.6.15])
        by mx.google.com with ESMTPSA id mz10sm632277wic.2.2013.12.13.11.47.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2013 11:47:00 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239263>

Write the gitk config data to $XDG_CONFIG_HOME/git/gitk ($HOME/.config/git/gitk
by default) in line with the XDG specification. This makes it consistent with
git which also follows the spec.

If $HOME/.gitk already exists use that for backward compatibility, so only new
installations are affected.

Signed-off-by: Astril Hayato <astrilhayato@gmail.com>
---
 gitk | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 33c3a6c..34dd4a6 100755
--- a/gitk
+++ b/gitk
@@ -2761,14 +2761,17 @@ proc savestuff {w} {
     global linkfgcolor circleoutlinecolor
     global autoselect autosellen extdifftool perfile_attrs markbgcolor use_ttk
     global hideremotes want_ttk maxrefs
+    global config_file config_file_tmp
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
     catch {
-	if {[file exists ~/.gitk-new]} {file delete -force ~/.gitk-new}
-	set f [open "~/.gitk-new" w]
+	if {[file exists $config_file_tmp]} {
+	    file delete -force $config_file_tmp
+	}
+	set f [open $config_file_tmp w]
 	if {$::tcl_platform(platform) eq {windows}} {
-	    file attributes "~/.gitk-new" -hidden true
+	    file attributes $config_file_tmp -hidden true
 	}
 	puts $f [list set mainfont $mainfont]
 	puts $f [list set textfont $textfont]
@@ -2845,7 +2848,7 @@ proc savestuff {w} {
 	}
 	puts $f "}"
 	close $f
-	file rename -force "~/.gitk-new" "~/.gitk"
+	file rename -force $config_file_tmp $config_file
     }
     set stuffsaved 1
 }
@@ -12058,7 +12061,27 @@ namespace import ::msgcat::mc
 ## And eventually load the actual message catalog
 ::msgcat::mcload $gitk_msgsdir
 
-catch {source ~/.gitk}
+catch {
+    # follow the XDG base directory specification by default. See
+    # http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
+    if {[info exists env(XDG_CONFIG_HOME)] && $env(XDG_CONFIG_HOME) ne ""} {
+	# XDG_CONFIG_HOME environment variable is set
+	set config_file [file join $env(XDG_CONFIG_HOME) git gitk]
+	set config_file_tmp [file join $env(XDG_CONFIG_HOME) git gitk-tmp]
+    } else {
+	# default XDG_CONFIG_HOME
+	set config_file "~/.config/git/gitk"
+	set config_file_tmp "~/.config/git/gitk-tmp"
+    }
+    if {![file exists $config_file]} {
+	if {![file exists [file dirname $config_file]]} {
+	    file mkdir [file dirname $config_file]
+	}
+	# for backward compatability use the old config file if it exists
+	if {[file exists "~/.gitk"]} {set config_file "~/.gitk"}
+    }
+    source $config_file
+}
 
 parsefont mainfont $mainfont
 eval font create mainfont [fontflags mainfont]
-- 
1.8.5.1
