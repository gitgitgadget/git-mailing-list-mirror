From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] gitk: add the equivalent of diff --color-words
Date: Sat, 16 Oct 2010 12:15:10 +0200
Message-ID: <3c06517d478b3725054f4ca08fb8c38e681549c4.1287223650.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 12:15:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P73nP-00010d-Rv
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 12:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044Ab0JPKPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 06:15:16 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:28211 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab0JPKPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 06:15:14 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 16 Oct
 2010 12:15:12 +0200
Received: from localhost.localdomain (217.162.250.31) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sat, 16 Oct
 2010 12:15:12 +0200
X-Mailer: git-send-email 1.7.3.1.266.g3c065
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159158>

Use the newly added 'diff --word-diff=porcelain' to teach gitk a
color-words mode, with two different modes analogous to the
--word-diff=plain and --word-diff=color settings.  These are selected
by a dropdown box.

As an extra twist, automatically enable this word-diff support when
the user mentions a word-diff related option on the command line.
These options were previously ignored because they would break diff
parsing.

Both of these features are only enabled if we have a version of git
that supports --word-diff=porcelain, meaning at least 1.7.2.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I sent this out ages ago, but it seems to have got stuck waiting for
git.git to pick up the required support:

  http://mid.gmane.org/20100417063557.GB6681@brick.ozlabs.ibm.com

Then I also forgot.  As you can check with 'git tag --contains
882749a', this support has indeed gone into 1.7.2, so gitk can now
also learn about word-diff.

The only change since the patch discussed in the above thread is that
I resolved a conflict with current gitk.git, and that the commit
message now knows the exact version that first had the porcelain
word-diff.

(I hand-edited the patch to apply to gitk.git, so if that broke
anything it's my fault.  But it seems to apply okay to its current
master.)


 gitk |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 1b0e09a..63a90bc 100644
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
@@ -1970,6 +1983,8 @@ proc makewindow {} {
     global fprogitem fprogcoord lastprogupdate progupdatepending
     global rprogitem rprogcoord rownumsel numcommits
     global have_tk85 use_ttk NS
+    global git_version
+    global worddiff
 
     # The "mc" arguments here are purely so that xgettext
     # sees the following string as needing to be translated
@@ -2243,6 +2258,15 @@ proc makewindow {} {
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
@@ -7502,11 +7526,16 @@ proc changeignorespace {} {
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
     global git_version currdiffsubmod
@@ -7523,6 +7552,9 @@ proc getblobdiffs {ids} {
     if {$ignorespace} {
 	append cmd " -w"
     }
+    if {$worddiff ne [mc "Line diff"]} {
+	append cmd " --word-diff=porcelain"
+    }
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -7608,6 +7640,7 @@ proc getblobdiffline {bdf ids} {
     global ctext_file_names ctext_file_lines
     global diffinhdr treediffs mergemax diffnparents
     global diffencoding jump_to_here targetline diffline currdiffsubmod
+    global worddiff
 
     set nr 0
     $ctext conf -state normal
@@ -7747,15 +7780,28 @@ proc getblobdiffline {bdf ids} {
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
@@ -7770,6 +7816,8 @@ proc getblobdiffline {bdf ids} {
 				lappend tags m$num
 			    }
 			}
+			set words_pre_markup "{+"
+			set words_post_markup "+}"
 		    }
 		    if {$targetline ne {}} {
 			if {$diffline == $targetline} {
@@ -7779,8 +7827,17 @@ proc getblobdiffline {bdf ids} {
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
@@ -11391,6 +11448,7 @@ if {[tk windowingsystem] eq "win32"} {
 set diffcolors {red "#00a000" blue}
 set diffcontext 3
 set ignorespace 0
+set worddiff ""
 set markbgcolor "#e0e0ff"
 
 set circlecolors {white blue gray blue blue}
-- 
1.7.3.1.266.g3c065
