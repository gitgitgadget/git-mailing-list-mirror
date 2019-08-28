Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42A511F461
	for <e@80x24.org>; Wed, 28 Aug 2019 23:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfH1XfQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 19:35:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:60522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726828AbfH1XfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 19:35:16 -0400
Received: (qmail 26435 invoked by uid 109); 28 Aug 2019 23:35:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Aug 2019 23:35:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16693 invoked by uid 111); 28 Aug 2019 23:36:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2019 19:36:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Aug 2019 19:35:15 -0400
From:   Jeff King <peff@peff.net>
To:     Jon Simons <jon@jonsimons.org>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH 1/2] list-objects-filter: only parse sparse OID when
 'have_git_dir'
Message-ID: <20190828233514.GA25355@sigill.intra.peff.net>
References: <20190828201824.1255-1-jon@jonsimons.org>
 <20190828201824.1255-2-jon@jonsimons.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828201824.1255-2-jon@jonsimons.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 04:18:23PM -0400, Jon Simons wrote:

> Fix a bug in partial cloning with sparse filters by ensuring to check
> for 'have_git_dir' before attempting to resolve the sparse filter OID.
> 
> Otherwise the client will trigger:
> 
>     BUG: refs.c:1851: attempting to get main_ref_store outside of repository
> 
> when attempting to git clone with a sparse filter.
> 
> Note that this fix is the minimal one which avoids the BUG and allows
> for the clone to complete successfully:
> 
> There is an open question as to whether there should be any attempt
> to resolve the OID provided by the client in this context, as a filter
> for the clone to be used on the remote side.  For cases where local
> and remote OID resolutions differ, resolving on the client side could
> be considered a bug.  For now, the minimal approach here is used to
> unblock further testing for partial clones with sparse filters, while
> a more invasive fix could make sense to pursue as a future direction.

Just to provide a little more of our findings to the list: I think the
main thing going on here is that the filter options-parsing code is
shared on the client and server side (and doesn't have any idea which it
is). That's why we see the "do not complain" comment in the context
below:

> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -71,7 +71,8 @@ static int gently_parse_list_objects_filter(
>  		 * command, but DO NOT complain if we don't have the blob or
>  		 * ref locally.
>  		 */
> -		if (!get_oid_with_context(the_repository, v0, GET_OID_BLOB,
> +		if (have_git_dir() &&
> +		    !get_oid_with_context(the_repository, v0, GET_OID_BLOB,
>  					  &sparse_oid, &oc))

and why it's OK to just quietly ignore this case. I don't think it's
hurting anything in practice. Whether we resolve the name or not, we
send the _original_ name to the other side (it would be a bug for us to
resolve it ourselves and send the oid).

> +test_expect_success 'partial clone with sparse filter succeeds' '
> +	git clone --no-local --no-checkout --filter=sparse:oid=master:all-files "file://$(pwd)/sparse-src" pc-all &&
> +	git clone --no-local --no-checkout --filter=sparse:oid=master:even-files "file://$(pwd)/sparse-src" pc-even &&
> +	git clone --no-local --no-checkout --filter=sparse:oid=master:odd-files "file://$(pwd)/sparse-src" pc-odd
> +'

Since you're using "--no-local", you should be able to just say
"sparse-src" without the full path or file URL.

I think Eric's style suggestions elsewhere in the thread were sensible,
too. And of course the code change itself looks good.

-Peff
