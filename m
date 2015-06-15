From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 3/5] t4150: test applying StGit series
Date: Mon, 15 Jun 2015 19:08:11 +0800
Message-ID: <1434366493-27155-4-git-send-email-pyokagan@gmail.com>
References: <1434366493-27155-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 13:09:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4SGB-0002jV-Os
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 13:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbbFOLIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 07:08:54 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33562 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbFOLIv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 07:08:51 -0400
Received: by pdjn11 with SMTP id n11so70811997pdj.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 04:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n9KFtNvQeakYnpUoTB6vBbQx4oyCw9BEEaeQDKO9+40=;
        b=p9b9IlnrtqUvLC1gPCZTM5y4M5isTFd+yMR3KEIFOhixxpEU9fGoACuFA+ZxhhSmhe
         M8GFgQ2gehp6oQRJYnsNr69+Y1ENdUf7eTwoqSxUeIVo3lgPud6KHCcYx7v6Hj5I+Dwg
         2al/Ww9itjNOitQJAEy1l7S4XfKS4eEq6Nse4I4Ib6bmXHV6AaH7QP/p58hCToERIm3r
         RnF0iP6Wk7OoggaObfTosKIJXsQlIxjaVJ7JvpUuefGi9EVH2AHy9jK4IOgkjCZECSas
         ysitin9T/QhwX6sgcFcWx3cya9GzhQ8q6wjg2n4K6VV3sawgNnLSQzbv0D2KZqfo5gYW
         j/vQ==
X-Received: by 10.67.4.138 with SMTP id ce10mr47737525pad.102.1434366530767;
        Mon, 15 Jun 2015 04:08:50 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id jt2sm11886795pbc.21.2015.06.15.04.08.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2015 04:08:49 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434366493-27155-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271674>

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
