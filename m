Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9462013A
	for <e@80x24.org>; Wed, 15 Feb 2017 22:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbdBOWct (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 17:32:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:56053 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751313AbdBOWct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 17:32:49 -0500
Received: (qmail 27433 invoked by uid 109); 15 Feb 2017 22:32:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 22:32:48 +0000
Received: (qmail 18548 invoked by uid 111); 15 Feb 2017 22:32:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 17:32:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2017 17:32:46 -0500
Date:   Wed, 15 Feb 2017 17:32:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: Confusing git messages when disk is full.
Message-ID: <20170215223246.mkaz22yrovnscnne@sigill.intra.peff.net>
References: <CABpqov=FE-h_2s=O9fkSjFjgFXSy6hDwc2fu5ijiVvkaLx9f_Q@mail.gmail.com>
 <20170215213221.lnraiktneokpk3mg@sigill.intra.peff.net>
 <xmqqk28r2kk4.fsf@gitster.mtv.corp.google.com>
 <20170215215151.a5chtxyjhbe3og4p@sigill.intra.peff.net>
 <xmqq7f4r2io5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f4r2io5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 02:28:10PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >>   abort:
> >>  	strbuf_release(&note);
> >>  	free(url);
> >> -	fclose(fp);
> >> +	if (ferror(fp))
> >> +		rc = -1;
> >> +	if (fclose(fp))
> >> +		rc = -1;
> >>  	return rc;
> >
> > Yeah, I think this works. Normally you'd want to flush before checking
> > ferror(), but since you detect errors from fclose, too, it should be
> > fine.
> >
> > We probably should write something stderr, though. Maybe:
> >
> >   if (ferror(fp) || fclose(fp))
> > 	rc = error_errno("unable to write to %s", filename);
> 
> Yes, and somehow make sure we do fclose(fp) even when we have an
> error already ;-)

Good catch. I think we use a nasty bitwise-OR elsewhere to do that.
Ah, here it is, in tempfile.c:

                /*
                 * Note: no short-circuiting here; we want to fclose()
                 * in any case!
                 */
                err = ferror(fp) | fclose(fp);

That works, but the fact that we need a comment is a good sign that it's
kind of gross. It's too bad stdio does not specify the return of fclose
to report an error in the close _or_ any previous error. I guess we
could wrap it with our own function.

-Peff
