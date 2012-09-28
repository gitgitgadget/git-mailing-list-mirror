From: Jeff King <peff@peff.net>
Subject: [PATCH] gitk: refresh the index before running diff-files
Date: Fri, 28 Sep 2012 16:50:54 -0400
Message-ID: <20120928205054.GA5985@sigill.intra.peff.net>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
 <20120928202330.GA5770@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Scott Batchelor <scott.batchelor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 22:51:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THhWh-0008I8-L0
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 22:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758701Ab2I1Uu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 16:50:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33880 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758672Ab2I1Uu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 16:50:56 -0400
Received: (qmail 21751 invoked by uid 107); 28 Sep 2012 20:51:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Sep 2012 16:51:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Sep 2012 16:50:54 -0400
Content-Disposition: inline
In-Reply-To: <20120928202330.GA5770@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206610>

On Fri, Sep 28, 2012 at 04:23:30PM -0400, Jeff King wrote:

> > I'm trying to figure out what the problem with "git diff-files" is
> > because gitk uses it under the hood, and I think that gitk is
> > reporting  erroneous changes (which are also reset by performing a
> > "git status" in the repo) in the "patch" files list.
> 
> gitk should probably be calling "update-index --refresh" on startup. If
> it already is, then it may be that whatever is updating the files is
> doing it while gitk is running.

Ah, it is not refreshing the index at all.  Try this (substitute
Makefile with some file in your repository):

  $ touch Makefile
  $ gitk  <-- reports uncommitted changes
  $ git update-index --refresh
  $ gitk  <-- changes go away

I am not a tcl hacker, but the patch below seems to fix it for me.

-- >8 --
Subject: [PATCH] gitk: refresh the index before running diff-files

If you have index entries that are stat-dirty but otherwise
unchanged, gitk will erroneously report that "local
uncommited changes" are present. This is because we call the
plumbing diff-files, which expects us to have updated the
index ourselves. So let's start doing so.

We only run this once per invocation of gitk, though. The
point of diff-files not running the update is that it does
not need to be run for every command, but generally only
once per high-level operation.

Signed-off-by: Jeff King <peff@peff.net>
---
Potentially the "reload" command should reset the need_index_refresh
flag, too.

 gitk | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/gitk b/gitk
index 379582a..561be23 100755
--- a/gitk
+++ b/gitk
@@ -5112,6 +5112,14 @@ proc dodiffindex {} {
     filerun $fd [list readdiffindex $fd $lserial $i]
 }
 
+proc refresh_index {} {
+    global need_index_refresh
+    if { $need_index_refresh } {
+	exec sh -c "git update-index --refresh >/dev/null 2>&1 || true"
+	set need_index_refresh false
+    }
+}
+
 proc readdiffindex {fd serial inst} {
     global viewmainheadid nullid nullid2 curview commitinfo commitdata lserial
     global vfilelimit
@@ -5131,6 +5139,7 @@ proc readdiffindex {fd serial inst} {
     }
 
     # now see if there are any local changes not checked in to the index
+    refresh_index
     set cmd "|git diff-files"
     if {$vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
@@ -11670,6 +11679,7 @@ set want_ttk 1
 set autosellen 40
 set perfile_attrs 0
 set want_ttk 1
+set need_index_refresh true
 
 if {[tk windowingsystem] eq "aqua"} {
     set extdifftool "opendiff"
-- 
1.7.12.42.g8bdb6d3
