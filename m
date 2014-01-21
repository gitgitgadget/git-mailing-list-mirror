From: Astril Hayato <astrilhayato@gmail.com>
Subject: [PATCH v2] gitk: Comply with XDG base directory specification
Date: Tue, 21 Jan 2014 19:10:16 +0000
Message-ID: <1390331416-4662-1-git-send-email-astrilhayato@gmail.com>
Cc: paulus@samba.org, Astril Hayato <astrilhayato@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 21 20:10:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5gig-0008R4-1e
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 20:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbaAUTKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 14:10:37 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:44228 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaAUTKf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 14:10:35 -0500
Received: by mail-wg0-f43.google.com with SMTP id y10so8244286wgg.34
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 11:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vqZBpo1DhQC8DyRQnSNPEBT07iO+GY3VzEO4k/oYGE0=;
        b=hkVhrFc3bYxlIR2DylvKkSlZ234JZEYLD+LcTEEjsblTVyutv1radQH2YhYfYQunr5
         Cy1kghZcWvTJ8n1OwRR0ke81a/PvwWRjwq9cXEuGvF2WuRWszKqkcFXujHv9HNSIP76c
         Bv0Z3GPNQ2BP995hN8pY3pKCuQ3emspEVHRFVheT4+cHdjhq5+swgUhgm0GFBHZfPb/a
         7gXkebLHww798EaDxAJHGo593UACyOLdaCWCrdW48nWhBYnnbioSTUT0cmroltBReCeZ
         PlmXKbH1OPFZis6gjLYIaFZCRrNqbqwJzDm6oPifPGXJHBXH2RCo0vTzuuEIWEYdFiYG
         FMtw==
X-Received: by 10.180.9.232 with SMTP id d8mr15928798wib.25.1390331434345;
        Tue, 21 Jan 2014 11:10:34 -0800 (PST)
Received: from localhost.localdomain (cpc4-blbn8-2-0-cust14.10-1.cable.virginm.net. [86.22.6.15])
        by mx.google.com with ESMTPSA id di9sm9462880wid.6.2014.01.21.11.10.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jan 2014 11:10:33 -0800 (PST)
X-Mailer: git-send-email 1.8.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240762>

Write the gitk config data to $XDG_CONFIG_HOME/git/gitk ($HOME/.config/git/gitk
by default) in line with the XDG specification. This makes it consistent with
git which also follows the spec.

If $HOME/.gitk already exists use that for backward compatibility, so only new
installations are affected.

Signed-off-by: Astril Hayato <astrilhayato@gmail.com>
---
 gitk | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 33c3a6c..d592d7e 100755
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
@@ -12058,7 +12061,29 @@ namespace import ::msgcat::mc
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
+	# for backward compatibility use the old config file if it exists
+	if {[file exists "~/.gitk"]} {
+	    set config_file "~/.gitk"
+	    set config_file_tmp "~/.gitk-tmp"
+	} elseif {![file exists [file dirname $config_file]]} {
+	    file mkdir [file dirname $config_file]
+	}
+    }
+    source $config_file
+}
 
 parsefont mainfont $mainfont
 eval font create mainfont [fontflags mainfont]
-- 
1.8.5.3
