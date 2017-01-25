Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B6A31F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 20:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbdAYUFZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 15:05:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:44719 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751374AbdAYUFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 15:05:25 -0500
Received: (qmail 31061 invoked by uid 109); 25 Jan 2017 20:05:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 20:05:25 +0000
Received: (qmail 15372 invoked by uid 111); 25 Jan 2017 20:05:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 15:05:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 15:05:23 -0500
Date:   Wed, 25 Jan 2017 15:05:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 12/12] receive-pack: avoid duplicates between our refs
 and alternates
Message-ID: <20170125200522.a7lh5d5tav3zcf2o@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
 <20170124004818.7resjwbe6ldqjfyx@sigill.intra.peff.net>
 <xmqq60l2c3hl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60l2c3hl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 12:02:30PM -0800, Junio C Hamano wrote:

> > +extract_ref_advertisement () {
> > +	perl -lne '
> > +		# \\ is there to skip capabilities after \0
> > +		/push< ([^\\]+)/ or next;
> > +		exit 0 if $1 eq "0000";
> > +		print $1;
> > +	'
> 
> Parsing TRACE_PACKET output?  Yuck.  But I think this has to do, as
> any other solution will bound to be uglier.

Agreed. My initial attempt was to just run "git receive-pack </dev/null"
and parse the advertisement. But then you have to parse pktlines. :)

> > +	# Notable things in this expectation:
> > +	#  - local refs are not de-duped
> > +	#  - .have does not duplicate locals
> > +	#  - .have does not duplicate itself
> > +	local=$(git -C fork rev-parse HEAD) &&
> > +	shared=$(git -C shared rev-parse only-shared) &&
> > +	cat >expect <<-EOF &&
> > +	$local refs/heads/master
> > +	$local refs/remotes/origin/HEAD
> > +	$local refs/remotes/origin/master
> > +	$shared .have
> > +	EOF
> 
> We may want to sort this thing and the extracted one when comparing;
> the order of the entries is not part of the feature we cast in stone.

True (and in fact the .have moved in the previous patch). I wondered,
though, if it might not be a reasonable thing for somebody to have to
look at the output and verify it when the order _does_ change.

I dunno.

-Peff
