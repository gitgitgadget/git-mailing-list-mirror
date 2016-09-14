Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60391FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 16:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764267AbcINQDQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 12:03:16 -0400
Received: from ikke.info ([178.21.113.177]:44104 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764248AbcINQDP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 12:03:15 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 1647C4400B9; Wed, 14 Sep 2016 18:03:08 +0200 (CEST)
Date:   Wed, 14 Sep 2016 18:03:08 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
Message-ID: <20160914160308.GB26893@ikke.info>
References: <20160913152622.2xtyn6mki6p6afsg@sigill.intra.peff.net>
 <20160913234612.22806-1-me@ikke.info>
 <20160913234612.22806-2-me@ikke.info>
 <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
 <20160914050919.qhv2gxzjyj5ydpub@sigill.intra.peff.net>
 <xmqqmvjbrpp4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmvjbrpp4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 10:54:47PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > It has been a while since I looked at rfc2822, but aren't the quoting
> > and syntax rules different for addresses versus other headers? We would
> > not want to dequote a Subject header, I think.
> 
> You're absolutely right.  RFC2822 does not quite _want_ to dequote
> anything.  As you pointed out in a separate message, we are the one
> who want to strip out "" quoting when mailinfo says
> 
> 	Author: "Jeff King"
> 
> to its standard output (aka "info"), and turn it into
> 
> 	GIT_AUTHOR_NAME='Jeff King'
> 
> and do so ONLY for the author name.
> 
> So I would think it is the responsibility of the one that reads the
> "info" file that is produced by mailinfo to dequote the backslash
> thing if the mailinfo gave us
> 
> 	Author: "Jeff \"Peff\" King"
> 

The RFC makes a distinction between structured fields and unstructured
fields. Quoting would not even be necessary for unstructured fields
(like Subject), so yes, that those fields should be left alone.

Unstructures fields are subject, comments, keywords and optional fields,
the rest is considered structured.

Because the only field where this is a problem is the From field, I
think it would be safe to limit the unquoting just to that field.

My reasoning to do the unquoting here is because it's the RFC requires
the quoting in the first place.

I already noticed a bug in the current unquoting of the author when
adding a comment to the From: field.

    From: "A U Thor" <au@thor.com> (test)

When applied the the author of this patch shows up as:

    Author: A U Thor" (test) <au@thor.com>

So I agree with Jeff[1] where he states that the surrounding quotes
should be removed, if that's not a problem for git.

[1]:https://public-inbox.org/git/20160914051305.vphknpsikyxi3hg3@sigill.intra.peff.net/
