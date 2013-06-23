From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/4] t9300: document fast-import empty path issues
Date: Sun, 23 Jun 2013 15:58:19 +0100
Message-ID: <79532d59f0480a07ceb7c11e31bcd793c12122d6.1371999369.git.john@keeping.me.uk>
References: <cover.1371999369.git.john@keeping.me.uk>
Cc: Dave Abrahams <dave@boostpro.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 23 16:58:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqlkj-00011y-O8
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 16:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682Ab3FWO6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 10:58:49 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:60776 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3FWO6s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 10:58:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 7BEDC198001;
	Sun, 23 Jun 2013 15:58:46 +0100 (BST)
X-Quarantine-ID: <Uqg3OnTZiiav>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uqg3OnTZiiav; Sun, 23 Jun 2013 15:58:45 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id A186E6064E3;
	Sun, 23 Jun 2013 15:58:45 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 767F2161E3F1;
	Sun, 23 Jun 2013 15:58:45 +0100 (BST)
X-Quarantine-ID: <oMEYtdEfyMhe>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oMEYtdEfyMhe; Sun, 23 Jun 2013 15:58:44 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 68BFA161E361;
	Sun, 23 Jun 2013 15:58:34 +0100 (BST)
X-Mailer: git-send-email 1.8.3.1.676.gaae6535
In-Reply-To: <cover.1371999369.git.john@keeping.me.uk>
In-Reply-To: <cover.1371999369.git.john@keeping.me.uk>
References: <cover.1371999369.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228742>

When given an empty path, fast-import sometimes reports "missing"
instead of using the root tree object.  On top of this, for "ls" and
file copy (but not move) it dies with "Empty path component found in
input".

Document this behaviour with failing test cases.

Reported-by: Dave Abrahams <dave@boostpro.com>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t9300-fast-import.sh | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ac6f3b6..f4b9355 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1031,6 +1031,32 @@ test_expect_success \
 	 git diff-tree -M -r M3^ M3 >actual &&
 	 compare_diff_raw expect actual'
 
+cat >input <<INPUT_END
+commit refs/heads/M4
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+rename root
+COMMIT
+
+from refs/heads/M2^0
+R "" sub
+
+INPUT_END
+
+cat >expect <<EOF
+:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 R100	file2/oldf	sub/file2/oldf
+:100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 R100	file4	sub/file4
+:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	sub/i/am/new/to/you
+:100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 R100	newdir/exec.sh	sub/newdir/exec.sh
+:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 R100	newdir/interesting	sub/newdir/interesting
+EOF
+test_expect_failure \
+	'M: rename root to subdirectory' \
+	'git fast-import <input &&
+	 git diff-tree -M -r M4^ M4 >actual &&
+	 cat actual &&
+	 compare_diff_raw expect actual'
+
 ###
 ### series N
 ###
@@ -1227,6 +1253,29 @@ test_expect_success \
 	 git diff-tree -C --find-copies-harder -r N4 N6 >actual &&
 	 compare_diff_raw expect actual'
 
+test_expect_failure \
+	'N: copy root by path' \
+	'cat >expect <<-\EOF &&
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	oldroot/file2/newf
+	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	oldroot/file2/oldf
+	:100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 C100	file4	oldroot/file4
+	:100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 C100	newdir/exec.sh	oldroot/newdir/exec.sh
+	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	oldroot/newdir/interesting
+	EOF
+	 cat >input <<-INPUT_END &&
+	commit refs/heads/N-copy-root-path
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	copy root directory by (empty) path
+	COMMIT
+
+	from refs/heads/branch^0
+	C "" oldroot
+	INPUT_END
+	 git fast-import <input &&
+	 git diff-tree -C --find-copies-harder -r branch N-copy-root-path >actual &&
+	 compare_diff_raw expect actual'
+
 test_expect_success \
 	'N: delete directory by copying' \
 	'cat >expect <<-\EOF &&
@@ -2934,4 +2983,20 @@ test_expect_success 'S: ls with garbage after sha1 must fail' '
 	test_i18ngrep "space after tree-ish" err
 '
 
+###
+### series T (ls)
+###
+# Setup is carried over from series S.
+
+test_expect_failure 'T: ls root tree' '
+	sed -e "s/Z\$//" >expect <<-EOF &&
+	040000 tree $(git rev-parse S^{tree})	Z
+	EOF
+	sha1=$(git rev-parse --verify S) &&
+	git fast-import --import-marks=marks <<-EOF >actual &&
+	ls $sha1 ""
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.3.1.676.gaae6535
