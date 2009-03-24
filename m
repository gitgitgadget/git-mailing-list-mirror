From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: .gitk should created hidden in windows
Date: Tue, 24 Mar 2009 01:04:07 +0100
Message-ID: <49C82377.40101@users.sourceforge.net>
References: <49BFA97A.1030203@lanwin.de> <18887.26239.115820.450313@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steve Wagner <lists@lanwin.de>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 01:07:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llu9Q-0006nP-8J
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 01:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbZCXAEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 20:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbZCXAEU
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 20:04:20 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:52448 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752171AbZCXAET (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 20:04:19 -0400
Received: from [172.23.170.147] (helo=anti-virus03-10)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Llu7s-0002Me-R3; Tue, 24 Mar 2009 00:04:16 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Llu7s-000864-Ai; Tue, 24 Mar 2009 00:04:16 +0000
Received: from [192.168.0.25] (pc025.patthoyts.tk [192.168.0.25])
	by badger.patthoyts.tk (Postfix) with ESMTP id CF7035182B;
	Tue, 24 Mar 2009 00:04:15 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <18887.26239.115820.450313@cargo.ozlabs.ibm.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114368>

Paul Mackerras wrote:
> Please try this patch and let me know if it does what you want.
> 
[snip]

This patch works fine on my Vista installation. The .gitk file is now
hidden.

An alternative that was discussed was to move it rather than hide it so
that it ends up in the Application Data folder along with settings for
other applications. The following patch does this but hits rather more
lines of code and ends up needing to check the original location as well.

diff --git a/gitk b/gitk
index a7294a1..5ec6e7b 100755
--- a/gitk
+++ b/gitk
@@ -2509,12 +2509,13 @@ proc savestuff {w} {
     global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
-    global autoselect extdifftool perfile_attrs markbgcolor
+    global autoselect extdifftool perfile_attrs markbgcolor rcfile

     if {$stuffsaved} return
     if {![winfo viewable .]} return
-    catch {
-	set f [open "~/.gitk-new" w]
+    set tmpfile "${rcfile}-new"
+    if {[catch {
+	set f [open $tmpfile {CREAT WRONLY}]
 	puts $f [list set mainfont $mainfont]
 	puts $f [list set textfont $textfont]
 	puts $f [list set uifont $uifont]
@@ -2555,7 +2556,10 @@ proc savestuff {w} {
 	}
 	puts $f "}"
 	close $f
-	file rename -force "~/.gitk-new" "~/.gitk"
+	file rename -force $tmpfile $rcfile
+    } err]} {
+        tk_messageBox -icon error -message $err \
+            -title "Failed to save preferences"
     }
     set stuffsaved 1
 }
@@ -10790,7 +10794,13 @@ namespace import ::msgcat::mc
 ## And eventually load the actual message catalog
 ::msgcat::mcload $gitk_msgsdir

-catch {source ~/.gitk}
+set rcfile ~/.gitk
+if {$::tcl_platform(platform) eq "windows"} {
+    # Load old settings file if present
+    if {[file exists ~/.gitk]} {catch {source ~/.gitk}}
+    set rcfile [file join $env(APPDATA) gitk.settings]
+}
+catch {source $rcfile}

 font create optionfont -family sans-serif -size -12
