Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68E51F858
	for <e@80x24.org>; Thu, 28 Jul 2016 23:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbcG1Xx1 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 19:53:27 -0400
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:57321 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbcG1XxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 19:53:25 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 185A347A2C3
	for <git@vger.kernel.org>; Fri, 29 Jul 2016 01:53:24 +0200 (CEST)
Received: from mfilter28-d.gandi.net (mfilter28-d.gandi.net [217.70.178.159])
	by relay2-d.mail.gandi.net (Postfix) with ESMTP id 2AB70C5A51;
	Fri, 29 Jul 2016 01:53:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter28-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter28-d.gandi.net (mfilter28-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id zDsgojaI4WQA; Fri, 29 Jul 2016 01:53:20 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 632F4C5A43;
	Fri, 29 Jul 2016 01:53:18 +0200 (CEST)
Date:	Thu, 28 Jul 2016 16:53:16 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160728235316.GB3676@x>
References: <20160728211149.GA371@x>
 <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
 <20160728215603.GA22865@sigill.intra.peff.net>
 <xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 03:14:48PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> > I think the original reason I did not make "--from" the default is that
> > I was worried about breaking consumers which do not know how to handle
> > in-body headers.
> 
> That's a fair concern.
> 
> So going back to Josh's original problem description:
> 
>     While git-send-email knows how to change the patch mails to use your own
>     address as "From:" and add a "From:" line to the body for the author,
>     any other tool used to send emails doesn't do that.
> 
> I wonder how these "any other tool" (that reads the format-patch
> output, i.e. mbox file with one mail per file each, and sends each
> as a piece of e-mail, without paying attention who you, the tool's
> user, are and blindly send them with the original "From:" and other
> headers intact in the header part of the message) are used in the
> wild to send patch submissions.  /usr/bin/mail or /usr/bin/Mail
> would not be among them, as I suspect they would place everything in
> the body part, and the would do so without stripping the "From "
> line that exists before each e-mail message.

mutt -H would be one example; I regularly use that to send mails.
(It'll override "From:" if it doesn't know the address in it, which
loses the author information entirely; it'll work fine with the --from
format.) git-imap-send would be another example; its behavior would vary
by mail client.  Both of those should always work fine with a mail
produced via --from; they'll just ignore the in-body "From:" and send
the mail.  They'd tend to do the wrong thing with a mail produced
without using --from though.

I don't know what people who end up sending From-spoofed mails to LKML
are using, but I've seen such mails regularly.  I also get occasional
blowback from someone who sent such mails including patches I authored
with my address spoofed as "From:".  And I've also seen someone flamed
for sending patches to a mailing list for review with spoofed "From:"
addresses.

I can think of aesthetic reasons to want the non-"--from" format (for
instance, sticking patch files into a non-git-based tool like quilt or a
distribution packaging system, and not wanting your own email address
included), but I can't think of any tool that would produce incorrect
results if handed the --from format.  That seems like an argument for
switching the default, and adding a --from-author option or similar to
get the current output.
