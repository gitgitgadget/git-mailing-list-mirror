From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/12] xmerge.c: "diff3 -m" style clips merge reduction level
 to EAGER or less
Date: Fri, 29 Aug 2008 17:42:35 -0700
Message-ID: <1220056963-2352-5-git-send-email-gitster@pobox.com>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
 <1220056963-2352-2-git-send-email-gitster@pobox.com>
 <1220056963-2352-3-git-send-email-gitster@pobox.com>
 <1220056963-2352-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 02:44:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEZs-00076v-Kc
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbYH3AnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752659AbYH3AnA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:43:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbYH3Am5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:42:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 345936DC08
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:42:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6B21C6DC07 for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:42:56
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.149.ga4c44
In-Reply-To: <1220056963-2352-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 96D34B6E-762C-11DD-B458-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94344>

When showing a conflicting merge result, and "--diff3 -m" style is asked
for, this patch makes sure that the merge reduction level does not exceed
XDL_MERGE_EAGER.  This is because "diff3 -m" style output would not make
sense for anything more aggressive than XDL_MERGE_EAGER, because of the
way how the merge reduction works.

"git merge-file" no longer has to force MERGE_EAGER when "--diff3" is
asked for because of this change.

Suppose a common ancestor (shared preimage) is modified to postimage #1
and #2 (each letter represents one line):

                     #####
    postimage#1: 1234ABCDE789
                    |    /
                    |   /
    preimage:    123456789
                    |   \
    postimage#2: 1234AXYE789
                     ####

XDL_MERGE_MINIMAL and XDL_MERGE_EAGER would:

 (1) find the s/56/ABCDE/ done on one side and s/56/AXYE/ done on the
     other side,

 (2) notice that they touch an overlapping area, and

 (3) mark it as a conflict, "ABCDE vs AXYE".

The difference between the two algorithms is that EAGER drops the hunk
altogether if the postimages match (i.e. both sides modified the same
way), while MINIMAL keeps it.  There is no other operation performed to
the hunk.  As the result, lines marked with "#" in the above picure will
be in the RCS merge style output like this (letters <, = and > represent
conflict marker lines):

    output:      1234<ABCDE=AXYE>789    ; with MINIMAL/EAGER

The part from the preimage that corresponds to these conflicting changes
is "56", which is what "diff3 -m" style output adds to it:

    output:      1234<ABCDE|56=AXYE>789 ; in "diff3 -m" style

Now, XDL_MERGE_ZEALOUS looks at the differences between the changes two
postimages made in order to reduce the number of lines in the conflicting
regions.  It notices that both sides start their new contents with "A",
and excludes it from the output (it also excludes "E" for the same
reason).  The conflict that used to be "ABCDE vs AXYE" is now "BCD vs XY":

    output:      1234A<BCD=XY>E789      ; with ZEALOUS

There could even be matching parts between two postimages in the middle.
Instead of one side rewriting the shared "56" to "ABCDE" and the other
side to "AXYE", imagine the case where the postimages are "ABCDE" and
"AXCYE", in which case instead of having one conflicted hunk "BCD vs XY",
you would have two conflicting hunks "B vs X" and "D vs Y".

In either case, once you reduce "ABCDE vs AXYE" to "BCD vs XY" (or "ABCDE
vs AXCYE" to "B vs X" and "D vs Y"), there is no part from the preimage
that corresponds to the conflicting change made in both postimages
anymore.  In other words, conflict reduced by ZEALOUS algorithm cannot be
expressed in "diff3 -m" style.  Representing the last illustration like
this is misleading to say the least:

    output:      1234A<BCD|56=XY>E789   ; broken "diff3 -m" style

because the preimage was not ...4A56E... to begin with.  "A" and "E" are
common only between the postimages.

Even worse, once a single conflicting hunk is split into multiple ones
(recall the example of breaking "ABCDE vs AXCYE" to "B vs X" and "D vs
Y"), there is no sane way to distribute the preimage text across split
conflicting hunks.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-merge-file.c |    4 +---
 xdiff/xmerge.c       |    9 +++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 5b4f020..1e92510 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -27,10 +27,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "-q") ||
 				!strcmp(argv[1], "--quiet"))
 			freopen("/dev/null", "w", stderr);
-		else if (!strcmp(argv[1], "--diff3")) {
+		else if (!strcmp(argv[1], "--diff3"))
 			merge_style = XDL_MERGE_DIFF3;
-			merge_level = XDL_MERGE_EAGER;
-		}
 		else
 			usage(merge_file_usage);
 		argc--;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 7dcd405..d9737f0 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -392,6 +392,15 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	int level = flags & XDL_MERGE_LEVEL_MASK;
 	int style = flags & XDL_MERGE_STYLE_MASK;
 
+	if (style == XDL_MERGE_DIFF3) {
+		/*
+		 * "diff3 -m" output does not make sense for anything
+		 * more aggressive than XDL_MERGE_EAGER.
+		 */
+		if (XDL_MERGE_EAGER < level)
+			level = XDL_MERGE_EAGER;
+	}
+
 	c = changes = NULL;
 
 	while (xscr1 && xscr2) {
-- 
1.6.0.1.149.ga4c44
