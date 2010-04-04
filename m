From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] gitk: add the equivalent of diff --color-words
Date: Sun, 4 Apr 2010 15:46:39 +0200
Message-ID: <d144dbcdc950d54837009b740ad1fa791b5e479a.1270388195.git.trast@student.ethz.ch>
References: <cover.1270388195.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 15:47:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyQAh-0000pk-Hb
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 15:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212Ab0DDNrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 09:47:24 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:55444 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754208Ab0DDNrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 09:47:08 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 4 Apr
 2010 15:47:01 +0200
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 4 Apr
 2010 15:46:41 +0200
X-Mailer: git-send-email 1.7.0.3.521.ga1e9e
In-Reply-To: <cover.1270388195.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143927>

Use the newly added 'diff --word-diff=porcelain' to teach gitk a
color-words mode, triggered by a checkbox.

As an extra twist, automatically enable this word-diff support when
the user mentions a word-diff related option on the command line.
These options were previously ignored because they would break diff
parsing.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 gitk |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..05ed053 100755
--- a/gitk
+++ b/gitk
@@ -131,6 +131,7 @@ proc unmerged_files {files} {
 
 proc parseviewargs {n arglist} {
     global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
+    global worddiff
 
     set vdatemode($n) 0
     set vmergeonly($n) 0
@@ -168,7 +169,7 @@ proc parseviewargs {n arglist} {
 		lappend diffargs $arg
 	    }
 	    "--raw" - "--patch-with-raw" - "--patch-with-stat" -
-	    "--name-only" - "--name-status" - "--color" - "--color-words" -
+	    "--name-only" - "--name-status" - "--color" -
 	    "--log-size" - "--pretty=*" - "--decorate" - "--abbrev-commit" -
 	    "--cc" - "-z" - "--header" - "--parents" - "--boundary" -
 	    "--no-color" - "-g" - "--walk-reflogs" - "--no-walk" -
@@ -177,6 +178,11 @@ proc parseviewargs {n arglist} {
 		# These cause our parsing of git log's output to fail, or else
 		# they're options we want to set ourselves, so ignore them.
 	    }
+	    "--color-words*" - "--word-diff*" {
+		# These trigger a word diff in the console interface,
+		# so help the user by enabling our own support
+		set worddiff 1
+	    }
 	    "--stat=*" - "--numstat" - "--shortstat" - "--summary" -
 	    "--check" - "--exit-code" - "--quiet" - "--topo-order" -
 	    "--full-history" - "--dense" - "--sparse" -
@@ -2240,6 +2246,9 @@ proc makewindow {} {
     ${NS}::checkbutton .bleft.mid.ignspace -text [mc "Ignore space change"] \
 	-command changeignorespace -variable ignorespace
     pack .bleft.mid.ignspace -side left -padx 5
+    ${NS}::checkbutton .bleft.mid.worddiff -text [mc "Word diff"] \
+	-command changeworddiff -variable worddiff
+    pack .bleft.mid.worddiff -side left -padx 5
     set ctext .bleft.bottom.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font textfont \
@@ -7494,11 +7503,16 @@ proc changeignorespace {} {
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
@@ -7515,6 +7529,9 @@ proc getblobdiffs {ids} {
     if {$ignorespace} {
 	append cmd " -w"
     }
+    if {$worddiff} {
+	append cmd " --word-diff=porcelain"
+    }
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -7599,6 +7616,7 @@ proc getblobdiffline {bdf ids} {
     global ctext_file_names ctext_file_lines
     global diffinhdr treediffs mergemax diffnparents
     global diffencoding jump_to_here targetline diffline
+    global worddiff
 
     set nr 0
     $ctext conf -state normal
@@ -7727,15 +7745,22 @@ proc getblobdiffline {bdf ids} {
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
@@ -7759,8 +7784,13 @@ proc getblobdiffline {bdf ids} {
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
@@ -11379,6 +11409,7 @@ if {[tk windowingsystem] eq "win32"} {
 set diffcolors {red "#00a000" blue}
 set diffcontext 3
 set ignorespace 0
+set worddiff 0
 set markbgcolor "#e0e0ff"
 
 set circlecolors {white blue gray blue blue}
-- 
1.7.0.3.521.ga1e9e
