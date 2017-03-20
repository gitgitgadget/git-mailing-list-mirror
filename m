Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F12820323
	for <e@80x24.org>; Mon, 20 Mar 2017 04:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbdCTEZd (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 00:25:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:47365 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbdCTEZc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 00:25:32 -0400
Received: (qmail 25244 invoked by uid 109); 20 Mar 2017 04:25:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 04:25:24 +0000
Received: (qmail 29391 invoked by uid 111); 20 Mar 2017 04:25:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 00:25:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 00:25:19 -0400
Date:   Mon, 20 Mar 2017 00:25:19 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 6/8] ref-filter: Add --no-contains option to
 tag/branch/for-each-ref
Message-ID: <20170320042519.srtavoxhm3fln5mw@sigill.intra.peff.net>
References: <20170318103256.27141-1-avarab@gmail.com>
 <20170318103256.27141-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170318103256.27141-7-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 10:32:54AM +0000, Ævar Arnfjörð Bjarmason wrote:

> Change the tag, branch & for-each-ref commands to have a --no-contains
> option in addition to their longstanding --contains options.
> 
> This allows for finding the last-good rollout tag given a known-bad
> <commit>. Given a hypothetically bad commit cf5c7253e0 the git version
> revert to can be found with this hacky two-liner:

s/revert to/to &/, I think.


> With this new --no-contains the same can be achieved with:
> [..]

The goal sounds good to me.

> In addition to those tests, add a test for "tag" which asserts that
> --no-contains won't find tree/blob tags, which is slightly
> unintuitive, but consistent with how --contains works & is documented.

Makes sense. In theory we could dig into commits to find trees and blobs
when the user gives us one. But I kind of doubt anybody really wants it,
and it's expensive to compute. For the simple cases, --points-at already
does the right thing.

[more on that below, though...]

> @@ -604,7 +606,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
>  		list = 1;
>  
> -	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
> +	if (filter.with_commit || filter.no_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
>  		list = 1;

Could we wrap this long conditional?

> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index df41fa0350..a11542c4fd 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -9,7 +9,7 @@ static char const * const for_each_ref_usage[] = {
>  	N_("git for-each-ref [<options>] [<pattern>]"),
>  	N_("git for-each-ref [--points-at <object>]"),
>  	N_("git for-each-ref [(--merged | --no-merged) [<object>]]"),
> -	N_("git for-each-ref [--contains [<object>]]"),
> +	N_("git for-each-ref [(--contains | --no-contains) [<object>]]"),
>  	NULL

I'm not sure if this presentation implies that the two cannot be used
together. It copies "--merged/--no-merged", but I think those two
_can't_ be used together (it probably wouldn't be hard to make it work,
but if nobody cares it may not be worth spending time on).

I also wonder if we need to explicitly document that --contains and
--no-contains can be used together and don't cancel each other. The
other option is to pick a new name ("--omits" is the most concise one I
could think of; maybe that is preferable anyway because it avoids
negation).

> @@ -457,7 +459,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	if (!cmdmode && !create_tag_object) {
>  		if (argc == 0)
>  			cmdmode = 'l';
> -		else if (filter.with_commit || filter.points_at.nr || filter.merge_commit || filter.lines != -1)
> +		else if (filter.with_commit || filter.no_commit || filter.points_at.nr || filter.merge_commit || filter.lines != -1)

Ditto here on the wrapping. There were a few other long lines, but I
won't point them all out.

> -		/* We perform the filtering for the '--contains' option */
> +		/* We perform the filtering for the '--contains' option... */
>  		if (filter->with_commit &&
> -		    !commit_contains(filter, commit, &ref_cbdata->contains_cache))
> +		    !commit_contains(filter, commit, filter->with_commit, &ref_cbdata->contains_cache))
> +			return 0;
> +		/* ...or for the `--no-contains' option */
> +		if (filter->no_commit &&
> +		    commit_contains(filter, commit, filter->no_commit, &ref_cbdata->no_contains_cache))
>  			return 0;

This looks nice and simple. Good.

> +# As the docs say, list tags which contain a specified *commit*. We
> +# don't recurse down to tags for trees or blobs pointed to by *those*
> +# commits.
> +test_expect_success 'Does --[no-]contains stop at commits? Yes!' '
> +	cd no-contains &&
> +	blob=$(git rev-parse v0.3:v0.3.t) &&
> +	tree=$(git rev-parse v0.3^{tree}) &&
> +	git tag tag-blob $blob &&
> +	git tag tag-tree $tree &&
> +	git tag --contains v0.3 >actual &&
> +	cat >expected <<-\EOF &&
> +	v0.3
> +	v0.4
> +	v0.5
> +	EOF
> +	test_cmp expected actual &&
> +	git tag --no-contains v0.3 >actual &&
> +	cat >expected <<-\EOF &&
> +	v0.1
> +	v0.2
> +	EOF
> +	test_cmp expected actual
> +'

The tests mostly look fine, but this one puzzled me. I guess we're
checking that tag-blob does not contain v0.3. But how could it?

The more interesting test to me is:

  git tag --contains $blob

which should barf on a non-commit.

For the --no-contains side, you could argue that the blob-tag doesn't
contain the commit, and it should be listed. But it looks like we just
drop all non-commit tags completely as soon as we start to do a
contains/not-contains traversal.

I think the more relevant comparison is "--no-merged", and it behaves
the same way as your new --no-contains. I don't think I saw this
subtlety in the documentation, though. It might be worth mentioning
(unless I just missed it).

-Peff
