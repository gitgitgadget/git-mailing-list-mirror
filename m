Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C868920189
	for <e@80x24.org>; Wed, 22 Jun 2016 19:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbcFVTkS (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 15:40:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:58730 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751600AbcFVTkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 15:40:17 -0400
Received: (qmail 7424 invoked by uid 102); 22 Jun 2016 19:40:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 15:40:16 -0400
Received: (qmail 5028 invoked by uid 107); 22 Jun 2016 19:40:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 15:40:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jun 2016 15:40:13 -0400
Date:	Wed, 22 Jun 2016 15:40:13 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] t/perf: fix regression in testing older versions of git
Message-ID: <20160622194013.GA1697@sigill.intra.peff.net>
References: <20160622193904.GA1509@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160622193904.GA1509@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Commit 7501b59 (perf: make the tests work in worktrees,
2016-05-13) introduced the use of "git rev-parse --git-path"
in the perf-lib setup code. Because the to-be-tested version
of git is at the front of the $PATH when this code runs,
this means we cannot use modern versions of t/perf to test
versions of git older than v2.5.0 (when that option was
introduced).

This is a symptom of a more general problem. The t/perf
suite is essentially independent of git versions, and
ideally we would be able to run the most modern and complete
set of tests across many historical versions (to see how
they compare). But any setup code they run is therefore
required to use the lowest common denominator we expect to
test.

So let's introduce a new variable, $MODERN_GIT, that we can
use both in perf-lib and in the test setup to get a reliable
set of git features (we might change git and break some
tests, of course, but $MODERN_GIT is tied to the same
version of git as the t/perf scripts, so they can be fixed
or adjusted together).

This commit fixes the "--git-path" case, but does not
mass-convert existing setup code to use $MODERN_GIT. Most
setup code is fairly vanilla and will work with effectively
all versions. But now the tool is there to fix any other
issues we find going forward.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/README      | 12 ++++++++++--
 t/perf/perf-lib.sh |  5 ++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/t/perf/README b/t/perf/README
index 8848c14..15986ca 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -115,8 +115,16 @@ After that you will want to use some of the following:
 
 At least one of the first two is required!
 
-You can use test_expect_success as usual.  For actual performance
-tests, use
+You can use test_expect_success as usual. In both test_expect_success
+and in test_perf, running "git" points to the version that is being
+peft-tested. The $MODERN_GIT variable points to the git wrapper for the
+currently checked-out version (i.e., the one that matches the t/perf
+scripts you are running).  This is useful if your setup uses commands
+that only work with newer versions of git than what you might want to
+test (but obviously your new commands must still create a state that can
+be used by the older version of git you are testing).
+
+For actual performance tests, use
 
 	test_perf 'descriptive string' '
 		command1 &&
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 18c363e..4eb2536 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -52,6 +52,9 @@ TEST_NO_MALLOC_CHECK=t
 # need to export them for test_perf subshells
 export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR GIT_TEST_CMP
 
+MODERN_GIT=$GIT_BUILD_DIR/bin-wrappers/git
+export MODERN_GIT
+
 perf_results_dir=$TEST_OUTPUT_DIRECTORY/test-results
 mkdir -p "$perf_results_dir"
 rm -f "$perf_results_dir"/$(basename "$0" .sh).subtests
@@ -81,7 +84,7 @@ test_perf_create_repo_from () {
 	repo="$1"
 	source="$2"
 	source_git="$(git -C "$source" rev-parse --git-dir)"
-	objects_dir="$(git -C "$source" rev-parse --git-path objects)"
+	objects_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-path objects)"
 	mkdir -p "$repo/.git"
 	(
 		cd "$source" &&
-- 
2.9.0.204.g1499a7b

