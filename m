From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 00/14] fast-export and remote-testgit improvements
Date: Sat, 24 Nov 2012 04:17:00 +0100
Message-ID: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Nov 24 04:17:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6FZ-0001mI-2i
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab2KXDR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:17:29 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab2KXDR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:17:28 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Z/klSh8lt8zxVf4GbAadZVXqHF1zphFLCSDnxwuTAis=;
        b=0uMKMTsIQncGAdYXwBU5OsG7lPSrxJCe9xVgOEq1Lq09p2W+/fONkhf242A9CE9m25
         WwAAbmHKDndaHBp33mDGnYfXpr9VCeQbBbMQmt3S1Y52UpA+1wru/3mfaENlnBcRxqLS
         c7VsG65pQscGetyak0Qb1ZtMJWWPkbSqn1UMlDd+fHR+hLDwzjAjlIz6W0u3d6BIdeVZ
         V8FDWlH20rj1IC4tYUz2egEcKA3umV0LgyJen/3HkQmN36cwIrnREPlJZ139eTaeCVmT
         K7JHO47YICl1Go9ThN6V2F5KoT+Xkqt2jfApfVn4/aX/HwtWlDUUL2ZX1MjUwf22UyBM
         iWcA==
Received: by 10.204.11.78 with SMTP id s14mr1715759bks.118.1353727047268;
        Fri, 23 Nov 2012 19:17:27 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id e22sm5472499bke.14.2012.11.23.19.17.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:17:26 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210284>

Hi,

I'm rerolling this series with the changes fron Junio, plus a bit more cleanups.

I dropped the last patch, because I found an issue and a separate patch series
would take care of that. Other than that the main changes remain the same.

The old remote-testgit is now remote-testpy (as it's testing the python
framework, not really remote helpers). The tests are simplified, and exercise
more features of transport-helper, and unsuprisingly, find more bugs.

Cheers.

Interdiff:

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 60e8f3b..31bfbee 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -529,9 +529,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 		 * sure it gets properly updated eventually.
 		 */
 		if (commit->util || commit->object.flags & SHOWN)
-			if (!(commit->object.flags & UNINTERESTING))
-				string_list_append(extra_refs, full_name)->util = commit;
-
+			string_list_append(extra_refs, full_name)->util = commit;
 		if (!commit->util)
 			commit->util = full_name;
 	}
@@ -620,7 +618,7 @@ static void import_marks(char *input_file)
 		if (object->flags & SHOWN)
 			error("Object %s already has a mark", sha1_to_hex(sha1));
 
-		if (object->type != 1)
+		if (object->type != OBJ_COMMIT)
 			/* only commits */
 			continue;
 
diff --git a/git-remote-testgit b/git-remote-testgit
index 4a00387..0389545 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -11,9 +11,6 @@ default_refspec="refs/heads/*:${prefix}/heads/*"
 
 refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
 
-gitmarks="$dir/git.marks"
-testgitmarks="$dir/testgit.marks"
-
 test -z "$refspec" && prefix="refs"
 
 export GIT_DIR="$url/.git"
@@ -22,11 +19,11 @@ mkdir -p "$dir"
 
 if test -z "$GIT_REMOTE_TESTGIT_NO_MARKS"
 then
+	gitmarks="$dir/git.marks"
+	testgitmarks="$dir/testgit.marks"
 	test -e "$gitmarks" || >"$gitmarks"
 	test -e "$testgitmarks" || >"$testgitmarks"
-else
-	>"$gitmarks"
-	>"$testgitmarks"
+	testgitmarks_args=( "--"{import,export}"-marks=$testgitmarks" )
 fi
 
 while read line
@@ -36,8 +33,11 @@ do
 		echo 'import'
 		echo 'export'
 		test -n "$refspec" && echo "refspec $refspec"
-		echo "*import-marks $gitmarks"
-		echo "*export-marks $gitmarks"
+		if test -n "$gitmarks"
+		then
+			echo "*import-marks $gitmarks"
+			echo "*export-marks $gitmarks"
+		fi
 		echo
 		;;
 	list)
@@ -56,17 +56,20 @@ do
 			test "${line%% *}" != "import" && break
 		done
 
-		echo "feature import-marks=$gitmarks"
-		echo "feature export-marks=$gitmarks"
+		if test -n "$gitmarks"
+		then
+			echo "feature import-marks=$gitmarks"
+			echo "feature export-marks=$gitmarks"
+		fi
 		echo "feature done"
-		git fast-export --{import,export}-marks="$testgitmarks" $refs |
+		git fast-export "${testgitmarks_args[@]}" $refs |
 		sed -e "s#refs/heads/#${prefix}/heads/#g"
 		echo "done"
 		;;
 	export)
 		before=$(git for-each-ref --format='%(refname) %(objectname)')
 
-		git fast-import --{import,export}-marks="$testgitmarks" --quiet
+		git fast-import "${testgitmarks_args[@]}" --quiet
 
 		after=$(git for-each-ref --format='%(refname) %(objectname)')
 
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index b6cc5c0..b2782a2 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -112,37 +112,40 @@ test_expect_success 'pulling without refspecs' '
 '
 
 test_expect_failure 'pushing without refspecs' '
+	test_when_finished "(cd local2 && git reset --hard origin)" &&
 	(cd local2 &&
 	echo content >>file &&
-	git commit -a -m three &&
+	git commit -a -m ten &&
 	GIT_REMOTE_TESTGIT_REFSPEC="" git push) &&
 	compare_refs local2 HEAD server HEAD
 '
 
-test_expect_failure 'pulling with straight refspec' '
+test_expect_success 'pulling with straight refspec' '
 	(cd local2 &&
 	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git pull) &&
 	compare_refs local2 HEAD server HEAD
 '
 
 test_expect_failure 'pushing with straight refspec' '
+	test_when_finished "(cd local2 && git reset --hard origin)" &&
 	(cd local2 &&
 	echo content >>file &&
-	git commit -a -m three &&
+	git commit -a -m eleven &&
 	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git push) &&
 	compare_refs local2 HEAD server HEAD
 '
 
-test_expect_failure 'pulling without marks' '
+test_expect_success 'pulling without marks' '
 	(cd local2 &&
 	GIT_REMOTE_TESTGIT_NO_MARKS=1 git pull) &&
 	compare_refs local2 HEAD server HEAD
 '
 
 test_expect_failure 'pushing without marks' '
+	test_when_finished "(cd local2 && git reset --hard origin)" &&
 	(cd local2 &&
 	echo content >>file &&
-	git commit -a -m three &&
+	git commit -a -m twelve &&
 	GIT_REMOTE_TESTGIT_NO_MARKS=1 git push) &&
 	compare_refs local2 HEAD server HEAD
 '
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 15357a1..237d2e5 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -461,7 +461,7 @@ from :12
 EOF
 
 test_expect_success 'refs are updated even if no commits need to be exported' '
-	echo -n > tmp-marks &&
+	> tmp-marks &&
 	git fast-export --import-marks=tmp-marks \
 		--export-marks=tmp-marks master > /dev/null &&
 	git fast-export --import-marks=tmp-marks \
@@ -469,10 +469,4 @@ test_expect_success 'refs are updated even if no commits need to be exported' '
 	test_cmp expected actual
 '
 
-test_expect_success 'proper extra refs handling' '
-	git fast-export master ^master master..master > actual &&
-	echo -n > expected &&
-	test_cmp expected actual
-'
-
 test_done

 .gitignore                           |   2 +-
 Documentation/git-remote-testgit.txt |   2 +-
 Makefile                             |   2 +-
 builtin/fast-export.c                |  16 ++-
 git-remote-testgit                   |  90 ++++++++++++
 git-remote-testgit.py                | 272 -----------------------------------
 git-remote-testpy.py                 | 272 +++++++++++++++++++++++++++++++++++
 git_remote_helpers/git/importer.py   |   2 +-
 t/t5800-remote-helpers.sh            | 148 -------------------
 t/t5800-remote-testpy.sh             | 148 +++++++++++++++++++
 t/t5801-remote-helpers.sh            | 161 +++++++++++++++++++++
 t/t9350-fast-export.sh               |  35 ++++-
 12 files changed, 719 insertions(+), 431 deletions(-)
 create mode 100755 git-remote-testgit
 delete mode 100644 git-remote-testgit.py
 create mode 100644 git-remote-testpy.py
 delete mode 100755 t/t5800-remote-helpers.sh
 create mode 100755 t/t5800-remote-testpy.sh
 create mode 100755 t/t5801-remote-helpers.sh

-- 
1.8.0
