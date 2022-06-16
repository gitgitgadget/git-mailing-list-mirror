Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A10C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 06:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358961AbiFPGID (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 02:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358654AbiFPGH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 02:07:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2B724BF5
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 23:07:42 -0700 (PDT)
Received: (qmail 12593 invoked by uid 109); 16 Jun 2022 06:07:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jun 2022 06:07:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 16 Jun 2022 02:07:41 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Richard Oliver <roliver@roku.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH] mktree: learn about promised objects
Message-ID: <YqrIrYHKUP6b/EtN@coredump.intra.peff.net>
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
 <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
 <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
 <YqkpRE8nykqVv8cn@nand.local>
 <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
 <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com>
 <1fe6c00a-806c-89de-cb67-d063dc4a5279@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fe6c00a-806c-89de-cb67-d063dc4a5279@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2022 at 02:17:58PM -0400, Derrick Stolee wrote:

> On 6/15/2022 1:40 PM, Richard Oliver wrote:
> > On 15/06/2022 05:00, Jeff King wrote:
> 
> >> So it is not just lookup, but actual tree walking that is expensive. The
> >> flip side is that you don't have to store a complete separate list of
> >> the promised objects. Whether that's a win depends on how many local
> >> objects you have, versus how many are promised.
> 
> This is also why blobless (or blob-size filters) are the recommended way
> to use partial clone. It's just too expensive to have tree misses.

I agree that tree misses are awful, but I'm actually talking about
something different: traversing the local trees we _do_ have in order to
find the set of promised objects. Which is worse for blob:none, because
it means you have more trees locally. :)

Try this with a big repo like linux.git:

  git clone --no-local --filter=blob:none linux.git repo
  cd repo

  # this is fast; we mark the promisor trees as UNINTERESTING, so we do
  # not look at them as part of the traversal, and never call
  # is_promisor_object().
  time git rev-list --count --objects --all --exclude-promisor-objects

  # but imagine we had a fixed mktree[1] that did not fault in the blobs
  # unnecessarily, and we made a new tree that references a promised
  # blob.
  tree=$(git ls-tree HEAD~1000 | grep Makefile | git mktree --missing)
  commit=$(echo foo | git commit-tree -p HEAD $tree)
  git update-ref refs/heads/foo $commit

  # this is now slow; even though we only call is_promisor_object()
  # once, we have to open every single tree in the pack to find it!
  time git rev-list --count --objects --all --exclude-promisor-objects

Those rev-lists run in 1.7s and 224s respectively. Ouch!

Now the setup there is kind of contrived, and it's actually not trivial
to convince rev-list to actually call is_promisor_object() these days.
That's because promisor-ness (promisosity?) tends to be one-way
transitive. A promised blob is usually either only referenced by
promised trees (which we have in this case), or is faulted in as part of
making a new tree.

But it's not guaranteed, and certainly a faulted-in object could later
be deleted from the local repo, since it's promised. I suspect there are
less convoluted workflows to get to a similar state, but I don't know
them offhand. There's more discussion of this issue in this thread from
last summer:

  https://lore.kernel.org/git/20210403090412.GH2271@szeder.dev/

-Peff

[1] The mktree I used was the fix discussed elsewhere in the thread:

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 902edba6d2..42ae82230c 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -117,15 +117,11 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 	}
 
 	/* Check the type of object identified by sha1 */
-	obj_type = oid_object_info(the_repository, &oid, NULL);
-	if (obj_type < 0) {
-		if (allow_missing) {
-			; /* no problem - missing objects are presumed to be of the right type */
-		} else {
+	if (!allow_missing) {
+		obj_type = oid_object_info(the_repository, &oid, NULL);
+		if (obj_type < 0)
 			die("entry '%s' object %s is unavailable", path, oid_to_hex(&oid));
-		}
-	} else {
-		if (obj_type != mode_type) {
+		else if (obj_type != mode_type) {
 			/*
 			 * The object exists but is of the wrong type.
 			 * This is a problem regardless of allow_missing
