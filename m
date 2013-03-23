From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 3/3] t7800: run --dir-diff tests with and without symlinks
Date: Sat, 23 Mar 2013 13:31:41 +0000
Message-ID: <cf71cc8757c7cb59e93d762fba922635c077376d.1364045138.git.john@keeping.me.uk>
References: <cover.1363980749.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 23 14:33:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJOZK-0003uL-VX
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 14:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003Ab3CWNco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 09:32:44 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:55973 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab3CWNcn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 09:32:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 2F1CF161E0F0;
	Sat, 23 Mar 2013 13:32:43 +0000 (GMT)
X-Quarantine-ID: <1Gc7JnS9P8zc>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Gc7JnS9P8zc; Sat, 23 Mar 2013 13:32:33 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 541A3161E3A7;
	Sat, 23 Mar 2013 13:32:20 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.324.ga64ebd9
In-Reply-To: <cover.1364045138.git.john@keeping.me.uk>
In-Reply-To: <cover.1364045138.git.john@keeping.me.uk>
References: <cover.1364045138.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218920>

Currently the difftool --dir-diff tests may or may not use symlinks
depending on the operating system on which they are run.  In one case
this has caused a test failure to be noticed only on Windows when the
test also fails on Linux when difftool is invoked with --no-symlinks.

Rewrite these tests so that they do not depend on the environment but
run explicitly with both --symlinks and --no-symlinks, protecting the
--symlinks version with a SYMLINKS prerequisite.

Signed-off-by: John Keeping <john@keeping.me.uk>

---
Changes since v1:
- &&-chain from the symlinks=... line

 t/t7800-difftool.sh | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index a0b8042..398e033 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -318,28 +318,39 @@ test_expect_success PERL 'setup change in subdirectory' '
 	git commit -m "modified both"
 '
 
-test_expect_success PERL 'difftool -d' '
-	git difftool -d --extcmd ls branch >output &&
+run_dir_diff_test () {
+	test_expect_success PERL "$1 --no-symlinks" "
+		symlinks=--no-symlinks &&
+		$2
+	"
+	test_expect_success PERL,SYMLINKS "$1 --symlinks" "
+		symlinks=--symlinks &&
+		$2
+	"
+}
+
+run_dir_diff_test 'difftool -d' '
+	git difftool -d $symlinks --extcmd ls branch >output &&
 	grep sub output &&
 	grep file output
 '
 
-test_expect_success PERL 'difftool --dir-diff' '
-	git difftool --dir-diff --extcmd ls branch >output &&
+run_dir_diff_test 'difftool --dir-diff' '
+	git difftool --dir-diff $symlinks --extcmd ls branch >output &&
 	grep sub output &&
 	grep file output
 '
 
-test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
-	git difftool --dir-diff --prompt --extcmd ls branch >output &&
+run_dir_diff_test 'difftool --dir-diff ignores --prompt' '
+	git difftool --dir-diff $symlinks --prompt --extcmd ls branch >output &&
 	grep sub output &&
 	grep file output
 '
 
-test_expect_success PERL 'difftool --dir-diff from subdirectory' '
+run_dir_diff_test 'difftool --dir-diff from subdirectory' '
 	(
 		cd sub &&
-		git difftool --dir-diff --extcmd ls branch >output &&
+		git difftool --dir-diff $symlinks --extcmd ls branch >output &&
 		grep sub output &&
 		grep file output
 	)
-- 
1.8.2.324.ga64ebd9
