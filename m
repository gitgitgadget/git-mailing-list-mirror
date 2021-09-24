Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B00EC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B9760F21
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346681AbhIXSrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:47:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:54676 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231919AbhIXSrs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:47:48 -0400
Received: (qmail 19147 invoked by uid 109); 24 Sep 2021 18:46:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:46:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11205 invoked by uid 111); 24 Sep 2021 18:46:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:46:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:46:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 12/16] refs: turn on GIT_REF_PARANOIA by default
Message-ID: <YU4c9S6jypbS4YCK@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The original point of the GIT_REF_PARANOIA flag was to include broken
refs in iterations, so that possibly-destructive operations would not
silently ignore them (and would generally instead try to operate on the
oids and fail when the objects could not be accessed).

We already turned this on by default for some dangerous operations, like
"repack -ad" (where missing a reachability tip would mean dropping the
associated history). But it was not on for general use, even though it
could easily result in the spreading of corruption (e.g., imagine
cloning a repository which simply omits some of its refs because
their objects are missing; the result quietly succeeds even though you
did not clone everything!).

This patch turns on GIT_REF_PARANOIA by default. So a clone as mentioned
above would actually fail (upload-pack tells us about the broken ref,
and when we ask for the objects, pack-objects fails to deliver them).
This may be inconvenient when working with a corrupted repository, but:

  - we are better off to err on the side of complaining about
    corruption, and then provide mechanisms for explicitly loosening
    safety.

  - this is only one type of corruption anyway. If we are missing any
    other objects in the history that _aren't_ ref tips, then we'd
    behave similarly (happily show the ref, but then barf when we
    started traversing).

We retain the GIT_REF_PARANOIA variable, but simply default it to "1"
instead of "0". That gives the user an escape hatch for loosening this
when working with a corrupt repository. It won't work across a remote
connection to upload-pack (because we can't necessarily set environment
variables on the remote), but there the client has other options (e.g.,
choosing which refs to fetch).

As a bonus, this also makes ref iteration faster in general (because we
don't have to call has_object_file() for each ref), though probably not
noticeably so in the general case. In a repo with a million refs, it
shaved a few hundred milliseconds off of upload-pack's advertisement;
that's noticeable, but most repos are not nearly that large.

The possible downside here is that any operation which iterates refs but
doesn't ever open their objects may now quietly claim to have X when the
object is corrupted (e.g., "git rev-list new-branch --not --all" will
treat a broken ref as uninteresting). But again, that's not really any
different than corruption below the ref level. We might have
refs/heads/old-branch as non-corrupt, but we are not actively checking
that we have the entire reachable history. Or the pointed-to object
could even be corrupted on-disk (but our "do we have it" check would
still succeed). In that sense, this is merely bringing ref-corruption in
line with general object corruption.

One alternative implementation would be to actually check for broken
refs, and then _immediately die_ if we see any. That would cause the
"rev-list --not --all" case above to abort immediately. But in many ways
that's the worst of all worlds:

  - it still spends time looking up the objects an extra time

  - it still doesn't catch corruption below the ref level

  - it's even more inconvenient; with the current implementation of
    GIT_REF_PARANOIA for something like upload-pack, we can make
    the advertisement and let the client choose a non-broken piece of
    history. If we bail as soon as we see a broken ref, they cannot even
    see the advertisement.

The test changes here show some of the fallout. A non-destructive "git
repack -adk" now fails by default (but we can override it). Deleting a
broken ref now actually tells the hooks the correct "before" state,
rather than a confusing null oid.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git.txt       | 19 ++++++++++---------
 refs.c                      |  2 +-
 t/t5312-prune-corruption.sh | 10 ++++++++--
 t/t5516-fetch-push.sh       |  7 ++++---
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index abace9eac2..d63c65e67d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -867,15 +867,16 @@ for full details.
 	end user, to be recorded in the body of the reflog.
 
 `GIT_REF_PARANOIA`::
-	If set to `1`, include broken or badly named refs when iterating
-	over lists of refs. In a normal, non-corrupted repository, this
-	does nothing. However, enabling it may help git to detect and
-	abort some operations in the presence of broken refs. Git sets
-	this variable automatically when performing destructive
-	operations like linkgit:git-prune[1]. You should not need to set
-	it yourself unless you want to be paranoid about making sure
-	an operation has touched every ref (e.g., because you are
-	cloning a repository to make a backup).
+	If set to `0`, ignore broken or badly named refs when iterating
+	over lists of refs. Normally Git will try to include any such
+	refs, which may cause some operations to fail. This is usually
+	preferable, as potentially destructive operations (e.g.,
+	linkgit:git-prune[1]) are better off aborting rather than
+	ignoring broken refs (and thus considering the history they
+	point to as not worth saving). The default value is `1` (i.e.,
+	be paranoid about detecting and aborting all operations). You
+	should not normally need to set this to `0`, but it may be
+	useful when trying to salvage data from a corrupted repository.
 
 `GIT_ALLOW_PROTOCOL`::
 	If set to a colon-separated list of protocols, behave as if
diff --git a/refs.c b/refs.c
index e72510813e..ac19c689fa 100644
--- a/refs.c
+++ b/refs.c
@@ -1420,7 +1420,7 @@ struct ref_iterator *refs_ref_iterator_begin(
 
 	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
 		if (ref_paranoia < 0)
-			ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
+			ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 1);
 		if (ref_paranoia) {
 			flags |= DO_FOR_EACH_INCLUDE_BROKEN;
 			flags |= DO_FOR_EACH_OMIT_DANGLING_SYMREFS;
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index d8ec5a7462..ea889c088a 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -49,11 +49,17 @@ test_expect_success 'put bogus object into pack' '
 	git cat-file -e $bogus
 '
 
-test_expect_success 'non-destructive repack ignores bogus name' '
+test_expect_success 'non-destructive repack bails on bogus ref' '
 	create_bogus_ref &&
-	git repack -adk
+	test_must_fail git repack -adk
 '
 
+test_expect_success 'GIT_REF_PARANOIA=0 overrides safety' '
+	create_bogus_ref &&
+	GIT_REF_PARANOIA=0 git repack -adk
+'
+
+
 test_expect_success 'destructive repack keeps packed object' '
 	create_bogus_ref &&
 	test_must_fail git repack -Ad --unpack-unreachable=now &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b13553ecf4..8212ca56dc 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -707,20 +707,21 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
 
 test_expect_success 'deleting dangling ref triggers hooks with correct args' '
 	mk_test_with_hooks testrepo heads/branch &&
+	orig=$(git -C testrepo rev-parse refs/heads/branch) &&
 	rm -f testrepo/.git/objects/??/* &&
 	git push testrepo :refs/heads/branch &&
 	(
 		cd testrepo/.git &&
 		cat >pre-receive.expect <<-EOF &&
-		$ZERO_OID $ZERO_OID refs/heads/branch
+		$orig $ZERO_OID refs/heads/branch
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/branch $ZERO_OID $ZERO_OID
+		refs/heads/branch $orig $ZERO_OID
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
-		$ZERO_OID $ZERO_OID refs/heads/branch
+		$orig $ZERO_OID refs/heads/branch
 		EOF
 
 		cat >post-update.expect <<-EOF &&
-- 
2.33.0.1071.gb37e412355

