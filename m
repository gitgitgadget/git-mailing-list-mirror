From: Damien Diederen <dd@crosstwine.com>
Subject: [RFC BANDAID PATCH] gitk: Don't add missing parents to display list when pickaxing
Date: Wed, 2 Jun 2010 22:32:40 +0200
Message-ID: <87ljaxcffb.fsf@mini.crosstwine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 23:06:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJv9P-0006bI-7Y
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 23:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758766Ab0FBVGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 17:06:54 -0400
Received: from 63.mail-out.ovh.net ([91.121.185.56]:58318 "HELO
	63.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758665Ab0FBVGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 17:06:52 -0400
Received: (qmail 30843 invoked by uid 503); 2 Jun 2010 21:17:14 -0000
Received: from b6.ovh.net (HELO mail177.ha.ovh.net) (213.186.33.56)
  by 63.mail-out.ovh.net with SMTP; 2 Jun 2010 21:17:13 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 2 Jun 2010 23:06:49 +0200
Received: from dslb-088-065-128-010.pools.arcor-ip.net (HELO localhost) (dd@crosstwine.com@88.65.128.10)
  by ns0.ovh.net with SMTP; 2 Jun 2010 23:06:49 +0200
OpenPGP: url=http://crosstwine.com/dd/gpg_key.txt; id=8F64EB2F4B373D44424F6D5CA125224E7F70D683
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Ovh-Tracer-Id: 14405044885261772510
X-Ovh-Remote: 88.65.128.10 (dslb-088-065-128-010.pools.arcor-ip.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148272>


Gitk unconditionally prepends --parents --boundary to the
user-provided argument list, and relies on boundary commits to
"neatly" close history lines.

Git log's '-S' option, however, interacts badly with --boundary as it
is implemented as a post-processing filter of the object graph.
Results coming from a common sub-graph end up producing no boundary,
yet may appear disjoint as no parent rewriting occurs.  In git.git:

    $ git log -SGMail --oneline --parents --boundary
    e498257 bd7440f Documentation/SubmittingPatches: clarify GMail section and SMTP
    df5753c a751b5c SubmittingPatches: update GMail section
    50dffd4 28001d0 Google has renamed the imap folder

This confuses gitk, which truncates its "display order"
list (containing the six commits he knows about--three plus three
parents) to a three-row display:

    @ Documentation/SubmittingPatches: clarify GMail section and SMTP
    |
    O show-branch: use DEFAULT_ABBREV instead of 7

    @ SubmittingPatches: update GMail section

Note how it picked up "show-branch: ..." (bd7440f) as a
pseudo-boundary of e498257, marking it with an "empty" bullet, but
then stopped prematurely--missing one of the matching commits!

This bandaid patch cause gitk not to try to "close" the arcs when
pickaxe is in effect.  "Missing parents" are not added to the display
order list, whose length then matches the number of rows.  It produces
the following imperfect display, which has the advantage of not
omitting any result:

    @ Documentation/SubmittingPatches: clarify GMail section and SMTP
    |
    | @ SubmittingPatches: update GMail section
    | |
    v v @ Google has renamed the imap folder

The parallel history lines are incorrect, and the arrows don't point
anywhere.  Fixing this would require more extensive changes to gitk's
display engine, and possibly invalidate some of the invariants on
which it currently relies.

Preliminary investigation suggests that adding "proper" --boundary
support to pickaxe would require to:

 1. disable rev_info->boundary when producing the revision list;

 2. manually maintain and trim rev_info->boundary_commits in
    cmd_log_walk according to the return value of log_tree_commit;

 3. perform a second pass of 'log_tree_commit' on the "fake" boundary,
    with pickaxe filtering disabled.

This seems to be a superior solution, but is not too pretty, and I may
be missing something (besides the fact that it slightly changes the
definition of boundary).  It may also fix --graph's current behaviour,
which is, err..., interesting.

I have not looked into parent rewriting, which may be the correct
thing to do.  Note, however, that it seems it would not match the way
e.g. 'gitk --grep=GMail' works--at a first glance.

Comments?  Suggestions?

---
 gitk |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 45e3380..5cd3787 100755
--- a/gitk
+++ b/gitk
@@ -130,7 +130,7 @@ proc unmerged_files {files} {
 }
 
 proc parseviewargs {n arglist} {
-    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
+    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vnoboundary vorigargs env
 
     set vdatemode($n) 0
     set vmergeonly($n) 0
@@ -141,6 +141,7 @@ proc parseviewargs {n arglist} {
     set origargs $arglist
     set allknown 1
     set filtered 0
+    set noboundary 0
     set i -1
     foreach arg $arglist {
 	incr i
@@ -194,6 +195,9 @@ proc parseviewargs {n arglist} {
 		# These mean that we get a subset of the commits
 		set filtered 1
 		lappend glflags $arg
+		if {[string match "-S*" $arg]} {
+		    set noboundary 1
+		}
 	    }
 	    "-n" {
 		# This appears to be the only one that has a value as a
@@ -237,6 +241,7 @@ proc parseviewargs {n arglist} {
     set vflags($n) $glflags
     set vrevs($n) $revargs
     set vfiltered($n) $filtered
+    set vnoboundary($n) $noboundary
     set vorigargs($n) $origargs
     return $allknown
 }
@@ -1360,6 +1365,7 @@ proc getcommitlines {fd inst view updating}  {
     global parents children curview hlview
     global idpending ordertok
     global varccommits varcid varctok vtokmod vfilelimit
+    global vnoboundary
 
     set stuff [read $fd 500000]
     # git log doesn't terminate the last commit with a null...
@@ -1401,7 +1407,9 @@ proc getcommitlines {fd inst view updating}  {
 	    set viewcomplete($view) 1
 	    # Check if we have seen any ids listed as parents that haven't
 	    # appeared in the list
-	    closevarcs $view
+	    if {!$vnoboundary($view)} {
+		closevarcs $view
+	    }
 	    notbusy $view
 	}
 	if {$view == $curview} {
-- 
1.7.1
