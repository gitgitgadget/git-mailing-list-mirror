Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A87E2036C
	for <e@80x24.org>; Fri,  6 Oct 2017 14:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbdJFOmV (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 10:42:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:35366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751491AbdJFOmU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 10:42:20 -0400
Received: (qmail 7640 invoked by uid 109); 6 Oct 2017 14:42:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 14:42:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6802 invoked by uid 111); 6 Oct 2017 14:42:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 10:42:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 10:42:17 -0400
Date:   Fri, 6 Oct 2017 10:42:17 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Subject: [PATCH 2/2] refs_resolve_ref_unsafe: handle d/f conflicts for writes
Message-ID: <20171006144217.y6oxux26hh2fb7og@sigill.intra.peff.net>
References: <20171006143745.w6q2yfgy6nvd2m2a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171006143745.w6q2yfgy6nvd2m2a@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If our call to refs_read_raw_ref() fails, we check errno to
see if the ref is simply missing, or if we encountered a
more serious error. If it's just missing, then in "write"
mode (i.e., when RESOLVE_REFS_READING is not set), this is
perfectly fine.

However, checking for ENOENT isn't sufficient to catch all
missing-ref cases. In the filesystem backend, we may also
see EISDIR when we try to resolve "a" and "a/b" exists.
Likewise, we may see ENOTDIR if we try to resolve "a/b" and
"a" exists. In both of those cases, we know that our
resolved ref doesn't exist, but we return an error (rather
than reporting the refname and returning a null sha1).

This has been broken for a long time, but nobody really
noticed because the next step after resolving without the
READING flag is usually to lock the ref and write it. But in
both of those cases, the write will fail with the same
errno due to the directory/file conflict.

There are two cases where we can notice this, though:

  1. If we try to write "a" and there's a leftover directory
     already at "a", even though there is no ref "a/b". The
     actual write is smart enough to move the empty "a" out
     of the way.

     This is reasonably rare, if only because the writing
     code has to do an independent resolution before trying
     its write (because the actual update_ref() code handles
     this case fine). The notes-merge code does this, and
     before the fix in the prior commit t3308 erroneously
     expected this case to fail.

  2. When resolving symbolic refs, we typically do not use
     the READING flag because we want to resolve even
     symrefs that point to unborn refs. Even if those unborn
     refs could not actually be written because of d/f
     conflicts with existing refs.

     You can see this by asking "git symbolic-ref" to report
     the target of a symref pointing past a d/f conflict.

We can fix the problem by recognizing the other "missing"
errnos and treating them like ENOENT. This should be safe to
do even for callers who are then going to actually write the
ref, because the actual writing process will fail if the d/f
conflict is a real one (and t1404 checks these cases).

Arguably this should be the responsibility of the
files-backend to normalize all "missing ref" errors into
ENOENT (since something like EISDIR may not be meaningful at
all to a database backend). However other callers of
refs_read_raw_ref() may actually care about the distinction;
putting this into resolve_ref() is the minimal fix for now.

The new tests in t1401 use git-symbolic-ref, which is the
most direct way to check the resolution by itself.
Interestingly we actually had a test that setup this case
already, but we only used it to verify that the funny state
could be overwritten, not that it could be resolved.

We also add a new test in t3200, as "branch -m" was the
original motivation for looking into this. What happens is
this:

  0. HEAD is pointing to branch "a"

  1. The user asks to rename "a" to "a/b".

  2. We create "a/b" and delete "a".

  3. We then try to update any worktree HEADs that point to
     the renamed ref (including the main repo HEAD). To do
     that, we have to resolve each HEAD. But now our HEAD is
     pointing at "a", and we get EISDIR due to the loose
     "a/b". As a result, we think there is no HEAD, and we
     do not update it. It now points to the bogus "a".

Interestingly this case used to work, but only accidentally.
Before 31824d180d (branch: fix branch renaming not updating
HEADs correctly, 2017-08-24), we'd update any HEAD which we
couldn't resolve. That was wrong, but it papered over the
fact that we were incorrectly failing to resolve HEAD.

So while the bug demonstrated by the git-symbolic-ref is
quite old, the regression to "branch -m" is recent.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c                  | 15 ++++++++++++++-
 t/t1401-symbolic-ref.sh | 26 +++++++++++++++++++++++++-
 t/t3200-branch.sh       | 10 ++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index df075fcd06..c590a992fb 100644
--- a/refs.c
+++ b/refs.c
@@ -1435,8 +1435,21 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		if (refs_read_raw_ref(refs, refname,
 				      sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
-			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
+
+			/* In reading mode, refs must eventually resolve */
+			if (resolve_flags & RESOLVE_REF_READING)
+				return NULL;
+
+			/*
+			 * Otherwise a missing ref is OK. But the files backend
+			 * may show errors besides ENOENT if there are
+			 * similarly-named refs.
+			 */
+			if (errno != ENOENT &&
+			    errno != EISDIR &&
+			    errno != ENOTDIR)
 				return NULL;
+
 			hashclr(sha1);
 			if (*flags & REF_BAD_NAME)
 				*flags |= REF_ISBROKEN;
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index eec3e90f9c..9e782a8122 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -129,11 +129,35 @@ test_expect_success 'symbolic-ref does not create ref d/f conflicts' '
 	test_must_fail git symbolic-ref refs/heads/df/conflict refs/heads/df
 '
 
-test_expect_success 'symbolic-ref handles existing pointer to invalid name' '
+test_expect_success 'symbolic-ref can overwrite pointer to invalid name' '
+	test_when_finished reset_to_sane &&
 	head=$(git rev-parse HEAD) &&
 	git symbolic-ref HEAD refs/heads/outer &&
+	test_when_finished "git update-ref -d refs/heads/outer/inner" &&
 	git update-ref refs/heads/outer/inner $head &&
 	git symbolic-ref HEAD refs/heads/unrelated
 '
 
+test_expect_success 'symbolic-ref can resolve d/f name (EISDIR)' '
+	test_when_finished reset_to_sane &&
+	head=$(git rev-parse HEAD) &&
+	git symbolic-ref HEAD refs/heads/outer/inner &&
+	test_when_finished "git update-ref -d refs/heads/outer" &&
+	git update-ref refs/heads/outer $head &&
+	echo refs/heads/outer/inner >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'symbolic-ref can resolve d/f name (ENOTDIR)' '
+	test_when_finished reset_to_sane &&
+	head=$(git rev-parse HEAD) &&
+	git symbolic-ref HEAD refs/heads/outer &&
+	test_when_finished "git update-ref -d refs/heads/outer/inner" &&
+	git update-ref refs/heads/outer/inner $head &&
+	echo refs/heads/outer >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 3ac7ebf85f..503a88d029 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -117,6 +117,16 @@ test_expect_success 'git branch -m bbb should rename checked out branch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'renaming checked out branch works with d/f conflict' '
+	test_when_finished "git branch -D foo/bar || git branch -D foo" &&
+	test_when_finished git checkout master &&
+	git checkout -b foo &&
+	git branch -m foo/bar &&
+	git symbolic-ref HEAD >actual &&
+	echo refs/heads/foo/bar >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git branch -m o/o o should fail when o/p exists' '
 	git branch o/o &&
 	git branch o/p &&
-- 
2.15.0.rc0.413.g9bb4ac64e2
