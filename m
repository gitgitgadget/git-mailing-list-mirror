From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] gitk: Remove mc parameter from proc show_error
Date: Mon, 11 May 2015 13:26:41 -0600
Message-ID: <1431372401-8750-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: paulus@samba.org, bernt@norang.ca, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 21:27:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrtLw-0005qJ-Rs
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 21:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbbEKT04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 15:26:56 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35382 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbbEKT0z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 15:26:55 -0400
Received: by pabtp1 with SMTP id tp1so117289747pab.2
        for <git@vger.kernel.org>; Mon, 11 May 2015 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=h7F7UqIGpYCnocqc3Gw4HaJiatt3JU3jeLKadcvtfI4=;
        b=c5uAhgL3DRi/gCr9wlonaQDhmqxO5Bw71gHddFDF/6YaAWBpz4L85GlVPfUMa4cJnE
         WdIYx4M8QZ2TYIGBsUDkjgtZSuTt3L7NDNxssCIgHe1GX4+1cBsAXRyOHKbXHArwkaXO
         S6d9SGZlG+XCtBXeIOlxVqucvOL7VEhOtwZMAHZwSD2uZQHwJ0R4DFbP7tTvOKUDzIFa
         PskfAoPeN5OsD+YMyqIJhfeGzpuPEwgOVZ71lXaBgd2yTbySO5lksZ+bkwe9Hn/F5qLn
         90IvqSGWqdRvYBW4xqGjbZkuMDmREP29ioUN6s19GzsWB5Y2Kn2tsUKGaDggikxzl9NN
         lS4g==
X-Received: by 10.70.90.231 with SMTP id bz7mr21393038pdb.15.1431372415054;
        Mon, 11 May 2015 12:26:55 -0700 (PDT)
Received: from alex-wolverine.bmi.utah.edu (guest-dhcp-163.bmi.utah.edu. [155.101.208.163])
        by mx.google.com with ESMTPSA id by3sm2548717pbb.37.2015.05.11.12.26.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 May 2015 12:26:52 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268816>

This is a better fix for 8d849957d81fc0480a52570d66cc3c2a688ecb1b.

This new fix makes the strings "Sorry, gitk cannot run..." and "OK"
translatable and the string "mc" not translatable. It will take effect
the next time `make update-po` is run.

msgcat is now imported before the Tcl/Tk version check so that the mc
function is available even if the version check fails. This should not
be a problem because msgcat and ::msgcat::mc were officially added in
Tcl 8.1 (released April 29, 1999) and we are not trying to support
versions of Tcl older than that.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 gitk | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/gitk b/gitk
index c186704..78baeb5 100755
--- a/gitk
+++ b/gitk
@@ -1894,13 +1894,13 @@ proc make_transient {window origin} {
     }
 }
 
-proc show_error {w top msg {mc mc}} {
+proc show_error {w top msg} {
     global NS
     if {![info exists NS]} {set NS ""}
     if {[wm state $top] eq "withdrawn"} { wm deiconify $top }
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
-    ${NS}::button $w.ok -default active -text [$mc OK] -command "destroy $top"
+    ${NS}::button $w.ok -default active -text [mc OK] -command "destroy $top"
     pack $w.ok -side bottom -fill x
     bind $top <Visibility> "grab $top; focus $top"
     bind $top <Key-Return> "destroy $top"
@@ -12016,10 +12016,29 @@ proc get_path_encoding {path} {
     return $tcl_enc
 }
 
+## For msgcat loading, first locate the installation location.
+if { [info exists ::env(GITK_MSGSDIR)] } {
+    ## Msgsdir was manually set in the environment.
+    set gitk_msgsdir $::env(GITK_MSGSDIR)
+} else {
+    ## Let's guess the prefix from argv0.
+    set gitk_prefix [file dirname [file dirname [file normalize $argv0]]]
+    set gitk_libdir [file join $gitk_prefix share gitk lib]
+    set gitk_msgsdir [file join $gitk_libdir msgs]
+    unset gitk_prefix
+}
+
+## Internationalization (i18n) through msgcat and gettext. See
+## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
+package require msgcat
+namespace import ::msgcat::mc
+## And eventually load the actual message catalog
+::msgcat::mcload $gitk_msgsdir
+
 # First check that Tcl/Tk is recent enough
 if {[catch {package require Tk 8.4} err]} {
-    show_error {} . "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
-		     Gitk requires at least Tcl/Tk 8.4." list
+    show_error {} . [mc "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
+			 Gitk requires at least Tcl/Tk 8.4."]
     exit 1
 }
 
@@ -12169,25 +12188,6 @@ if {[tk windowingsystem] eq "aqua"} {
     set ctxbut <Button-3>
 }
 
-## For msgcat loading, first locate the installation location.
-if { [info exists ::env(GITK_MSGSDIR)] } {
-    ## Msgsdir was manually set in the environment.
-    set gitk_msgsdir $::env(GITK_MSGSDIR)
-} else {
-    ## Let's guess the prefix from argv0.
-    set gitk_prefix [file dirname [file dirname [file normalize $argv0]]]
-    set gitk_libdir [file join $gitk_prefix share gitk lib]
-    set gitk_msgsdir [file join $gitk_libdir msgs]
-    unset gitk_prefix
-}
-
-## Internationalization (i18n) through msgcat and gettext. See
-## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
-package require msgcat
-namespace import ::msgcat::mc
-## And eventually load the actual message catalog
-::msgcat::mcload $gitk_msgsdir
-
 catch {
     # follow the XDG base directory specification by default. See
     # http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
-- 
2.4.0
