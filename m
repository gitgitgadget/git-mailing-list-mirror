Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8833920984
	for <e@80x24.org>; Wed, 14 Sep 2016 04:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753762AbcINE6o (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 00:58:44 -0400
Received: from ikke.info ([178.21.113.177]:60162 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbcINE6n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 00:58:43 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 5411C4400B9; Wed, 14 Sep 2016 06:58:41 +0200 (CEST)
Date:   Wed, 14 Sep 2016 06:58:41 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
Message-ID: <20160914045841.GA26893@ikke.info>
Reply-To: me@lists.ikke.info
References: <20160913152622.2xtyn6mki6p6afsg@sigill.intra.peff.net>
 <20160913234612.22806-1-me@ikke.info>
 <20160913234612.22806-2-me@ikke.info>
 <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 05:04:45PM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> 
> It often is easier to read if smaller of the two are in the if part
> and the larger in else part.  Also your switch/case is indented one
> level too deep.  I.e.
> 

Thanks, I've switched the order and fixed indentation.

> 
> I found the variable name "skip" a bit hard to reason about.  What
> it does is to signal the next round of the processing that we have
> seen a single-byte quote and it should keep the byte it will get, no
> matter what its value is.  It is "skipping" the conditional
> processing, but I'd imagine most people would consider it is
> "keeping the byte".

Yes, I agree and was trying to find a better name. I have renamed it to
"take_next_literally", which indicates better what it means.

> 
> > @@ -461,6 +506,7 @@ static int check_header(struct mailinfo *mi,
> >  			 */
> >  			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
> >  			decode_header(mi, &sb);
> > +			unescape_quoted_pair(mi, &sb);
> >  			handle_header(&hdr_data[i], &sb);
> >  			ret = 1;
> >  			goto check_header_out;
> 
> I wonder why this call is only in here, not on other headers that
> all call decode_header().  For that matter, I wonder if the call (or
> the logic of the helper function itself) should go at the end of
> decode_header().  After all, this is different kind of decoding; the
> current one knows how to do b/q encoding but forgot about the more
> traditional quoting done with backslash, and you are teaching the
> code that the current decoding it does is insufficient and how to
> handle the one that the original implementors forgot about.

Makes sense, it should be applied to all headers (I missed the other
decode_header calls).

I will send a new version later.
