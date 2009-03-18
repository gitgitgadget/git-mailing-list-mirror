From: Heiko Voigt <git-list@hvoigt.net>
Subject: [CVSPS PATCH v2] fix: correct rev order in case commiters clocks
 were not syncronised
Date: Wed, 18 Mar 2009 18:34:03 +0100
Message-ID: <49C1308B.7070509@hvoigt.net>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net> <49B52F74.1090006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, ydirson@altern.org,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 18 18:36:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljzg9-00079I-64
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759301AbZCRReK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 13:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759293AbZCRReJ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:34:09 -0400
Received: from darksea.de ([83.133.111.250]:55585 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759051AbZCRReH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 13:34:07 -0400
Received: (qmail 20267 invoked from network); 18 Mar 2009 18:33:53 +0100
Received: from unknown (HELO macbook.lan) (127.0.0.1)
  by localhost with SMTP; 18 Mar 2009 18:33:53 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <49B52F74.1090006@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113634>

This fixes the following kind of cvs issues:

 Structure of the test cvs repository

 Message   File:Content         Commit Time
 Rev 1     a: 1.1               2009-02-21 19:11:43 +0100
 Rev 2     a: 1.2    b: 1.1     2009-02-21 19:11:14 +0100
 Rev 3               b: 1.2     2009-02-21 19:11:43 +0100

 As you can see the commit of Rev 3 has the same time as
 Rev 1 this was leading to a broken estimation of patchset
 order.

The correction only applies to the main development line and specifically
ignores branches. The reason behind this is that a complete implementation
covering the correction of branches needs much more work.

I do not consider this patch a very "clean" bugfix. It is somewhat hacky
but may help someone who otherwise would not be able to use cvsps. It
additionally can help to find broken revisions and manually correct the
input files.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
I am currently looking into a more clean solution which does not fidle
with the timestamps but only corrects the ordering of patchsets. To
implement this cvsps needs to be extended to use a topological sort
algorithm instead of a simple merge sort. Maybe Michael can give me some
directions how this was solved in cvs2svn.

My current idea is about using a modified selection sort. Sorting in
chronological order. It should always select the minimum date as the
next patchset as long as it does not conflict with the minimum last
chosen revision of all affected files. If it conflicts another pass will
select the patchset with the minimum revision for that file. This means
sorting time will be O(n^2), another drawback is the space required to
remember the last revision of every file and its branches.

Assuming that this can be implemented in my limited time I will attempt
to do so.

Here are a few explanations about this updated patch:

Michael Haggerty schrieb:
> 
> I am not familiar with the cvsps code, so I will just make some comments
> about things that it is not obvious from your patch that you have
> considered.  These things all caused problems in pre-2.0 versions of
> cvs2svn:
> 
> 1. It is not clear from the patch in what order the revisions are being
> processed.  If they are being processed in the order that they appear in
> the RCS file, then you have to consider branches:
> 
>    * The date adjustment should only occur along chains of revisions
> that are "causally related" -- that is, adjacent revisions on trunk, or
> adjacent revisions on a branch, or the first revision on a branch
> relative to the revision from which the branch sprouted.  It is not
> always the case that revisions that are adjacent in the RCS file are
> causally related.
> 
>    * The revisions along trunk appear in RCS files in reverse
> chronological order; e.g., 1.3, 1.2, 1.1 (this seems to be the case you
> handle).  But the revisions along a branch appear in chronological
> order; e.g., 1.3.2.1, 1.3.2.2, 1.3.2.3.  Do you handle both cases
> correctly?  (A unit test involving revisions on branches would be helpful.)

The input which is parsed by cvsps comes from the cvs log command. There
everything appears in reverse chronological order. Branches always come
at the end of the log so they are not timely ordered among the main
development line.

I adressed this issue by only applying the correction to the mainline.
This is not complete but solves the most practical special case.

A complete implementation needs much more work because in addition to
the last revision of the main line the last revision of every branch
would need to be remembered.

> 2. One form of clock skew that is common in CVS repositories is that
> some computer's CMOS battery went dead and the clock reverted to 1970
> after every reboot.  Given that you adjust revisions' times only towards
> the past, then such a glitch would force the times of all earlier
> revisions to be pushed back to 1970.  (Since you unconditionally
> subtract one second from each commit timestamp, this could also
> conceivably cause an underflow to 2038, but this is admittedly rather
> unlikely.)  This is a hard problem to solve generally.  But if you want
> to handle this problem more robustly, I suggest that you always adjust
> times towards the future, as incorrect clock times in the far future
> seem to be less common in practice.
> 
> Of course these clock skew corrections, if only applied to one file at a
> time, can easily cause changesets to be broken up if the time deltas
> exceed five minutes.

I addressed this by checking for time_t underflow before correction.
cvps will exit with an error message in case it happens. Due to the
reverse chronological order of the input I am only able to see one step
into the future but not into the past. Thats why I can only correct into
the past.

> 
> 3. When cvsps collects individual file revisions into changesets (within
> the 5 minute window), a single "consensus" commit time has to be chosen
> from all of the single-file commits.  Depending on how cvsps does this,
> it could be that the consensus commit times for two commits involving
> revisions within a single file are put back out of order (undoing your
> timestamp fixup).  It would be nice to verify that this does not result
> in out-of-order commits.

On file revisions cvsps corrects using this patch it will probably
happen that one change is broken into multiple patchsets. Because cvsps
issues warnings for every revision time it is changing the user can 
manually repair these rcs files.

cvsps keeps the minimum time of any member as the "consensus" time. So
the time correction backwards in time can result in out of order
commits. So it is not ensured that all commits compile. But it should be
ensured that all revisions of single files appear in the correct order.

As stated in the commit message this is not a "clean" solution but can
help to clean the imported repository and get correct revision ordering
on the main development line.

 cvsps.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/cvsps.c b/cvsps.c
index 81c6e21..1e72969 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -259,6 +259,45 @@ int main(int argc, char *argv[])
     exit(0);
 }
 
+void detect_and_repair_time_skew(const char *last_date, char *date, int n,
+                                 PatchSetMember *psm)
+{
+
+    time_t smaller;
+    time_t bigger;
+    struct tm *ts;
+    char *rev_end;
+
+    /* if last_date does not exist do nothing */
+    if (last_date[0] == '\0')
+        return;
+
+    /* TODO: repairing of branch times, skipping them for the moment */
+    /* check whether rev is of the form /1.[0-9]+/ */
+    if (psm->post_rev->rev[0] != '1' || psm->post_rev->rev[1] != '.')
+        return;
+    strtol(psm->post_rev->rev+2, &rev_end, 10);
+    if (*rev_end != '\0')
+        return;
+
+    /* important: because rlog is showing revisions backwards last_date should
+     * always be bigger than date */
+    convert_date(&bigger, last_date);
+    convert_date(&smaller, date);
+
+    if (difftime(bigger, smaller) <= 0) {
+        debug(DEBUG_APPMSG1, "broken revision date: %s -> %s file: %s, repairing.\n",
+              date, last_date, psm->file->filename);
+        if (!(bigger > 0)) {
+            debug(DEBUG_APPERROR, "timestamp underflow, exiting ... ");
+            exit(1);
+        }
+        smaller = bigger - 1;
+        ts = gmtime(&smaller);
+        strftime(date, n, "%Y-%m-%d %H:%M:%S", ts);
+    }
+}
+
 static void load_from_cvs()
 {
     FILE * cvsfp;
@@ -267,6 +306,7 @@ static void load_from_cvs()
     CvsFile * file = NULL;
     PatchSetMember * psm = NULL;
     char datebuff[20];
+    char last_datebuff[20];
     char authbuff[AUTH_STR_MAX];
     int logbufflen = LOG_STR_MAX + 1;
     char * logbuff = malloc(logbufflen);
@@ -334,6 +374,8 @@ static void load_from_cvs()
 	exit(1);
     }
 
+    /* initialize the last_datebuff with value indicating invalid date */
+    last_datebuff[0]='\0';
     for (;;)
     {
 	char * tst;
@@ -474,8 +516,14 @@ static void load_from_cvs()
 	    {
 		if (psm)
 		{
+		    detect_and_repair_time_skew(last_datebuff, datebuff, 20, psm);
 		    PatchSet * ps = get_patch_set(datebuff, logbuff, authbuff, psm->post_rev->branch, psm);
 		    patch_set_add_member(ps, psm);
+
+		    /* remember last revision */
+		    strncpy(last_datebuff, datebuff, 20);
+		    /* just to be sure */
+		    last_datebuff[19] = '\0';
 		}
 
 		logbuff[0] = 0;
@@ -487,8 +535,13 @@ static void load_from_cvs()
 	    {
 		if (psm)
 		{
+		    detect_and_repair_time_skew(last_datebuff, datebuff, 20, psm);
 		    PatchSet * ps = get_patch_set(datebuff, logbuff, authbuff, psm->post_rev->branch, psm);
 		    patch_set_add_member(ps, psm);
+
+		    /* just finished the last revision of this file, set last_datebuff to invalid */
+		    last_datebuff[0]='\0';
+
 		    assign_pre_revision(psm, NULL);
 		}
 
-- 
1.6.1.2.390.gba743
