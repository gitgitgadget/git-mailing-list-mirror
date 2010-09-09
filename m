From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] t/t5510-fetch.sh: improve testing with explicit URL and merge spec
Date: Thu,  9 Sep 2010 13:56:37 -0500
Message-ID: <NYNWO-6R8khWRYvZHfeUgZWw3DJpqSnrL38KkBJYm9iti69nWEX9zBwCvwiTEGTR8e9aY62V_L8@cipher.nrlssc.navy.mil>
References: <7vtymipddv.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 09 20:57:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmJm-0003g2-W1
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 20:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab0IIS5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 14:57:50 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40127 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab0IIS5t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 14:57:49 -0400
Received: by mail.nrlssc.navy.mil id o89Ius3e001247; Thu, 9 Sep 2010 13:56:54 -0500
In-Reply-To: <7vtymipddv.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 09 Sep 2010 18:56:54.0499 (UTC) FILETIME=[C51FC330:01CB5050]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155877>

From: Brandon Casey <drafnel@gmail.com>

Commit 6106ce46 introduced a test to demonstrate fetch's failure to
retrieve any objects or update FETCH_HEAD when it was supplied a repository
URL and the current branch had a configured merge spec.  This commit
expands the original test based on comments from Junio Hamano.  In addition
to actually verifying that the fetch updates FETCH_HEAD correctly, and does
not update the current branch, two more tests are added to ensure that the
merge configuration is ignored even when the supplied URL matches the URL
of the remote configured for the branch.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t5510-fetch.sh |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 8fbd894..efb42d1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -240,10 +240,36 @@ test_expect_success 'fetch with a non-applying branch.<name>.merge' '
 	git fetch blub
 '
 
-test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge' '
+# URL supplied to fetch does not match the url of the configured branch's remote
+test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge [1]' '
+	one_head=$(cd one && git rev-parse HEAD) &&
+	this_head=$(git rev-parse HEAD) &&
 	git update-ref -d FETCH_HEAD &&
 	git fetch one &&
-	git rev-parse --verify FETCH_HEAD
+	test $one_head = "$(git rev-parse --verify FETCH_HEAD)" &&
+	test $this_head = "$(git rev-parse --verify HEAD)"
+'
+
+# URL supplied to fetch matches the url of the configured branch's remote and
+# the merge spec matches the branch the remote HEAD points to
+test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge [2]' '
+	one_ref=$(cd one && git symbolic-ref HEAD) &&
+	git config branch.master.remote blub &&
+	git config branch.master.merge "$one_ref" &&
+	git update-ref -d FETCH_HEAD &&
+	git fetch one &&
+	test $one_head = "$(git rev-parse --verify FETCH_HEAD)" &&
+	test $this_head = "$(git rev-parse --verify HEAD)"
+'
+
+# URL supplied to fetch matches the url of the configured branch's remote, but
+# the merge spec does not match the branch the remote HEAD points to
+test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge [3]' '
+	git config branch.master.merge "${one_ref}_not" &&
+	git update-ref -d FETCH_HEAD &&
+	git fetch one &&
+	test $one_head = "$(git rev-parse --verify FETCH_HEAD)" &&
+	test $this_head = "$(git rev-parse --verify HEAD)"
 '
 
 # the strange name is: a\!'b
-- 
1.7.2.1
