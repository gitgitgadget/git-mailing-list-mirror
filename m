Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60397C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 13:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A43420716
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 13:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgC1NPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 09:15:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:54398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726045AbgC1NPz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 09:15:55 -0400
Received: (qmail 23920 invoked by uid 109); 28 Mar 2020 13:15:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Mar 2020 13:15:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1221 invoked by uid 111); 28 Mar 2020 13:25:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Mar 2020 09:25:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Mar 2020 09:15:53 -0400
From:   Jeff King <peff@peff.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v3 1/1] remote.c: fix handling of %(push:remoteref)
Message-ID: <20200328131553.GA643242@coredump.intra.peff.net>
References: <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
 <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 05:45:58PM +0100, Damien Robert wrote:

> Since the intention of %(push:remoteref), from 9700fae5ee (for-each-ref:
> let upstream/push report the remote ref name) is to get exactly which
> branch `git push` will push to, even in the fallback cases, fix this.
> 
> To get the meaning of %(push:remoteref), `ref-filter.c` calls
> `remote_ref_for_branch`. We simply add a new static helper function,
> `branch_get_push_remoteref` that follows the logic of
> `branch_get_push_1`, and call it from `remote_ref_for_branch`.

I looked at this again with fresh eyes, and I think it's a pretty
practical fix all around. I noticed one memory leak, but it's actually
there already. :-/

> I ended up following most of Junio's suggestion, except having a
>     default: BUG(...)
> and returning NULL at the end of the case.
>
> I prefer to return explicitly in each case statement rather than use break
> to fallback at the end of the case.

What you have looks reasonable to me (and would hopefully get us a
compiler warning if new push modes are added).

> I said I would also update branch_get_push1 to be as similar as possible to
> branch_get_push_remoteref, but because of the error handling of the latter,
> it would makes the syntax a bit weird, so I did not touch it.
>
> I am still a bit annoyed that I cannot call branch_get_push_remoteref from
> branch_get_push1 because of the PUSH_DEFAULT_UPSTREAM case, but this can
> wait and we will need to work with the code duplication meanwhile.

I looked into this, too, and have a working patch. It does get a little
awkward, though, and I'm happy to just take your patch for now as the
practical thing.

> -const char *remote_ref_for_branch(struct branch *branch, int for_push)
> [...]
> -			const char *dst, *remote_name =
> -				pushremote_for_branch(branch, NULL);
> -			struct remote *remote = remote_get(remote_name);
> -
> -			if (remote && remote->push.nr &&
> -			    (dst = apply_refspecs(&remote->push,
> -						  branch->refname))) {
> -				return dst;
> -			}

This is the leak in the old code. apply_refspecs() returns a newly
allocated buffer, but our caller would never know to free it because we
return a const pointer.

And we have the same problem in the new code:

> +static const char *branch_get_push_remoteref(struct branch *branch)
> [...]
> +	if (remote->push.nr) {
> +		return apply_refspecs(&remote->push, branch->refname);
> +	}

But we can't return a "char *", because all of the other return values
point to long-lived strings that the caller won't own. One way to solve
it would be to xstrdup() all of those. I'm not thrilled about that,
though; for-each-ref already does way more allocations-per-ref than I'd
like.

A better solution would be for this function to write the result into a
strbuf. For one-off calls that's no worse than allocating a string to
return, and for repeated calls like for-each-ref, it could reuse the
same allocated strbuf over and over.

Since this leak existed before your patch, I'm inclined to treat it as a
separate topic and not have it hold up this fix.

> +static const char *branch_get_push_remoteref(struct branch *branch)
> [...]

All the logic here makes sense to me.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh

The tests makes sense to me, though I found a few nits to pick:

> index 9c910ce746..60e21834fd 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -874,7 +874,34 @@ test_expect_success ':remotename and :remoteref' '
>  		actual="$(git for-each-ref \
>  			--format="%(push:remotename),%(push:remoteref)" \
>  			refs/heads/push-simple)" &&
> -		test from, = "$actual"
> +		test from, = "$actual" &&

The existing tests just assume taht push.default=simple. Since we're now
testing everything, should this be "git -c push.default=simple" to be
more explicit?

Likewise, is it worth labeling all of the simple cases with a comment
(or possibly putting them in separate tests, though I guess some of the
setup is shared)?  This one expects blank because there's no configured
upstream.

> +		git config branch.push-simple.remote from &&
> +		git config branch.push-simple.merge refs/heads/master &&
> +		actual="$(git for-each-ref \
> +			--format="%(push:remotename),%(push:remoteref)" \
> +			refs/heads/push-simple)" &&
> +		test from, = "$actual" &&

This one expects blank because the upstream and local names don't match.

> +		actual="$(git -c push.default=upstream for-each-ref \
> +			--format="%(push:remotename),%(push:remoteref)" \
> +			refs/heads/push-simple)" &&
> +		test from,refs/heads/master = "$actual" &&

This one has a real configured upstream (and relies on the
branch.*.merge config set above). OK.

It's a little funny that the branch is still called push-simple. :)

> +		actual="$(git -c push.default=current for-each-ref \
> +			--format="%(push:remotename),%(push:remoteref)" \
> +			refs/heads/push-simple)" &&
> +		test from,refs/heads/push-simple = "$actual" &&

Same name on the other side. OK.

> +		actual="$(git -c push.default=matching for-each-ref \
> +			--format="%(push:remotename),%(push:remoteref)" \
> +			refs/heads/push-simple)" &&
> +		test from,refs/heads/push-simple = "$actual" &&

Ditto for matching, which I think is the only sensible output.

> +		actual="$(git -c push.default=nothing for-each-ref \
> +			--format="%(push:remotename),%(push:remoteref)" \
> +			refs/heads/push-simple)" &&
> +		test from, = "$actual" &&

Nothing for nothing. Makes sense.

> +		git config branch.push-simple.merge refs/heads/push-simple &&
> +		actual="$(git for-each-ref \
> +			--format="%(push:remotename),%(push:remoteref)" \
> +			refs/heads/push-simple)" &&
> +		test from,refs/heads/push-simple = "$actual"

And this is a real simple that actually shows something. It would make
more sense to me with the other "simple" tests, but I guess _not_ having
the upstream set to the same name is important for the quality of the
"current" and "upstream" tests.

Maybe we could do this test first, before setting branch.*.merge to
refs/heads/master?

-Peff
