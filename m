From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/44] request-pull: fix for specific branch
Date: Sat, 28 Sep 2013 17:03:29 -0500
Message-ID: <1380405849-13000-5-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2iQ-0002qV-53
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197Ab3I1WKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:13 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:44279 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab3I1WKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:08 -0400
Received: by mail-oa0-f52.google.com with SMTP id n2so3053219oag.11
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=19xr5bj9zIdGzBelCHWjKraZ9ik06UvW03aZL4+ECBU=;
        b=CfKRQTEu0GJKnEtimedSkn+GW2SVtodGZE9nyePTK7S0jILuOcwDVIFaZYwCzAaNcp
         A0B7uNgI2VpaV5XP/JGajZXXAAUQR2RYhw4n1zuO6GnKV5mwQRMzFgKEwlFGY7Pkh191
         gsJgDQ5LDvZwpR6BbBMtTMxy0eLknPlyPxFzIomWg2zEQOtuTvP2NHB9OxTST44YxUeT
         nDp4Qm86b0H55oJRABvtfbZmsZjH65SBjapHT7YG1EKzHojTEryaUrN3PP/2Op5c4OpD
         TNOJtjOclGVFfl1fwMfTDtTzEx5oYGQ7Ff/Sg5PHW3DIt8iVdjwNQelLxKM4C5r4vn5n
         157A==
X-Received: by 10.182.22.226 with SMTP id h2mr12437003obf.8.1380406208150;
        Sat, 28 Sep 2013 15:10:08 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm25434897oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235524>

Wether we use a symbolic ref, or we specify the branch directly
shouldn't really matter, we would want the branch description either
way.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.sh     | 13 +++++--------
 t/t5150-request-pull.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 6348dac..3c9a982 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -37,15 +37,12 @@ done
 
 base=$1 url=$2 head=${3-HEAD} status=0 branch_name=
 
-headref=$(git symbolic-ref -q "$head")
-if git show-ref -q --verify "$headref"
+headref=$(git rev-parse -q --verify --symbolic-full-name "$head")
+branch_name=${headref#refs/heads/}
+if test "z$branch_name" = "z$headref" ||
+	! git config "branch.$branch_name.description" >/dev/null
 then
-	branch_name=${headref#refs/heads/}
-	if test "z$branch_name" = "z$headref" ||
-		! git config "branch.$branch_name.description" >/dev/null
-	then
-		branch_name=
-	fi
+	branch_name=
 fi
 
 tag_name=$(git describe --exact "$head^0" 2>/dev/null)
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 54f41bf..a9ee96a 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -249,4 +249,36 @@ test_expect_success 'pull request when pushed tag' '
 	! grep "You locally have .* but it does not (yet)" err
 '
 
+test_expect_success 'pull request with branch description' '
+	test_when_finished "(cd local && git checkout - && git branch -D for-upstream)" &&
+	rm -fr downstream.git &&
+	git init --bare downstream.git &&
+	(
+		cd local &&
+		git checkout -b for-upstream master &&
+		git config branch.for-upstream.description "Branch for upstream$LF" &&
+		git push origin for-upstream &&
+		git request-pull initial origin >../request
+	) &&
+	cat request &&
+	grep "(from the branch description for for-upstream local branch)" request &&
+	grep "Branch for upstream" request
+'
+
+test_expect_success 'pull request with branch description from rev' '
+	test_when_finished "(cd local && git checkout - && git branch -D for-upstream)" &&
+	rm -fr downstream.git &&
+	git init --bare downstream.git &&
+	(
+		cd local &&
+		git checkout -b for-upstream master &&
+		git config branch.for-upstream.description "Branch for upstream$LF" &&
+		git push origin for-upstream &&
+		git request-pull initial origin for-upstream >../request
+	) &&
+	cat request &&
+	grep "(from the branch description for for-upstream local branch)" request &&
+	grep "Branch for upstream" request
+'
+
 test_done
-- 
1.8.4-fc
