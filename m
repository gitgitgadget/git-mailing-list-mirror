Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30DA6206FB
	for <e@80x24.org>; Fri,  8 Jul 2016 22:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbcGHWqI (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 18:46:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:42200 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756032AbcGHWqG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 18:46:06 -0400
Received: (qmail 7494 invoked by uid 102); 8 Jul 2016 22:46:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 18:46:05 -0400
Received: (qmail 16353 invoked by uid 107); 8 Jul 2016 22:46:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 18:46:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 18:46:01 -0400
Date:	Fri, 8 Jul 2016 18:46:01 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
Message-ID: <20160708224601.GA11389@sigill.intra.peff.net>
References: <xmqqh9c1nlvm.fsf@gitster.mtv.corp.google.com>
 <20160708175821.GA29326@google.com>
 <xmqqshvkkm86.fsf@gitster.mtv.corp.google.com>
 <CAGZ79ka8eHOx28Ja+S6DOGEOrV_ijUvi_NnjprhuzQ+3O9BAoQ@mail.gmail.com>
 <20160708214637.GB9820@sigill.intra.peff.net>
 <CAGZ79kZOdcJwd0ePMquhfJTv=xZGP_+w4BRV=GyTy3ejb79yrQ@mail.gmail.com>
 <20160708222127.GA10756@sigill.intra.peff.net>
 <CAGZ79kbu1ec-8LiFrvnXqFqsjFnEofhjZnxcENa1aA1K56m9Fg@mail.gmail.com>
 <20160708223533.GA11056@sigill.intra.peff.net>
 <CAGZ79kbj8tGb9BsTo_CGqOdfsinJrafHAY5HhQEQDCtAXQqKgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbj8tGb9BsTo_CGqOdfsinJrafHAY5HhQEQDCtAXQqKgw@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 03:43:27PM -0700, Stefan Beller wrote:

> On Fri, Jul 8, 2016 at 3:35 PM, Jeff King <peff@peff.net> wrote:
> >
> > Yes. I haven't been following the intermediate discussion and patches,
> > but I don't see anything wrong with the general design above. I think
> > you do need to use rp_error() to get the die message to the client for
> > non-ssh cases, though (that is a problem with other protocol-error
> > messages, too; I wonder if we should install a custom die handler, or
> > convert them all to some kind of rp_die()).
> 
> Some of the rp_error messages do not want to die(), but most seem to
> be ok when the rp_error would die.

Sorry, I meant converting die() into:

  rp_error(...);
  die(...);

possibly via an rp_die() helper.  The existing rp_error() cases would
remain untouched.

Installing a die handler could make that work automatically, though I
suspect it would lead to corner cases where we break protocol (e.g., if
we die() in the middle of writing out a packet).

-Peff
