From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 5/5] t7800: run --dir-diff tests with and without symlinks
Date: Fri, 29 Mar 2013 11:28:36 +0000
Message-ID: <d5998552e411600b51f86155aa61b8491b3d6fcb.1364555970.git.john@keeping.me.uk>
References: <cover.1364555970.git.john@keeping.me.uk>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 29 12:30:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULXVw-000235-FL
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 12:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633Ab3C2LaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 07:30:01 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:50142 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab3C2LaA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 07:30:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 32EA7606500;
	Fri, 29 Mar 2013 11:30:00 +0000 (GMT)
X-Quarantine-ID: <54Y8zzn1DFdV>
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
	with ESMTP id 54Y8zzn1DFdV; Fri, 29 Mar 2013 11:29:59 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 78BB86064EC;
	Fri, 29 Mar 2013 11:29:46 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.411.g65a544e
In-Reply-To: <cover.1364555970.git.john@keeping.me.uk>
In-Reply-To: <cover.1364555970.git.john@keeping.me.uk>
References: <cover.1364555970.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219494>

Currently the difftool --dir-diff tests may or may not use symlinks
depending on the operating system on which they are run.  In one case
this has caused a test failure to be noticed only on Windows when the
test also fails on Linux when difftool is invoked with --no-symlinks.

Rewrite these tests so that they do not depend on the environment but
run explicitly with both --symlinks and --no-symlinks, protecting the
--symlinks version with a SYMLINKS prerequisite.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t7800-difftool.sh | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index df443a9..a6bd99e 100755
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
1.8.2.411.g65a544e
