Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F99B1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 05:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfBVFEK (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 00:04:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:53772 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725854AbfBVFEK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 00:04:10 -0500
Received: (qmail 28647 invoked by uid 109); 22 Feb 2019 05:04:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 05:04:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19168 invoked by uid 111); 22 Feb 2019 05:04:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 00:04:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 00:04:06 -0500
Date:   Fri, 22 Feb 2019 00:04:06 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] http: use --stdin and --keep when downloading pack
Message-ID: <20190222050406.GA6050@sigill.intra.peff.net>
References: <20190221140809.GA21759@sigill.intra.peff.net>
 <20190221184948.100083-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190221184948.100083-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 10:49:48AM -0800, Jonathan Tan wrote:

> > > -	if (finalize_object_file(preq->tmpfile.buf, sha1_pack_name(p->sha1))
> > > -	 || finalize_object_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
> > > -		free(tmp_idx);
> > > -		return -1;
> > > +	if (finish_command(&ip)) {
> > > +		ret = -1;
> > > +		goto cleanup;
> > >  	}
> > 
> > If the command fails but we got something in *lockfile, should we clean
> > it up? Likewise, do we need to be installing a signal handler to clean
> > it up in case we die in other code paths (or by a signal)?
> 
> My inclination is not to do it - as far as I can tell, we don't have
> cleanup or signal handlers in fetch-pack.c either.

Hmm, yeah, you're right. Nor do we do it on fetch. At first I was
surprised that this doesn't cause more problems (we'd leave it in place
after seeing a pre-receive hook fail, for instance), but in practice it
gets cleaned up along with the rest of the quarantine area.

There's still a window where we may leave it around, though (and we
don't quarantine fetches at all), so it might be worth addressing at
some point. But I agree it is totally out of scope for this patch.

-Peff
