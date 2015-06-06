From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 3/6] am --skip: support skipping while on unborn branch
Date: Sat,  6 Jun 2015 19:46:09 +0800
Message-ID: <1433591172-27077-4-git-send-email-pyokagan@gmail.com>
References: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 13:46:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1CYj-0005A2-1f
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 13:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbbFFLqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 07:46:36 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33835 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbbFFLqe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 07:46:34 -0400
Received: by payr10 with SMTP id r10so65894222pay.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gTi5xvWdEZHJfsVzknfIvo0u4ZCeajDgZS7B2MTEZ1I=;
        b=WQx/7FLahYAwbwd7IpRt5XiN5UnbO7Bu0oMgvz6rUpJVcImstP/9z0L5/B1h4aIL8s
         UHWa37J30/Mw5nWZJzAU4LmFZ++2/E+SdpkIaeYM5ph1u/wCxmaw00klt6RerfX1kfv3
         BDFB4lxwZSAtpG3BMRKHI/kQud82Bgett2oVobMcev8P5XZdiZNSts5J5pSDiqkiPW9/
         HfHEaeiSygSaq96HpHXxqvjqcGB7YKnqe5ffgAuwbwSKivIrb+SWVNKAyZmvdQYjq238
         2Ht87idtYN+Tn6ptsn6fTErVjdRr+lHxmlAzozVChMdN9C+Ti0q94cvkg5cgc1P+naUl
         PW4w==
X-Received: by 10.68.142.42 with SMTP id rt10mr13494870pbb.27.1433591193680;
        Sat, 06 Jun 2015 04:46:33 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id on3sm9344587pbc.69.2015.06.06.04.46.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 04:46:32 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270918>

When git am --skip is run, git am will copy HEAD's tree entries to the
index with "git reset HEAD". However, on an unborn branch, HEAD does not
point to a tree, so "git reset HEAD" will fail.

Fix this by treating HEAD as en empty tree when we are on an unborn
branch.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-am.sh           |  4 +---
 t/t4151-am-abort.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c847b58..67f4f25 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -509,9 +509,7 @@ then
 		git read-tree --reset -u $head_tree $head_tree &&
 		index_tree=$(git write-tree) &&
 		git read-tree -m -u $index_tree $head_tree
-		orig_head=$(cat "$GIT_DIR/ORIG_HEAD")
-		git reset HEAD
-		git update-ref ORIG_HEAD $orig_head
+		git read-tree $head_tree
 		;;
 	,t)
 		if test -f "$dotest/rebasing"
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index b618ee0..ea4a49e 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -92,4 +92,14 @@ test_expect_success 'am -3 stops on conflict on unborn branch' '
 	test 4 = "$(cat otherfile-4)"
 '
 
+test_expect_success 'am -3 --skip clears index on unborn branch' '
+	test_path_is_dir .git/rebase-apply &&
+	echo tmpfile >tmpfile &&
+	git add tmpfile &&
+	git am --skip &&
+	test -z "$(git ls-files)" &&
+	test_path_is_missing otherfile-4 &&
+	test_path_is_missing tmpfile
+'
+
 test_done
-- 
2.1.4
