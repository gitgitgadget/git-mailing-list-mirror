Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57472C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B7061261
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346571AbhIXSoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:44:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:54668 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231919AbhIXSoN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:44:13 -0400
Received: (qmail 19135 invoked by uid 109); 24 Sep 2021 18:42:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:42:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11157 invoked by uid 111); 24 Sep 2021 18:42:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:42:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:42:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 11/16] refs: omit dangling symrefs when using GIT_REF_PARANOIA
Message-ID: <YU4cHlGaEwBzTJ0k@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dangling symrefs aren't actually a corruption problem. It's perfectly
fine for refs/remotes/origin/HEAD to point to an unborn branch. And in
particular, if you are trying to establish reachability, a symref that
points nowhere doesn't matter either way. Any ref it could point to will
be examined during the rest of the traversal.

It's possible that a symref pointing nowhere _could_ be a sign that the
ref it was meant to point to was deleted accidentally (e.g., via
corruption). But there is no particular reason to think that is true for
any given case, and in the meantime, GIT_REF_PARANOIA kicking in
automatically for some operations means they'll fail unnecessarily.

So let's loosen it just a bit. The new test in t5312 shows off an
example that is safe, but currently fails (and no longer does after this
patch).

Note that we don't do anything if the caller explicitly asked for
DO_FOR_EACH_INCLUDE_BROKEN. In that case they may be looking for
dangling symrefs themselves, and setting GIT_REF_PARANOIA should not
_loosen_ things from what the caller asked for.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c                      | 12 ++++++++----
 t/t5312-prune-corruption.sh |  7 +++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index c28bd6a818..e72510813e 100644
--- a/refs.c
+++ b/refs.c
@@ -1418,10 +1418,14 @@ struct ref_iterator *refs_ref_iterator_begin(
 {
 	struct ref_iterator *iter;
 
-	if (ref_paranoia < 0)
-		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
-	if (ref_paranoia)
-		flags |= DO_FOR_EACH_INCLUDE_BROKEN;
+	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
+		if (ref_paranoia < 0)
+			ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
+		if (ref_paranoia) {
+			flags |= DO_FOR_EACH_INCLUDE_BROKEN;
+			flags |= DO_FOR_EACH_OMIT_DANGLING_SYMREFS;
+		}
+	}
 
 	iter = refs->be->iterator_begin(refs, prefix, flags);
 
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 1522a4ba8e..d8ec5a7462 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -62,6 +62,13 @@ test_expect_success 'destructive repack keeps packed object' '
 	git cat-file -e $bogus
 '
 
+test_expect_success 'destructive repack not confused by dangling symref' '
+	test_when_finished "git symbolic-ref -d refs/heads/dangling" &&
+	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
+	git repack -ad &&
+	test_must_fail git cat-file -e $bogus
+'
+
 # We create two new objects here, "one" and "two". Our
 # main branch points to "two", which is deleted,
 # corrupting the repository. But we'd like to make sure
-- 
2.33.0.1071.gb37e412355

