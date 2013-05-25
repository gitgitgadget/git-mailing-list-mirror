From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 43/48] remote-hg: add check_push() helper
Date: Fri, 24 May 2013 21:29:59 -0500
Message-ID: <1369449004-17981-44-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:34:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Iz-0002wk-8x
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862Ab3EYCd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:57 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58785 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849Ab3EYCdz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:55 -0400
Received: by mail-ob0-f174.google.com with SMTP id fb19so6268391obc.33
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=P5bM5QSbVV4RbmSG9P2Cf0z2XC0BnxFvTbiQmMNzlF0=;
        b=aS0aQI46VMzBSBxk0GDs2IFFQfR0F/gY+/OsG5vTZW1RIEkxUESbpzetvDuekFdF9O
         0tCLWnoj1iQnX2REy5ySPTQ5lYMlQlxxu0Tm84zHzMojv+zpmFy9Zr+eTVYlWFzngsx2
         oXl9jCSmJRSOe2JSyB/tRJw+8J8oePc71L+YpLGT4FdLvcz8RxjqzXgekjkxFDYbrDEF
         N2q0lxdwuXke5vzsOJbtfputCSyzOVsS+1uXP2lhHcMVvhUe8VsTs8L0ODfIMMjEC6i0
         fD+HZAMnZlu2io+lpkrb/z5+2ftCzgEzCagV7KEpOVLEGVlP8RoXF3VDcWc7gl82W/YR
         5+rA==
X-Received: by 10.182.237.6 with SMTP id uy6mr11924392obc.31.1369449234849;
        Fri, 24 May 2013 19:33:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm20013796obb.14.2013.05.24.19.33.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225458>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 66 +++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index f594584..aeab48a 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -48,6 +48,38 @@ check_bookmark () {
 	fi
 }
 
+check_push () {
+	local expected_ret=$1 ret=0 ref_ret=0 IFS=':'
+
+	shift
+	git push origin "$@" 2> error
+	ret=$?
+	cat error
+
+	while read branch kind
+	do
+		case "$kind" in
+		'new')
+			grep "^ \* \[new branch\] *${branch} -> ${branch}$" error || ref_ret=1
+			;;
+		'non-fast-forward')
+			grep "^ ! \[rejected\] *${branch} -> ${branch} (non-fast-forward)$" error || ref_ret=1
+			;;
+		'')
+			grep "^   [a-f0-9]*\.\.[a-f0-9]* *${branch} -> ${branch}$" error || ref_ret=1
+			;;
+		esac
+		let 'ref_ret' && echo "match for '$branch' failed" && break
+	done
+
+	if let 'expected_ret != ret || ref_ret'
+	then
+		return 1
+	fi
+
+	return 0
+}
+
 setup () {
 	(
 	echo "[ui]"
@@ -344,8 +376,9 @@ test_expect_success 'remote push diverged' '
 	cd gitrepo &&
 	echo diverge > content &&
 	git commit -a -m diverged &&
-	test_expect_code 1 git push 2> error &&
-	grep "^ ! \[rejected\] *master -> master (non-fast-forward)$" error
+	check_push 1 <<-EOF
+	master:non-fast-forward
+	EOF
 	) &&
 
 	check_branch hgrepo default bump
@@ -373,8 +406,9 @@ test_expect_success 'remote update bookmark diverge' '
 	git checkout --quiet diverge &&
 	echo diverge > content &&
 	git commit -a -m diverge &&
-	test_expect_code 1 git push 2> error &&
-	grep "^ ! \[rejected\] *diverge -> diverge (non-fast-forward)$" error
+	check_push 1 <<-EOF
+	diverge:non-fast-forward
+	EOF
 	) &&
 
 	check_bookmark hgrepo diverge "bump bookmark"
@@ -468,19 +502,17 @@ test_expect_success 'remote big push' '
 
 	(
 	cd gitrepo &&
-	test_expect_code 1 git push origin master \
-		good_bmark bad_bmark1 bad_bmark2 new_bmark \
-		branches/good_branch branches/bad_branch \
-		branches/new_branch 2> error &&
-
-	grep "^   [a-f0-9]*\.\.[a-f0-9]* *master -> master$" error &&
-	grep "^   [a-f0-9]*\.\.[a-f0-9]* *good_bmark -> good_bmark$" error &&
-	grep "^ \* \[new branch\] *new_bmark -> new_bmark$" error &&
-	grep "^ ! \[rejected\] *bad_bmark2 -> bad_bmark2 (non-fast-forward)$" error &&
-	grep "^ ! \[rejected\] *bad_bmark1 -> bad_bmark1 (non-fast-forward)$" error &&
-	grep "^   [a-f0-9]*\.\.[a-f0-9]* *branches/good_branch -> branches/good_branch$" error &&
-	grep "^ ! \[rejected\] *branches/bad_branch -> branches/bad_branch (non-fast-forward)$" error &&
-	grep "^ \* \[new branch\] *branches/new_branch -> branches/new_branch$" error
+
+	check_push 1 --all <<-EOF
+	master
+	good_bmark
+	branches/good_branch
+	new_bmark:new
+	branches/new_branch:new
+	bad_bmark1:non-fast-forward
+	bad_bmark2:non-fast-forward
+	branches/bad_branch:non-fast-forward
+	EOF
 	) &&
 
 	check_branch hgrepo default one &&
-- 
1.8.3.rc3.312.g47657de
