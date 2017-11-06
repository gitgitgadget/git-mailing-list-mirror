Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E922120450
	for <e@80x24.org>; Mon,  6 Nov 2017 16:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932603AbdKFQNS (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 11:13:18 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:55031 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932588AbdKFQNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 11:13:16 -0500
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Mon, 06 Nov 2017 17:13:15 +0100
  id 0000000000000043.000000005A008A1B.000055C8
Date:   Mon, 6 Nov 2017 17:13:15 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: Improved error handling (Was: [PATCH 1/2] sequencer: factor out
 rewrite_file())
Message-ID: <20171106161315.dmftp6ktk6bu7cah@ruderich.org>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
 <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
 <20171103103248.4p45r4klojk5cf2g@ruderich.org>
 <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com>
 <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net>
 <20171104183643.akaazwswysphzuoq@ruderich.org>
 <20171105020700.2p4nguemzdrwiila@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20171105020700.2p4nguemzdrwiila@sigill.intra.peff.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 04, 2017 at 10:07:00PM -0400, Jeff King wrote:
> Yes, I think what you've written here (and below) is quite close to the
> error_context patches I linked elsewhere in the thread. In other
> words, I think it's a sane approach.

In contrast to error_context I'd like to keep all exiting
behavior (die, ignore, etc.) in the hand of the caller and not
use any callbacks as that makes the control flow much harder to
follow.

> I agree it might be nice for the error context to have a positive "there
> was an error" flag. It's probably worth making it redundant with the
> return code, though, so callers can use whichever style is most
> convenient for them.

Agreed.

Regarding the API, should it be allowed to pass NULL as error
pointer to request no additional error handling or should the
error functions panic on NULL? Allowing NULL makes partial
conversions possible (e.g. for write_in_full) where old callers
just pass NULL and check the return values and converted callers
can use the error struct.

How should translations get handled? Appending ": %s" for
strerror(errno) might be problematic. Same goes for "outer
message: inner message" where the helper function just inserts ":
" between the messages. Is _("%s: %s") (with appropriate
translator comments) enough to handle these cases?

Suggestions how to name the struct and the corresponding
functions? My initial idea was struct error and to use error_ as
prefix, but I'm not sure if struct error is too broad and may
introduce conflicts with system headers. Also error_ is a little
long and could be shorted to just err_ but I don't know if that's
clear enough. The error_ prefix doesn't conflict with many git
functions, but there are some in usage.c (error_errno, error,
error_routine).

And as general question, is this approach to error handling
something we should pursue or are there objections? If there's
consensus that this might be a good idea I'll look into
converting some parts of the git code (maybe refs.c) to see how
it pans out.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
