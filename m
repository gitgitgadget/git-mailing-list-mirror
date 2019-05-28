Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90371F462
	for <e@80x24.org>; Tue, 28 May 2019 18:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfE1SsH (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 14:48:07 -0400
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:49386 "EHLO
        resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727297AbfE1SsH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 May 2019 14:48:07 -0400
Received: from resomta-po-04v.sys.comcast.net ([96.114.154.228])
        by resqmta-po-12v.sys.comcast.net with ESMTP
        id Vep9hHLtZvWpbVh8ohgVMa; Tue, 28 May 2019 18:48:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559069286;
        bh=tUH2J0geEyEvDdpdUfxyYZVfHzBLYfFo+Ap9NgXOBvg=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=15Y9msCKW0UxYwz1MB6AOdQS8TDWcdXvZeE72f3ctmUDYmdSkYevFqoEwTqA4JY2I
         1VbOYEI8EBfnl2QRa+G9F1jZIvBQn69cgadIIhgx8oPGjLNEpRZqf8enHfqOkoTS7/
         NMAPDMHsNRnTq/Z9/gb4zdu6b2HQlM2XB0FiueJnoBu/OBElZOBzLe8ogvx3hXn8R7
         1X6/oaYKTxAKyLBCrQoxbGpHdNc913hCs43VyTU4SIq4xMB+md/4ZSOVHOVJBFYaP6
         Tzk7WB/hBk0irGyCBlaCSVtwrQqRbJyky/dkiemcpPMkHGZzO1ddrHINh4tbeM7FOM
         SFaQ80SIks4Iw==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:b43f:cfdf:8f71:b59d])
        by resomta-po-04v.sys.comcast.net with ESMTPSA
        id Vh8jhiwElC2yaVh8ohpE3s; Tue, 28 May 2019 18:48:06 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Tue, 28 May 2019 11:48:01 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 1/5] list-objects-filter: refactor into a context
 struct
Message-ID: <20190528184801.GA4556@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <341bc55d4a3f5438b1523525cf683f96d75e8c3e.1558484115.git.matvore@google.com>
 <20190524004938.GB46998@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524004938.GB46998@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 05:49:38PM -0700, Emily Shaffer wrote:
> This commit message might read more easily on its own if you define
> "this bundle of data" at least once. Since there are things being moved
> from both list-objects-filter.c (filter_blobs_none_data) and
> list-objects-filter.h (list_objects_filter_result and filter_free_fn)
> into the new struct in list-objects-filter.h, it's not immediately clear
> to me from the diff what's going on.
> 

I will take care to define the context struct in the commit message and the
code comments.

I was originally intending to put this in the context struct: data common to all
filter types used when executing a filter. But now I'm leaning toward just
using the struct as a grab-bag for execution data for *all* filter types. This
would be more similar to how the list_objects_filter_options struct works, and
it would save having to define a special free_fn for each (actually, most)
filter types. I'll play around with this idea and probably put it in the next
roll-up (comments welcome, though).

> > -static void *filter_blobs_none__init(
> > -	struct oidset *omitted,
> > +static void filter_blobs_none__init(
> >  	struct list_objects_filter_options *filter_options,
> > -	filter_object_fn *filter_fn,
> > -	filter_free_fn *filter_free_fn)
> > +	struct filter_context *ctx)
> >  {
> > -	struct filter_blobs_none_data *d = xcalloc(1, sizeof(*d));
> > -	d->omits = omitted;
> > -
> > -	*filter_fn = filter_blobs_none;
> > -	*filter_free_fn = free;
> > -	return d;
> > +	ctx->filter_fn = filter_blobs_none;
> 
> I think you want to set ctx->free_fn here too, right? It seems like
> you're not setting ctx->omitted anymore because you'd be reading that
> information in from ctx->omitted (so it's redundant).
> 

Not necessary because the blobs:none filter type doesn't have filter-specific
data for it. blobs:none is unique in that regard.
