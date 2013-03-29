From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 4/5] t7800: fix tests when difftool uses --no-symlinks
Date: Fri, 29 Mar 2013 11:28:35 +0000
Message-ID: <7c54c9df46d8c0bcd0290c4c307001b36421fcb3.1364555970.git.john@keeping.me.uk>
References: <cover.1364555970.git.john@keeping.me.uk>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 29 12:30:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULXVe-0001BT-MW
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 12:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585Ab3C2L3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 07:29:47 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:50061 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab3C2L3q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 07:29:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 325E56064CA;
	Fri, 29 Mar 2013 11:29:46 +0000 (GMT)
X-Quarantine-ID: <dxMN5YYIl0hT>
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
	with ESMTP id dxMN5YYIl0hT; Fri, 29 Mar 2013 11:29:45 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 60AC9606500;
	Fri, 29 Mar 2013 11:29:32 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.411.g65a544e
In-Reply-To: <cover.1364555970.git.john@keeping.me.uk>
In-Reply-To: <cover.1364555970.git.john@keeping.me.uk>
References: <cover.1364555970.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219493>

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
5) the output file doesn't contain the expected output, causing the
   test to fail

Instead of adding all changes, explicitly add only the files that the
test is using, allowing later tests to write their result files into the
working tree.

Signed-off-by: John Keeping <john@keeping.me.uk>

---
Changes since v2:
- Fix grammar issues in commit message
- Remove the final paragraph of the commit message since this is now
  addressed by patch 2/5 in this series

 t/t7800-difftool.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 9fd09db..df443a9 100755
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
1.8.2.411.g65a544e
