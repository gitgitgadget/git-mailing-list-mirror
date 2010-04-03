From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/2] gitk: add the equivalent of diff --color-words
Date: Sat, 3 Apr 2010 20:06:20 +0200
Message-ID: <057c2dc29e3392103470ecf782f92d3cd432ded6.1270317502.git.trast@student.ethz.ch>
References: <cover.1270317502.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Paul Mackerras <paulus@samba.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 03 20:06:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny7k5-0005W5-I5
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 20:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775Ab0DCSGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 14:06:31 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:44362 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755811Ab0DCSGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 14:06:25 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 3 Apr
 2010 20:06:21 +0200
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 3 Apr
 2010 20:06:22 +0200
X-Mailer: git-send-email 1.7.0.4.504.g4d2c
In-Reply-To: <cover.1270317502.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143892>

Use the newly added 'diff --color-words --porcelain' to teach gitk a
color-words mode, triggered by a checkbox.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 gitk |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..d269226 100755
--- a/gitk
+++ b/gitk
@@ -2240,6 +2240,9 @@ proc makewindow {} {
     ${NS}::checkbutton .bleft.mid.ignspace -text [mc "Ignore space change"] \
 	-command changeignorespace -variable ignorespace
     pack .bleft.mid.ignspace -side left -padx 5
+    ${NS}::checkbutton .bleft.mid.worddiff -text [mc "Word diff"] \
+	-command changeworddiff -variable worddiff
+    pack .bleft.mid.worddiff -side left -padx 5
     set ctext .bleft.bottom.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font textfont \
@@ -7494,11 +7497,16 @@ proc changeignorespace {} {
     reselectline
 }
 
+proc changeworddiff {} {
+    reselectline
+}
+
 proc getblobdiffs {ids} {
     global blobdifffd diffids env
     global diffinhdr treediffs
     global diffcontext
     global ignorespace
+    global worddiff
     global limitdiffs vfilelimit curview
     global diffencoding targetline diffnparents
     global git_version
@@ -7515,6 +7523,9 @@ proc getblobdiffs {ids} {
     if {$ignorespace} {
 	append cmd " -w"
     }
+    if {$worddiff} {
+	append cmd " --color-words --porcelain"
+    }
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -7599,6 +7610,7 @@ proc getblobdiffline {bdf ids} {
     global ctext_file_names ctext_file_lines
     global diffinhdr treediffs mergemax diffnparents
     global diffencoding jump_to_here targetline diffline
+    global worddiff
 
     set nr 0
     $ctext conf -state normal
@@ -7727,15 +7739,22 @@ proc getblobdiffline {bdf ids} {
 	    # parse the prefix - one ' ', '-' or '+' for each parent
 	    set prefix [string range $line 0 [expr {$diffnparents - 1}]]
 	    set tag [expr {$diffnparents > 1? "m": "d"}]
+	    set dowords [expr {$worddiff && $diffnparents == 1}]
 	    if {[string trim $prefix " -+"] eq {}} {
 		# prefix only has " ", "-" and "+" in it: normal diff line
 		set num [string first "-" $prefix]
+		if {$dowords} {
+		    set line [string range $line 1 end]
+		}
 		if {$num >= 0} {
 		    # removed line, first parent with line is $num
 		    if {$num >= $mergemax} {
 			set num "max"
 		    }
-		    $ctext insert end "$line\n" $tag$num
+		    $ctext insert end "$line" $tag$num
+		    if {!$dowords} {
+			$ctext insert end "\n" $tag$num
+		    }
 		} else {
 		    set tags {}
 		    if {[string first "+" $prefix] >= 0} {
@@ -7759,8 +7778,13 @@ proc getblobdiffline {bdf ids} {
 			    incr diffline
 			}
 		    }
-		    $ctext insert end "$line\n" $tags
+		    $ctext insert end "$line" $tags
+		    if {!$dowords} {
+			$ctext insert end "\n" $tags
+		    }
 		}
+	    } elseif {$dowords && $prefix eq "~"} {
+		$ctext insert end "\n" {}
 	    } else {
 		# "\ No newline at end of file",
 		# or something else we don't recognize
@@ -11379,6 +11403,7 @@ if {[tk windowingsystem] eq "win32"} {
 set diffcolors {red "#00a000" blue}
 set diffcontext 3
 set ignorespace 0
+set worddiff 0
 set markbgcolor "#e0e0ff"
 
 set circlecolors {white blue gray blue blue}
-- 
1.7.0.4.504.g4d2c
