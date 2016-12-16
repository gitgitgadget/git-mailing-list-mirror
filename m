Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4F41FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 02:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755757AbcLPCip (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 21:38:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:57403 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbcLPCio (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 21:38:44 -0500
Received: (qmail 8829 invoked by uid 109); 16 Dec 2016 02:32:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 02:32:03 +0000
Received: (qmail 8577 invoked by uid 111); 16 Dec 2016 02:32:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 21:32:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 21:31:59 -0500
Date:   Thu, 15 Dec 2016 21:31:59 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 3/3] t: use nongit() function where applicable
Message-ID: <20161216023159.pzimmmknyptgutnu@sigill.intra.peff.net>
References: <20161216022904.cjang6napnl2vkc6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161216022904.cjang6napnl2vkc6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many tests want to run a command outside of any git repo;
with the nongit() function this is now a one-liner. It saves
a few lines, but more importantly, it's immediately obvious
what the code is trying to accomplish.

This doesn't convert every such case in the test suite; it
just covers those that want to do a one-off command. Other
cases, such as the ones in t4035, are part of a larger
scheme of outside-repo files, and it's less confusing for
them to stay consistent with the surrounding tests.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is obviously not necessary for the rest of the series, but the
diffstat is certainly pleasing.

 t/t1308-config-set.sh    | 10 ++--------
 t/t9100-git-svn-basic.sh | 17 ++---------------
 t/t9902-completion.sh    |  7 +------
 3 files changed, 5 insertions(+), 29 deletions(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7655c94c28..ff50960cca 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -219,14 +219,8 @@ test_expect_success 'check line errors for malformed values' '
 '
 
 test_expect_success 'error on modifying repo config without repo' '
-	mkdir no-repo &&
-	(
-		GIT_CEILING_DIRECTORIES=$(pwd) &&
-		export GIT_CEILING_DIRECTORIES &&
-		cd no-repo &&
-		test_must_fail git config a.b c 2>err &&
-		grep "not in a git directory" err
-	)
+	nongit test_must_fail git config a.b c 2>err &&
+	grep "not in a git directory" err
 '
 
 cmdline_config="'foo.bar=from-cmdline'"
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 92a3aa8063..8a8ba65a2a 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -17,25 +17,12 @@ case "$GIT_SVN_LC_ALL" in
 	;;
 esac
 
-deepdir=nothing-above
-ceiling=$PWD
-
 test_expect_success 'git svn --version works anywhere' '
-	mkdir -p "$deepdir" && (
-		GIT_CEILING_DIRECTORIES="$ceiling" &&
-		export GIT_CEILING_DIRECTORIES &&
-		cd "$deepdir" &&
-		git svn --version
-	)
+	nongit git svn --version
 '
 
 test_expect_success 'git svn help works anywhere' '
-	mkdir -p "$deepdir" && (
-		GIT_CEILING_DIRECTORIES="$ceiling" &&
-		export GIT_CEILING_DIRECTORIES &&
-		cd "$deepdir" &&
-		git svn help
-	)
+	nongit git svn help
 '
 
 test_expect_success \
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2ba62fbc17..a34e55f874 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -257,12 +257,7 @@ test_expect_success SYMLINKS '__gitdir - resulting path avoids symlinks' '
 '
 
 test_expect_success '__gitdir - not a git repository' '
-	(
-		cd subdir/subsubdir &&
-		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY" &&
-		export GIT_CEILING_DIRECTORIES &&
-		test_must_fail __gitdir
-	)
+	nongit test_must_fail __gitdir
 '
 
 test_expect_success '__gitcomp - trailing space - options' '
-- 
2.11.0.348.g960a0b554
