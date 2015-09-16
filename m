From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 26/67] replace trivial malloc + sprintf /strcpy calls to
 xstrfmt
Date: Wed, 16 Sep 2015 06:43:28 -0400
Message-ID: <20150916104328.GH13966@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915154510.GZ29753@sigill.intra.peff.net>
 <CAPig+cQTGbE4jC2o8zta0HR3ske3y3MoFTd7zBvwMTg6vp3Vag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 12:43:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcABh-00045c-Kk
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 12:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbbIPKnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 06:43:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:59871 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752059AbbIPKnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 06:43:37 -0400
Received: (qmail 17974 invoked by uid 102); 16 Sep 2015 10:43:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 05:43:37 -0500
Received: (qmail 16795 invoked by uid 107); 16 Sep 2015 10:43:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 06:43:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 06:43:28 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQTGbE4jC2o8zta0HR3ske3y3MoFTd7zBvwMTg6vp3Vag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278019>

On Wed, Sep 16, 2015 at 12:24:38AM -0400, Eric Sunshine wrote:

> On Tue, Sep 15, 2015 at 11:45 AM, Jeff King <peff@peff.net> wrote:
> > replace trivial malloc + sprintf /strcpy calls to xstrfmt
> 
> s/to/with/
> 
> Also, do you want either to add a space after '/' or drop the one before it?

Thanks, fixed both.

> > --- a/imap-send.c
> > +++ b/imap-send.c
> > @@ -889,9 +889,8 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
> >         }
> >
> >         /* response: "<user> <digest in hex>" */
> > -       resp_len = strlen(user) + 1 + strlen(hex) + 1;
> > -       response = xmalloc(resp_len);
> > -       sprintf(response, "%s %s", user, hex);
> > +       response = xstrfmt("%s %s", user, hex);
> > +       resp_len = strlen(response);
> >
> >         response_64 = xmalloc(ENCODED_SIZE(resp_len) + 1);
> 
> The original resp_len calculation included the NUL but the revised
> does not. If I'm reading this correctly, the revised calculation is
> correct, and the original was over-allocating response_64, right?

Hrm, I didn't notice that. We actually feed "resp_len" directly to
EVP_EncodeBlock, meaning it it _would_ include the trailing NUL in the
encoded output. So my modification is not wrong memory-wise (we allocate
enough to hold the result), but does produce different output.

I'm not at all convinced that the original is correct, but if we are
going to fix it, it should definitely not be part of this patch. I'll
switch it to:

  resp_len = strlen(response) + 1;

which matches the original.

Thanks for being such a careful reviewer. :)

-Peff
