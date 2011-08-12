From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 05/56] t6042: Add tests for content issues with modify/rename/directory conflicts
Date: Thu, 11 Aug 2011 23:19:38 -0600
Message-ID: <1313126429-17368-6-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkB2-0004ab-Iy
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab1HLFUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:20:45 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab1HLFUm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:42 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yFuPlbKlnsUam9AviGf1Bsdbt4auKoZYIb6u5WjOMEo=;
        b=AFKJwig0bh9Nh9vgqEJEBYjurFmrcV9skkCprwXpXwOOEUKcoWYFK1FKewRjZ7f79u
         tVFU9sYUPPbZ+a9xN9LZFHn6BdtSzSxMgSh+kQUOCG7b1OtVP1YhHT2ihWyOwcpC5ILY
         vR5LT1hWKFNltcP950IVjT/MqMXfXHtcu1wDA=
Received: by 10.42.74.130 with SMTP id w2mr527758icj.462.1313126442321;
        Thu, 11 Aug 2011 22:20:42 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.40
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179166>

Add testcases that cover a variety of merge issues with files being
renamed and modified on different sides of history, when there are
directories possibly conflicting with the rename location.

Case 1:
On one side of history, a file is modified and a new directory is added.
On the other side of history, the file is modified in a non-conflicting
way but is renamed to the location of the new directory.

Case 2:
[Same as case 1, but there is also a content conflict.  In detail:]
On one side of history, a file is modified and a new directory is added.
On the other side of history, the file is modified in a conflicting way
and it is renamed to the location of the new directory.

Case 3:
[Similar to case 1, but the "conflicting" directory is the directory
where the file original resided.  In detail:]
On one side of history, a file is modified.  On the other side of history,
the file is modified in a non-conflicting way, but the directory it was
under is removed and the file is renamed to the location of the directory
it used to reside in (i.e. 'sub/file' gets renamed to 'sub').  This is
flagged as a directory/rename conflict, but should be able to be resolved
since the directory can be cleanly removed by the merge.

One branch renames a file and makes a file where the directory the renamed
file used to be in, and the other branch updates the file in
place. Merging them should resolve it cleanly as long as the content level
change on the branches do not overlap and rename is detected, or should
leave conflict without losing information.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v1: New and improved commit message.

 t/t6042-merge-rename-corner-cases.sh |  141 ++++++++++++++++++++++++++++++++++
 1 files changed, 141 insertions(+), 0 deletions(-)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index db5560c..b465667 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -198,4 +198,145 @@ test_expect_failure 'detect rename/add-source and preserve all data, merge other
 	test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
 '
 
+test_expect_success 'setup content merge + rename/directory conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n6\n" >file &&
+	git add file &&
+	test_tick &&
+	git commit -m base &&
+	git tag base &&
+
+	git checkout -b right &&
+	echo 7 >>file &&
+	mkdir newfile &&
+	echo junk >newfile/realfile &&
+	git add file newfile/realfile &&
+	test_tick &&
+	git commit -m right &&
+
+	git checkout -b left-conflict base &&
+	echo 8 >>file &&
+	git add file &&
+	git mv file newfile &&
+	test_tick &&
+	git commit -m left &&
+
+	git checkout -b left-clean base &&
+	echo 0 >newfile &&
+	cat file >>newfile &&
+	git add newfile &&
+	git rm file &&
+	test_tick &&
+	git commit -m left
+'
+
+test_expect_failure 'rename/directory conflict + clean content merge' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+
+	git checkout left-clean^0 &&
+
+	test_must_fail git merge -s recursive right^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	echo 0 >expect &&
+	git cat-file -p base:file >>expect &&
+	echo 7 >>expect &&
+	test_cmp expect newfile~HEAD &&
+
+	test $(git rev-parse :2:newfile) = $(git hash-object expect) &&
+
+	test -f newfile/realfile &&
+	test -f newfile~HEAD
+'
+
+test_expect_failure 'rename/directory conflict + content merge conflict' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+
+	git checkout left-conflict^0 &&
+
+	test_must_fail git merge -s recursive right^0 &&
+
+	test 4 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	git cat-file -p left-conflict:newfile >left &&
+	git cat-file -p base:file    >base &&
+	git cat-file -p right:file   >right &&
+	test_must_fail git merge-file \
+		-L "HEAD:newfile" \
+		-L "" \
+		-L "right^0:file" \
+		left base right &&
+	test_cmp left newfile~HEAD &&
+
+	test $(git rev-parse :1:newfile) = $(git rev-parse base:file) &&
+	test $(git rev-parse :2:newfile) = $(git rev-parse left-conflict:newfile) &&
+	test $(git rev-parse :3:newfile) = $(git rev-parse right:file) &&
+
+	test -f newfile/realfile &&
+	test -f newfile~HEAD
+'
+
+test_expect_success 'setup content merge + rename/directory conflict w/ disappearing dir' '
+	git reset --hard &&
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir sub &&
+	printf "1\n2\n3\n4\n5\n6\n" >sub/file &&
+	git add sub/file &&
+	test_tick &&
+	git commit -m base &&
+	git tag base &&
+
+	git checkout -b right &&
+	echo 7 >>sub/file &&
+	git add sub/file &&
+	test_tick &&
+	git commit -m right &&
+
+	git checkout -b left base &&
+	echo 0 >newfile &&
+	cat sub/file >>newfile &&
+	git rm sub/file &&
+	mv newfile sub &&
+	git add sub &&
+	test_tick &&
+	git commit -m left
+'
+
+test_expect_success 'disappearing dir in rename/directory conflict handled' '
+	git reset --hard &&
+	git clean -fdqx &&
+
+	git checkout left^0 &&
+
+	git merge -s recursive right^0 &&
+
+	test 1 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	echo 0 >expect &&
+	git cat-file -p base:sub/file >>expect &&
+	echo 7 >>expect &&
+	test_cmp expect sub &&
+
+	test -f sub
+'
+
 test_done
-- 
1.7.6.100.gac5c1
