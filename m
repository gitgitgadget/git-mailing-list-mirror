From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Sat, 23 Mar 2013 13:31:40 +0000
Message-ID: <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
References: <cover.1363980749.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 23 14:32:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJOZ2-0003hP-OW
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 14:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056Ab3CWNcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 09:32:25 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:55846 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab3CWNcY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 09:32:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 13FC6161E3FC;
	Sat, 23 Mar 2013 13:32:23 +0000 (GMT)
X-Quarantine-ID: <qoFKGOn5nVlK>
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
	with ESMTP id qoFKGOn5nVlK; Sat, 23 Mar 2013 13:32:20 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 73EF0161E3E6;
	Sat, 23 Mar 2013 13:32:09 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.324.ga64ebd9
In-Reply-To: <cover.1364045138.git.john@keeping.me.uk>
In-Reply-To: <cover.1364045138.git.john@keeping.me.uk>
References: <cover.1364045138.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218919>

When 'git difftool --dir-diff' is using --no-symlinks (either explicitly
or implicitly because it's running on Windows), any working tree files
that have been copied to the temporary directory are copied back after
the difftool completes.

Because an earlier test uses "git add .", the "output" file used by
tests is tracked by Git and the following sequence occurs during some
tests:

1) the shell opens "output" to redirect the difftool output
2) difftool copies the empty "output" to the temporary directory
3) difftool runs "ls" which writes to "output"
4) difftool copies the empty "output" file back over the output of the
   command
5) the output files doesn't contain the expected output, causing the
   test to fail

Instead of adding all changes, explicitly add only the files that the
test is using, allowing later tests to write their result files into the
working tree.

In the longer term, difftool probably needs to learn to warn the user
instead of overwrite any changes that have been made to the working tree
file.

Signed-off-by: John Keeping <john@keeping.me.uk>

---
Changes since v1:
- Fix the actual cause of the issue in the test instead of masking it by
  moving the output file under .git/

 t/t7800-difftool.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index e694972..a0b8042 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -314,7 +314,7 @@ test_expect_success PERL 'setup change in subdirectory' '
 	git commit -m "added sub/sub" &&
 	echo test >>file &&
 	echo test >>sub/sub &&
-	git add . &&
+	git add file sub/sub &&
 	git commit -m "modified both"
 '
 
-- 
1.8.2.324.ga64ebd9
