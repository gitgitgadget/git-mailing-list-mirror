From: Elijah Newren <newren@gmail.com>
Subject: [WIP PATCH 10/10] Add new testcase (temp14) showing how undetected renames can cause or spuriously avoid merge conflicts
Date: Mon, 21 Mar 2011 12:31:04 -0600
Message-ID: <1300732264-9638-11-git-send-email-newren@gmail.com>
References: <1300732264-9638-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jnE-0000hi-1r
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159Ab1CUSZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:25:05 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47678 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1CUSY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:24:59 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so5223921vxi.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=C9896kp6TIGWVAJER9kAFeH5csU6EkryPCgN9/kdkQI=;
        b=BsxMOOC/BT2/1OqBqQPLUvWAtPyuOLWlGC167BnHzjZVo0TbKB20d/p+VINCKZJJo2
         Y6kUyHkXMAMORBZnNP5nrRo5SNOlYZ+aoVY5B6SzlUe6J51smgL06Spba+lzOuUnA3hn
         ZnTnYWxoJoGoFgzRksFo6/zsMNPvsVo0xk4lI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fcL4DBBfrPeFn5tJXjIBTBMwfLTM+ghVmGCkG3bAjtbtARvuZ3Lm7zL0vcGzBMDyDr
         Qi07kWGxSty4zj9zHvpYsJMzZ+vo5CpIABPO4bQQUm6KL+ouoj7/2qc6EknGjzoazs/r
         RipZ8461pXLbva/LuEZiD9Qfw4HN/fXzvPWJg=
Received: by 10.220.186.195 with SMTP id ct3mr1264856vcb.108.1300731898524;
        Mon, 21 Mar 2011 11:24:58 -0700 (PDT)
Received: from localhost6.localdomain6 (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b6sm1507291vci.0.2011.03.21.11.24.56
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:24:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.120.g38a18
In-Reply-To: <1300732264-9638-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169634>

---
 t/temp14.sh |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100755 t/temp14.sh

diff --git a/t/temp14.sh b/t/temp14.sh
new file mode 100755
index 0000000..f82d991
--- /dev/null
+++ b/t/temp14.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='undetected renames cause merge problems'
+
+. ./test-lib.sh
+
+test_expect_success 'setup undetected rename causing conflict in merge' '
+	printf "1\n2\n3\n4\n5\n" >a &&
+	echo foo >b &&
+	git add a b &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a c &&
+	echo "Completely different content" >a &&
+	git add a &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	echo 6 >>a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_success 'undetected rename causes conflict' '
+	git checkout -q C^0 &&
+	git merge -s recursive B^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test 6 -eq $(wc -l < c) &&
+	test $(git rev-parse HEAD:a) = $(git rev-parse B:a) &&
+	test $(git rev-parse HEAD:b) = $(git rev-parse A:b)
+'
+
+test_expect_success 'setup undetected rename causing missed merge conflict' '
+	git reset --hard &&
+	git clean -f &&
+
+	git checkout -b D A &&
+	echo 7 >>a &&
+	git add a &&
+	git mv a c &&
+	echo "Completely different content" >a &&
+	git add a &&
+	git commit -m D &&
+
+	git checkout -b E A &&
+	git rm a &&
+	echo "Completely different content" >>a &&
+	git add a &&
+	git commit -m E
+'
+
+test_expect_success 'undetected rename causes missed conflict' '
+	git checkout -q E^0 &&
+	test_must_fail git merge -s recursive D^0
+'
+
+test_done
-- 
1.7.4
