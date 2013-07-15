From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] config: add support for http.<url>.* settings
Date: Mon, 15 Jul 2013 00:43:38 -0400
Message-ID: <20130715044337.GA21127@sigill.intra.peff.net>
References: <9e7edfbc83a7284615af4ca0de39c1b@f74d39fa044aa309eaea14b9f57fe79>
 <20130712095923.GA4695@sigill.intra.peff.net>
 <F5272E14-188E-4199-9523-D2ED66574D91@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 06:43:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyadU-0007qr-Qf
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 06:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab3GOEnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 00:43:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:35788 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909Ab3GOEnk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 00:43:40 -0400
Received: (qmail 21665 invoked by uid 102); 15 Jul 2013 04:45:00 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Jul 2013 23:45:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jul 2013 00:43:38 -0400
Content-Disposition: inline
In-Reply-To: <F5272E14-188E-4199-9523-D2ED66574D91@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230416>

On Fri, Jul 12, 2013 at 06:07:35AM -0700, Kyle J. McKay wrote:

> >It looks like you're matching the URLs as raw strings, and I don't see
> >any canonicalization going on. What happens if I have
> >"https://example.com/foo+bar" in my config, but then I visit
> >"https://example.comfoo%20bar"?
> 
> The documentation for http.<url>.* says:

Yes, I know. My question was more rhetorical, as in "what _should_
happen". It seems unfriendly not to do at least some basic
canonicalization with respect to encodings.

> >That does make your by-length ordering impossible, but I don't
> >think you
> >can do it in the general case. If I have:
> >
> > [http "http://peff@example.com"] foo = 1
> > [http "http://example.com:8080"] foo = 2
> >
> >and I visit "http://peff@example.com:8080", which one is the winner?
> 
> If I were to spilt everything out, then I would only have the second
> one match.  The first config is on a different port, quite possibly
> an entirely different service.  It shouldn't match.

Yeah, sorry, that was a bad example, because a missing port is not
"do not care", but rather "default port". A better example is:

  [http "http://peff@example.com/"] foo = 1
  [http "http://example.com/path/"] foo = 2

If we see the URL "http://peff@example.com/path/foo", I would expect the
second one to match (it does not under a pure-prefix scheme). If we were
to make it match, you cannot say which of the two entries is "more
specific" they are both specific in different ways.

> I don't think it's necessary to split the URL apart though.  Whatever
> URL the user gave to git on the command line (at some point even if
> it's now stored as a remote setting in config) complete with URL-
> encoding, user names, port names, etc. is the same url, possibly
> shortened, that needs to be used for the http.<url>.option setting.

I'm not sure I agree with this. The URL handed to git is not always
typed directly by the user. E.g., it might be cut-and-paste from an
email or website, or it may even be fed by a script (e.g., the "repo"
tool will pull URLs from its manifest file).

> I think that's simple and very easy to explain and avoids user
> confusion and surprise while still allowing a default to be set for a
> site but easily overridden for a portion of that site without needing
> to worry about the order config files are processed or the order of
> the [http "<url>"] sections within them.

But the user has to worry about last-one-wins anyway for same-length
prefixes, as you noted below.

> >using the usual "last one wins" strategy that our config uses. It has
> >the unfortunate case that:
> >
> > [http "http://example.com"]
> >    foo = 1
> > [http]
> >    foo = 2
> >
> >will always choose http.foo=2, but I don't think that is a big problem
> >in practice.
> 
> I think that violates the principle of least surprise.  In this case:
> 
> [http "https://cacert.org"]
>   sslVerify = false
> [http]
>   sslVerify = true

Sure, I think yours is less surprising in this case. But it is more
surprising in other cases, like ones where URL encoding or optional
components are involved.  E.g., imagine your two options above were
flipped (you do not usually verify ssl, but it is very important for you
to do so against cacert.org). An automated tool like repo tries to clone
from https://user@cacert.org, and you might be surprised that SSL
verification is not turned on.

> >>-	git_config(http_options, NULL);
> >>+	git_config(http_options, (void *)url);
> >
> >No need to cast again. :)
> 
> Ah, but there is in order to avoid a warning:

Ah, you're right. Sorry for the noise.

-Peff
