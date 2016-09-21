Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBF3820985
	for <e@80x24.org>; Wed, 21 Sep 2016 22:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934211AbcIUWbo (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 18:31:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:46389 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934051AbcIUWbn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 18:31:43 -0400
Received: (qmail 22758 invoked by uid 109); 21 Sep 2016 22:31:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Sep 2016 22:31:43 +0000
Received: (qmail 3973 invoked by uid 111); 21 Sep 2016 22:31:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Sep 2016 18:31:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Sep 2016 18:31:40 -0400
Date:   Wed, 21 Sep 2016 18:31:40 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Yaroslav Halchenko <yoh@onerussian.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/3] http: check curl_multi_remove_handle error code
Message-ID: <20160921223140.qj3354gtrm6km6mg@sigill.intra.peff.net>
References: <20160913002557.10671-1-e@80x24.org>
 <xmqqr38nv8ul.fsf@gitster.mtv.corp.google.com>
 <20160921214623.GA1919@whir>
 <20160921222208.ccgnpgx3gcvbjpfm@sigill.intra.peff.net>
 <20160921222959.GA4781@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160921222959.GA4781@whir>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 10:29:59PM +0000, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
> > On Wed, Sep 21, 2016 at 09:46:23PM +0000, Eric Wong wrote:
> > 
> > > -----------8<-----------
> > > Subject: [PATCH] http: check curl_multi_remove_handle error code
> > > 
> > > This should help detect bugs in future changes.  While we're at
> > > it, fix a (probably innocuous) bug in our http_cleanup function
> > > for users of older curl.
> > > 
> > > curl_multi_remove_handle was not idempotent until curl 7.33.0
> > > with commit 84f3b3dd448399f9548468676e1bd1475dba8de5
> > > ("curl_multi_remove_handle: allow multiple removes"),
> > > so we track the "curlm" membership of the curl easy handle
> > > ourselves with a new "in_multi" flag.
> > 
> > Does curl provide a meaningful error here? I'm just wondering if we
> > could simply let curl handle this, and just ignore the error that comes
> > from older versions. We're basically just replicating curl's own state
> > data here.
> 
> curl before 7.33.0 returned CURLM_BAD_EASY_HANDLE.  This error
> code also happens if we pass a bad/corrupt easy handle;
> so it could be hiding an error on our end.

Hmm, yeah. So we would want to make it conditional on the version
anyway, so that we detected such bugs on more modern systems. That still
doesn't seem unreasonable to me, but your patch is also not very big, so
it's probably fine (the major risk with yours is simply that our state
and curl's state get out of sync).

-Peff
