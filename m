From: Greg Brockman <gdb@MIT.EDU>
Subject: [RFC/PATCH] Add test case for dealing with a tracked file in an ignored directory
Date: Wed, 18 Aug 2010 04:29:48 -0500
Message-ID: <1282123788-24055-1-git-send-email-gdb@mit.edu>
References: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
Cc: Greg Brockman <gdb@mit.edu>
To: avarab@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
	jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 18 11:30:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OleyY-000287-1w
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 11:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369Ab0HRJaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 05:30:20 -0400
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:58287 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237Ab0HRJaT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 05:30:19 -0400
X-AuditID: 12074425-b7bfeae000000a0d-c1-4c6ba82444da
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id 86.58.02573.428AB6C4; Wed, 18 Aug 2010 05:30:12 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o7I9UHeX015953;
	Wed, 18 Aug 2010 05:30:17 -0400
Received: from localhost (97-112-206-188.frgo.qwest.net [97.112.206.188])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7I9UCLs011509;
	Wed, 18 Aug 2010 05:30:15 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.1.68.g1ba78
In-Reply-To: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153822>

This test case attempts to match the behavior of 'git add ignore-file'
with 'git add ignore-dir/file' when .gitignore contains entries for
ignore-file and ignore-dir.
---
 t/t3700-add.sh |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

This patch is a follow-up to the thread '[RFC/PATCH] git-add: Don't
exclude explicitly-specified tracked files' at

  http://thread.gmane.org/gmane.comp.version-control.git/153194

In this patch, I propose the desired behavior of 'git add' for files
contained in ignored directories.  I have attempted to mirror the
behavior of 'git add' for ignored files, but I may have gotten that
wrong or that might not actually be what we want here.  Comments on
whether this is the desired behavior and whether these test-cases
accurate capture that behavior would be appreciated.

Thank you,

Greg

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 7d7140d..97ba9e9 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -288,4 +288,34 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file' '
 	test_cmp expect.err actual.err
 '
 
+cat >expect <<EOF
+The following paths are ignored by one of your .gitignore files:
+ignored-dir
+Use -f if you really want to add them.
+fatal: no files added
+EOF
+
+test_expect_success 'git add with file in ignored directory' '
+	mkdir ignored-dir &&
+	echo ignored-dir >> .gitignore &&
+	touch ignored-dir/file &&
+	test_must_fail git add ignored-dir/file >actual 2>&1 &&
+	test_cmp actual expect &&
+	git add -f ignored-dir/file &&
+	git add ignored-dir/file &&
+	echo change > ignored-dir/file &&
+	git add ignored-dir/file &&
+	! ( git ls-files -m ignored-dir/file | grep ignored-dir/file )
+'
+
+test_expect_success 'git add with ignored directory using git globs' "
+	mkdir ignored-dir2 && echo ignored-dir2 >> .gitignore && touch ignored-dir2/file &&
+	git add 'ignored-dir2/*' >actual 2>&1 &&
+	echo \"fatal: pathspec 'ignored-dir2/*' did not match any files\" | test_cmp - actual
+	git add -f ignored-dir2/file && echo change > ignored-dir2/file &&
+	git add 'ignored-dir2/*' >actual 2>&1 &&
+	echo '' | test_cmp - actual &&
+	git ls-files -m ignored-dir2/file | grep ignored-dir2/file
+"
+
 test_done
-- 
1.7.2.1.68.g1ba78
