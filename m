From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 3/5] t4150: test applying StGit series
Date: Mon,  8 Jun 2015 23:48:49 +0800
Message-ID: <1433778531-18260-4-git-send-email-pyokagan@gmail.com>
References: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Chris Packham <judge.packham@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 17:50:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zJX-00016Z-S1
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbbFHPuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:50:09 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36805 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbbFHPuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:50:00 -0400
Received: by pdjm12 with SMTP id m12so107394716pdj.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n9KFtNvQeakYnpUoTB6vBbQx4oyCw9BEEaeQDKO9+40=;
        b=TK9gu57gAD78cnB5XwUiFBk5c1gKE+j+FR+uDR8W4yM5BJdoe5g4BhqRGzlHM0Q1Ee
         3Pghglxti9D8KcK8/rv07+Qmwz09ydWskryAqr3egCUB/srlq2zhRw9sWei/4Psns1NF
         2LeI6J4TwVBglTXJUut+Kf09kzHncWuGyB5gfDMPnkA4r4TExkxOYs9ghA4PLuERjJE/
         6NQEgHe1pAvgtsam+0BVfu+bqoTsjc55rfcuyas5Meafp4cGaYbb+G9Kpvp/SjtFa/G3
         vLVIe0LLoRO7yI70yBcyN3yjEDKAsOTf7jRXvJwu4ofR9l5FDoukIl9El1GD6qkKH+ZA
         rEkA==
X-Received: by 10.67.4.201 with SMTP id cg9mr2857273pad.53.1433778599238;
        Mon, 08 Jun 2015 08:49:59 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id vn7sm2998792pab.26.2015.06.08.08.49.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jun 2015 08:49:57 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271056>

A StGit series is a directory containing a "series" file which begins
with the line:

	# This series applies on GIT commit XXXXX

where XXXXX is the commit ID that the patch series applies on. Every
following line names a patch in the directory to be applied.

Test that git-am, when given this "series" file, is able to detect it as
an StGit series and apply all the patches in the series.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 51962e4..7aad8f8 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -116,6 +116,13 @@ test_expect_success setup '
 		echo "---" &&
 		git diff-tree --no-commit-id --stat -p second
 	} >patch1-stgit.eml &&
+	mkdir stgit-series &&
+	cp patch1-stgit.eml stgit-series/patch &&
+	{
+		echo "# This series applies on GIT commit $(git rev-parse first)" &&
+		echo "patch"
+	} >stgit-series/series &&
+
 
 	sed -n -e "3,\$p" msg >file &&
 	git add file &&
@@ -219,6 +226,16 @@ test_expect_success 'am --patch-format=stgit applies stgit patch' '
 	test_cmp_rev second^ HEAD^
 '
 
+test_expect_success 'am applies stgit series' '
+	rm -fr .git/rebase-apply &&
+	git checkout -f first &&
+	git am stgit-series/series &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	test_cmp_rev second HEAD &&
+	test_cmp_rev second^ HEAD^
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.1.4
