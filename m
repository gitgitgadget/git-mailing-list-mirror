From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 11/37] t6036: Test index and worktree state, not just that merge fails
Date: Mon, 20 Sep 2010 02:28:44 -0600
Message-ID: <1284971350-30590-12-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjS-0005rH-8S
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838Ab0ITI14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:27:56 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39104 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab0ITI1y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:54 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1070490pzk.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=p9isWIF+PNKeA71UJ4/vFUowMkiL7JCWo6zRT4bJGKY=;
        b=Xcb04VRuwx+ois+yzJNQK3e2iIIG0Jhjg+I5/Y1a02Rdtfh/IOIhF0cq6MB1FLL+9e
         7BWkGoN4ljOpYsKvIy9AcOy/X9O4qX6StUveb5Aht2kkQM3MXzEes03j7TLoNxSybe79
         qB/1hnG4H+Y9Q30Su4L9FK4EuK5PIp3A+VhOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lC71NGUKpZlyuuBOWLWtLFfBYRmhLEwHmuLzApyEtn2d/KwzCUvjRrJCf1Ed4GeK28
         Fn+166PXUWp9GcyDGkHYEBZrOMgjEad3g+is1ECZIrKFA9OzjIKCEymlTDDn+puA7Gsx
         lPMbSO1NtQ9KS0kbDUuj6AuV2mZ4mP6yl3nOo=
Received: by 10.142.162.13 with SMTP id k13mr7336998wfe.318.1284971273977;
        Mon, 20 Sep 2010 01:27:53 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156569>

c94736a (merge-recursive: don't segfault while handling rename clashes
2009-07-30) added this testcase with an interesting corner case test,
which previously had cased git to segfault.  This test ensures that the
segfault does not return and that the merge correctly fails; just add
some checks that verify the state of the index and worktree after the merge
are correct.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index b874141..1755073 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -14,7 +14,7 @@ test_description='recursive merge corner cases'
 #  R1  R2
 #
 
-test_expect_success setup '
+test_expect_success 'setup basic criss-cross + rename with no modifications' '
 	ten="0 1 2 3 4 5 6 7 8 9"
 	for i in $ten
 	do
@@ -45,11 +45,29 @@ test_expect_success setup '
 	git tag R2
 '
 
-test_expect_success merge '
+test_expect_success 'merge simple rename+criss-cross with no modifications' '
 	git reset --hard &&
 	git checkout L2^0 &&
 
-	test_must_fail git merge -s recursive R2^0
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
+	cp two merged &&
+	>empty &&
+	test_must_fail git merge-file \
+		-L "Temporary merge branch 2" \
+		-L "" \
+		-L "Temporary merge branch 1" \
+		merged empty one &&
+	test $(git rev-parse :1:three) = $(git hash-object merged)
 '
 
 test_done
-- 
1.7.3.271.g16009
