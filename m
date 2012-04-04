From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] contrib: add win32 credential-helper
Date: Wed, 4 Apr 2012 07:23:42 -0400
Message-ID: <20120404112341.GA28354@sigill.intra.peff.net>
References: <1332198414-5884-1-git-send-email-kusmabite@gmail.com>
 <20120323211001.GA18198@sigill.intra.peff.net>
 <CABPQNSac0opcTDVBwr4VeuA7pxqbtsqU7mdmYWms9tu3MjcpeQ@mail.gmail.com>
 <20120404101014.GB13870@sigill.intra.peff.net>
 <CABPQNSYRxZHSW_urpH7yh=Bct2-X2TAsd3=jaJF_9Rb-foegLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 13:23:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFOJa-0007UM-Cu
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 13:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179Ab2DDLXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 07:23:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45922
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756133Ab2DDLXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 07:23:44 -0400
Received: (qmail 8327 invoked by uid 107); 4 Apr 2012 11:23:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Apr 2012 07:23:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2012 07:23:42 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSYRxZHSW_urpH7yh=Bct2-X2TAsd3=jaJF_9Rb-foegLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194693>

On Wed, Apr 04, 2012 at 12:37:25PM +0200, Erik Faye-Lund wrote:

> Sure, but this is a problem with HTTP-auth, we don't have to make it a
> problem of our credential-api as well. For instance,  we could try to
> send the credentials to the server as UTF-8 first, and if that fails
> re-try with ISO-8859-1. If neither works, we probably need more info;
> if it's worth it somebody could implement a per-remote locale or
> something. I'm not saying we should, but it's something that could be
> done if the HTTP-auth issue proves to be real.

Ugh. The retry thing is just hideous. I'd much rather wait for a real
solution like the draft rfc I mentioned, and then implement that (or
better yet, it is probably something that curl would implement). But in
the meantime, I haven't seen a single report on the list that what git
is doing is a problem, and I'd much rather come to the same solution
that browsers do than invent some git-specific junk.

> Losing the encoding EARLY isn't any better than trying to preserve it
> for as long as possible, and only lose it when we KNOW we're sending
> this down a path where the encoding is undefined?

I see what you're saying, but there are two points against this:

  1. We don't necessarily even know what the original encoding is.

  2. All code paths currently end in a place where we drop the encoding
     (http auth and certificate passwords). So it's sort of a non-issue
     at this point.

> And passing UTF-8 data when the encoding is undefined is probably one
> of the less insane things to attempt, no?

Not necessarily. If the user types latin1 and their webserver expects
latin1, then we will be breaking their setup. Preserving the bytes as-is
means we will do the right thing in that case. It means we will do the
wrong thing when the user types latin1 and the webserver expects utf-8,
but that is _already_ broken even without credential helpers. Have we
seen any bug reports?

> The problem is that for some helpers you need to know the encoding in
> order to have a user-interface show the data. This goes both for OSX
> and Windows. If you mess up the encoding, in the helper, then you'll
> mess up the entries in the OS'es key-managers. While this might not be
> a problem in practice for US-English users, we've seen for Git for
> Windows that e.g. some Asians are really unhappy with their username
> becoming some completely incomprehensible string.

How are they inputting their username? If they are seeing garbage, then
surely it is coming to git in some encoding that is different than what
the password manager expects. Then we give it to a helper, which hands
it to system storage, which assumes that what we give it is utf-8. So
the error there seems to me to be the layer between the helper and the
system storage, where the string is converted from "a stream of bytes"
to "a utf-8 encoded string".

So why is this a credential helper protocol problem, and not an
implementation issue for the specific helper? How does git find out the
encoding? Presumably by checking $LANG, or whatever system-specific
locale information there is. Can't the helper do the same thing?

> Saying "Hey, I'm just passing on what I got here, don't blame the
> messenger" isn't a solution, it's adding to the problem. I'm sorry if
> I'm a bit blunt here, but being a pass-through is a sorry excuse. User
> names and passwords are text-strings by definition; "name" and "word"
> both imply it. No one has a binary blob of 0xbadf00d as a username or
> password.

I never argued that people are putting in binary blobs. I do argue that
we don't necessarily know the encoding of the input, nor what encoding
is expected for the output. So by preserving bytes, we can at least not
make the situation worse.  The username git sees is some bytes from a
file handle. How do we know what encoding it's in? The concept of "text
string" is not well-defined in the Unix world, and data tends to be
considered as streams of bytes.

We can guess from $LANG, though I'm not sure how foolproof that is in
practice (more on that below).

> Now, my suggestion was to define that these are UTF-8; if we pass it
> UTF-8 it will still give back UTF-8. But it can be converted
> internally so the OS can show the credential in it's manager.

Which implies that git must be converting what the user gives us into
UTF-8. And then converting it back (to what?) when we get the data back
from the helper, before we send it to the webserver? Or do we always
send UTF-8 to the webserver? Won't that break setups that currently
work?

> What can of worms? Shouldn't getpass simply get the password in the
> current system locale? When the user inputs the string is exactly the
> moment we want to convert the "external locale" into a known encoding.

Is that always accurate on every system? If so, then why don't we do it
in every place that we take input from the user? I suspect the answer is
a fear that we would end up corrupting data as often as we end up
helping.

Maybe that fear is unfounded (it is not my decision, but rather general
git design). Maybe this is just a Unix thing, where the attitude is
usually that data is a stream of bytes. I don't know.

-Peff
