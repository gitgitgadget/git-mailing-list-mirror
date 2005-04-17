From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Do not run useless show-diff on unmerged paths repeatedly.
Date: Sat, 16 Apr 2005 19:18:02 -0700
Message-ID: <7vis2m2lk5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 04:14:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMzIu-00062p-OJ
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 04:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVDQCSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 22:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVDQCSO
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 22:18:14 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:32956 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261234AbVDQCSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 22:18:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417021803.NVMN9923.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 22:18:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When run on unmerged dircache, show-diff compares the working
file with each non-empty stage for that path.  Two out of three
times, this is not very helpful.  This patch makes it report the
unmergedness only once per each path and avoids running the
actual diff.

Upper layer SCMs like Cogito are expected to find out mode/SHA1
for each stage by using "show-files --stage" and run the diff
itself.  This would result in more sensible diffs.

To be applied on top of my previous patches:

    [PATCH] Optionally tell show-diff to show only named files.
    [PATCH] show-diff -z option for machine readable output.
    [PATCH] show-diff shell safety.
    [PATCH] (take 2) Rename confusing variable in show-diff.
    [PATCH] show-diff style fix.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 ++show-diff.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

--- ./show-diff.c	2005-04-16 19:01:28.000000000 -0700
+++ ./++show-diff.c	2005-04-16 18:57:55.000000000 -0700
@@ -167,6 +167,19 @@
 		    ! matches_pathspec(ce, argv+1, argc-1))
 			continue;
 
+		if (ce_stage(ce)) {
+			if (machine_readable)
+				printf("U %s%c", ce->name, 0);
+			else
+				printf("%s: Unmerged\n",
+				       ce->name);
+			while (i < entries &&
+			       !strcmp(ce->name, active_cache[i]->name))
+				i++;
+			i--; /* compensate for loop control increments */
+			continue;
+		}
+ 
 		if (stat(ce->name, &st) < 0) {
 			if (errno == ENOENT && silent_on_nonexisting_files)
 				continue;

