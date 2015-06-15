From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 1/5] t4150: test applying StGit patch
Date: Mon, 15 Jun 2015 19:08:09 +0800
Message-ID: <1434366493-27155-2-git-send-email-pyokagan@gmail.com>
References: <1434366493-27155-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 13:08:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4SG9-0002jV-Ti
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 13:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbbFOLIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 07:08:48 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34670 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbFOLIp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 07:08:45 -0400
Received: by pdbki1 with SMTP id ki1so70799664pdb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 04:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mK2lCnoY8e9drmQnlXIuqjbTj0Iynmh1QVtTxEPTmUc=;
        b=XCk7WxbmLKtT9/3uAdh79AB8RQw+14SleZImVDtTbK7qzxWrwt3BuALkj8pvndnmos
         xBOQzbSMdZnNG2EqRnU4wbi8TtP1kbMos4xV0DaEWQXXqrQlzlbJ9Z730yfeAiejGnC7
         EnxghIBHE0k8D8M2gKK5J3S+T3qiBOOGsyFhL3Qc8FiUBSfxe/d9vgG5U4ESA7Msfpoo
         OclNhWx8E8mJX3WHKW0OoAQMF40XAw3PJx+MEwSUNg+v0I7xL73I2oGGOynq4kn89piZ
         jSX3vNJoIoK565SAIpAAar8AHgqVeCU/1x41RPxki6PTD8fW7DfujXfXqsiYK+Ueu8W7
         5mjA==
X-Received: by 10.66.194.201 with SMTP id hy9mr48129201pac.140.1434366524441;
        Mon, 15 Jun 2015 04:08:44 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id jt2sm11886795pbc.21.2015.06.15.04.08.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2015 04:08:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434366493-27155-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271673>

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
