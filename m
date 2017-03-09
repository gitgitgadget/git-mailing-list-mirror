Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EA9D1FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 10:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbdCIKP4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 05:15:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:41165 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753635AbdCIKPz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 05:15:55 -0500
Received: (qmail 6432 invoked by uid 109); 9 Mar 2017 10:09:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 10:09:12 +0000
Received: (qmail 3455 invoked by uid 111); 9 Mar 2017 10:09:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 05:09:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 05:09:10 -0500
Date:   Thu, 9 Mar 2017 05:09:10 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] branch & tag: Add a --no-contains option
Message-ID: <20170309100910.z4h7bwqzxw2xynyu@sigill.intra.peff.net>
References: <20170308202025.17900-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170308202025.17900-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2017 at 08:20:25PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Change the branch & tag commands to have a --no-contains option in
> addition to their longstanding --contains options.
> 
> The use-case I have for this is mainly to find the last-good rollout
> tag given a known-bad <commit>. Right given a hypothetically bad
> commit v2.10.1-3-gcf5c7253e0 now you can find that with this hacky
> one-liner:
> 
>     (./git tag -l 'v[0-9]*'; ./git tag -l 'v[0-9]*' --contains v2.10.1-3-gcf5c7253e0)|sort|uniq -c|grep -E '^ *1 '|awk '{print $2}'
> 
> But with the --no-contains option you can now get the exact same
> output with:
> 
>     ./git tag -l 'v[0-9]*' --no-contains v2.10.1-3-gcf5c7253e0 | sort

I think that's a good goal.

I'm not sure about the name. I would have expected "--no-contains" to
reset the list of "--contains" commits to the empty set. That's an
option convention we've been slowly moving towards (e.g., with
OPT_STRING_LIST).

What you've added here _does_ match "--no-merged", though. I'm not sure
of the best way forward. At the very least, "--no-contains" is currently
an error, so you would not be changing existing behavior.

> Once I'd implemented this for "tag" it was easy enough to add it for
> "branch". I haven't added it to "for-each-ref" but that would be
> trivial if anyone cares, but that use-case would be even more obscure
> than adding it to "branch", so I haven't bothered.

I'd prefer to have it consistently in all three. We should be able to
tell people to use for-each-ref in their scripts, and that's harder if
it is missing features.

> The "describe" command also has a --contains option, but its semantics
> are unrelated to what tag/branch/for-each-ref use --contains for, and
> I don't see how a --no-contains option for it would make any sense.

Yeah, I think that feature is orthogonal.

> -static int commit_contains(struct ref_filter *filter, struct commit *commit)
> +static int commit_contains(struct ref_filter *filter, struct commit *commit, const int with_commit)
>  {
> +	struct commit_list *tmp = with_commit ? filter->with_commit : filter->no_commit;
>  	if (filter->with_commit_tag_algo)
> -		return contains_tag_algo(commit, filter->with_commit);
> -	return is_descendant_of(commit, filter->with_commit);
> +		return contains_tag_algo(commit, tmp);
> +	return is_descendant_of(commit, tmp);
>  }

Perhaps it would be simpler if the caller just passed the right
commit_list rather than a flag. We unfortunately do still need to pass
the "filter" (for the algorithm field), but the caller is then:

  if (filter->with_commit &&
      !commit_contains(filter, filter->with_commit, commit))
          return 0;
  if (filter->no_commit &&
      commit_contains(filter, filter->no_commit, commit))
          return 0;

which avoids the 0/1 flag whose meaning is not immediately apparent at
the callsite. One day we can hopefully unify the two algorithms and
ditch the extra filter parameter.

I almost suggested that there simply be an option to invert the match
(like --invert-contains or something).  But what you have here is more
flexible, if somebody ever wanted to do:

  git tag --contains X --no-contains Y

That could be useful if a feature was introduced in X and then got buggy
in Y.

> @@ -1708,8 +1782,91 @@ run_with_limited_stack () {
>  
>  test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
>  
> +# These are all the tags we've created above
> +cat >expect.no-contains <<EOF
> [...80 tags...]
> +EOF

That's a lot of tags, and I'd worry it makes the test a little brittle.
Can we limit the set of tags with a name-match? It shouldn't affect the
purpose of the test (the deep stack comes from traversing the commits,
not the number of tags).

-Peff
