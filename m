From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git status: Fix false positive "new commits" output for dirty
 submodules
Date: Thu, 11 Mar 2010 16:19:18 +0100
Message-ID: <4B9909F6.5090104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 16:19:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpkAa-0001V2-6z
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 16:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035Ab0CKPTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 10:19:22 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:47702 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933039Ab0CKPTU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 10:19:20 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 43DD3143A243D;
	Thu, 11 Mar 2010 16:19:19 +0100 (CET)
Received: from [80.128.124.167] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NpkAR-00051Q-00; Thu, 11 Mar 2010 16:19:19 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18PnkYcbQWWdTt7qh4Sj6yMWkXNty0dDLQp4YK+
	AqMW57AlNSm7aknfwshyuye+bWjW9a2FhnSzzmve5YAjaAG5uP
	drDZwnq+V13CCh5go4VA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141980>

Testing if the output "new commits" should appear in the long format of
"git status" was done by comparing the hashes of the diffpair. This always
resulted in printing "new commits" for submodules that contained untracked
or modified content, no matter if they also contained new commits. The
reason was that the two->sha1 is always the null_sha1 when diffing against
the work tree. This patch gets the correct ref to compare against by
calling resolve_gitlink_ref(.., "HEAD", ..).

Unfortunately the test case that should have found this bug had been
changed incorrectly too. It is fixed and extended to test for other
combinations too.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Another way to fix this bug would have been to enter the correct sha1
into two->sha1 for submodules with new commits. But i am not sure about
the side effects such a change would have and thus fixed it this way so
it could not hit anyone else.


 t/t7506-status-submodule.sh |   84 +++++++++++++++++++++++++++++++++++++++++--
 wt-status.c                 |    9 ++++-
 2 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 1c8d32a..dc9150a 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -34,7 +34,7 @@ test_expect_success 'status with modified file in submodule' '
 	(cd sub && git reset --hard) &&
 	echo "changed" >sub/foo &&
 	git status >output &&
-	grep "modified:   sub (new commits, modified content)" output
+	grep "modified:   sub (modified content)" output
 '

 test_expect_success 'status with modified file in submodule (porcelain)' '
@@ -49,7 +49,7 @@ test_expect_success 'status with modified file in submodule (porcelain)' '
 test_expect_success 'status with added file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
-	grep "modified:   sub (new commits, modified content)" output
+	grep "modified:   sub (modified content)" output
 '

 test_expect_success 'status with added file in submodule (porcelain)' '
@@ -64,7 +64,7 @@ test_expect_success 'status with untracked file in submodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	grep "modified:   sub (new commits, untracked content)" output
+	grep "modified:   sub (untracked content)" output
 '

 test_expect_success 'status with untracked file in submodule (porcelain)' '
@@ -74,6 +74,84 @@ test_expect_success 'status with untracked file in submodule (porcelain)' '
 	EOF
 '

+test_expect_success 'status with added and untracked file in submodule' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	echo "content" >sub/new-file &&
+	git status >output &&
+	grep "modified:   sub (modified content, untracked content)" output
+'
+
+test_expect_success 'status with added and untracked file in submodule (porcelain)' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	echo "content" >sub/new-file &&
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
+test_expect_success 'status with modified file in modified submodule' '
+	(cd sub && git reset --hard) &&
+	rm sub/new-file &&
+	(cd sub && echo "next change" >foo && git commit -m "next change" foo) &&
+	echo "changed" >sub/foo &&
+	git status >output &&
+	grep "modified:   sub (new commits, modified content)" output
+'
+
+test_expect_success 'status with modified file in modified submodule (porcelain)' '
+	(cd sub && git reset --hard) &&
+	echo "changed" >sub/foo &&
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
+test_expect_success 'status with added file in modified submodule' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	git status >output &&
+	grep "modified:   sub (new commits, modified content)" output
+'
+
+test_expect_success 'status with added file in modified submodule (porcelain)' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
+test_expect_success 'status with untracked file in modified submodule' '
+	(cd sub && git reset --hard) &&
+	echo "content" >sub/new-file &&
+	git status >output &&
+	grep "modified:   sub (new commits, untracked content)" output
+'
+
+test_expect_success 'status with untracked file in modified submodule (porcelain)' '
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
+test_expect_success 'status with added and untracked file in modified submodule' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	echo "content" >sub/new-file &&
+	git status >output &&
+	grep "modified:   sub (new commits, modified content, untracked content)" output
+'
+
+test_expect_success 'status with added and untracked file in modified submodule (porcelain)' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	echo "content" >sub/new-file &&
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
 test_expect_success 'rm submodule contents' '
 	rm -rf sub/* sub/.git
 '
diff --git a/wt-status.c b/wt-status.c
index e0e915e..d5d23de 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "run-command.h"
 #include "remote.h"
+#include "refs.h"

 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -238,8 +239,12 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		if (!d->worktree_status)
 			d->worktree_status = p->status;
 		d->dirty_submodule = p->two->dirty_submodule;
-		if (S_ISGITLINK(p->two->mode))
-			d->new_submodule_commits = !!hashcmp(p->one->sha1, p->two->sha1);
+		if (S_ISGITLINK(p->two->mode)) {
+			unsigned char sha1[20];
+
+			if (resolve_gitlink_ref(p->two->path, "HEAD", sha1) == 0)
+				d->new_submodule_commits = !!hashcmp(p->one->sha1, sha1);
+		}
 	}
 }

-- 
1.7.0.2.387.g275c3b
