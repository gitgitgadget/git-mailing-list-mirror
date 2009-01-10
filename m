From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH] Add new testcases for format-patch root commits
Date: Sat, 10 Jan 2009 19:39:37 +0300
Message-ID: <1231605577-26148-1-git-send-email-aspotashev@gmail.com>
References: <20090110113903.GB25723@myhost>
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 17:42:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLgvA-0000SM-KL
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 17:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbZAJQji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 11:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbZAJQjh
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 11:39:37 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:6966 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbZAJQjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 11:39:36 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3642343fgg.17
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 08:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PH+6CA8yFqtnVSA8PQSv+TRkCfZOiPSB4XAagtFfyLU=;
        b=uzNPLcjLObabhhPC9SbxxxWbtY+AvvTNUkwFzEFU7XJGpQGAF/1NWdG8gUdYCn9rHK
         E64HzGTs5tBT4HzT99GAkahcS6HDv9O0fOwxrvo53U063f74MCQCvqPT1HckJhkTrOrd
         8CYHrU/64jGV2bcfnXBpXFlAgjv0VKVGT6JrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LUXFm3b0fQjPIBiIMGeFKMzAM149pChDYN6qjTDbaAR2F1PAEmxiJaLj21H/xndg3U
         E26L80atuFylqaveC/h6J9BR5GyqoKNpU2m3yxwubm5Ki6W8Zvpqh+2WdcmrBp9HntL8
         AUDQXHcL7zSZzyVAeh2Z975zEh42Ei4U5m2Fo=
Received: by 10.86.68.2 with SMTP id q2mr445740fga.3.1231605574355;
        Sat, 10 Jan 2009 08:39:34 -0800 (PST)
Received: from localhost.localdomain (ppp83-237-189-185.pppoe.mtu-net.ru [83.237.189.185])
        by mx.google.com with ESMTPS id e11sm24315066fga.2.2009.01.10.08.39.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jan 2009 08:39:34 -0800 (PST)
X-Mailer: git-send-email 1.6.1.76.gc123b
In-Reply-To: <20090110113903.GB25723@myhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105129>

1. format-patch'ing root commit shouldn't create empty patches
2. With --root it should create a patch for the root commit
3. Similar testcases with two commits in the tree

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---

git format-patch lacks a '--no-root' option, so I used
'git config log.showroot false' to emulate it.



 t/t4033-format-patch-root-commit.sh |   52 +++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100755 t/t4033-format-patch-root-commit.sh

diff --git a/t/t4033-format-patch-root-commit.sh b/t/t4033-format-patch-root-commit.sh
new file mode 100755
index 0000000..846c11c
--- /dev/null
+++ b/t/t4033-format-patch-root-commit.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='Format-patch root commit skipping/allowing'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git config log.showroot false
+	git config format.numbered false
+	echo A > file &&
+	git add file &&
+	git commit -m First
+'
+
+test_patch_count() {
+	cnt=$(grep "^Subject: \[PATCH\]" $1 | wc -l) &&
+	test $cnt = $2
+}
+
+test_patch_is_single() {
+	cnt=$(grep "^Subject: \[PATCH\] $2" $1 | wc -l) &&
+	test $cnt = 1
+}
+
+test_expect_success 'format-patch root commit with showroot = false' '
+	git format-patch -1 &&
+	test_must_fail cat 0001-First.patch
+'
+
+test_expect_success 'format-patch root commit' '
+	git format-patch --root --stdout -5 >root-only.patch &&
+	test_patch_count root-only.patch 1 &&
+	test_patch_is_single root-only.patch First
+'
+
+test_expect_success 'format-patch 2 commits without root' '
+	echo B > file &&
+	git commit -a -m Second &&
+
+	git format-patch --stdout -2 >two-except-root.patch &&
+	test_patch_count two-except-root.patch 1 &&
+	test_patch_is_single two-except-root.patch Second
+'
+
+test_expect_success 'format-patch 2 commits including root' '
+	git format-patch --root --stdout -2 >two-with-root.patch &&
+	test_patch_count two-with-root.patch 2 &&
+	test_patch_is_single two-with-root.patch First &&
+	test_patch_is_single two-with-root.patch Second
+'
+
+test_done
-- 
1.6.1.81.g61cf1
