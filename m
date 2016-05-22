From: larsxschneider@gmail.com
Subject: [PATCH v1 3/3] travis-ci: run Git bisect on failed tests
Date: Sun, 22 May 2016 13:00:56 +0200
Message-ID: <1463914856-64745-4-git-send-email-larsxschneider@gmail.com>
References: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com>
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 13:01:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4R8I-0001yu-4X
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 13:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbcEVLBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 07:01:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35964 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbcEVLBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 07:01:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id q62so7647438wmg.3
        for <git@vger.kernel.org>; Sun, 22 May 2016 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xmcBBOYx/pJEnXhBCt0uEBN6uoeH++S/9DIRynGrj6U=;
        b=sFLFOjn+FUdUiTVrAqZUecUmjnEHGFTIcI0O4200PSMTI3UF1fRCyxpDHpwwSO1fRU
         RCkCxo+yWekzXJ/i7Ub5T5tCxbdoyuvfLl7Xuv41MzMmyNSvW8UVwNnOABvYwkfmWNTQ
         FjPP3dA9ZGmYJ8j98RtBY8B9uh4xgJjCtIvD/fdiEQHieHGm4UpLlzhi5NA+JkuK4qp6
         JDK7D7it6AkmuiubDWu66ZkH+Ld0C/v6LLzps5QhJhc3yga5NdvyB6JE6zffiGXs3Lwg
         W8/6ugY3TPXDbgzzioCE/oZZUyuC5BMJvhqonGIoifCj9Rphmu5zBtWuLLpTg63XVyxV
         QxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xmcBBOYx/pJEnXhBCt0uEBN6uoeH++S/9DIRynGrj6U=;
        b=nLP1F2DqZNT+KSQlTSUr70yEBaHdVICLHz7iePjaZrhrBgPZovTf3W/DK8F0Wr9nPT
         RULPpbHxsBtdhqCbWAiq0AdTC4e3/Mtpd6xsg73kYY4WEVhPFveOP+YaIrZ0gKrL+3op
         sna/UKU3XgcxHXfqm2CuspguZJPxnQH3w8vDqE1wmEjZ1fr3MutH5hqFI9VHTROGacf/
         jQV+4MlOFzhVVTIm5us3UEp4L727RNr3Z7B/6zAGtgAAictnF4b/CDaL5IPucdTmpdk8
         lwwJ7FQtzaXRaQmxd9hIAHf74JwBruMq2Ucqvu1zg4Zzlo619F3aKW/5lmVnmL/p/SF1
         0r+w==
X-Gm-Message-State: AOPr4FX+Aj+bn7syGkfx7GQQKzsEpiPXI8singuZWHFFjRh3VRaE4V2y1Ab4dqXbzzf5sQ==
X-Received: by 10.28.11.82 with SMTP id 79mr11809339wml.33.1463914861183;
        Sun, 22 May 2016 04:01:01 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB5ECD.dip0.t-ipconnect.de. [93.219.94.205])
        by smtp.gmail.com with ESMTPSA id u4sm29343478wjz.4.2016.05.22.04.01.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 May 2016 04:01:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295279>

From: Lars Schneider <larsxschneider@gmail.com>

Junio usually pushes many commits at once to the public "pu"/"next"/
"master" branches. If a test fails then it is not obvious what commit
caused the failure. Therefore we run Git bisect with the merge base
between the failing rev and its more stable branch ("next" for "pu",
"master" for "next", and "maint" for "master") as good ref to find the
offending commit. This is only enabled on "github.com/git/git" because
there we can assume that all relevant branches are up to date.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml       |  2 +-
 ci/test-report.sh | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 81d2027..922807b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -101,7 +101,7 @@ script: make --quiet test
 after_failure:
   - >
     : '<-- Click here to see detailed test output!                                                        ';
-    ./ci/test-report.sh
+    ./ci/test-report.sh $TRAVIS_REPO_SLUG $TRAVIS_BRANCH;
 
 notifications:
   email: false
diff --git a/ci/test-report.sh b/ci/test-report.sh
index d08a999..8f7adad 100755
--- a/ci/test-report.sh
+++ b/ci/test-report.sh
@@ -1,5 +1,12 @@
 #!/bin/sh
 #
+# Print test results and run Git bisect on failed tests.
+#
+REPO_ORG_NAME=$1
+CURRENT_BRANCH_NAME=$2
+
+
+#
 # Print test results
 #
 for TEST_EXIT in t/test-results/*.exit
@@ -17,3 +24,61 @@ do
 	fi
 done
 
+
+#
+# Run Git bisect
+#
+run_bisect () {
+	TEST_SCRIPT=$1
+	BAD_REV=$2
+	GOOD_RV=$3
+	TMPDIR=$(mktemp -d -t "ci-report-bisect-XXXXXX" 2>/dev/null)
+	cat > "$TMPDIR/bisect-run.sh" <<EOF
+
+EOF
+	chmod +x "$TMPDIR/bisect-run.sh"
+	git bisect start $BAD_REV $GOOD_RV
+	git bisect run "$TMPDIR/bisect-run.sh"
+	if test -e ./t/$TEST_SCRIPT.sh && make --jobs=2 >/dev/null 2>&1
+	then
+		cd t && ./$TEST_SCRIPT.sh >/dev/null 2>&1
+	else
+		# If the test file does not exist or the build fails then tell
+		# Git bisect to skip the commit.
+		exit 125
+	fi
+	git bisect reset >/dev/null 2>&1
+}
+
+case "$CURRENT_BRANCH_NAME" in
+	master) STABLE_BRANCH="maint";;
+	next)   STABLE_BRANCH="master";;
+	pu)     STABLE_BRANCH="next";;
+esac
+
+if test "$REPO_ORG_NAME" = "git/git" && test -n $STABLE_BRANCH
+then
+	BAD_REV=$(git rev-parse HEAD)
+
+	# Travis CI clones are shallow. It is possible that the last good revision
+	# was not fetched, yet. Therefore we need to fetch all commits on the
+	# stable branch.
+	git config remote.origin.fetch "+refs/heads/$STABLE_BRANCH:refs/remotes/origin/$STABLE_BRANCH"
+	git fetch --unshallow --quiet
+	LAST_GOOD_REV=$(git merge-base $BAD_REV "remotes/origin/$STABLE_BRANCH")
+
+	for TEST_EXIT in t/test-results/*.exit
+	do
+		if test "$(cat "$TEST_EXIT")" != "0"
+		then
+			TEST="${TEST_EXIT%.exit}"
+			TEST_SCRIPT=${TEST#t/test-results/}
+			echo "------------------------------------------------------------------------"
+			echo "  $(tput setaf 1)${TEST} Bisect$(tput sgr0)"
+			echo "------------------------------------------------------------------------"
+			run_bisect $TEST_SCRIPT $BAD_REV $LAST_GOOD_REV
+			echo ""
+			echo ""
+		fi
+	done
+fi
-- 
2.5.1
