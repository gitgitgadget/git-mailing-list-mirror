Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96DCF1FAFB
	for <e@80x24.org>; Tue,  4 Apr 2017 02:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbdDDCBh (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 22:01:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:56284 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbdDDCBg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 22:01:36 -0400
Received: (qmail 16344 invoked by uid 109); 4 Apr 2017 02:01:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 02:01:32 +0000
Received: (qmail 3018 invoked by uid 111); 4 Apr 2017 02:01:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Apr 2017 22:01:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Apr 2017 22:01:30 -0400
Date:   Mon, 3 Apr 2017 22:01:30 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3] http.postbuffer: allow full range of ssize_t values
Message-ID: <20170404020130.76thbl5rum2gxgtn@sigill.intra.peff.net>
References: <20170331172631.12024-1-dturner@twosigma.com>
 <20170401060116.b2v7tyoi7fcxwbvo@sigill.intra.peff.net>
 <34d444b673c64310baa275f821037b3e@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34d444b673c64310baa275f821037b3e@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 03, 2017 at 05:03:49PM +0000, David Turner wrote:

> > > Unfortunately, in order to push some large repos, the http postbuffer
> > > must sometimes exceed two gigabytes.  On a 64-bit system, this is OK:
> > > we just malloc a larger buffer.
> > 
> > I'm still not sure why a 2GB post-buffer is necessary. It sounds like something
> > is broken in your setup. Large pushes should be sent chunked.
> > 
> > I know broken setups are a fact of life, but this feels like a really hacky work-
> > around.
> 
> I'm not sure what other workaround I should use.  I guess I could do
> multiple pushes, but only if individual objects are under the size
> limit, and I'm not sure all of mine are (maybe I'll get lucky tho).  I
> know that this is a configuration issue with gitlab:
> https://gitlab.com/gitlab-org/gitlab-ce/issues/30315 but I don't know
> when that will get fixed.  I could manually copy the repo to the
> server and do a local push, but I don't know that I have the necessary
> permissions to do that. Or I could do this, which would hopefully
> actually solve the problem.

I didn't think we had gotten details on what was actually broken. Is it
really that GitLab does not support chunked transfers? I know that's
what the issue above says, but it sounds like it is just assuming that
is the problem based on the recent messages to the list.

If that's really the issue, then OK. That's lame, but something the
client has to work around. It seems like a pretty big gap, though (and
one I'd think people would have hit before; the default post-buffer is
only 1MB. Surely people routinely push more than that to GitLab servers?
So I'm really wondering if there is something else going on here.

What does it look like when it fails? What does GIT_TRACE_CURL look like
(or GIT_CURL_VERBOSE if your client is older, but remember to sanitize
any auth lines)?

> > The ultimate fate of this number, though, is to be handed to:
> > 
> >   curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, rpc->len);
> > 
> > where the final argument is interpreted as a long. So I suspect that on 64-bit
> > Windows, setting http.postbuffer to "3G" would cause some kind of weird
> > error (either a truncated post or some internal curl error due to the negative
> > size, depending on how curl handles it).
> 
> Ah, so we would need to use CURLOPT_POSTFIELDSIZE_LARGE.  Will re-roll.

Ah, neat. I didn't even know about CURLOPT_POSTFIELDSIZE_LARGE, and
thought we'd have to just limit 32-bit platforms. That's a much better
solution.

> > I saw the earlier iteration used a size_t, but you switched it after the compiler
> > (rightfully) complained about the signedness. But I'm not sure why we would
> > want ssize_t here instead of just using git_parse_unsigned().
> 
> It was originally signed.  I'm not sure why that was, but I figured it
> would be simpler to save the extra bit just in case.

I think it was simply because git_config_int() is the generic "number"
parser, and nobody ever thought about it.

In fact, passing a negative value to curl would be disastrous, as it
would use strlen(). I don't think a negative value could ever get that
far, though. It looks like the config code would silently turn a
negative value into LARGE_PACKET_MAX.

IMHO, complaining about the negative number to the user would be an
improvement.

-Peff
