Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15BA23DB
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2C910C
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 19:42:26 -0800 (PST)
Received: (qmail 27465 invoked by uid 109); 7 Nov 2023 03:42:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Nov 2023 03:42:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10423 invoked by uid 111); 7 Nov 2023 03:42:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Nov 2023 22:42:28 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Nov 2023 22:42:24 -0500
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/5] merge-ort: implement support for packing objects
 together
Message-ID: <20231107034224.GA874199@coredump.intra.peff.net>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <xmqqo7go7w63.fsf@gitster.g>
 <0ac32374-7d52-8f0c-8583-110de678291e@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ac32374-7d52-8f0c-8583-110de678291e@gmx.de>

On Mon, Nov 06, 2023 at 04:46:32PM +0100, Johannes Schindelin wrote:

> I wonder whether a more generic approach would be more desirable, an
> approach that would work for `git replay`, too, for example (where
> streaming objects does not work because they need to be made available
> immediately because subsequent `merge_incore_nonrecursive()` might expect
> the created objects to be present)?
> 
> What I have in mind is more along Elijah's suggestion at the Contributor
> Summit to use the `tmp_objdir*()` machinery. But instead of discarding the
> temporary object database, the contained objects would be repacked and the
> `.pack`, (maybe `.rev`) and the `.idx` file would then be moved (in that
> order) before discarding the temporary object database.
> 
> This would probably need to be implemented as a new
> `tmp_objdir_pack_and_migrate()` function that basically spawns
> `pack-objects` and feeds it the list of generated objects, writing
> directly into the non-temporary object directory, then discarding the
> `tmp_objdir`.

Perhaps I'm missing some piece of the puzzle, but I'm not sure what
you're trying to accomplish with that approach.

If the goal is to increase performance by avoiding the loose object
writes, then we haven't really helped much. We're still writing them,
and then writing them again for the repack.

If the goal is just to end up with a single nice pack for the long term,
then why do we need to use tmp_objdir at all? That point of that API is
to avoid letting other simultaneous processes see the intermediate state
before we're committed to keeping the objects around. That makes sense
for receiving a fetch or push, since we want to do some quality checks
on the objects before agreeing to keep them. But does it make sense for
a merge? Sure, in some workflows (like GitHub's test merges) we might
end up throwing away the merge result if it's not clean. But there is no
real downside to other processes seeing those objects. They can be
cleaned up at the next pruning repack.

I guess if your scenario requirements include "and we are never allowed
to run a pruning repack", then that could make sense. And I know that
has been a historical issue for GitHub. But I'm not sure it's
necessarily a good driver for an upstream feature.

As an alternative, though, I wonder if you need to have access to the
objects outside of the merge process. If not, then rather than an
alternate object store, what if that single process wrote to a streaming
pack _and_ used its running in-core index of the objects to allow access
via the usual object-retrieval. Then you'd get a single, clean pack as
the outcome _and_ you'd get the performance boost over just "write loose
objects, repack, and prune".

-Peff
