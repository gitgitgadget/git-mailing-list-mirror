From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/3 v2] t7800: run --dir-diff tests with and without symlinks
Date: Fri, 22 Mar 2013 21:05:30 +0000
Message-ID: <20130322210530.GJ2283@serenity.lan>
References: <cover.1363980749.git.john@keeping.me.uk>
 <9227365bf9cdfde61c1fdd374756187d00c84480.1363980749.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 22:06:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ9AB-00016y-Ly
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 22:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423142Ab3CVVFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 17:05:44 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:49203 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423056Ab3CVVFm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 17:05:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 0BCD3CDA5E4;
	Fri, 22 Mar 2013 21:05:42 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UE+fn971E3sx; Fri, 22 Mar 2013 21:05:41 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id ACF54CDA598;
	Fri, 22 Mar 2013 21:05:32 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <9227365bf9cdfde61c1fdd374756187d00c84480.1363980749.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218844>

Currently the difftool --dir-diff tests may or may not use symlinks
depending on the operating system on which they are run.  In one case
this has caused a test failure to be noticed only on Windows when the
test also fails on Linux when difftool is invoked with --no-symlinks.

Rewrite these tests so that they do not depend on the environment but
run explicitly with both --symlinks and --no-symlinks, protecting the
--symlinks version with a SYMLINKS prerequisite.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
The previous version of this was missing half the intended change :-(
Sorry for the noise.

 t/t7800-difftool.sh | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 1eed439..bba8a9d 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -318,28 +318,39 @@ test_expect_success PERL 'setup change in subdirectory' '
 	git commit -m "modified both"
 '
 
-test_expect_success PERL 'difftool -d' '
-	git difftool -d --extcmd ls branch >.git/output &&
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
+	git difftool -d $symlinks --extcmd ls branch >.git/output &&
 	grep sub .git/output &&
 	grep file .git/output
 '
 
-test_expect_success PERL 'difftool --dir-diff' '
-	git difftool --dir-diff --extcmd ls branch >.git/output &&
+run_dir_diff_test 'difftool --dir-diff' '
+	git difftool --dir-diff $symlinks --extcmd ls branch >.git/output &&
 	grep sub .git/output &&
 	grep file .git/output
 '
 
-test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
-	git difftool --dir-diff --prompt --extcmd ls branch >.git/output &&
+run_dir_diff_test 'difftool --dir-diff ignores --prompt' '
+	git difftool --dir-diff $symlinks --prompt --extcmd ls branch >.git/output &&
 	grep sub .git/output &&
 	grep file .git/output
 '
 
-test_expect_success PERL 'difftool --dir-diff from subdirectory' '
+run_dir_diff_test 'difftool --dir-diff from subdirectory' '
 	(
 		cd sub &&
-		git difftool --dir-diff --extcmd ls branch >../.git/output &&
+		git difftool --dir-diff $symlinks --extcmd ls branch >../.git/output &&
 		grep sub ../.git/output &&
 		grep file ../.git/output
 	)
-- 
1.8.2.324.ga64ebd9
