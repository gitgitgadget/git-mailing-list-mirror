From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 05/37] t6022: Add tests for reversing order of merges when D/F conflicts present
Date: Mon, 20 Sep 2010 02:28:38 -0600
Message-ID: <1284971350-30590-6-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjP-0005rH-KK
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779Ab0ITI1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:27:42 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37157 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab0ITI1l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:41 -0400
Received: by pvg2 with SMTP id 2so1071833pvg.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=R6KuqSDiKPICgYaOSw/0qvj3LVSVmCfVzRPwDa7GUvs=;
        b=xKWBNOMT0xtqylXzM4cm2LouCxjybJofVrkz49LIPG1TReTnDdnNYFJcsMa3m6Lz6v
         mhC4cI08vXz29kiw4tambdsAPGcvl/ISMaDNaG1yiy0VksqvBlej1dHO4RcOVDUbtcNJ
         6l71lYbGZoRVfxaXK5SRoo+UQj6fUYkBJwUPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ct1i/xgfKk7LrQYCR9QsXJMTD38Kcj10tee1oE1HjZ/xwYqFpsXmiP+1E8ZbdcUIgh
         ORN85S/bv3xmIeAcesJDTRbFS4XYEDPLKdVW5di0IDIqB/F0/tkX/X6cBXLOJIB8fG8E
         85F96uCMCsnZcnBESlTV0067RP4pt7GmJbwzs=
Received: by 10.142.141.12 with SMTP id o12mr7350462wfd.280.1284971260922;
        Mon, 20 Sep 2010 01:27:40 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156561>

When merging two branches with some path involved in a D/F conflict, the
choice of which branch to merge into the other matters for (at least) two
reasons: (1) whether the working copy has a directory full of files that
is in the way of a file, or a file exists that is in the way of a
directory of files, (2) when the directory full of files does not disappear
due to the merge, what files at the same paths should be renamed to
(e.g. filename~HEAD vs. filename~otherbranch).

Add some tests that reverse the merge order of two other tests, and which
verify the contents are as expected (namely, that the results are identical
other than modified-for-uniqueness filenames involving branch names).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6022-merge-rename.sh |   58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index a992206..2839dfb 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -415,6 +415,28 @@ test_expect_failure 'Rename+D/F conflict; renamed file merges but dir in way' '
 	test_cmp expected dir~HEAD
 '
 
+test_expect_failure 'Same as previous, but merged other way' '
+	git reset --hard &&
+	rm -rf dir~* &&
+	git checkout -q dir-in-way^0 &&
+	test_must_fail git merge --strategy=recursive renamed-file-has-no-conflicts >output 2>errors &&
+
+	! grep "error: refusing to lose untracked file at" errors &&
+	grep "CONFLICT (delete/modify): dir/file-in-the-way" output &&
+	grep "Auto-merging dir" output &&
+	grep "Adding as dir~renamed-file-has-no-conflicts instead" output &&
+
+	test 2 = "$(git ls-files -u | wc -l)" &&
+	test 2 = "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+
+	test_must_fail git diff --quiet &&
+	test_must_fail git diff --cached --quiet &&
+
+	test -f dir/file-in-the-way &&
+	test -f dir~renamed-file-has-no-conflicts &&
+	test_cmp expected dir~renamed-file-has-no-conflicts
+'
+
 cat >expected <<\EOF &&
 1
 2
@@ -469,4 +491,40 @@ test_expect_failure 'Rename+D/F conflict; renamed file cannot merge and dir in t
 	test_cmp expected dir~HEAD
 '
 
+cat >expected <<\EOF &&
+1
+2
+3
+4
+5
+6
+7
+8
+9
+10
+<<<<<<< HEAD
+11
+=======
+12
+>>>>>>> renamed-file-has-conflicts
+EOF
+
+test_expect_failure 'Same as previous, but merged other way' '
+	git reset --hard &&
+	rm -rf dir~* &&
+	git checkout -q dir-in-way^0 &&
+	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
+
+	test 5 = "$(git ls-files -u | wc -l)" &&
+	test 3 = "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)" &&
+	test 2 = "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+
+	test_must_fail git diff --quiet &&
+	test_must_fail git diff --cached --quiet &&
+
+	test -f dir/file-in-the-way &&
+	test -f dir~renamed-file-has-conflicts &&
+	test_cmp expected dir~renamed-file-has-conflicts
+'
+
 test_done
-- 
1.7.3.271.g16009
