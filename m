Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522711F462
	for <e@80x24.org>; Tue, 21 May 2019 01:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfEUBcv (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 21:32:51 -0400
Received: from thyrsus.com ([71.162.243.5]:38034 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfEUBcv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 21:32:51 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 3506B470485F; Mon, 20 May 2019 21:32:50 -0400 (EDT)
From:   esr@thyrsus.com (Eric S. Raymond)
To:     git@vger.kernel.org
Subject: RFC: Separate commit identification from Merkle hashing
Message-Id: <20190521013250.3506B470485F@snark.thyrsus.com>
Date:   Mon, 20 May 2019 21:32:50 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have been thinking hard about the problems raised during my
request for unique timestamps.  I think I've found a better way
to bust the box I was trying to break out of.  I am therefore
withdrawing that proposal and replacing it with this one.

It's time to separate commit identification from Merkle hashing.

One reason I am sure of this is the SHA-1 to whatever transition.
We can't count on the successor hash to survive attack forever.
Accordingly, git's design needs to be stable against the possibility
of having to accommodate multiple future hash algorithms in the
future.

Here's how to do it:

1. Commit IDs and Merkle-tree hashes become separate commit
   properties in the git filesystem.

2. The data structure representing a Merkle-tree hash becomes
   a pair consisting of a value and a hash-algorithm tag. An
   empty tag is interpreted as SHA-1. I will call this entity the
   "verification hash" and avoid unqualified use of "hash" in the
   rest of this proposal.

3. The initial value of a commit's ID in a live repository is a copy
   of its verification hash, except in one important case.

4. When a repository is exported to a stream, the commit-id is dumped
   with other commit metadata.  Thus, anything that can read a stream
   can resolve commit references in its change comments.

5. When a stream is imported, if a commit has a commit-id field it
   overrides the default assignment of the generated verification hash
   to that field.

6. Commit IDs are free-format and not interpreted by git except
   as lookup keys. When git changes verification-hash functions,
   commit IDs do not change.

Notice several important properties of this design.

A. Git becomes absolutely future-proofed against hash-algorithm
   changes. It can even support the use of multiple hash types over
   the lifetime of one repo.

B. All SHA-1 commit references will resolve forever even after git
   stops generating them.  All future hash-based commit references will
   also be good forever.

C. The id/verification split will be invisible from clients at start,
   because initially they coincide and will continue to do so unless
   an explicit decision changes either the verification-hash algorithm
   or the way commit-IDs are initialized.

D. My wish for forward-portable unique commit IDs is granted.
   They're not by default eyeball-friendly, but I can live with that.
   Furthermore, because they're preserved in streams they can be
   eternally stable even as hash algorithms and preferred ID
   formats change.

E. There is now a unique total order on the repo, modulo highly
   unlikely (and in priciple completely avoidable) commit-ID
   collisions. It's commit date tie-broken by commit-ID sort order.
   It too survives hash-function changes.

F. There's no need for timestamp uniqueness any more.

G. When a repository is imported from (say) Subversion, the Subversion
   IDs *don't have to break*!  They can be used to initialize the
   commit-ID fields. Many users migrating from other VCSes will be
   deeply, deeply grateful for this feature.

I believe this solves every problem I walked in with except timestamp
truncation.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

Probably fewer than 2% of handguns and well under 1% of all guns will
ever be involved in a violent crime. Thus, the problem of criminal gun
violence is concentrated within a very small subset of gun owners,
indicating that gun control aimed at the general population faces a
serious needle-in-the-haystack problem.
	-- Gary Kleck, "Point Blank: Handgun Violence In America"
