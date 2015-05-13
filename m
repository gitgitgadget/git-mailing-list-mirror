From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 4/9] t5520: test for failure if index has unresolved entries
Date: Wed, 13 May 2015 17:08:51 +0800
Message-ID: <1431508136-15313-5-git-send-email-pyokagan@gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:09:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSfh-0003JI-8O
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920AbbEMJJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:09:38 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35208 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbbEMJJe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:09:34 -0400
Received: by pabtp1 with SMTP id tp1so44526775pab.2
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HP+yRrUSEbFBwAUT6iTB+VLgaHNkU1XzeG0uQNVY6+E=;
        b=OJIh4ABZUPD1S+ZWCqeKVDfeO6wQUl4a6wlu7vnbOoCh542IcTXXaJME69qJq3J4/F
         mPWAS2Fq6Jbu1wIa1gdWGDCJ7/UOyCejtAhw2dhrIfMCrMNJ5jNTI1wwlfb6gfcnwwmK
         T/irmpAlF2/FdqsTkpwzuY8HBk/NQlcEHUpcwkWOkb3f4WuDbh5aSkqi4l9m0e+y36eg
         fypYNobieeeGFoHw3LwVVMNBwp757eLUzDAhnWO45i6ZbhZgjJQUJMubuuMvFxD2TEEs
         AqnrHsQnsSlzc6U8da8P5cIPvsysHDsWSN9SDbzZ3XM8kg5wrSMDI7hgIG7KDN9Lm0TF
         dj7g==
X-Received: by 10.70.50.199 with SMTP id e7mr35961019pdo.124.1431508173849;
        Wed, 13 May 2015 02:09:33 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id df7sm18645685pdb.32.2015.05.13.02.09.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:09:32 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268953>

Commit d38a30d (Be more user-friendly when refusing to do something
because of conflict., 2010-01-12) introduced code paths to git-pull
which will error out with user-friendly advices if the user is in the
middle of a merge or has unmerged files.

Implement tests to ensure that git-pull will not run, and will print
these advices, if the user is in the middle of a merge or has unmerged
files in the index.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

* Command substitution is now quoted.

 t/t5520-pull.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e53d8e9..8e95402 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -164,6 +164,26 @@ test_expect_success 'fail if upstream branch does not exist' '
 	verbose test "$(cat file)" = file
 '
 
+test_expect_success 'fail if the index has unresolved entries' '
+	git checkout -b third second^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	verbose test "$(cat file)" = file &&
+	echo modified2 >file &&
+	git commit -a -m modified2 &&
+	verbose test -z "$(git ls-files -u)" &&
+	test_must_fail git pull . second &&
+	verbose test -n "$(git ls-files -u)" &&
+	cp file expected &&
+	test_must_fail git pull . second 2>err &&
+	test_i18ngrep "you have unmerged files" err &&
+	test_cmp expected file &&
+	git add file &&
+	verbose test -z "$(git ls-files -u)" &&
+	test_must_fail git pull . second 2>err &&
+	test_i18ngrep "have not concluded your merge" err &&
+	test_cmp expected file
+'
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
