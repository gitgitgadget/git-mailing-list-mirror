From: Jeff King <peff@peff.net>
Subject: [PATCH 06/25] t: use verbose instead of hand-rolled errors
Date: Fri, 20 Mar 2015 06:09:00 -0400
Message-ID: <20150320100900.GF12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:09:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtrY-0002HR-P9
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbbCTKJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:09:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:35680 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751449AbbCTKJD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:09:03 -0400
Received: (qmail 5691 invoked by uid 102); 20 Mar 2015 10:09:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:09:03 -0500
Received: (qmail 21485 invoked by uid 107); 20 Mar 2015 10:09:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:09:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:09:00 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265880>

Many tests that predate the "verbose" helper function use a
pattern like:

  test ... || {
	  echo ...
	  false
  }

to give more verbose output. Using the helper, we can do
this with a single line, and avoid a || which interacts
badly with &&-chaining (besides fooling --chain-lint, we hit
the error block no matter which command in the chain failed,
so we may often show useless results).

In most cases, the messages printed by "verbose" are equally
good (in some cases better; t6006 accidentally redirects the
message to a file!). The exception is t7001, whose output
suffers slightly. However, it's still enough to show the
user which part failed, given that we will have just printed
the test script to stderr.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4022-diff-rewrite.sh    |  5 +----
 t/t4202-log.sh             | 30 +++++-------------------------
 t/t6006-rev-list-format.sh |  5 +----
 t/t7001-mv.sh              |  5 +----
 t/t7300-clean.sh           | 10 ++--------
 5 files changed, 10 insertions(+), 45 deletions(-)

diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index 2d030a4..cb51d9f 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -20,10 +20,7 @@ test_expect_success setup '
 test_expect_success 'detect rewrite' '
 
 	actual=$(git diff-files -B --summary test) &&
-	expr "$actual" : " rewrite test ([0-9]*%)$" || {
-		echo "Eh? <<$actual>>"
-		false
-	}
+	verbose expr "$actual" : " rewrite test ([0-9]*%)$"
 
 '
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index a22ac7c..85230a8 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -113,11 +113,7 @@ test_expect_success 'diff-filter=M' '
 
 	actual=$(git log --pretty="format:%s" --diff-filter=M HEAD) &&
 	expect=$(echo second) &&
-	test "$actual" = "$expect" || {
-		echo Oops
-		echo "Actual: $actual"
-		false
-	}
+	verbose test "$actual" = "$expect"
 
 '
 
@@ -125,11 +121,7 @@ test_expect_success 'diff-filter=D' '
 
 	actual=$(git log --pretty="format:%s" --diff-filter=D HEAD) &&
 	expect=$(echo sixth ; echo third) &&
-	test "$actual" = "$expect" || {
-		echo Oops
-		echo "Actual: $actual"
-		false
-	}
+	verbose test "$actual" = "$expect"
 
 '
 
@@ -137,11 +129,7 @@ test_expect_success 'diff-filter=R' '
 
 	actual=$(git log -M --pretty="format:%s" --diff-filter=R HEAD) &&
 	expect=$(echo third) &&
-	test "$actual" = "$expect" || {
-		echo Oops
-		echo "Actual: $actual"
-		false
-	}
+	verbose test "$actual" = "$expect"
 
 '
 
@@ -149,11 +137,7 @@ test_expect_success 'diff-filter=C' '
 
 	actual=$(git log -C -C --pretty="format:%s" --diff-filter=C HEAD) &&
 	expect=$(echo fourth) &&
-	test "$actual" = "$expect" || {
-		echo Oops
-		echo "Actual: $actual"
-		false
-	}
+	verbose test "$actual" = "$expect"
 
 '
 
@@ -161,11 +145,7 @@ test_expect_success 'git log --follow' '
 
 	actual=$(git log --follow --pretty="format:%s" ichi) &&
 	expect=$(echo third ; echo second ; echo initial) &&
-	test "$actual" = "$expect" || {
-		echo Oops
-		echo "Actual: $actual"
-		false
-	}
+	verbose test "$actual" = "$expect"
 
 '
 
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 2b7c0f0..b77d4c9 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -358,10 +358,7 @@ test_expect_success 'empty email' '
 	test_tick &&
 	C=$(GIT_AUTHOR_EMAIL= git commit-tree HEAD^{tree} </dev/null) &&
 	A=$(git show --pretty=format:%an,%ae,%ad%n -s $C) &&
-	test "$A" = "A U Thor,,Thu Apr 7 15:14:13 2005 -0700" || {
-		echo "Eh? $A" >failure
-		false
-	}
+	verbose test "$A" = "A U Thor,,Thu Apr 7 15:14:13 2005 -0700"
 '
 
 test_expect_success 'del LF before empty (1)' '
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 69f11bd..7b56081 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -161,10 +161,7 @@ test_expect_success "Michael Cassar's test case" '
 	git mv papers/unsorted/Thesis.pdf papers/all-papers/moo-blah.pdf &&
 
 	T=`git write-tree` &&
-	git ls-tree -r $T | grep partA/outline.txt || {
-		git ls-tree -r $T
-		(exit 1)
-	}
+	git ls-tree -r $T | verbose grep partA/outline.txt
 '
 
 rm -fr papers partA path?
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 04118ad..99be5d9 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -119,10 +119,7 @@ test_expect_success C_LOCALE_OUTPUT 'git clean with relative prefix' '
 		git clean -n ../src |
 		sed -n -e "s|^Would remove ||p"
 	) &&
-	test "$would_clean" = ../src/part3.c || {
-		echo "OOps <$would_clean>"
-		false
-	}
+	verbose test "$would_clean" = ../src/part3.c
 '
 
 test_expect_success C_LOCALE_OUTPUT 'git clean with absolute path' '
@@ -134,10 +131,7 @@ test_expect_success C_LOCALE_OUTPUT 'git clean with absolute path' '
 		git clean -n "$(pwd)/../src" |
 		sed -n -e "s|^Would remove ||p"
 	) &&
-	test "$would_clean" = ../src/part3.c || {
-		echo "OOps <$would_clean>"
-		false
-	}
+	verbose test "$would_clean" = ../src/part3.c
 '
 
 test_expect_success 'git clean with out of work tree relative path' '
-- 
2.3.3.520.g3cfbb5d
