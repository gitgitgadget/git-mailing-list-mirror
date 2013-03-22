From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/3] t7800: run --dir-diff tests with and without symlinks
Date: Fri, 22 Mar 2013 19:36:33 +0000
Message-ID: <9227365bf9cdfde61c1fdd374756187d00c84480.1363980749.git.john@keeping.me.uk>
References: <20130322115352.GI2283@serenity.lan>
 <cover.1363980749.git.john@keeping.me.uk>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 20:38:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ7my-0003Aq-EO
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 20:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656Ab3CVTh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 15:37:29 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:41028 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982Ab3CVTh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 15:37:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 4086F6064E2;
	Fri, 22 Mar 2013 19:37:26 +0000 (GMT)
X-Quarantine-ID: <VzYJTgZKR3Y1>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VzYJTgZKR3Y1; Fri, 22 Mar 2013 19:37:25 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id D855860652F;
	Fri, 22 Mar 2013 19:37:14 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.324.ga64ebd9
In-Reply-To: <cover.1363980749.git.john@keeping.me.uk>
In-Reply-To: <cover.1363980749.git.john@keeping.me.uk>
References: <cover.1363980749.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218840>

Currently the difftool --dir-diff tests may or may not use symlinks
depending on the operating system on which they are run.  In one case
this has caused a test failure to be noticed only on Windows when the
test also fails on Linux when difftool is invoked with --no-symlinks.

Rewrite these tests so that they do not depend on the environment but
run explicitly with both --symlinks and --no-symlinks, protecting the
--symlinks version with a SYMLINKS prerequisite.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t7800-difftool.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 1eed439..4a70508 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -318,25 +318,36 @@ test_expect_success PERL 'setup change in subdirectory' '
 	git commit -m "modified both"
 '
 
-test_expect_success PERL 'difftool -d' '
+run_dir_diff_test () {
+	test_expect_success PERL "$1 --no-symlinks" "
+		symlinks=--no-symlinks
+		$2
+	"
+	test_expect_success PERL,SYMLINKS "$1 --symlinks" "
+		symlinks=--symlinks
+		$2
+	"
+}
+
+run_dir_diff_test 'difftool -d' '
 	git difftool -d --extcmd ls branch >.git/output &&
 	grep sub .git/output &&
 	grep file .git/output
 '
 
-test_expect_success PERL 'difftool --dir-diff' '
+run_dir_diff_test 'difftool --dir-diff' '
 	git difftool --dir-diff --extcmd ls branch >.git/output &&
 	grep sub .git/output &&
 	grep file .git/output
 '
 
-test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
+run_dir_diff_test 'difftool --dir-diff ignores --prompt' '
 	git difftool --dir-diff --prompt --extcmd ls branch >.git/output &&
 	grep sub .git/output &&
 	grep file .git/output
 '
 
-test_expect_success PERL 'difftool --dir-diff from subdirectory' '
+run_dir_diff_test 'difftool --dir-diff from subdirectory' '
 	(
 		cd sub &&
 		git difftool --dir-diff --extcmd ls branch >../.git/output &&
-- 
1.8.2.324.ga64ebd9
