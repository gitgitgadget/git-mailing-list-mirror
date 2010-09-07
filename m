From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] fast-export: ensure that a renamed file is printed after all references
Date: Tue, 7 Sep 2010 21:33:02 +0200
Message-ID: <201009072133.02930.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 21:33:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot3ux-0003Fj-Mj
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 21:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757890Ab0IGTdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 15:33:14 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:29292 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756502Ab0IGTdN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 15:33:13 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1798E1000F;
	Tue,  7 Sep 2010 21:33:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0D0C319F5C9;
	Tue,  7 Sep 2010 21:33:03 +0200 (CEST)
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155732>

t9350 sets up a commit where a file is both copied and renamed. The output
of fast-export for this commit should look like this:

  author ...
  committer ...
  from :19
  C "file2" "file4"
  R "file2" "file5"

The order of the two modification lines is derived from the result that
the diff machinery produces.

060df62 (fast-export: Fix output order of D/F changes) inserted a qsort
call that modifies the order of the diff result. Unfortunately, qsort need
not be stable. Therefore, it is possible that the 'R' line appears before
the 'C' line and the resulting fast-import stream is incorrect.

Fix it by forcing that the rename entry is printed after all other
modification lines with the same file name.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin/fast-export.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 965e90e..007bba6 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -166,7 +166,15 @@ static int depth_first(const void *a_, const void *b_)
 	cmp = memcmp(name_a, name_b, len);
 	if (cmp)
 		return cmp;
-	return (len_b - len_a);
+	cmp = len_b - len_a;
+	if (cmp)
+		return cmp;
+	/*
+	 * Move 'R'ename entries last so that all references of the file
+	 * appear in the output before it is renamed (e.g., when a file
+	 * was copied and renamed in the same commit).
+	 */
+	return (a->status == 'R') - (b->status == 'R');
 }
 
 static void show_filemodify(struct diff_queue_struct *q,
-- 
1.7.1.402.gf1eeb
