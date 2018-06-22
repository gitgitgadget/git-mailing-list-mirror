Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12C81F516
	for <e@80x24.org>; Fri, 22 Jun 2018 09:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeFVJYE (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 05:24:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:51768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753177AbeFVJYB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 05:24:01 -0400
Received: (qmail 3856 invoked by uid 109); 22 Jun 2018 09:24:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Jun 2018 09:24:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16651 invoked by uid 111); 22 Jun 2018 09:24:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Jun 2018 05:24:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jun 2018 05:23:59 -0400
Date:   Fri, 22 Jun 2018 05:23:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 2/4] t: switch "branch -l" to "branch --create-reflog"
Message-ID: <20180622092359.GB13573@sigill.intra.peff.net>
References: <20180622092327.GA8361@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180622092327.GA8361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for deprecating "-l", let's make sure we're
using the recommended option ourselves.

This patch just mechanically converts "branch -l" to "branch
--create-reflog".  Note that with the exception of the
actual "--create-reflog" test, we could actually remove "-l"
entirely from most of these callers. That's because these
days core.logallrefupdates defaults to true in a non-bare
repository.

I've left them in place, though, since they serve to
document the expectation of the test, even if they are
technically noops.

Signed-off-by: Jeff King <peff@peff.net>
---
Same as before.

 t/t1410-reflog.sh |  4 ++--
 t/t3200-branch.sh | 34 +++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 553e26d9ce..8293131001 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -339,8 +339,8 @@ test_expect_failure 'reflog with non-commit entries displays all entries' '
 '
 
 test_expect_success 'reflog expire operates on symref not referrent' '
-	git branch -l the_symref &&
-	git branch -l referrent &&
+	git branch --create-reflog the_symref &&
+	git branch --create-reflog referrent &&
 	git update-ref referrent HEAD &&
 	git symbolic-ref refs/heads/the_symref refs/heads/referrent &&
 	test_when_finished "rm -f .git/refs/heads/referrent.lock" &&
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ec56176093..dbca665da4 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -49,9 +49,9 @@ test_expect_success 'git branch HEAD should fail' '
 cat >expect <<EOF
 $ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
 EOF
-test_expect_success 'git branch -l d/e/f should create a branch and a log' '
+test_expect_success 'git branch --create-reflog d/e/f should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
-	git -c core.logallrefupdates=false branch -l d/e/f &&
+	git -c core.logallrefupdates=false branch --create-reflog d/e/f &&
 	test_path_is_file .git/refs/heads/d/e/f &&
 	test_path_is_file .git/logs/refs/heads/d/e/f &&
 	test_cmp expect .git/logs/refs/heads/d/e/f
@@ -82,7 +82,7 @@ test_expect_success 'git branch -m dumps usage' '
 
 test_expect_success 'git branch -m m broken_symref should work' '
 	test_when_finished "git branch -D broken_symref" &&
-	git branch -l m &&
+	git branch --create-reflog m &&
 	git symbolic-ref refs/heads/broken_symref refs/heads/i_am_broken &&
 	git branch -m m broken_symref &&
 	git reflog exists refs/heads/broken_symref &&
@@ -90,13 +90,13 @@ test_expect_success 'git branch -m m broken_symref should work' '
 '
 
 test_expect_success 'git branch -m m m/m should work' '
-	git branch -l m &&
+	git branch --create-reflog m &&
 	git branch -m m m/m &&
 	git reflog exists refs/heads/m/m
 '
 
 test_expect_success 'git branch -m n/n n should work' '
-	git branch -l n/n &&
+	git branch --create-reflog n/n &&
 	git branch -m n/n n &&
 	git reflog exists refs/heads/n
 '
@@ -378,9 +378,9 @@ mv .git/config-saved .git/config
 git config branch.s/s.dummy Hello
 
 test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
-	git branch -l s/s &&
+	git branch --create-reflog s/s &&
 	git reflog exists refs/heads/s/s &&
-	git branch -l s/t &&
+	git branch --create-reflog s/t &&
 	git reflog exists refs/heads/s/t &&
 	git branch -d s/t &&
 	git branch -m s/s s &&
@@ -444,7 +444,7 @@ test_expect_success 'git branch --copy dumps usage' '
 '
 
 test_expect_success 'git branch -c d e should work' '
-	git branch -l d &&
+	git branch --create-reflog d &&
 	git reflog exists refs/heads/d &&
 	git config branch.d.dummy Hello &&
 	git branch -c d e &&
@@ -459,7 +459,7 @@ test_expect_success 'git branch -c d e should work' '
 '
 
 test_expect_success 'git branch --copy is a synonym for -c' '
-	git branch -l copy &&
+	git branch --create-reflog copy &&
 	git reflog exists refs/heads/copy &&
 	git config branch.copy.dummy Hello &&
 	git branch --copy copy copy-to &&
@@ -486,7 +486,7 @@ test_expect_success 'git branch -c ee ef should copy ee to create branch ef' '
 '
 
 test_expect_success 'git branch -c f/f g/g should work' '
-	git branch -l f/f &&
+	git branch --create-reflog f/f &&
 	git reflog exists refs/heads/f/f &&
 	git config branch.f/f.dummy Hello &&
 	git branch -c f/f g/g &&
@@ -497,7 +497,7 @@ test_expect_success 'git branch -c f/f g/g should work' '
 '
 
 test_expect_success 'git branch -c m2 m2 should work' '
-	git branch -l m2 &&
+	git branch --create-reflog m2 &&
 	git reflog exists refs/heads/m2 &&
 	git config branch.m2.dummy Hello &&
 	git branch -c m2 m2 &&
@@ -506,18 +506,18 @@ test_expect_success 'git branch -c m2 m2 should work' '
 '
 
 test_expect_success 'git branch -c zz zz/zz should fail' '
-	git branch -l zz &&
+	git branch --create-reflog zz &&
 	git reflog exists refs/heads/zz &&
 	test_must_fail git branch -c zz zz/zz
 '
 
 test_expect_success 'git branch -c b/b b should fail' '
-	git branch -l b/b &&
+	git branch --create-reflog b/b &&
 	test_must_fail git branch -c b/b b
 '
 
 test_expect_success 'git branch -C o/q o/p should work when o/p exists' '
-	git branch -l o/q &&
+	git branch --create-reflog o/q &&
 	git reflog exists refs/heads/o/q &&
 	git reflog exists refs/heads/o/p &&
 	git branch -C o/q o/p
@@ -570,10 +570,10 @@ test_expect_success 'git branch -C master5 master5 should work when master is ch
 '
 
 test_expect_success 'git branch -C ab cd should overwrite existing config for cd' '
-	git branch -l cd &&
+	git branch --create-reflog cd &&
 	git reflog exists refs/heads/cd &&
 	git config branch.cd.dummy CD &&
-	git branch -l ab &&
+	git branch --create-reflog ab &&
 	git reflog exists refs/heads/ab &&
 	git config branch.ab.dummy AB &&
 	git branch -C ab cd &&
@@ -685,7 +685,7 @@ test_expect_success 'renaming a symref is not allowed' '
 '
 
 test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
-	git branch -l u &&
+	git branch --create-reflog u &&
 	mv .git/logs/refs/heads/u real-u &&
 	ln -s real-u .git/logs/refs/heads/u &&
 	test_must_fail git branch -m u v
-- 
2.18.0.539.gcf23d6d4f1

