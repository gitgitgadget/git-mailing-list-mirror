From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t4049: avoid test failures on filemode challenged file systems
 (Windows)
Date: Thu, 29 Nov 2012 09:22:11 +0100
Message-ID: <50B71B33.1090000@viscovery.net>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 09:22:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdzOF-0002VT-7f
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 09:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167Ab2K2IWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 03:22:20 -0500
Received: from so.liwest.at ([212.33.55.13]:11808 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab2K2IWT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 03:22:19 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TdzNs-00086F-CF; Thu, 29 Nov 2012 09:22:12 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 239181660F;
	Thu, 29 Nov 2012 09:22:12 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1354051310-29093-1-git-send-email-gitster@pobox.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210822>

From: Johannes Sixt <j6t@kdbg.org>

The earlier change 74faaa16 (Fix "git diff --stat" for interesting - but
empty - file changes) needed to change the count of differing files
because the executable-bit changes of two empty files are now counted.

On file systems that do not record the executable bit, however, the old
file count was actually correct (and the updated tests fail) because the
mode change cannot be diagnosed by looking at the file system alone.

Change the mode not only on the file system, but also in the index;
compare the new state against the commit, so that the tests do not depend
on the file system's ability to record the executable bit, when possible.

The exception is the test for unmerged entries, which does depend on the
file system; we have to skip it.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 11/27/2012 22:21, schrieb Junio C Hamano:
> It turns out that there are at least two bugs in the diffstat
> counting code.  This series comes on top of the earlier 74faaa1 (Fix
> "git diff --stat" for interesting - but empty - file changes,
> 2012-10-17) to fix them.

The tests still fail on Windows. I am not sure whether there is a
difference in comparing the file system against the index or a commit.
If there is, then the updated tests might not test the same thing.

-- Hannes

 t/t4049-diff-stat-count.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 37f50cd..9e29e71 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup' '
 
 test_expect_success 'limit output to 2 (simple)' '
 	git reset --hard &&
-	chmod +x c d &&
+	test_chmod +x c d &&
 	echo a >a &&
 	echo b >b &&
 	cat >expect <<-\EOF
@@ -24,13 +24,13 @@ test_expect_success 'limit output to 2 (simple)' '
 	 ...
 	 4 files changed, 2 insertions(+)
 	EOF
-	git diff --stat --stat-count=2 >actual &&
+	git diff --stat --stat-count=2 HEAD >actual &&
 	test_i18ncmp expect actual
 '
 
 test_expect_success 'binary changes do not count in lines' '
 	git reset --hard &&
-	chmod +x c d &&
+	test_chmod +x c d &&
 	echo a >a &&
 	echo b >b &&
 	cat "$TEST_DIRECTORY"/test-binary-1.png >d &&
@@ -40,11 +40,11 @@ test_expect_success 'binary changes do not count in lines' '
 	 ...
 	 4 files changed, 2 insertions(+)
 	EOF
-	git diff --stat --stat-count=2 >actual &&
+	git diff --stat --stat-count=2 HEAD >actual &&
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'exclude unmerged entries from total file count' '
+test_expect_success FILEMODE 'exclude unmerged entries from total file count' '
 	git reset --hard &&
 	echo a >a &&
 	echo b >b &&
-- 
1.8.0.1.1524.gaf6675c
