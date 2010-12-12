From: lists@haller-berlin.de
Subject: [PATCH v2/RFC] gitk: Add "First parent" checkbox
Date: Sun, 12 Dec 2010 21:08:05 +0100
Message-ID: <1292184485-39351-1-git-send-email-lists@haller-berlin.de>
References: <20101212042732.GA7296@brick.ozlabs.ibm.com>
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Dec 12 21:12:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRsH2-00089Q-0P
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 21:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab0LLUId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 15:08:33 -0500
Received: from mail.ableton.net ([62.96.12.117]:57486 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976Ab0LLUIc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 15:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=cJC5/ZYr0b+46CEeuoa+/d9adsamfRbL8t9IvmeIsaU=;
	b=UsxGn1gGj8rcP5da77RvHzmYwIDRK/uZTk5URpo0nT/SuEemxEpnUxdmefQQhd7AwzSjgYdLrI4EGw4Rjm2ngzVOnbxJUCsza83mG98fhXEdou9tsjwafUM/S9u1sxQmSUsydQc784xmomhylx+PIMnKvEqqpqx55Uo1qGG1nuA=;
Received: from dslb-088-074-017-003.pools.arcor-ip.net ([88.74.17.3] helo=localhost.localdomain)
	by mail.ableton.net with esmtpa (Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PRsDd-00032j-GK; Sun, 12 Dec 2010 21:08:29 +0100
X-Mailer: git-send-email 1.7.3.2.442.g97e50
In-Reply-To: <20101212042732.GA7296@brick.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163489>

From: Stefan Haller <lists@haller-berlin.de>

Sometimes it's desirable to see what changes were introduced by a
merge commit, rather than how conflicts were resolved. This adds
a checkbox which, when turned on, makes gitk show the equivalent
of "git show --first-parent <commit>" for merge commits.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
Paul Mackerras <paulus@samba.org> wrote:

> I just applied Thomas Rast's patch, so you'll need to rebase. 

OK, here's a new patch, rebased onto current master (but otherwise
unchanged for now).

> Also you're right that we're running out of space; perhaps we need to make
> the pane header two rows high.

The suggestion was to make it two rows high only if it doesn't fit on
one row (i.e. dynamically "line-wrap"), and I like the idea.  Unfortunately
that's beyond my Tk skills; anybody willing to help?

> Finally, "First parent" doesn't really convey to me immediately what it
> does -- I have to think about it, so it will probably confuse new users.
> I don't know what would be better, though.

What I like about it is that it's consistent with the command-line
client, "git show --first-parent".  But I don't insist on it if anybody
has a better suggestion.

 gitk |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index e82c6bf..7201ba0 100755
--- a/gitk
+++ b/gitk
@@ -2269,6 +2269,10 @@ proc makewindow {} {
 	pack .bleft.mid.worddiff -side left -padx 5
     }
 
+    ${NS}::checkbutton .bleft.mid.firstparent -text [mc "First parent"] \
+	-command changefirstparent -variable firstparent
+    pack .bleft.mid.firstparent -side left -padx 5
+
     set ctext .bleft.bottom.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font textfont \
@@ -6897,6 +6901,7 @@ proc selectline {l isnew {desired_loc {}}} {
     global cmitmode showneartags allcommits
     global targetrow targetid lastscrollrows
     global autoselect jump_to_here
+    global firstparent
 
     catch {unset pending_select}
     $canv delete hover
@@ -7038,7 +7043,7 @@ proc selectline {l isnew {desired_loc {}}} {
     init_flist [mc "Comments"]
     if {$cmitmode eq "tree"} {
 	gettree $id
-    } elseif {[llength $olds] <= 1} {
+    } elseif {[llength $olds] <= 1 || $firstparent} {
 	startdiff $id
     } else {
 	mergediff $id
@@ -7442,7 +7447,7 @@ proc diffcmd {ids flags} {
 proc gettreediffs {ids} {
     global treediff treepending
 
-    if {[catch {set gdtf [open [diffcmd $ids {--no-commit-id}] r]}]} return
+    if {[catch {set gdtf [open [diffcmd $ids {--no-commit-id -m --first-parent}] r]}]} return
 
     set treepending $ids
     set treediff {}
@@ -7534,12 +7539,20 @@ proc changeworddiff {name ix op} {
     reselectline
 }
 
+proc changefirstparent {} {
+    global treediffs
+    catch {unset treediffs}
+
+    reselectline
+}
+
 proc getblobdiffs {ids} {
     global blobdifffd diffids env
     global diffinhdr treediffs
     global diffcontext
     global ignorespace
     global worddiff
+    global firstparent
     global limitdiffs vfilelimit curview
     global diffencoding targetline diffnparents
     global git_version currdiffsubmod
@@ -7552,13 +7565,18 @@ proc getblobdiffs {ids} {
     if {[package vcompare $git_version "1.6.6"] >= 0} {
 	set submodule "--submodule"
     }
-    set cmd [diffcmd $ids "-p $textconv $submodule  -C --cc --no-commit-id -U$diffcontext"]
+    set cmd [diffcmd $ids "-p $textconv $submodule  -C --no-commit-id -U$diffcontext"]
     if {$ignorespace} {
 	append cmd " -w"
     }
     if {$worddiff ne [mc "Line diff"]} {
 	append cmd " --word-diff=porcelain"
     }
+    if {$firstparent} {
+	append cmd " -m --first-parent"
+    } else {
+	append cmd " --cc"
+    }
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -11453,6 +11471,7 @@ set diffcolors {red "#00a000" blue}
 set diffcontext 3
 set ignorespace 0
 set worddiff ""
+set firstparent 0
 set markbgcolor "#e0e0ff"
 
 set circlecolors {white blue gray blue blue}
-- 
1.7.3.2.442.g97e50
