From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/44] request-pull: fix exact match checking
Date: Sat, 28 Sep 2013 17:03:31 -0500
Message-ID: <1380405849-13000-7-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2iW-0002uM-SX
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214Ab3I1WKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:17 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:57241 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190Ab3I1WKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:14 -0400
Received: by mail-ob0-f170.google.com with SMTP id va2so4189670obc.1
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DkoFBOQkS7oZa32eiAqQXMrcALD+1VN4kWbViTSPipI=;
        b=o01CVeobLQCAcb9GpdE+JkCroozyWZwaj02co9B0QrQQrNliCA1VxIdh/T6q3hKyox
         e9z3opK8gpUzU0a0OelqDWH4Q4qXWKW+jWOACRY0B9hXG+VEpF/waJEUM/rgLajkuRYA
         90rd6cZoA8s7goh2SUX8GNZSR9hkxpXlCHKuq+IoRTj7ZoW60Q0dwZ7qC+/UXanCigJB
         Q4EXCvBxM2mYCoXVeeGdF6iyEHZ6gguubFD/Dl4MHj9fIQaGJJbGx7AZarVks+ktV2Nb
         tzK1HynYeBeOOK3/f2tl7NzW9u6XDLvG1eNvfKQwhAxOf6gmCCXyrzrc8X3dMCEKZ2kC
         iLsg==
X-Received: by 10.182.181.34 with SMTP id dt2mr12209270obc.30.1380406213834;
        Sat, 28 Sep 2013 15:10:13 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id gc8sm19527351obb.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235526>

It obviously never worked, refs don't start with '/'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.sh     | 10 ++++++++--
 t/t5150-request-pull.sh | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 3e510ca..c970244 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -38,6 +38,11 @@ done
 base=$1 url=$2 head=${3-HEAD} status=0 branch_name=
 
 headref=$(git rev-parse -q --verify --symbolic-full-name "$head")
+if test "$headref" = "HEAD"
+then
+	headref=
+fi
+
 branch_name=${headref#refs/heads/}
 if test "z$branch_name" = "z$headref" ||
 	! git config "branch.$branch_name.description" >/dev/null
@@ -90,8 +95,9 @@ find_matching_ref='
 			$tagged = $found;
 			last;
 		}
-		if ($ref =~ m|/\Q$ARGV[0]\E$|) {
+		if ($ref eq $ARGV[0]) {
 			$exact = $found;
+			last;
 		}
 	}
 	if ($tagged) {
@@ -103,7 +109,7 @@ find_matching_ref='
 	}
 '
 
-ref=$(git ls-remote "$url" | perl -e "$find_matching_ref" "$head" "$headrev" "$tag_name")
+ref=$(git ls-remote "$url" | perl -e "$find_matching_ref" "$headref" "$headrev" "$tag_name")
 
 url=$(git ls-remote --get-url "$url")
 
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index a9ee96a..73f0369 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -281,4 +281,25 @@ test_expect_success 'pull request with branch description from rev' '
 	grep "Branch for upstream" request
 '
 
+test_expect_success 'pull request with exact match' '
+	test_when_finished "(cd local && git checkout - && git branch -D for-upstream)" &&
+	rm -fr downstream.git &&
+	git init --bare downstream.git &&
+	(
+		cd local &&
+		git checkout -b for-upstream master &&
+		git push origin master:for-upstream master:zeebra &&
+		git request-pull initial origin for-upstream >../request
+	) &&
+	cat request &&
+	sed -nf read-request.sed <request >digest &&
+	cat digest &&
+	{
+		read task &&
+		read repository &&
+		read branch
+	} <digest &&
+	test "$branch" = for-upstream
+'
+
 test_done
-- 
1.8.4-fc
