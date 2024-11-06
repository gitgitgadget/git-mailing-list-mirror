Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D913A26F
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927841; cv=none; b=lAIW4BRwyzZNO0vR24xFFGsX0tLLWv+CsugvyNk5rfsWTwXmPQxmBXUnzZvpcuDfY+9byDHulmEcO88B/F9aWG8xLrkDLh7ekUVU57eSEPZvDLH+Y0mcp+O0ctGjFQGQGs95/5wgIyveDe6YDy0NagmNFJJeRCZZ04G4A1A2Ytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927841; c=relaxed/simple;
	bh=NyIbO+48Z9DzYkKOTStLWJJPk2xTmNqjQV3ZBpDF9Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibnzv4o1HEgKSQahgztoA/3UXhM7XG/qHrthpMf+WjhMtGBYRCfUGYTPdX9UcKbtp+EKoB0WqrlfbB4MNds1jb2WObY/R2SmhsA98DzpoLkEM7qlz+0L9gHGCW1upkar6O9IWOe7gHbhHU+G3qWcQvZeBXfOccUIu9d+Ptu1Et8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dTBkytPP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dTBkytPP"
Received: (qmail 15355 invoked by uid 109); 6 Nov 2024 21:17:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NyIbO+48Z9DzYkKOTStLWJJPk2xTmNqjQV3ZBpDF9Ow=; b=dTBkytPPioS/xA5BICOfBHCF0eMJfrVVgqNLJJrSOZItHlWAB9vizkCJ3y7SxrzE2RybAyni6Bhera6wrVV/pyQIQVobCUjgZNGE7W239FJrHxSn6d/IiuM+BSkG7L/HQ8dOLVaUlU1fBU7Jc1vKJrkNNEsOt9VR1gREH5IQFpXuzijdMSok6gh5W5gd8mFBGitA8FXqkKvGK9YLSIayV95ZWrUIadnwRy1iq7wOOvWhCUAY2o4r8R9nx6pMFi1MYomhXmAAAne29MX4yAko+Yb5951BHoBSdEf1kr/de4VC9UIepRZCJWw6z+6AUxnGaTw8rAKoa3NivT7OfdESoA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Nov 2024 21:17:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8161 invoked by uid 111); 6 Nov 2024 21:17:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 16:17:17 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 16:17:17 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benno Evers <benno.martin.evers@gmail.com>,
	Rasmus Villemoes <ravi@prevas.dk>, Benno Evers <benno@bmevers.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/4] describe: stop traversing when we run out of names
Message-ID: <20241106211717.GD956383@coredump.intra.peff.net>
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

When trying to describe a commit, we'll traverse from the commit,
collecting candidate tags that point to its ancestors. But once we've
seen all of the tags in the repo, there's no point in traversing
further. There's nothing left to find!

For a default "git describe", this isn't usually a big problem. In a
large repo you'll probably have multiple tags, so we'll eventually find
10 candidates (the default for max_candidates) and stop there. And in a
small repo, it's quick to traverse to the root.

But you can imagine a large repo with few tags. Or, as we saw in a real
world case, explicitly limiting the set of matches like this (on
linux.git):

  git describe --match=v6.12-rc4 HEAD

which goes all the way to the root before realizing that no, there are
no other tags under consideration besides the one we fed via --match.
If we add in "--candidates=1" there, it's much faster (at least as of
the previous commit).

But we should be able to speed this up without the user asking for it.
After expanding all matching tags, we know the total number of names. We
could just stop the traversal there, but as hinted at above we already
have a mechanism for doing that: the max_candidate limit. So we can just
reduce that limit to match the number of possible candidates.

Our p6100 test shows this off:

  Test                                           HEAD^             HEAD
  ---------------------------------------------------------------------------------------
  6100.2: describe HEAD                          0.71(0.65+0.06)   0.72(0.68+0.04) +1.4%
  6100.3: describe HEAD with one max candidate   0.01(0.00+0.00)   0.01(0.00+0.00) +0.0%
  6100.4: describe HEAD with one tag             0.72(0.66+0.05)   0.01(0.00+0.00) -98.6%

Now we are fast automatically, just as if --candidates=1 were supplied
by the user.

Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Helped-by: Rasmus Villemoes <ravi@prevas.dk>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index 69f2d942be..8ec3be87df 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -667,6 +667,8 @@ int cmd_describe(int argc,
 			     NULL);
 	if (!hashmap_get_size(&names) && !always)
 		die(_("No names found, cannot describe anything."));
+	if (hashmap_get_size(&names) < max_candidates)
+		max_candidates = hashmap_get_size(&names);
 
 	if (argc == 0) {
 		if (broken) {
-- 
2.47.0.441.g1a09955689
