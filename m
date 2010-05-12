From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: gitk: Show notes
Date: Wed, 12 May 2010 12:56:58 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20100512085658.GA22938@tugrik.mns.mnsspb.ru>
References: <1273566416-3512-1-git-send-email-kirr@mns.spb.ru> <4BE96B41.7010902@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 12 10:55:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC7jH-0007BW-IO
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 10:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235Ab0ELIzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 04:55:42 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:37453 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463Ab0ELIzl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 04:55:41 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1OC7it-0007Ra-T8; Wed, 12 May 2010 12:55:24 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1OC7kQ-0006RV-IK; Wed, 12 May 2010 12:56:58 +0400
Content-Disposition: inline
In-Reply-To: <4BE96B41.7010902@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146932>

On Tue, May 11, 2010 at 04:35:45PM +0200, Michael J Gruber wrote:
> Kirill Smelkov venit, vidit, dixit 11.05.2010 10:26:
> > If in git.git I do
> > 
> >     $ git notes add -m 'This makes status significantly slower with Dokko' \
> >         ee6fc514
> > 
> > then `git log` shows the note...
> > 
> 
> because --show-notes is the default...
> 
> > ... but unfortunately gitk does not.
> 
> ... unless --pretty is given, and gitk uses --pretty.
> 
> But what is wrong with gitk --show-notes?

Sorry, you are right. I learned notes just yesterday and forgot one can
pass such options to gitk.

> If you mean to adjust gitk's default to log's current default please say
> so in the commit message. There's no need to include a longish sample
> output for that.

Ok, agree.

> Also, I don't think proc do_readcommit needs the notes. The other two
> places use $args, so it might make sense to prepend --show-notes to the
> arg list in a central place.

Right.

I've tried to rework the patch -- only I could not find a better way to
prepend --show-notes to arg, than just define $show_notes based on
$git_version and use it in 2 appropriate places.

Also, --show-notes was introduced in git-1.6.6.2, but our $git_version
is 3 digits only, so this will be really enabled for git-1.7.0 .


Thanks for the review, and maybe there is a better way to do it?

Kirill


---- 8< ----

From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Tue, 11 May 2010 12:17:11 +0400
Subject: [PATCH] gitk: Show notes by default (like git log do)

Starting from ~ git-1.6.6, log, show & whatchanged show notes by default.

On the other hand, gitk does not show notes by default, because under
the hood it calls `git log --pretty=raw ...` to get the log, and in
`git log` notes are turned off, when user specifies format or pretty
settings.

Yes, it is possible to invoke `gitk --show-notes` explicitly, but since
from user's perspective, gitk is gui enabled git log, it would be
logical for gitk to show notes by default too for consistency.

In git, --show-notes was introduced in 66b2ed (Fix "log" family not to
be too agressive about showing notes) which predates 1.6.6.2

Notes can still be supressed with `gitk --no-notes`.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 gitk |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 1b0e09a..45e3380 100755
--- a/gitk
+++ b/gitk
@@ -313,6 +313,7 @@ proc start_rev_list {view} {
     global viewactive viewinstances vmergeonly
     global mainheadid viewmainheadid viewmainheadid_orig
     global vcanopt vflags vrevs vorigargs
+    global show_notes
 
     set startmsecs [clock clicks -milliseconds]
     set commitidx($view) 0
@@ -361,8 +362,8 @@ proc start_rev_list {view} {
     }
 
     if {[catch {
-	set fd [open [concat | git log --no-color -z --pretty=raw --parents \
-			 --boundary $args "--" $files] r]
+	set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
+			--parents --boundary $args "--" $files] r]
     } err]} {
 	error_popup "[mc "Error executing git log:"] $err"
 	return 0
@@ -456,6 +457,7 @@ proc updatecommits {} {
     global mainheadid viewmainheadid viewmainheadid_orig pending_select
     global isworktree
     global varcid vposids vnegids vflags vrevs
+    global show_notes
 
     set isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
     rereadrefs
@@ -508,8 +510,8 @@ proc updatecommits {} {
 	set args $vorigargs($view)
     }
     if {[catch {
-	set fd [open [concat | git log --no-color -z --pretty=raw --parents \
-			  --boundary $args "--" $vfilelimit($view)] r]
+	set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
+			--parents --boundary $args "--" $vfilelimit($view)] r]
     } err]} {
 	error_popup "[mc "Error executing git log:"] $err"
 	return
@@ -11521,6 +11523,11 @@ set NS [expr {$use_ttk ? "ttk" : ""}]
 
 set git_version [join [lrange [split [lindex [exec git version] end] .] 0 2] .]
 
+set show_notes {}
+if {[package vcompare $git_version "1.6.6.2"] >= 0} {
+    set show_notes "--show-notes"
+}
+
 set runq {}
 set history {}
 set historyindex 0
-- 
1.7.1.91.ga63a7
