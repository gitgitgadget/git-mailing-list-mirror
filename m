From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 15:17:58 -0400
Message-ID: <20150630191758.GA6845@peff.net>
References: <20150625165341.GA21949@peff.net>
 <20150625165545.GC23503@peff.net>
 <20150629222247.GA31607@flurp.local>
 <20150630102055.GA11928@peff.net>
 <xmqqr3ot6s9u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 21:18:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA12m-0006jm-ND
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 21:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbbF3TSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 15:18:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:53924 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751534AbbF3TSB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 15:18:01 -0400
Received: (qmail 9195 invoked by uid 102); 30 Jun 2015 19:18:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 14:18:01 -0500
Received: (qmail 18049 invoked by uid 107); 30 Jun 2015 19:18:05 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 15:18:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jun 2015 15:17:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr3ot6s9u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273097>

On Tue, Jun 30, 2015 at 10:05:33AM -0700, Junio C Hamano wrote:

> > I'd guess most cases will fit in 128 bytes and never even hit this code
> > path. You could also get fancier and start the buffer smaller, but only
> > do the fmt hack when we cross a threshold.
> 
> I'd assume that the "hint" thing will persist across calls somehow?
> In an invocation of "git log --date=format:<some format>" for
> millions of commits, it is likely that the length of the formatted
> date string will stay the same or close to the same (yeah, I know
> "Wednesday" would be longer than "Monday").

I hadn't thought about that. It could persist, but I don't think this is
necessarily the right place to do it. For two reasons:

  1. You have no idea in strbuf_addftime if it's the same fmt being
     added over and over. This is the wrong place to make that
     optimization.

  2. If you are interested in efficiency in a loop, then you should be
     reusing the same strbuf over and over, and avoiding the extra
     allocation in the first place. And that is indeed what we do for
     "git log --date", as we will always use the same static-local
     buffer in show_date().

> Answering myself to my earlier question, the reason is because I was
> worried what happens when given fmt is a malformed strftime format
> specifier.  Perhaps it ends with a lone % and "% " may format to
> something unexpected, or something.
> 
> Are we checking an error from strftime(3)?

POSIX doesn't define any errno values for strftime (and in fact says "No
errors are defined"). The return value description for POSIX (and the
glibc manpage) talk about only whether or not the output fits. However,
POSIX does say "If a conversion specifier is not one of the above, the
behavior is undefined".

So certainly I could imagine an implementation that returns "0" when you
feed it a bogus value. If you (as a user) feed us crap to give to
strftime, I am not particularly concerned with whether you get crap out.
My main concern is that it would return "0" and we would loop forever.
OTOH, I think any sane implementation would simply copy unknown
placeholders out (certainly glibc does that). So I think we could simply
consider it a quality of implementation issue, and deal with any
particular crappy implementations if and when they get reported. We
could add something tricky (like "--date=format:%") to the test suite to
make it likelier to catch such a thing.

-Peff
