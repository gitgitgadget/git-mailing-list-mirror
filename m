From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] merge-recursive: handle file mode changes
Date: Thu, 13 Mar 2008 23:47:41 +0100
Message-ID: <20080313224741.GA5000@localhost>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site> <20080313192246.GA30361@localhost> <alpine.LSU.1.00.0803132216580.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 23:48:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZwDk-000166-TA
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 23:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbYCMWrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 18:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753021AbYCMWrl
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 18:47:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:56812 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbYCMWrk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 18:47:40 -0400
Received: by ug-out-1314.google.com with SMTP id z38so567857ugc.16
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 15:47:36 -0700 (PDT)
Received: by 10.66.251.3 with SMTP id y3mr1897053ugh.88.1205448456787;
        Thu, 13 Mar 2008 15:47:36 -0700 (PDT)
Received: from darc.dyndns.org ( [88.117.96.248])
        by mx.google.com with ESMTPS id g30sm8361946ugd.54.2008.03.13.15.47.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Mar 2008 15:47:35 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1JZwD7-0002cy-EU; Thu, 13 Mar 2008 23:47:41 +0100
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803132216580.4174@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77143>

Handle file mode changes similarly to changes of content. If the file mode
changed in only one branch, keep the changed version. If the file mode
changed in both branches, prompt the user to choose one by reporting a
conflict.

This also fixes a bug which caused the merge to fail if the merged files were
empty.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Hi,

On Thu, Mar 13, 2008 at 10:17:07PM +0100, Johannes Schindelin wrote:
> If the modes are different, the merge is not clean.

If the mode has only changed in either the head or the remote tree, I believe
we should keep the changed version without conflict - just like we do for
non-overlapping changes of content.

If, however, both files changed in a different way, we report a conflict and
keep the remote version by default. I based this decision on the assumption
that the user is more likely to have acknowledged the head branch, while he may
want to think about whether or not the change in the remote version is ok.

I cleaned up the code a bit and added a comment, so I hope the behavior is
clearer now.

> The point is not that they are empty.  Maybe you want to fix that message.

Indeed.

I am not exactly sure how I should set the result.merge flag. In this context
it seems to have the exact opposite meaning of result.clean. Is that correct?

Regards,
Clemens

 merge-recursive.c          |   21 ++++++++++++++++-----
 t/t6031-merge-recursive.sh |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 5 deletions(-)
 create mode 100755 t/t6031-merge-recursive.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index 34e3167..d8938cc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1025,12 +1025,21 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 			hashcpy(result.sha, b->sha1);
 		}
 	} else {
-		if (!sha_eq(a->sha1, o->sha1) && !sha_eq(b->sha1, o->sha1))
-			result.merge = 1;
-
-		result.mode = a->mode == o->mode ? b->mode: a->mode;
+		/*
+		 * If mode changed in only one branch, keep the changed
+		 * version. Otherwise, keep remote version and create a
+		 * conflict.
+		 */
+		if (a->mode != o->mode && b->mode != o->mode &&
+				a->mode != b->mode) {
+			result.clean = 0;
+			result.mode = b->mode;
+		} else
+			result.mode = o->mode == a->mode ? b->mode : a->mode;
 
-		if (sha_eq(a->sha1, o->sha1))
+		if (sha_eq(a->sha1, b->sha1))
+			hashcpy(result.sha, b->sha1);
+		else if (sha_eq(a->sha1, o->sha1))
 			hashcpy(result.sha, b->sha1);
 		else if (sha_eq(b->sha1, o->sha1))
 			hashcpy(result.sha, a->sha1);
@@ -1062,6 +1071,8 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 		} else {
 			die("unsupported object type in the tree");
 		}
+
+		result.merge = !result.clean;
 	}
 
 	return result;
diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
new file mode 100755
index 0000000..36cd664
--- /dev/null
+++ b/t/t6031-merge-recursive.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='merge-recursive: handle file mode'
+. ./test-lib.sh
+
+test_expect_success 'mode change in one branch: keep changed version' '
+	: >file1 &&
+	git add file1 &&
+	git commit -m initial &&
+	git checkout -b a1 master &&
+	: >dummy &&
+	git add dummy &&
+	git commit -m a &&
+	git checkout -b b1 master &&
+	chmod +x file1 &&
+	git add file1 &&
+	git commit -m b1 &&
+	git checkout a1 &&
+	git merge-recursive master -- a1 b1 &&
+	test -x file1
+'
+
+test_expect_success 'mode change in both branches: expect conflict' '
+	git reset --hard HEAD &&
+	git checkout -b a2 master &&
+	: >file2 &&
+	chmod +x file2 &&
+	git add file2 &&
+	git commit -m a2 &&
+	git checkout -b b2 master &&
+	: >file2 &&
+	git add file2 &&
+	git commit -m b2 &&
+	git checkout a2 &&
+	! (git merge-recursive master -- a2 b2 || test $? -ne 1) &&
+	! test -x file2
+'
+
+test_done
-- 
1.5.4.4
