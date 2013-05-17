From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] difftool: fix dir-diff when file does not exist in working tree
Date: Fri, 17 May 2013 18:29:37 +0100
Message-ID: <de6690bea81de561747ca49893fbc77fa3eb8529.1368811736.git.john@keeping.me.uk>
Cc: Kevin Bracey <kevin@bracey.fi>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 17 19:29:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOTb-0004xm-Na
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756463Ab3EQR3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:29:51 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:48769 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756372Ab3EQR3v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:29:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 60A436064FA;
	Fri, 17 May 2013 18:29:50 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZSoy9SnGawbd; Fri, 17 May 2013 18:29:49 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 1DB2F60650A;
	Fri, 17 May 2013 18:29:42 +0100 (BST)
X-Mailer: git-send-email 1.8.3.rc2.285.gfc18c2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224719>

Commit 02c5631 (difftool --dir-diff: symlink all files matching the
working tree, 2013-03-14) does not handle the case where a file that is
being compared does not exist in the working tree.  Fix this by checking
for existence explicitly before running git-hash-object.

Reported-by: Kevin Bracey <kevin@bracey.fi>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
This fixes a regression in 1.8.3-rc0.

 git-difftool.perl   | 9 ++++++++-
 t/t7800-difftool.sh | 7 +++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 6780292..0a1cb0a 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -92,7 +92,14 @@ sub use_wt_file
 		return 0;
 	}
 
-	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
+	my $wt_sha1;
+	if (-e "$workdir/$file") {
+		$wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
+	} else {
+		# If the file doesn't exist in the working tree, use something
+		# that cannot match a SHA-1.
+		$wt_sha1 = '';
+	};
 	my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
 	return ($use, $wt_sha1);
 }
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index a6bd99e..d46f041 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -356,6 +356,13 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory' '
 	)
 '
 
+run_dir_diff_test 'difftool --dir-diff when worktree file is missing' '
+	test_when_finished git reset --hard &&
+	rm file2 &&
+	git difftool --dir-diff $symlinks --extcmd ls branch master >output &&
+	grep file2 output
+'
+
 write_script .git/CHECK_SYMLINKS <<\EOF
 for f in file file2 sub/sub
 do
-- 
1.8.3.rc2.285.gfc18c2c
