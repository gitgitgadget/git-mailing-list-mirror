From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] contrib: add win32 credential-helper
Date: Wed, 4 Apr 2012 06:10:14 -0400
Message-ID: <20120404101014.GB13870@sigill.intra.peff.net>
References: <1332198414-5884-1-git-send-email-kusmabite@gmail.com>
 <20120323211001.GA18198@sigill.intra.peff.net>
 <CABPQNSac0opcTDVBwr4VeuA7pxqbtsqU7mdmYWms9tu3MjcpeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 12:10:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFNAX-0000jA-3P
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 12:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070Ab2DDKKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 06:10:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45863
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753759Ab2DDKKR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 06:10:17 -0400
Received: (qmail 7381 invoked by uid 107); 4 Apr 2012 10:10:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Apr 2012 06:10:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2012 06:10:14 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSac0opcTDVBwr4VeuA7pxqbtsqU7mdmYWms9tu3MjcpeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194691>

On Mon, Apr 02, 2012 at 05:53:47PM +0200, Erik Faye-Lund wrote:

> > Otherwise, newline is a reasonable choice, as the protocol
> > already can't communicate usernames/passwords with newlines (a
> > limitation that I accepted to make the protocol much simpler for
> > scripting use).
> 
> This works, but it causes Windows 7's credential manager to glitch in
> rendering the credential (adding all the newlines to the end of the
> line, and stretching an icon - yuck), which is also a bit unfortunate.
>
> So I'm thinking that escaping the string needs to be done. It can't be
> that big of a deal ;)

Gross. I guess backslash-escaping or something similar would be pretty
easy to implement.

> > Like many other parts of git, we treat the data as binary goo as much as
> > possible. So git hands the helper whatever bytes the user provided, and
> > ships off whatever bytes are provided by the helper over http without
> > any further processing. The only two exceptions are:
> [...]
> 
> ASCII unsernames might be common in the UNIX-world, but in the Windows
> world this is very much not the case. These functions can be used for
> all kinds of services, so I don't think assuming ASCII makes much
> sense.
> 
> And since OSX documents the encoding, I'm guessing that non-ASCII
> usernames isn't entirely unheard of there either.

But what does it mean to have an encoding for credentials that will be
sent over http basic-auth? As far as I know, the binary bytes are simply
base64-encoded and sent to the server in a header, and there is no room
for an encoding or any normalization in the password. You just hope that
the remote side is using the same encoding as you, and that there are no
normalization issues (e.g., your username contains "e with accent", but
your input system provides "e" + "combining accent").

It looks like there is a draft rfc to try to help with this:

  http://tools.ietf.org/html/draft-reschke-basicauth-enc-05

but I have no idea if it is adopted at all yet.

> In general, I think the whole "let's try to get away with not
> specifying encoding" is a bit dangerous. Without knowing what encoding
> the input and output is, the helpers are pretty much useless for
> people.

Not necessarily. By being a pass-through, things will usually just work.
That is, if you hand the helper UTF-8 to store, then it should hand you
back UTF-8. Ditto for any other encoding. And if it doesn't work, it's
not the helper's problem, but a mismatch between the http client and
server. The helper's job is to reproduce some bytes.

> Sure, saying "at least ASCII" helps, but it just takes us
> halfway there. And, I think UTF-8 is the least insane option here.

Of course. UTF-8 is pretty much always the least insane option, and I
would hope that everybody is using it. But by being a pass-through, we
don't restrict it. If the client and server both want to use Shift JIS,
then the stock git helpers will work fine. On systems where the OS
mandates a particular encoding (I didn't even check for the OS X helper,
but let us imagine it will barf on non-UTF8 data), then I would expect
everybody to be using that encoding, and the pass-through just works.

If your helper storage really cares, then I think it's sane to assume
you'll get UTF-8 input, and to pass that back out. But I really didn't
want to open the can of worms that is having "getpass()" figure out what
encoding it is getting from the user.

-Peff
