From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 12/37] t6036: Add a second testcase similar to the first but with content changes
Date: Mon, 20 Sep 2010 02:28:45 -0600
Message-ID: <1284971350-30590-13-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjS-0005rH-PG
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab0ITI16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:27:58 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63516 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab0ITI14 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:56 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1070478pzk.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zG/HLP0pn4GtyooCgW2LL6h6m7Yd190ZrAHWrq0NbHw=;
        b=HjDxlz8K78tzCJPuOybErTfuZmPKQKXQ4B9j7Cf9nR92WZyVsufvMYYBtbPzoFfrm7
         b/0WXc6EDsPkv8RWfpTEmoH0NTpzdpzBv0Yf3dpOM/iG/HVTYMNjiGxCXI3UCQ+MVjVU
         obpgZIOmKc9pCdKSpx/oXFidTYDweo0IrXiXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qBX9O2ITYxm2tPV5GuJztwMPkF1gyqa0YBcZVUA0rD8cVcOXwBnQs0k3h3YVwgF9Wg
         tVDzwsSAKB03oJLhowOMwS3b+DORli1eGVzu8gi1+azy/go+lJ4XrUGEM42D4zHAxVra
         bSZNTtc6PX/hhY9sRmJld+r3U9Zg/M2rYqWhw=
Received: by 10.142.191.10 with SMTP id o10mr7328818wff.324.1284971276223;
        Mon, 20 Sep 2010 01:27:56 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156568>

c94736a (merge-recursive: don't segfault while handling rename clashes
2009-07-30) added t6036 with a testcase that involved dual renames and a
criss-cross merge.  Add a test that is nearly identical, but which also
involves content modification -- a case git currently does not merge
correctly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh |   76 +++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 1755073..9206c22 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -70,4 +70,80 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
 	test $(git rev-parse :1:three) = $(git hash-object merged)
 '
 
+#
+# Same as before, but modify L1 slightly:
+#
+#  L1m L2
+#   o---o
+#  / \ / \
+# o   X   ?
+#  \ / \ /
+#   o---o
+#  R1  R2
+#
+
+test_expect_success 'setup criss-cross + rename merges with basic modification' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	ten="0 1 2 3 4 5 6 7 8 9"
+	for i in $ten
+	do
+		echo line $i in a sample file
+	done >one &&
+	for i in $ten
+	do
+		echo line $i in another sample file
+	done >two &&
+	git add one two &&
+	test_tick && git commit -m initial &&
+
+	git branch L1 &&
+	git checkout -b R1 &&
+	git mv one three &&
+	echo more >>two &&
+	git add two &&
+	test_tick && git commit -m R1 &&
+
+	git checkout L1 &&
+	git mv two three &&
+	test_tick && git commit -m L1 &&
+
+	git checkout L1^0 &&
+	test_tick && git merge -s ours R1 &&
+	git tag L2 &&
+
+	git checkout R1^0 &&
+	test_tick && git merge -s ours L1 &&
+	git tag R2
+'
+
+test_expect_failure 'merge criss-cross + rename merges with basic modification' '
+	git reset --hard &&
+	git checkout L2^0 &&
+
+	test_must_fail git merge -s recursive R2^0 &&
+
+	test 5 = $(git ls-files -s | wc -l) &&
+	test 3 = $(git ls-files -u | wc -l) &&
+	test 0 = $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:one) = $(git rev-parse L2:one) &&
+	test $(git rev-parse :0:two) = $(git rev-parse R2:two) &&
+	test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
+	test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
+
+	head -n 10 two >merged &&
+	cp one merge-me &&
+	>empty &&
+	test_must_fail git merge-file \
+		-L "Temporary merge branch 2" \
+		-L "" \
+		-L "Temporary merge branch 1" \
+		merged empty merge-me &&
+	test $(git rev-parse :1:three) = $(git hash-object merged)
+'
+
 test_done
-- 
1.7.3.271.g16009
