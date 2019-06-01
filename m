Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838D11F462
	for <e@80x24.org>; Sat,  1 Jun 2019 00:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFAALa (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 20:11:30 -0400
Received: from resqmta-po-03v.sys.comcast.net ([96.114.154.162]:43898 "EHLO
        resqmta-po-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbfFAAL3 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 May 2019 20:11:29 -0400
Received: from resomta-po-20v.sys.comcast.net ([96.114.154.244])
        by resqmta-po-03v.sys.comcast.net with ESMTP
        id WrX7hqUV7pf2NWrcPhbo2q; Sat, 01 Jun 2019 00:11:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559347889;
        bh=upxyLFj42IZn6fKkNGuBG7fotJ/Y9t+9CSMrF2roxWs=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=vo8k30+M18Cl6BzOwO8RFyvj8+ojtuH9hokfNudyfegFt8dXzXcwnJjjkD3p9WLRB
         Hitgitny8ny1S08PCzce13BSo1qwW28KWq7yeeF83rszJd+yhdgL+3T1cQm3Xm0uWd
         TS1Myui4Kr+IgxBm0fZL6ku1g5qCVBAi6Ij3iTRTfn9RJq5cfKypwB8RIMrPyvzmcx
         SKSUVNQA3ce+CS287v8ASbIg0rXFTvpPUVc8IxBJUmz76/k/VT+vhsEK2l8PcicltT
         PVUfHGnBr88pcGTa1b1xFPYoxEwSsdQdCXqK3EnkMKihd/XRkDUPfzupBXhAgNSVjq
         mkGyfgm7dbXRA==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:a4f1:9a8c:7e29:36eb])
        by resomta-po-20v.sys.comcast.net with ESMTPSA
        id WrcMh3pWsSHF0WrcNhvZDc; Sat, 01 Jun 2019 00:11:28 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Fri, 31 May 2019 17:11:26 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190601001126.GE4641@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <2b47d4b1-ea62-d59e-77e0-d95dfad084e0@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b47d4b1-ea62-d59e-77e0-d95dfad084e0@jeffhostetler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 05:01:15PM -0400, Jeff Hostetler wrote:
> We are allowing an unlimited number of filters in the composition.
> In the code, the compose filter data has space for a LHS and RHS, so
> I'm assuming we're mapping
> 
>     --filter=f1 --filter=f2 --filter=f3 --filter=f4
> or  --filter=combine:f1+f2+f3+f4
> into basically
>     (compose f1 (compose f2 (compose (f3 f4)))
> 
> I wonder if it would be easier to understand if we just built an array
> or linked list, but I'll read on.

As I mentioned in earlier messages, I have changed this to use an array. It's
nicer now.

(nit: the filters were left-associative rather than right-associative)

> Should we swap the order of the terms in the || so that we always
> clear the d->sub[i].is_skipping_tree on LOFS_END_TREE ?
> 

Done, and added a comment:

	/*
	 * Check should_delegate before oidset_contains so that
	 * is_skipping_tree gets unset even when the object is marked as seen.
	 * As of this writing, no filter uses LOFR_MARK_SEEN on trees that also
	 * uses LOFR_SKIP_TREE, so the ordering is only theoretically
	 * important. Be cautious if you change the order of the below checks
	 * and more filters have been added!
	 */

> 
> > +			result[i] = LOFR_ZERO;
> > +			continue;
> > +		}
> > +
> > +		result[i] = d->sub[i].ctx.filter_fn(
> > +			r, filter_situation, obj, pathname, filename,
> > +			&d->sub[i].ctx);
> > +
> > +		if (result[i] & LOFR_MARK_SEEN)
> > +			oidset_insert(&d->sub[i].seen, &obj->oid);
> 
> So filter[i] has said it never wants to show this object (hard omit).
> And the guard at the top of the loop will prevent future invocations
> from checking it again if the object is revisited.
> 

Yes.

> > +
> > +		if (result[i] & LOFR_SKIP_TREE) {
> > +			d->sub[i].is_skipping_tree = 1;
> > +			d->sub[i].skip_tree = obj->oid;
> 
> So this marks the tree object at the top of the skip as far as
> filter[i] is concerned.
> 

Yes.

> > +		}
> > +	}
> > +
> > +	if ((result[0] & LOFR_DO_SHOW) && (result[1] & LOFR_DO_SHOW))
> > +		combined_result |= LOFR_DO_SHOW;
> > +	if (d->sub[0].is_skipping_tree && d->sub[1].is_skipping_tree)
> > +		combined_result |= LOFR_SKIP_TREE;
> 
> Something about the above bothers me, but I can't quite say what
> it is.
> 

It looks nicer now that it's array-based. Let me know what you think after I
send the next roll-up.

> Do we need to do:
>     if ((result[0] & LOFR_MARK_SEEN) && (result[1] & LOFR_MARK_SEEN))
>         combined_result |= LOFR_MARK_SEEN;

This should be a O(1) sort of optimization, since if we don't set it, the top
filter will still be called, but won't delegate to any sub-filters. It doesn't
complicate the code much, so it seems worth it to add. Done.

> I'm out of time now, will pick this up again next week.

Thank you for taking a look and for your patience so far.
