From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 28/48] remote-hg: add test for big push
Date: Fri, 24 May 2013 21:29:44 -0500
Message-ID: <1369449004-17981-29-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4II-0002Nn-ED
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab3EYCdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:09 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:37816 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab3EYCdI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:08 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so6241002obb.16
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=amyDm4CFj6X2BBK7Ppz/FCguRSvB456W9eqKNrEj6IY=;
        b=lk0YzcywKayYXE3mk5isdKWv3KH6NboiGH3cDR9D5YlXLG0txHfY4xGr7oUaxdh0d1
         0umFXtKQTNUAtj8C6L6azDQEi96nLQonVrQ5aa8bTJQ60wQoLXqwhz4j40rerQcdMUVp
         t9FsM1B9A02FKk1ctyO5JZBw9jL+6lwjWRNX8TOsrtSvdwDdq8cfaFGfRzrrgHX8Y2MK
         SNzimEMo93x0uIq9Nz1Nedxvvuws3L4bqT1FeUmhEZRYGOT21n71WOHYHQaze89JZ/2v
         JGtF9y/uH+nwQNV4oDA2zNX+yamFQx5NiejmPFqSR1YgxvFtoATIqm7BhV21DzQqfSLw
         5++g==
X-Received: by 10.182.220.161 with SMTP id px1mr13402843obc.82.1369449188016;
        Fri, 24 May 2013 19:33:08 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm20029353oby.12.2013.05.24.19.33.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225442>

With lots branches and bookmarks, non-ff, updated and new.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 113 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 6 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 64f0849..1855d1a 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -27,15 +27,25 @@ check () {
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
 
 setup () {
@@ -385,4 +395,95 @@ test_expect_failure 'remote new bookmark multiple branch head' '
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
+	hg bookmark -i good_bmark &&
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
1.8.3.rc3.312.g47657de
