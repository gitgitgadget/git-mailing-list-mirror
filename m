From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Demonstrate breakage: checkout overwrites untracked symlink with directory
Date: Sat, 5 Feb 2011 19:18:44 +0100
Message-ID: <201102051918.44848.j6t@kdbg.org>
References: <201102022025.06140.j6t@kdbg.org> <7v7hdixkys.fsf@alter.siamese.dyndns.org> <201102022324.22123.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Feb 05 19:18:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plmii-0002Lq-Ia
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 19:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab1BESSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 13:18:49 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:17851 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753273Ab1BESSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 13:18:48 -0500
X-Greylist: delayed 71556 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Feb 2011 13:18:47 EST
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BF0702C4005;
	Sat,  5 Feb 2011 19:18:45 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 87D1919F5AA;
	Sat,  5 Feb 2011 19:18:45 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201102022324.22123.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166105>

This adds tests where an untracked file and an untracked symlink are in the
way where a directory should be created by 'git checkout'. Commit b1735b1a
(do not overwrite files in leading path, 2010-12-14) fixed the case where
a file is in the way, but the untracked symlink is still removed silently.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
On Mittwoch, 2. Februar 2011, Johannes Sixt wrote:
> It seems to interact with the lstat_cache. When lstat
> reports a symlink, this result is cached; but if it is a regular file, it
> is not cached.

The case where a file is in the way was fixed only in v1.7.3.4, but symlinks
are still affected. Clemens, can you help?

-- Hannes

PS: When a date is given for commit reference in a commit message as above,
do you prefer the author date or the committer date? Above, I took the
committer date, which is 2 months behind the author date.

 t/t2019-checkout-overwrite.sh |   50 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100755 t/t2019-checkout-overwrite.sh

diff --git a/t/t2019-checkout-overwrite.sh b/t/t2019-checkout-overwrite.sh
new file mode 100755
index 0000000..e4e529d
--- /dev/null
+++ b/t/t2019-checkout-overwrite.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='checkout must not overwrite an untracked objects'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	mkdir -p a/b/c &&
+	>a/b/c/d &&
+	git add -A &&
+	git commit -m base &&
+	git tag start
+'
+
+test_expect_success 'create a commit where dir a/b changed to file' '
+
+	git checkout -b file &&
+	rm -rf a/b &&
+	>a/b &&
+	git add -A &&
+	git commit -m "dir to file"
+'
+
+test_expect_success 'checkout commit with dir must not remove untracked a/b' '
+
+	git rm --cached a/b &&
+	git commit -m "un-track the file" &&
+	test_must_fail git checkout start &&
+	test -f a/b
+'
+
+test_expect_success 'create a commit where dir a/b changed to symlink' '
+
+	rm -rf a/b &&	# cleanup if previous test failed
+	git checkout -f -b symlink start &&
+	rm -rf a/b &&
+	ln -s foo a/b &&
+	git add -A &&
+	git commit -m "dir to symlink"
+'
+
+test_expect_failure 'checkout commit with dir must not remove untracked a/b' '
+
+	git rm --cached a/b &&
+	git commit -m "un-track the symlink" &&
+	test_must_fail git checkout start &&
+	test -h a/b
+'
+
+test_done
-- 
1.7.4.80.g89060
