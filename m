Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CB218DF62
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 05:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756011651; cv=none; b=igb9k3fGFW+5NhwK8awI3i5FVZ4PoK6B6MUc7WycRShaHTBkmlXioTFV2SOriF33iau0Dbef4T3agTHuYdCNEsY0fkxLVynyJ4Fz6sTDlRMCHTUV2uQMxQJIKNVFW/5VFBuoP1JpjS8wbysy8AzCSEXRoMD4Y4hI49tGbdsfN88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756011651; c=relaxed/simple;
	bh=O7S0vloV684b1u7kGtPrlALO5958snn/sRZWiaPAiHs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mdxwzdBh4BwmrFYmZRdZbIb8ISKOnni0KdDIXs1xCx3tiNitIiEAZsZTr47XlgJYOdVT2TvCoKEh70vqwlKUcgsETNehxpoiYaKTIJfTS7gK+1sYl1bzX62YeS4qbxgSjV88TToUh01t67SXB5CGU07DWY6I/qkbEsI4UvhQcNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HCDnQ34n; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HCDnQ34n"
Received: (qmail 65038 invoked by uid 109); 24 Aug 2025 05:00:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=20240930; bh=O7S0vloV684b1u7kGtPrlALO5958snn/sRZWiaPAiHs=; b=HCDnQ34n/YpkCtK+Rd4wngYeiioNRdNTCUcfHMi01vX7HVX4HB9LcPLXvLc8Wn9iJWGZ9W0RjLsO+/GH+E2dGuZuo9iw4nZadGcGEKroVP0C6THB5KaQgYiJqTz2WlF4FXpWz/T5k4F6iOfrIKzOv6WWz4eB+3JoFKiNKk3cqjY75B9LEna9Mi6GTTuCevGaB7uFKe6sapU/yP7anzaUrfAKcGFsW6z6ArZCx1DwgqmElrsd13QwxG5gG4zwIJ/PrdPZk4EP+pclVQ5MGYMhSqv6A9j9MGGwCH+QeprgzLtESv3B5Agng0fJrRm0BlHK4Wang/ZEgzuvoUvOXIbDWg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 24 Aug 2025 05:00:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 128535 invoked by uid 111); 24 Aug 2025 05:00:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 24 Aug 2025 01:00:40 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 24 Aug 2025 01:00:40 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] fetch-pack: re-scan when double-checking graph objects
Message-ID: <20250824050040.GA228050@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The fetch code tries to avoid asking the remote side for an object we
already have. It does this by traversing recent commits reachable from
our refs looking for matches. Commit 5d4cc78f72 (fetch-pack: die if in
commit graph but not obj db, 2024-11-05) introduced an extra check
there: if we think we have an object because it's in the commit graph,
we double-check that we actually have it in our object database with a
call to odb_has_object().

But that call does not pass any flags, and so the function won't call
reprepared_packed_git() if it does not find the object. That opens us up
to the usual race against some other process repacking the odb:

  1. We scan the list of packs in objects/pack but haven't yet opened them.

  2. Somebody else packs the object into a new pack (which we don't know
     about), and deletes the old pack it was in.

  3. Our odb_has_object() calls tries to open that old pack, but finds it
     is gone. We declare that we don't have the object.

And this causes us to erroneously complain and abort the fetch, thinking
our commit-graph and object database are out of sync. Instead, we should
pass HAS_OBJECT_RECHECK_PACKED, which will add a new step:

  4. We re-scan the pack directory again, find the new pack, and locate
     the object.

Often the fetch code tries to avoid these kinds of re-scans if it's
likely that we won't have the object. If the other side has told us
about object X and we want to know if we have it, we'll skip the re-scan
(to avoid spending a lot of effort when there are many such objects). We
can accept the racy false negative in that case because the worst case
is that we ask the other side to send us the object.

But this is not one of those cases. These are objects which are
accessible from _our_ refs, and which we already found in the commit
graph file. We should have them, and if we don't, we'll die()
immediately. So the performance impact is negligible, and getting the
right answer is important.

There's no test here because it's inherently racy. In fact, I had
trouble even developing a minimal test. The problem seen in the wild can
be produced like this:

  # Any git.git mirror which supports partial clones; I think this
  # should work with any repo that contains submodules, but note that
  # $obj below is specific to this repo
  url=https://github.com/git/git.git

  # This is a commit that is not at the tip of any branches (so after
  # we have it, we'll still have some commits to fetch).
  obj=cf6f63ea6bf35173e02e18bdc6a4ba41288acff9

  git init
  git fetch --filter=tree:0 $url $obj:refs/heads/foo
  git checkout foo
  git commit-graph write --reachable
  git fetch $url

What happens here is that the initial fetch grabs that older commit (and
its ancestors) but no trees or blobs, and the subsequent checkout grabs
the necessary trees and blobs just for that commit. The final fetch
spawns a long sequence of child fetches due to fetch_submodules(), which
wants to check whether there have been any gitlink modifications which
should trigger a fetch of the related submodule (we'll leave aside the
irony that we did not even check out any submodules yet).

That series of fetches causes us to accumulate packs, which eventually
triggers background maintenance to run. That repacks all-into-one, and
the pack containing $obj goes away in favor of a new pack. And then the
fetch eventually fails with:

  fatal: You are attempting to fetch cf6f63ea6bf35173e02e18bdc6a4ba41288acff9, which is in the commit graph file but
not in the object database.

In the scenario above, the race becomes likely because of the long
series of quick fetches. But I _think_ the bug is independent of partial
clones entirely, and you could run into the same thing with a single
fetch, some other process running "git repack" simultaneously, and a bit
of bad luck. I haven't been able to reproduce, though. I'm not sure if
that's because there's some mis-analysis above, or if the race window is
just small enough that it's hard to trigger.

At any rate, re-scanning here seems like an obviously correct thing to
do with no downside, and it does fix the partial-clone case shown above.

Reported-by: Дилян Палаузов <dilyan.palauzov@aegee.org>
Signed-off-by: Jeff King <peff@peff.net>
---
Originally discussed in:

  https://lore.kernel.org/git/e7a2fdff63d9a90ef4dc1341fa642fff5197b64a.camel@aegee.org/

 fetch-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 20e5533b21..6ed5662951 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -143,7 +143,8 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 	commit = lookup_commit_in_graph(the_repository, oid);
 	if (commit) {
 		if (mark_tags_complete_and_check_obj_db) {
-			if (!odb_has_object(the_repository->objects, oid, 0))
+			if (!odb_has_object(the_repository->objects, oid,
+					    HAS_OBJECT_RECHECK_PACKED))
 				die_in_commit_graph_only(oid);
 		}
 		return commit;
-- 
2.51.0.364.gbc6ae1dd20
