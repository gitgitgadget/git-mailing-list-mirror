From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 08/37] t6022: Add tests for rename/rename combined with D/F conflicts
Date: Mon, 20 Sep 2010 02:28:41 -0600
Message-ID: <1284971350-30590-9-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjR-0005rH-Nx
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810Ab0ITI1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:27:51 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63878 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab0ITI1s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:48 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1072016pxi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3kes3LnjSV7Vvo00/glKPaU6wTvB/onZRfOyv//btAA=;
        b=YbEMIJ5zotMLN/zef8MQ/RE5Bm54WxUAxYHd+Zt9jim22z3QZ1p3TzDlPYGFRHgmsx
         gQRcleOcvRPqWLJD+W+7xITfE/6sNFaVjP7iuYXhgI1H3k1Zk2J+guE66dXr0JSH6hv/
         r68xF2oGLy53GkyV8CdwIuGcpPtBLEp/BQNZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sYMVBk+rXgQrYj5JYd6GI2PaHxKc5TiAhLrHr9zCwIiKd9bICIf/pKbXOXQfWyjAtJ
         UawCE8JSeeDdH42pMtQz2poA7uo96FqWG83BP1c4YDdO3XOcyFtx4vNOxLEI4gxKzd9P
         q97gQWiWocOLwUGMieNnl70Wq5z2H9d97EDdY=
Received: by 10.142.232.5 with SMTP id e5mr7338421wfh.300.1284971267881;
        Mon, 20 Sep 2010 01:27:47 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156565>

Add tests where one file is renamed to two different paths in different
sides of history, and where each of the new files matches the name of a
directory from the opposite side of history.  Include tests for both the
case where the merge results in those directories not being cleanly
removed, and where those directories are cleanly removed during the merge.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6022-merge-rename.sh |   79 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index a38b383..02dea16 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -628,4 +628,83 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
 	test "stuff" = $(cat two)
 '
 
+test_expect_success 'setup rename of one file to two, with directories in the way' '
+	git reset --hard &&
+	git checkout --orphan first-rename &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	echo stuff >original &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	mkdir two &&
+	>two/file &&
+	git add two/file &&
+	git mv original one &&
+	git commit -m "Put two/file in the way, rename to one" &&
+
+	git checkout -b second-rename HEAD~1 &&
+	mkdir one &&
+	>one/file &&
+	git add one/file &&
+	git mv original two &&
+	git commit -m "Put one/file in the way, rename to two"
+'
+
+test_expect_failure 'check handling of differently renamed file with D/F conflicts' '
+	git checkout -q first-rename^0 &&
+	test_must_fail git merge --strategy=recursive second-rename &&
+
+	test 5 = "$(git ls-files -s | wc -l)" &&
+	test 3 = "$(git ls-files -u | wc -l)" &&
+	test 1 = "$(git ls-files -u one | wc -l)" &&
+	test 1 = "$(git ls-files -u two | wc -l)" &&
+	test 1 = "$(git ls-files -u original | wc -l)" &&
+	test 2 = "$(git ls-files -o | wc -l)" &&
+
+	test -f one/file &&
+	test -f two/file &&
+	test -f one~HEAD &&
+	test -f two~second-rename &&
+	! test -f original
+'
+
+test_expect_success 'setup rename one file to two; directories moving out of the way' '
+	git reset --hard &&
+	git checkout --orphan first-rename-redo &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	echo stuff >original &&
+	mkdir one two &&
+	touch one/file two/file &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	git rm -rf one &&
+	git mv original one &&
+	git commit -m "Rename to one" &&
+
+	git checkout -b second-rename-redo HEAD~1 &&
+	git rm -rf two &&
+	git mv original two &&
+	git commit -m "Rename to two"
+'
+
+test_expect_failure 'check handling of differently renamed file with D/F conflicts' '
+	git checkout -q first-rename-redo^0 &&
+	test_must_fail git merge --strategy=recursive second-rename-redo &&
+
+	test 3 = "$(git ls-files -u | wc -l)" &&
+	test 1 = "$(git ls-files -u one | wc -l)" &&
+	test 1 = "$(git ls-files -u two | wc -l)" &&
+	test 1 = "$(git ls-files -u original | wc -l)" &&
+	test 0 = "$(git ls-files -o | wc -l)" &&
+
+	test -f one &&
+	test -f two &&
+	! test -f original
+'
+
 test_done
-- 
1.7.3.271.g16009
