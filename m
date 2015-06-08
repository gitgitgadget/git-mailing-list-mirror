From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 1/5] t4150: test applying StGit patch
Date: Mon,  8 Jun 2015 23:48:47 +0800
Message-ID: <1433778531-18260-2-git-send-email-pyokagan@gmail.com>
References: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Chris Packham <judge.packham@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 17:50:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zJs-0001R1-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbbFHPuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:50:18 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36717 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbbFHPty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:49:54 -0400
Received: by pdjm12 with SMTP id m12so107392853pdj.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mK2lCnoY8e9drmQnlXIuqjbTj0Iynmh1QVtTxEPTmUc=;
        b=HgusoMPIlu4kngxcNbg6FwSNLoI9IP6cLtot4YHB+/GezpJL397sTkFuOo8vOc19wl
         3qHWRGKOrJta0H0rdpx8iDyi4UQOWmbyMCd+qWZJngw1RzCuxiICLItvDWAbsl9oNyqp
         +98HA214wAM0go2SJezkTjBZ4K6lMgGR6LUNDiOee6k8enqJD/A1xBTbFPQpjQhOK9/I
         nQuyQVIzfqRlnxZwtSwYH5rDNZZGs2LUxnTwEtSpkvZkTIDXTBHddbV00JK84EIDHa8w
         rfqZaQA2f/37DEBXFuZ3I8lTzOYyZGA4HRLd+a2YyNgnj9mJXOew5njfkNIDiRjemZad
         oKcA==
X-Received: by 10.70.133.66 with SMTP id pa2mr31037363pdb.164.1433778593572;
        Mon, 08 Jun 2015 08:49:53 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id vn7sm2998792pab.26.2015.06.08.08.49.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jun 2015 08:49:52 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271057>

By default, an StGit patch separates the subject from the commit message
and headers as follows:

	$subject

	From: $author_name <$author_email>

	$message
	---
	$diffstats

We test git-am's ability to detect such a patch as an StGit patch, and
its ability to be able to extract the commit author, date and message
from such a patch.

Based-on-patch-by: Chris Packham <judge.packham@gmail.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 306e6f3..0ead529 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -104,6 +104,18 @@ test_expect_success setup '
 		echo "X-Fake-Field: Line Three" &&
 		git format-patch --stdout first | sed -e "1d"
 	} > patch1-ws.eml &&
+	{
+		sed -ne "1p" msg &&
+		echo &&
+		echo "From: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" &&
+		echo "Date: $GIT_AUTHOR_DATE" &&
+		echo &&
+		sed -e "1,2d" msg &&
+		echo &&
+		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
+		echo "---" &&
+		git diff-tree --no-commit-id --stat -p second
+	} >patch1-stgit.eml &&
 
 	sed -n -e "3,\$p" msg >file &&
 	git add file &&
@@ -187,6 +199,16 @@ test_expect_success 'am applies patch e-mail with preceding whitespace' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_success 'am applies stgit patch' '
+	rm -fr .git/rebase-apply &&
+	git checkout -f first &&
+	git am patch1-stgit.eml &&
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
