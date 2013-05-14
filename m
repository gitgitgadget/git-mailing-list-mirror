From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 34/47] remote-hg: add test for big push
Date: Mon, 13 May 2013 23:36:57 -0500
Message-ID: <1368506230-19614-35-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc731-000504-J0
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921Ab3ENEkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:35 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:61470 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895Ab3ENEkb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:31 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so101132oag.27
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hIPo7oKElpoBmv5xA51bSMao+TiNWUXx+QKf+q9KcSk=;
        b=iTC0cqVhNE3Dk/hGS3tOacTDP/4Trk9hJBDg69YMpiklJCq2P/keor8m5kwywYEr9y
         9cIVSLSlVkdNdVrxmiXIn/v71Ecx6FBVD81Ltz0wn4G5r46HKHRGMJFoPZ1qM3UTES4x
         6lsjJONMIle/Z4Pg/9xSTZ85QUfZa+L7NjPShTLRiCj0A5QE2MKkNFuZBPugMpMkX1bP
         bi+OuF12Qm6213UVkGjBXxzyQE6ivu7z35KDEv4qycYCHBbBfDG9q2LZs3MQMR50jjqr
         4G6sgRP36BOR9RHsXjzuW9P9TuaPMAapdN6Xbiagy0j6Dnb3xmgYAuDA4XSOjQayHW7B
         8SHg==
X-Received: by 10.60.142.7 with SMTP id rs7mr1595348oeb.106.1368506431089;
        Mon, 13 May 2013 21:40:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id fm10sm10639094obb.4.2013.05.13.21.40.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224270>

With lots branches and bookmarks, non-ff, updated and new.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 113 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 6 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index c3fa04d..d98c7a7 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -27,15 +27,25 @@ check () {
 }
 
 check_bookmark () {
-	echo $3 > expected &&
-	hg -R $1 log -r "bookmark('$2')" --template '{desc}\n' > actual &&
-	test_cmp expected actual
+	if [ -n "$3" ]; then
+		echo $3 > expected &&
+		hg -R $1 log -r "bookmark('$2')" --template '{desc}\n' > actual &&
+		test_cmp expected actual
+	else
+		hg -R $1 bookmarks > out &&
+		! grep $2 out
+	fi
 }
 
 check_branch () {
-	echo $3 > expected &&
-	hg -R $1 log -r $2 --template '{desc}\n' > actual &&
-	test_cmp expected actual
+	if [ -n "$3" ]; then
+		echo $3 > expected &&
+		hg -R $1 log -r $2 --template '{desc}\n' > actual &&
+		test_cmp expected actual
+	else
+		hg -R $1 branches > out &&
+		! grep $2 out
+	fi
 }
 
 setup () {
@@ -325,4 +335,95 @@ test_expect_failure 'remote new bookmark multiple branch head' '
 	check_bookmark hgrepo feature-c feature-c
 '
 
+# cleanup previous stuff
+rm -rf hgrepo
+
+test_expect_failure 'remote big push' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero &&
+	hg bookmark bad_bmark1 &&
+	echo one > content &&
+	hg commit -m one &&
+	hg bookmark bad_bmark2 &&
+	hg bookmark good_bmark &&
+	hg bookmark -i &&
+	hg -q branch good_branch &&
+	echo "good branch" > content &&
+	hg commit -m "good branch" &&
+	hg -q branch bad_branch &&
+	echo "bad branch" > content &&
+	hg commit -m "bad branch"
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd gitrepo &&
+	echo two > content &&
+	git commit -q -a -m two &&
+
+	git checkout -q good_bmark &&
+	echo three > content &&
+	git commit -q -a -m three &&
+
+	git checkout -q bad_bmark1 &&
+	git reset --hard HEAD^ &&
+	echo four > content &&
+	git commit -q -a -m four &&
+
+	git checkout -q bad_bmark2 &&
+	git reset --hard HEAD^ &&
+	echo five > content &&
+	git commit -q -a -m five &&
+
+	git checkout -q -b new_bmark master &&
+	echo six > content &&
+	git commit -q -a -m six &&
+
+	git checkout -q branches/good_branch &&
+	echo seven > content &&
+	git commit -q -a -m seven &&
+	echo eight > content &&
+	git commit -q -a -m eight &&
+
+	git checkout -q branches/bad_branch &&
+	git reset --hard HEAD^ &&
+	echo nine > content &&
+	git commit -q -a -m nine &&
+
+	git checkout -q -b branches/new_branch master &&
+	echo ten > content &&
+	git commit -q -a -m ten &&
+
+	test_expect_code 1 git push origin master \
+		good_bmark bad_bmark1 bad_bmark2 new_bmark \
+		branches/good_branch branches/bad_branch \
+		branches/new_branch 2> error &&
+
+	grep "^   [a-f0-9]*\.\.[a-f0-9]* *master -> master$" error &&
+	grep "^   [a-f0-9]*\.\.[a-f0-9]* *good_bmark -> good_bmark$" error &&
+	grep "^ \* \[new branch\] *new_bmark -> new_bmark$" error &&
+	grep "^ ! \[rejected\] *bad_bmark2 -> bad_bmark2 (non-fast-forward)$" error &&
+	grep "^ ! \[rejected\] *bad_bmark1 -> bad_bmark1 (non-fast-forward)$" error &&
+	grep "^   [a-f0-9]*\.\.[a-f0-9]* *branches/good_branch -> branches/good_branch$" error &&
+	grep "^ ! \[rejected\] *branches/bad_branch -> branches/bad_branch (non-fast-forward)$" error &&
+	grep "^ \* \[new branch\] *branches/new_branch -> branches/new_branch$" error
+	) &&
+
+	check_branch hgrepo default one &&
+	check_branch hgrepo good_branch "good branch" &&
+	check_branch hgrepo bad_branch "bad branch" &&
+	check_branch hgrepo new_branch '' &&
+	check_bookmark hgrepo good_bmark one &&
+	check_bookmark hgrepo bad_bmark1 one &&
+	check_bookmark hgrepo bad_bmark2 one &&
+	check_bookmark hgrepo new_bmark ''
+'
+
 test_done
-- 
1.8.3.rc1.579.g184e698
