From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Exhibit merge bug that clobbers index&WT
Date: Sun, 22 Aug 2010 23:06:29 +0200
Message-ID: <49ac8bd95d88739f2fd9b37619ecf1c471b3a04f.1282510960.git.trast@student.ethz.ch>
References: <201008170945.31850.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 22 23:06:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnHkf-0006UC-Cn
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 23:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab0HVVGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 17:06:45 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54354 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab0HVVGo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 17:06:44 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 22 Aug
 2010 23:06:42 +0200
Received: from localhost.localdomain (129.132.208.152) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 22 Aug
 2010 23:06:34 +0200
X-Mailer: git-send-email 1.7.2.2.479.g07acc
In-Reply-To: <201008170945.31850.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154192>

Running git-merge on an unborn branch is supposed to do an index-level
merge with the other side, and then update the branch name there.  In
the common case where the index was empty at the start, this makes
'git pull otherrepo branch' a convenient way to populate the history
after 'git init'.

However, if the index was *not* empty, git-merge silently discards
*both index and worktree* copies of all files that were tracked,
leading to data loss.  Exhibit this bug.

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Here's a less lazy approach at a bug report.

I'm not too happy that noone went for a fix though; this is a real
data loss scenario and from his complaints on IRC, Dscho actually hit
it and had to reconstruct from the blobs.


 t/t7607-merge-overwrite.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index d82349a..ff08ebf 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -84,4 +84,20 @@ test_expect_success 'will not overwrite removed file with staged changes' '
 	test_cmp important c1.c
 '
 
+test_expect_success 'set up unborn branch and content' '
+	git symbolic-ref HEAD refs/heads/unborn &&
+	rm -f .git/index &&
+	echo foo > tracked-file &&
+	git add tracked-file &&
+	echo bar > untracked-file
+'
+
+test_expect_failure 'will not clobber WT/index when merging into unborn' '
+	git merge master &&
+	grep foo tracked-file &&
+	git show :tracked-file >expect &&
+	grep foo expect &&
+	grep bar untracked-file
+'
+
 test_done
-- 
1.7.2.2.479.g07acc
