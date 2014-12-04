From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] prompt: respect GIT_TERMINAL_PROMPT to disable
 terminal prompts
Date: Thu, 4 Dec 2014 16:01:49 -0500
Message-ID: <20141204210149.GB19953@peff.net>
References: <20141204034206.GA1493@peff.net>
 <20141204035228.GB21492@peff.net>
 <xmqqy4qntgs6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 22:01:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwdX9-0002BT-Ri
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 22:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbaLDVBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 16:01:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:48525 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753165AbaLDVBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 16:01:51 -0500
Received: (qmail 20217 invoked by uid 102); 4 Dec 2014 21:01:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 15:01:51 -0600
Received: (qmail 9384 invoked by uid 107); 4 Dec 2014 21:01:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 16:01:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 16:01:49 -0500
Content-Disposition: inline
In-Reply-To: <xmqqy4qntgs6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260800>

On Thu, Dec 04, 2014 at 10:24:09AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/prompt.c b/prompt.c
> > index e5b4938..8181eeb 100644
> > --- a/prompt.c
> > +++ b/prompt.c
> > @@ -57,11 +57,19 @@ char *git_prompt(const char *prompt, int flags)
> >  			r = do_askpass(askpass, prompt);
> >  	}
> >  
> > -	if (!r)
> > -		r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
> >  	if (!r) {
> > -		/* prompts already contain ": " at the end */
> > -		die("could not read %s%s", prompt, strerror(errno));
> > +		const char *err;
> > +
> > +		if (git_env_bool("GIT_TERMINAL_PROMPT", 1)) {
> > +			r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
> > +			err = strerror(errno);
> > +		} else {
> > +			err = "terminal prompts disabled";
> > +		}
> > +		if (!r) {
> > +			/* prompts already contain ": " at the end */
> > +			die("could not read %s%s", prompt, err);
> > +		}
> >  	}
> >  	return r;
> >  }
> 
> I wish this covered a lot more than just this part from an
> end-user's point of view, but this is definitely one of the most
> important code paths the mechanism should cover.

Which parts do you mean? Stuff like "git add -i"?  I agree it might be
nice to turn that off, but it is a little bit of a different beast, in
that it reads from stdin. The git_prompt code is unique in accessing
/dev/tty directly, which makes it hard to shut off.

I don't know of any other code in git that  (and it is used in
many spots due to calls into the credential_fill code).

I suspect there's similar code in git-svn that comes from the svn
library, and it might be nice to cover that, too.

Anyway, I'm happy to give other prompts the same treatment, but I think
we can wait and add them as they are noticed.

-Peff
