Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267511F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbcG2AQX (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:16:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:50681 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752529AbcG2AQW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:16:22 -0400
Received: (qmail 12346 invoked by uid 102); 29 Jul 2016 00:16:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 20:16:22 -0400
Received: (qmail 29857 invoked by uid 107); 29 Jul 2016 00:16:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 20:16:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jul 2016 20:16:19 -0400
Date:	Thu, 28 Jul 2016 20:16:19 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160729001618.GA9646@sigill.intra.peff.net>
References: <20160728211149.GA371@x>
 <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
 <20160728215603.GA22865@sigill.intra.peff.net>
 <xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 03:14:48PM -0700, Junio C Hamano wrote:

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

I cannot speak for everybody, of course, but the reason I implemented
"--from" is because my workflow is basically:

  git format-patch --from --stdout @{u}..HEAD >mbox
  mutt -f mbox

and then I use mutt's "resend" command to send each one. Mutt uses the
"From" header written by format-patch as the default (and so I would
have to manually move the headers around if not for "--from").

The commands above are wrapped in a script, so I have no problem
remembering to type "--from", but I can see how it would be irritating
for general use. I would go so far as to say that any time the patches
are going to be mailed, that "--from" is the right thing to do (because
otherwise you are relying on your MUA to avoid impersonating the
original author).

The question in my mind is whether people actually use format-patch for
things besides emailing, and if the final destination is something other
than "git am".  It is a handy format because it is the least-lossy way
to move commits around external to git itself.  That's why "rebase" used
it originally. If the final destination is "am" (as it is for rebase),
then in-body headers are OK, because we know it understands those. If
not, then it's a regression.

I think on the whole that defaulting to "--from" would help more people
than hurt them, but if we do believe there are scripts that would be
regressed, it probably needs a deprecation period.

-Peff
