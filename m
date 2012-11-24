From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 09/14] remote-testgit: exercise more features
Date: Sat, 24 Nov 2012 04:17:09 +0100
Message-ID: <1353727034-24698-10-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:18:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6G9-0002E8-TC
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627Ab2KXDSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:18:00 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594Ab2KXDR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:17:59 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SW1kPHUng3qJTgbshCaTba0kUKyk0WJBKYvENQdcIqk=;
        b=1It7vgvqeqW32IQJPNykMiEL2YJBnlu04DJpg3TkM8MRhyLOgQKfq/6YR1E9v0zlPE
         /n7gcX64smhA9UsLx0SNPAmtNqXSyQov6jV0dzIp+NpyO1b8AYv8q00FbF5qMgXPRqKW
         9oiB+g8NPSpyxq2NV8yUPUxn/fXzplq/EYq0LQnAru87FB3CJTy4R/3ugn0uSG+fax7X
         cuLDzR/YZNys3pHlGTyPweQENmQh4IakFfRdVPt2puyBZy0MCo7TQa0peH2CWvyAgU1m
         CYu9Z4jQYI451X6xHplFxrsgUV/HyZu9T1XN6pzi+qY2/nWLcJgdsbEYY6ftmp7Figdl
         BjMA==
Received: by 10.204.136.209 with SMTP id s17mr1681212bkt.13.1353727079111;
        Fri, 23 Nov 2012 19:17:59 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id t11sm5463330bkv.11.2012.11.23.19.17.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:17:58 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210293>

Unfortunately a lot of these tests fail.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit        | 38 +++++++++++++++++++++++-----------
 t/t5801-remote-helpers.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index bf4d22c..e140282 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -6,17 +6,25 @@ url=$2
 
 dir="$GIT_DIR/testgit/$alias"
 prefix="refs/testgit/$alias"
-refspec="refs/heads/*:${prefix}/heads/*"
 
-gitmarks="$dir/git.marks"
-testgitmarks="$dir/testgit.marks"
+default_refspec="refs/heads/*:${prefix}/heads/*"
+
+refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
+
+test -z "$refspec" && prefix="refs"
 
 export GIT_DIR="$url/.git"
 
 mkdir -p "$dir"
 
-test -e "$gitmarks" || > "$gitmarks"
-test -e "$testgitmarks" || > "$testgitmarks"
+if test -z "$GIT_REMOTE_TESTGIT_NO_MARKS"
+then
+	gitmarks="$dir/git.marks"
+	testgitmarks="$dir/testgit.marks"
+	test -e "$gitmarks" || >"$gitmarks"
+	test -e "$testgitmarks" || >"$testgitmarks"
+	testgitmarks_args=( "--"{import,export}"-marks=$testgitmarks" )
+fi
 
 while read line
 do
@@ -24,9 +32,12 @@ do
 	capabilities)
 		echo 'import'
 		echo 'export'
-		echo "refspec $refspec"
-		echo "*import-marks $gitmarks"
-		echo "*export-marks $gitmarks"
+		test -n "$refspec" && echo "refspec $refspec"
+		if test -n "$gitmarks"
+		then
+			echo "*import-marks $gitmarks"
+			echo "*export-marks $gitmarks"
+		fi
 		echo
 		;;
 	list)
@@ -45,13 +56,16 @@ do
 			test "${line%% *}" != "import" && break
 		done
 
-		echo "feature import-marks=$gitmarks"
-		echo "feature export-marks=$gitmarks"
-		git fast-export --use-done-feature --{import,export}-marks="$testgitmarks" $refs |
+		if test -n "$gitmarks"
+		then
+			echo "feature import-marks=$gitmarks"
+			echo "feature export-marks=$gitmarks"
+		fi
+		git fast-export --use-done-feature "${testgitmarks_args[@]}" $refs |
 		sed -e "s#refs/heads/#${prefix}/heads/#g"
 		;;
 	export)
-		git fast-import --{import,export}-marks="$testgitmarks" --quiet
+		git fast-import "${testgitmarks_args[@]}" --quiet
 		echo
 		;;
 	'')
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index bc0b5f7..12ae256 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -110,4 +110,56 @@ test_expect_failure 'push new branch with old:new refspec' '
 	compare_refs local HEAD server refs/heads/new-refspec
 '
 
+test_expect_success 'cloning without refspec' '
+	GIT_REMOTE_TESTGIT_REFSPEC="" \
+	git clone "testgit::${PWD}/server" local2 &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_success 'pulling without refspecs' '
+	(cd local2 &&
+	git reset --hard &&
+	GIT_REMOTE_TESTGIT_REFSPEC="" git pull) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pushing without refspecs' '
+	test_when_finished "(cd local2 && git reset --hard origin)" &&
+	(cd local2 &&
+	echo content >>file &&
+	git commit -a -m ten &&
+	GIT_REMOTE_TESTGIT_REFSPEC="" git push) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_success 'pulling with straight refspec' '
+	(cd local2 &&
+	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git pull) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pushing with straight refspec' '
+	test_when_finished "(cd local2 && git reset --hard origin)" &&
+	(cd local2 &&
+	echo content >>file &&
+	git commit -a -m eleven &&
+	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git push) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_success 'pulling without marks' '
+	(cd local2 &&
+	GIT_REMOTE_TESTGIT_NO_MARKS=1 git pull) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pushing without marks' '
+	test_when_finished "(cd local2 && git reset --hard origin)" &&
+	(cd local2 &&
+	echo content >>file &&
+	git commit -a -m twelve &&
+	GIT_REMOTE_TESTGIT_NO_MARKS=1 git push) &&
+	compare_refs local2 HEAD server HEAD
+'
+
 test_done
-- 
1.8.0
