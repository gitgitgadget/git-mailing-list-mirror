From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] google code http auth weirdness
Date: Sat, 16 Mar 2013 23:00:23 -0400
Message-ID: <20130317030023.GA12937@sigill.intra.peff.net>
References: <20130315115947.GA30675@sigill.intra.peff.net>
 <CAJo=hJt5P4616VLGcjdGFQ0YA_+gT+o1Vw3zWSbafDT6Cu6M2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 17 04:01:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH3qJ-0001FM-Cv
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 04:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab3CQDA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 23:00:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53939 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934Ab3CQDA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 23:00:26 -0400
Received: (qmail 5950 invoked by uid 107); 17 Mar 2013 03:02:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Mar 2013 23:02:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Mar 2013 23:00:23 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJt5P4616VLGcjdGFQ0YA_+gT+o1Vw3zWSbafDT6Cu6M2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218323>

On Sat, Mar 16, 2013 at 06:11:32PM -0700, Shawn O. Pearce wrote:

> > That seems kind of crazy to me. It's generating an HTTP 200 just to tell
> > us the credentials are wrong. Which kind of makes sense; it's the only
> > way to convince the git client to show a custom message when it aborts
> > (rather than producing its own client-side "authorization failed"
> > message).
> 
> Actually the reason here wasn't to use a custom message. It was to
> avoid the client from entering into the old /info/refs fallback path
> that existed between 703e6e76 (Git 1.6.6.2) and 6ac964a62 (Git
> 1.7.12.3). During these versions non-200 responses from the smart
> request usually led to a useless error in the client. I suggested to
> the Google Code team when they implemented Git support to use a 200
> response with the ERR header to give the end-user something easier to
> understand than what the Git client have otherwise printed.

OK, that makes sense. I do wonder, though, if the loss of the custom
message will be bad for Google Code. The current message is:

  fatal: remote error: Invalid username/password.
  You may need to use your generated googlecode.com password; see
  https://code.google.com/hosting/settings

which is an important clue (this being the first time I had used Google
Code to authenticate, I was quite surprised that the password was
different from the web page's password, and that pointer helped me
figure it out more quickly).

> >   1. Always return a 401 for bad credentials. This means it would lose
> >      the custom message. But I think that is a good indication that the
> >      client should be putting more effort into showing the body of the
> >      401. Probably not all the time, as we do not want to spew HTML at
> >      the user, but we could perhaps relay error bodies if the
> >      content-type is "application/x-git-error" or something.
> >
> >      The downside is that even if we make such a client change and the
> >      the Google Code server change sit's behavior, people on older git
> >      clients will lose the benefit of the message.
> 
> I don't think this is the way to handle errors in the protocol. I
> prefer the existing approach of sending a 200 OK with the ERR header
> to indicate the message to show to the client. It works since 1.6.6
> when smart HTTP was introduced, and it has a very specific meaning.
> The 200 is stating the transport worked, and the ERR is stating the
> Git operation did not. :-)

Sorry, I should have been more clear. I mean only to use it for
transport errors, not git errors. So we should not in general be
converting 200 responses into something else (with the exception of the
401, because it does have a transport meaning). But when we _do_ issue
an unsuccessful HTTP code, we should include a message that can be
relayed to the user.

> Where we have an issue is on a recoverable authentication error.
> Recoverable authentication errors should use 401 so the client can try
> again. I don't know how older (e.g. 1.6.6) clients behave here with a
> 401 response. I guess I should crack out a 1.6.6 build and test.

Before 42653c0 (Prompt for a username when an HTTP request 401s,
2010-04-01), in v1.7.1.1, I think you just get something like:

  error: 401 Authorization failed
  fatal: HTTP request failed

> I don't work on Google Code, but I have asked the team to consider
> making at least this change.

Thanks for looking into it.

-Peff
