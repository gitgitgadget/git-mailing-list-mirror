From: Jeff King <peff@peff.net>
Subject: [PATCH 07/25] t: use test_must_fail instead of hand-rolled blocks
Date: Fri, 20 Mar 2015 06:09:22 -0400
Message-ID: <20150320100922.GG12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:09:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtry-0002Xy-KC
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbbCTKJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:09:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:35683 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751332AbbCTKJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:09:25 -0400
Received: (qmail 5697 invoked by uid 102); 20 Mar 2015 10:09:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:09:25 -0500
Received: (qmail 21501 invoked by uid 107); 20 Mar 2015 10:09:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:09:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:09:22 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265881>

These test scripts likely predate test_must_fail, and can be
made simpler by using it (in addition to making them pass
--chain-lint).

The case in t6036 loses some verbosity in the failure case,
but it is so tied to a specific failure mode that it is not
worth keeping around (and the outcome of the test is not
affected at all).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4124-apply-ws-rule.sh          | 5 ++---
 t/t6036-recursive-corner-cases.sh | 7 +------
 t/t9300-fast-import.sh            | 7 ++-----
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index c6474de..d350065 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -99,9 +99,8 @@ test_expect_success 'whitespace=warn, default rule' '
 
 test_expect_success 'whitespace=error-all, default rule' '
 
-	apply_patch --whitespace=error-all && return 1
-	test -s target && return 1
-	: happy
+	test_must_fail apply_patch --whitespace=error-all &&
+	! test -s target
 
 '
 
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 8923b04..9d6621c 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -195,12 +195,7 @@ test_expect_success 'git detects differently handled merges conflict' '
 	git reset --hard &&
 	git checkout D^0 &&
 
-	git merge -s recursive E^0 && {
-		echo "BAD: should have conflicted"
-		test "Incorrectly merged content" = "$(cat new_a)" &&
-			echo "BAD: Silently accepted wrong content"
-		return 1
-	}
+	test_must_fail git merge -s recursive E^0 &&
 
 	test 3 = $(git ls-files -s | wc -l) &&
 	test 3 = $(git ls-files -u | wc -l) &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 584b538..aac126f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2853,8 +2853,8 @@ test_expect_success 'S: notemodify with garbage after mark commit-ish must fail'
 # from
 #
 test_expect_success 'S: from with garbage after mark must fail' '
-	# no &&
-	git fast-import --import-marks=marks --export-marks=marks <<-EOF 2>err
+	test_must_fail \
+	git fast-import --import-marks=marks --export-marks=marks <<-EOF 2>err &&
 	commit refs/heads/S2
 	mark :303
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -2865,9 +2865,6 @@ test_expect_success 'S: from with garbage after mark must fail' '
 	M 100644 :403 hello.c
 	EOF
 
-	ret=$? &&
-	echo returned $ret &&
-	test $ret -ne 0 && # failed, but it created the commit
 
 	# go create the commit, need it for merge test
 	git fast-import --import-marks=marks --export-marks=marks <<-EOF &&
-- 
2.3.3.520.g3cfbb5d
