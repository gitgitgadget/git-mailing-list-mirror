Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7014AAE
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ABAC2
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 13:18:12 -0700 (PDT)
Received: (qmail 32416 invoked by uid 109); 1 Nov 2023 20:18:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Nov 2023 20:18:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5647 invoked by uid 111); 1 Nov 2023 20:18:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Nov 2023 16:18:13 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Nov 2023 16:18:10 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] max_tree_depth: lower it for MSVC to avoid stack
 overflows
Message-ID: <20231101201810.GA1419081@coredump.intra.peff.net>
References: <pull.1604.git.1698680732691.gitgitgadget@gmail.com>
 <pull.1604.v2.git.1698843810814.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1604.v2.git.1698843810814.gitgitgadget@gmail.com>

On Wed, Nov 01, 2023 at 01:03:30PM +0000, Johannes Schindelin via GitGitGadget wrote:

> So the best bet to work around this for now seems to just lower the
> maximum allowed tree depth _even further_ for MSVC builds.

Thanks for rewriting this. The resulting patch looks good to me.

Just a few small thoughts:

> There seems to be some internal stack overflow detection in MSVC's
> `malloc()` machinery that seems to be independent of the `stack reserve`
> and `heap reserve` sizes specified in the executable (editable via
> `EDITBIN /STACK:<n> <exe>` and `EDITBIN /HEAP:<n> <exe>`).

Yikes, I'm sure that paragraph sums up a painful debugging journey. :)

> In the newly test cases added by `jk/tree-name-and-depth-limit`, this
> stack overflow detection is unfortunately triggered before Git can print
> out the error message about too-deep trees and exit gracefully. Instead,
> it exits with `STATUS_STACK_OVERFLOW`. This corresponds to the numeric
> value -1073741571, something the MSYS2 runtime we sadly need to use to
> run Git's test suite cannot handle and which it internally maps to the
> exit code 127. Git's test suite, in turn, mistakes this to mean that the
> command was not found, and fails both test cases.

I think this detail is OK, but the bit about mistaking 127 is IMHO kind
of irrelevant to the purpose of the patch. The whole point of those
tests is that they would trigger in a segfault to alert us that the
default depth limit was too high, and they did. So it was in fact lucky
that even though the segfault was munged into 127, our test_must_fail
still noticed it.

> Note: even switching to using a different allocator (I used mimalloc
> because that's what Git for Windows uses for its GCC builds) does not
> help, as the zlib code used to unpack compressed pack entries _still_
> uses the regular `malloc()`. And runs into the same issue.

I didn't think zlib ever malloc'd, since we feed it streaming data (and
it will return and ask us to flush if the output buffer is full). But I
admit I haven't dug too far into it, and it sounds like you may have.

What I was wondering specifically is whether you're actually hitting the
raw malloc() (as opposed to xmalloc) calls in diff-delta.c (which would
depend on how you've set up the different allocator).

Either way, changing anything there is well outside the scope of your
patch. I've just always wondered if those raw malloc() calls might cause
headaches, and whether this might be a concrete example of such.

-Peff
