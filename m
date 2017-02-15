Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0A082013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbdBPAAT (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:00:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:56078 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753311AbdBOXSf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:18:35 -0500
Received: (qmail 30581 invoked by uid 109); 15 Feb 2017 23:18:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 23:18:35 +0000
Received: (qmail 18917 invoked by uid 111); 15 Feb 2017 23:18:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 18:18:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2017 18:18:33 -0500
Date:   Wed, 15 Feb 2017 18:18:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: Confusing git messages when disk is full.
Message-ID: <20170215231832.bzg3ygz4ualcvqlc@sigill.intra.peff.net>
References: <CABpqov=FE-h_2s=O9fkSjFjgFXSy6hDwc2fu5ijiVvkaLx9f_Q@mail.gmail.com>
 <20170215213221.lnraiktneokpk3mg@sigill.intra.peff.net>
 <xmqqk28r2kk4.fsf@gitster.mtv.corp.google.com>
 <20170215215151.a5chtxyjhbe3og4p@sigill.intra.peff.net>
 <xmqq7f4r2io5.fsf@gitster.mtv.corp.google.com>
 <20170215223246.mkaz22yrovnscnne@sigill.intra.peff.net>
 <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 02:50:19PM -0800, Junio C Hamano wrote:

> > That works, but the fact that we need a comment is a good sign that it's
> > kind of gross. It's too bad stdio does not specify the return of fclose
> > to report an error in the close _or_ any previous error. I guess we
> > could wrap it with our own function.
> 
> Sure.  I am happy to add something like this:
> 
> 	/*
> 	 * closes a FILE *, returns 0 if closing and all the
> 	 * previous stdio operations on fp were successful,
> 	 * otherwise non-zero.
> 	 */
> 	int xfclose(FILE *fp)
> 	{
> 		return ferror(fp) | fclose(fp);
> 	}

Yes, that's exactly what I had in mind (might be worth calling out the
bitwise-OR, though, just to make it clear it's not a typo).

> I do not think we should try to do anything fancier to allow the
> caller to tell ferror() and fclose() apart, as such a caller would
> then need to do

Absolutely. If they care, they can call the two separately.

You are right that errno is untrustworthy in the ferror() case, though.
Maybe that is reason not to add xfclose, and just force this caller to
do something like:

  if (ferror(fp))
	rc = error("unable to write to %s", filename);
  if (fclose(fp))
	rc = error_errno("unable to write to %s", filename);

Of course, if the earlier error persists through fclose, we'd print two
errors. This would all be much easier if the filehandles kept not just
an error bit, but the original errno. <sigh>

Maybe a not-terrible compromise is to fake the errno in the ferror case,
like:

  int xfclose(FILE *fp)
  {
	int error_flag = ferror(fp);

	/*
	 * If we get an error from fclose, the current errno value is
	 * trustworthy. But if it succeeds and we had a previous error,
	 * we need to report failure, but the value of errno could
	 * be unrelated. Make up a generic errno value.
	 */
	if (fclose(fp))
		return EOF;
	} else if (error_flag) {
		errno = EINVAL; /* or EIO? */
		return EOF;
	} else {
		return 0;
	}
  }

Or maybe that would just confuse people when they later get "invalid
argument" in the error message. I wish there was an errno value for "I
don't remember what the error was".

I dunno. This whole thing is ending up a lot more complicated than I had
hoped. I just didn't want to have to say "unable to write to %s" twice. ;)

-Peff
