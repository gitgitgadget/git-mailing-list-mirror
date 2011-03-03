From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 2/3] t6022: New test checking for unnecessary updates of files in D/F conflicts
Date: Wed,  2 Mar 2011 23:13:11 -0700
Message-ID: <1299132792-17497-3-git-send-email-newren@gmail.com>
References: <1299132792-17497-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 03 07:13:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv1n0-0003hV-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 07:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab1CCGNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 01:13:20 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37884 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab1CCGNS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 01:13:18 -0500
Received: by mail-qw0-f46.google.com with SMTP id 7so617671qwd.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 22:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Z5on326eOMa8k6LdubnLWnR2P+UUo7s3oE+L2L/XHkc=;
        b=lJjIRpRRWJipyKXOgkn2R5ns5I8Kcu2YQBm89jkH8dUUANV0HJO2tjwWr5CPd+GxEt
         I9MhSCmFi1LTMD99pWWhiGu2ps5FdyG40Mb37y905Hz8SyFoNRTC2f6L8N+dCE7tfZ6d
         i23dMaxg5LU9mJMhxp53VZucd0KOiba99rVAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YRdwMe/4GIPm5XUb33bk/CxDwgF/pAai8db3cIAt4QTIBmbzu/G9UfgC5p9eH57t6a
         ORZr0x5hymOMco7ekY2f1VqLh0JA5rmiIPsz9YE/WjcilDR80Zoiz2hyXecf03OG1Afn
         P2etn5uQVGq6g1byB53n8wlrZAkjqnUqm8M/0=
Received: by 10.229.228.133 with SMTP id je5mr538263qcb.159.1299132797970;
        Wed, 02 Mar 2011 22:13:17 -0800 (PST)
Received: from Miney.hsd1.nm.comcast.net. (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id s32sm402361qco.38.2011.03.02.22.13.15
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Mar 2011 22:13:17 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1299132792-17497-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168376>


Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Jeff King <peff@peff.net>
---
 t/t6022-merge-rename.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 16330a6..88cc410 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -640,4 +640,38 @@ test_expect_failure 'avoid unnecessary update, normal rename' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup avoid unnecessary update, with D/F conflict' '
+	git reset --hard &&
+	git checkout --orphan avoid-unnecessary-update-2 &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	mkdir df &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >df/file &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	git mv df/file temp &&
+	rm -rf df &&
+	git mv temp df &&
+	echo 11 >>df &&
+	git add -u &&
+	git commit -m "Renamed and modified" &&
+
+	git checkout -b merge-branch-2 HEAD~1 &&
+	>unrelated-change &&
+	git add unrelated-change &&
+	git commit -m "Only unrelated changes"
+'
+
+test_expect_failure 'avoid unnecessary update, with D/F conflict' '
+	git checkout -q avoid-unnecessary-update-2^0 &&
+	test-chmtime =1 rename &&
+	test-chmtime -v +0 rename >expect &&
+	git merge merge-branch-2 &&
+	git diff-files --exit-code &&   # Is "rename" clean, or stat dirty?
+	test-chmtime -v +0 rename >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.4
