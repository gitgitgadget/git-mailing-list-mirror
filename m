Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A713A26F
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927837; cv=none; b=stv0cjq2Umn4DTWZk9zIFL2Bryo1Xq+thDtLHDwwWM2+HZJzzB83aI/EQVRUBwa9oc5ma/33QBcXmzY47T3xQFIjTqfuM6hT+AMWMkO8J4AQfYyfas5e3zuC7SwyzF+kntZHSPsVKQwsxMaRfILkomSi916C5guHquIPWY6C+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927837; c=relaxed/simple;
	bh=KfkgKkj+16YOE96qsPRAw/isziZbMbhyBlAmFfzNLaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk7p/5TVLrKUJ7yc41gvgtafkaJM6NzIi9C67kCk4a7WGCsUFbR4Q+mi/Aqkpgmr6ZK7WTrjsPr72qSfVIJvZt13reGFmcqRertZJhhbAWyT4NhIsXGS5zK7GS1SZ5UX0xwT1br/9bBxjUzA2CweuaoyumyLk4w+R7CzXUglP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L8KyDuwX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L8KyDuwX"
Received: (qmail 15336 invoked by uid 109); 6 Nov 2024 21:17:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KfkgKkj+16YOE96qsPRAw/isziZbMbhyBlAmFfzNLaM=; b=L8KyDuwXIawhfTLxsMo0CL0GFRkfTiIAEobeMLY/SkxRZxvakWVS5c5ADwWvRXP6VAN07lVfD6muEpDGmskVLDuMyg/cc+hotVAmUFHFcIzFG40PCyuSkkkbqMyXkuK6sa2BzRjsyPe55+VFOREFCEyBEycRVhdm99zu8i4s9EhZHLyEW2G+c46fBJ188lrMzn7VAfoI0t/TPSS5mNp/w2iMQyhF/W1fvKgQO8HB/6eDdQO+/qhf18kFdOQPXCTI76+aEUznX3kWJWZebO+5NpDXqLIcY8PRBs9cLURLly1PBiR5on0qdZd4a8a7oje/5oXCD72l7NK7jg+yaCu+Hg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Nov 2024 21:17:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8153 invoked by uid 111); 6 Nov 2024 21:17:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 16:17:14 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 16:17:14 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benno Evers <benno.martin.evers@gmail.com>,
	Rasmus Villemoes <ravi@prevas.dk>, Benno Evers <benno@bmevers.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/4] describe: stop digging for max_candidates+1
Message-ID: <20241106211714.GC956383@coredump.intra.peff.net>
References: <20241106192236.GC880133@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106192236.GC880133@coredump.intra.peff.net>

By default, describe considers only 10 candidate matches, and stops
traversing when we have enough. This makes things much faster in a large
repository, where collecting all candidates requires walking all the way
down to the root (or at least to the oldest tag). This goes all the way
back to 8713ab3079 (Improve git-describe performance by reducing
revision listing., 2007-01-13).

However, we don't stop immediately when we have enough candidates. We
keep traversing and only bail when we find one more candidate that we're
ignoring. Usually this is not too expensive, if the tags are sprinkled
evenly throughout history. But if you are unlucky, you might hit the max
candidate quickly, and then have a huge swath of history before finding
the next one.

Our p6100 test has exactly this unlucky case: with a max of "1", we find
a recent tag quickly and then have to go all the way to the root to find
the old tag that will be discarded.

A more interesting real-world case is:

  git describe --candidates=1 --match=v6.12-rc4 HEAD

in the linux.git repo. There we restrict the set of tags to a single
one, so there is no older candidate to find at all! But despite
--candidates=1, we keep traversing to the root only to find nothing.

So why do we keep traversing after hitting thet max? There are two
reasons I can see:

  1. In theory the extra information that there was another candidate
     could be useful, and we record it in the gave_up_on variable. But
     we only show this information with --debug.

  2. After finding the candidate, there's more processing we do in our
     loop. The most important of this is propagating the "within" flags
     to our parent commits, and putting them in the commit_list we'll
     use for finish_depth_computation().

     That function continues the traversal until we've counted all
     commits reachable from the starting point but not reachable from
     our best candidate tag (so essentially counting "$tag..$start", but
     avoiding re-walking over the bits we've seen).  If we break
     immediately without putting those commits into the list, our depth
     computation will be wrong (in the worst case we'll count all the
     way down to the root, not realizing those commits are included in
     our tag).

But we don't need to find a new candidate for (2). As soon as we finish
the loop iteration where we hit max_candidates, we can then quit on the
next iteration. This should produce the same output as the original code
(which could, after all, find a candidate on the very next commit
anyway) but ends the traversal with less pointless digging.

We still have to set "gave_up_on"; we've popped it off the list and it
has to go back. An alternative would be to re-order the loop so that it
never gets popped, but it's perhaps still useful to show in the --debug
output, so we need to know it anyway. We do have to adjust the --debug
output since it's now just a commit where we stopped traversing, and not
the max+1th candidate.

p6100 shows the speedup using linux.git:

  Test                                           HEAD^             HEAD
  ---------------------------------------------------------------------------------------
  6100.2: describe HEAD                          0.70(0.63+0.06)   0.71(0.66+0.04) +1.4%
  6100.3: describe HEAD with one max candidate   0.70(0.64+0.05)   0.01(0.00+0.00) -98.6%
  6100.4: describe HEAD with one tag             0.70(0.67+0.03)   0.70(0.63+0.06) +0.0%

Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Helped-by: Rasmus Villemoes <ravi@prevas.dk>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 7330a77b38..69f2d942be 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -366,6 +366,12 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		struct commit_name **slot;
 
 		seen_commits++;
+
+		if (match_cnt == max_candidates) {
+			gave_up_on = c;
+			break;
+		}
+
 		slot = commit_names_peek(&commit_names, c);
 		n = slot ? *slot : NULL;
 		if (n) {
@@ -381,10 +387,6 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 				if (n->prio == 2)
 					annotated_cnt++;
 			}
-			else {
-				gave_up_on = c;
-				break;
-			}
 		}
 		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
 			struct possible_tag *t = &all_matches[cur_match];
@@ -470,9 +472,8 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		fprintf(stderr, _("traversed %lu commits\n"), seen_commits);
 		if (gave_up_on) {
 			fprintf(stderr,
-				_("more than %i tags found; listed %i most recent\n"
-				"gave up search at %s\n"),
-				max_candidates, max_candidates,
+				_("found %i tags; gave up search at %s\n"),
+				max_candidates,
 				oid_to_hex(&gave_up_on->object.oid));
 		}
 	}
-- 
2.47.0.441.g1a09955689

