From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 3/3] gitk: add the equivalent of diff --color-words
Date: Mon, 12 Apr 2010 15:07:46 +0200
Message-ID: <c6a5b441d481dee8861c8b9b2898cce10b7a1f75.1271077334.git.trast@student.ethz.ch>
References: <cover.1271077334.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 15:08:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1JNJ-0006hj-0V
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 15:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab0DLNIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 09:08:04 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:33992 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201Ab0DLNIA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 09:08:00 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.247.2; Mon, 12 Apr
 2010 15:07:57 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.247.2; Mon, 12 Apr
 2010 15:07:46 +0200
X-Mailer: git-send-email 1.7.1.rc0.260.g2b919
In-Reply-To: <cover.1271077334.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144725>

Use the newly added 'diff --word-diff=porcelain' to teach gitk a
color-words mode, with two different modes analogous to the
--word-diff=plain and --word-diff=color settings.  These are selected
by a dropdown box.

As an extra twist, automatically enable this word-diff support when
the user mentions a word-diff related option on the command line.
These options were previously ignored because they would break diff
parsing.

Both of these features are only enabled if we have a version of git
that supports --word-diff=porcelain, tentatively set to 1.7.2.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 gitk |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index e9e284e..466c328 100755
--- a/gitk
+++ b/gitk
@@ -131,6 +131,7 @@ proc unmerged_files {files} {
 
 proc parseviewargs {n arglist} {
     global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
+    global worddiff git_version
 
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
@@ -177,6 +178,18 @@ proc parseviewargs {n arglist} {
 		# These cause our parsing of git log's output to fail, or else
 		# they're options we want to set ourselves, so ignore them.
 	    }
+	    "--color-words*" - "--word-diff=color" {
+		# These trigger a word diff in the console interface,
+		# so help the user by enabling our own support
+		if {[package vcompare $git_version "1.7.2"] >= 0} {
+		    set worddiff [mc "Color words"]
+		}
+	    }
+	    "--word-diff*" {
+		if {[package vcompare $git_version "1.7.2"] >= 0} {
+		    set worddiff [mc "Markup words"]
+		}
+	    }
 	    "--stat=*" - "--numstat" - "--shortstat" - "--summary" -
 	    "--check" - "--exit-code" - "--quiet" - "--topo-order" -
 	    "--full-history" - "--dense" - "--sparse" -
@@ -1967,6 +1980,8 @@ proc makewindow {} {
     global fprogitem fprogcoord lastprogupdate progupdatepending
     global rprogitem rprogcoord rownumsel numcommits
     global have_tk85 use_ttk NS
+    global git_version
+    global worddiff
 
     # The "mc" arguments here are purely so that xgettext
     # sees the following string as needing to be translated
@@ -2240,6 +2255,15 @@ proc makewindow {} {
     ${NS}::checkbutton .bleft.mid.ignspace -text [mc "Ignore space change"] \
 	-command changeignorespace -variable ignorespace
     pack .bleft.mid.ignspace -side left -padx 5
+
+    set worddiff [mc "Line diff"]
+    if {[package vcompare $git_version "1.7.2"] >= 0} {
+	makedroplist .bleft.mid.worddiff worddiff [mc "Line diff"] \
+	    [mc "Markup words"] [mc "Color words"]
+	trace add variable worddiff write changeworddiff
+	pack .bleft.mid.worddiff -side left -padx 5
+    }
+
     set ctext .bleft.bottom.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font textfont \
@@ -7494,11 +7518,16 @@ proc changeignorespace {} {
     reselectline
 }
 
+proc changeworddiff {name ix op} {
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
@@ -7515,6 +7544,9 @@ proc getblobdiffs {ids} {
     if {$ignorespace} {
 	append cmd " -w"
     }
+    if {$worddiff ne [mc "Line diff"]} {
+	append cmd " --word-diff=porcelain"
+    }
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -7599,6 +7631,7 @@ proc getblobdiffline {bdf ids} {
     global ctext_file_names ctext_file_lines
     global diffinhdr treediffs mergemax diffnparents
     global diffencoding jump_to_here targetline diffline
+    global worddiff
 
     set nr 0
     $ctext conf -state normal
@@ -7729,15 +7762,28 @@ proc getblobdiffline {bdf ids} {
 	    # parse the prefix - one ' ', '-' or '+' for each parent
 	    set prefix [string range $line 0 [expr {$diffnparents - 1}]]
 	    set tag [expr {$diffnparents > 1? "m": "d"}]
+	    set dowords [expr {$worddiff ne [mc "Line diff"] && $diffnparents == 1}]
+	    set words_pre_markup ""
+	    set words_post_markup ""
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
+		    if {$dowords && $worddiff eq [mc "Markup words"]} {
+			$ctext insert end "\[-$line-\]" $tag$num
+		    } else {
+			$ctext insert end "$line" $tag$num
+		    }
+		    if {!$dowords} {
+			$ctext insert end "\n" $tag$num
+		    }
 		} else {
 		    set tags {}
 		    if {[string first "+" $prefix] >= 0} {
@@ -7752,6 +7798,8 @@ proc getblobdiffline {bdf ids} {
 				lappend tags m$num
 			    }
 			}
+			set words_pre_markup "{+"
+			set words_post_markup "+}"
 		    }
 		    if {$targetline ne {}} {
 			if {$diffline == $targetline} {
@@ -7761,8 +7809,17 @@ proc getblobdiffline {bdf ids} {
 			    incr diffline
 			}
 		    }
-		    $ctext insert end "$line\n" $tags
+		    if {$dowords && $worddiff eq [mc "Markup words"]} {
+			$ctext insert end "$words_pre_markup$line$words_post_markup" $tags
+		    } else {
+			$ctext insert end "$line" $tags
+		    }
+		    if {!$dowords} {
+			$ctext insert end "\n" $tags
+		    }
 		}
+	    } elseif {$dowords && $prefix eq "~"} {
+		$ctext insert end "\n" {}
 	    } else {
 		# "\ No newline at end of file",
 		# or something else we don't recognize
@@ -11381,6 +11438,7 @@ if {[tk windowingsystem] eq "win32"} {
 set diffcolors {red "#00a000" blue}
 set diffcontext 3
 set ignorespace 0
+set worddiff ""
 set markbgcolor "#e0e0ff"
 
 set circlecolors {white blue gray blue blue}
-- 
1.7.1.rc0.262.gff1a3
