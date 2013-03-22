From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Fri, 22 Mar 2013 19:36:32 +0000
Message-ID: <5fc134f6c4a88232c78240539084e9d35db3a6cb.1363980749.git.john@keeping.me.uk>
References: <20130322115352.GI2283@serenity.lan>
 <cover.1363980749.git.john@keeping.me.uk>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 20:37:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ7mj-0002zX-34
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 20:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355Ab3CVThQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 15:37:16 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:40973 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268Ab3CVThP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 15:37:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id A4576606516;
	Fri, 22 Mar 2013 19:37:14 +0000 (GMT)
X-Quarantine-ID: <pbZyhsSzHh4U>
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
	with ESMTP id pbZyhsSzHh4U; Fri, 22 Mar 2013 19:37:14 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 2962B6064E7;
	Fri, 22 Mar 2013 19:37:02 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.324.ga64ebd9
In-Reply-To: <cover.1363980749.git.john@keeping.me.uk>
In-Reply-To: <cover.1363980749.git.john@keeping.me.uk>
References: <cover.1363980749.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218839>

When 'git difftool --dir-diff' is using --no-symlinks (either explicitly
or implicitly because it's running on Windows), any working tree files
that have been copied to the temporary directory are copied back after
the difftool completes.  This includes untracked files in the working
tree.

During the tests, this means that the following sequence occurs:

1) the shell opens "output" to redirect the difftool output
2) difftool copies the empty "output" to the temporary directory
3) difftool runs "ls" which writes to "output"
4) difftool copies the empty "output" file back over the output of the
   command
5) the output files doesn't contain the expected output, causing the
   test to fail

Avoid this by writing the output into .git/ which will not be copied or
overwritten.

In the longer term, difftool probably needs to learn to warn the user
instead of overwrite any changes that have been made to the working tree
file.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t7800-difftool.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index e694972..1eed439 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -319,29 +319,29 @@ test_expect_success PERL 'setup change in subdirectory' '
 '
 
 test_expect_success PERL 'difftool -d' '
-	git difftool -d --extcmd ls branch >output &&
-	grep sub output &&
-	grep file output
+	git difftool -d --extcmd ls branch >.git/output &&
+	grep sub .git/output &&
+	grep file .git/output
 '
 
 test_expect_success PERL 'difftool --dir-diff' '
-	git difftool --dir-diff --extcmd ls branch >output &&
-	grep sub output &&
-	grep file output
+	git difftool --dir-diff --extcmd ls branch >.git/output &&
+	grep sub .git/output &&
+	grep file .git/output
 '
 
 test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
-	git difftool --dir-diff --prompt --extcmd ls branch >output &&
-	grep sub output &&
-	grep file output
+	git difftool --dir-diff --prompt --extcmd ls branch >.git/output &&
+	grep sub .git/output &&
+	grep file .git/output
 '
 
 test_expect_success PERL 'difftool --dir-diff from subdirectory' '
 	(
 		cd sub &&
-		git difftool --dir-diff --extcmd ls branch >output &&
-		grep sub output &&
-		grep file output
+		git difftool --dir-diff --extcmd ls branch >../.git/output &&
+		grep sub ../.git/output &&
+		grep file ../.git/output
 	)
 '
 
-- 
1.8.2.324.ga64ebd9
