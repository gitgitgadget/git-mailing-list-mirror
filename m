From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential: do not store credentials received from
 helpers
Date: Sat, 7 Apr 2012 00:56:12 -0400
Message-ID: <20120407045612.GA965@sigill.intra.peff.net>
References: <20120407033417.GA13914@sigill.intra.peff.net>
 <CAJo=hJvqQ0CgCga4va3ZX+XV5DWc1kWS5v4vYWkEzRYT5+p+cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 06:56:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGNhl-0001TO-R6
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 06:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831Ab2DGE4R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Apr 2012 00:56:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53088
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab2DGE4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 00:56:16 -0400
Received: (qmail 19070 invoked by uid 107); 7 Apr 2012 04:56:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Apr 2012 00:56:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Apr 2012 00:56:12 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJvqQ0CgCga4va3ZX+XV5DWc1kWS5v4vYWkEzRYT5+p+cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194933>

On Fri, Apr 06, 2012 at 09:12:39PM -0700, Shawn O. Pearce wrote:

> On Fri, Apr 6, 2012 at 20:34, Jeff King <peff@peff.net> wrote:
> > =C2=A02. If you use a time-based storage helper like
> > =C2=A0 =C2=A0 "git-credential-cache", every time you run a git
> > =C2=A0 =C2=A0 command which uses the credential, it will also
> > =C2=A0 =C2=A0 re-insert the credential after use, freshening the
> > =C2=A0 =C2=A0 cache timestamp. So the cache will eventually expire =
N
> > =C2=A0 =C2=A0 time units after the last _use_, not after the time t=
he
> > =C2=A0 =C2=A0 user actually typed the password. This is probably no=
t
> > =C2=A0 =C2=A0 what most users expect or want (and if they do, we
> > =C2=A0 =C2=A0 should do it explicitly by providing an option to
> > =C2=A0 =C2=A0 refresh the timestamp on use).
>=20
> So if I use the cache helper, and its set to expire at the default of
> 15 minutes, I have to type my password in every 15 minutes, even if I
> am doing a Git operation roughly every 8 minutes during a work day?

Yes. It's less convenient, but safer and more predictable (you put your
password in at 2:30, it's gone at 2:45). Keep in mind that you can also
bump the cache time. And like I said, if we do want have it behave the
other way, that's OK, but it should be explicit (and it can be optional=
,
even if it defaults to auto-refresh on use).

Or you could even do something more complex. gpg-agent will refresh the
timestamp on use, but still has a "max ttl" that drops a credential N
seconds after it was input, even if it was used recently. But making an=
y
decision like that means that the daemon needs to actually know whether
the timestamp came from the user, or whether it was simply accessed and
regurgitated to us.

> This breaks one of my credential helpers.
>=20
> I have a helper that generates a password by asking a remote system t=
o
> generate a short lived password based on other authentication systems
> that I can't describe. Once I have that password, its good for $X
> time.
>=20
> The helper just dumps it out to Git, and Git turns around and stores
> it into the cache for me. This means later requests will keep that
> credential in the cache, and avoid making that remote system call
> every time I do a Git network command.

I considered your use case when writing the patch and thought "no,
that's too insane. Nobody would want that." But leave it to you to prov=
e
me wrong. :)

I'm torn. What you are doing is totally reasonable for your case. At th=
e
same time, having it happen without the user's knowledge could have
surprising security implications, because you're leaking passwords from
one helper to the other (in the example in the commit message, I
mentioned a high-security helper followed by "cache". Which is probably
not that bad. But imagine if it were "store").

> I guess I now need to change my helper to cache git credential-cache
> itself and store the password into the cache if it wants to use the
> cache?

That's one option, though it is a little bit of a pain to implement (no=
t
hard, but not one line of code). It would be very easy to add a
"credential.storeHelperCredentials" option that defaulted to off (that
name is horrible, but you get the point).

> Should we update the credential helper documentation at the same time
> as this change to make it clear Git won't cache passwords returned
> from helpers, but a helper could call the credential-cache itself if
> it wanted to reuse the existing cache service?

Yeah, I'll add a documentation update when I re-roll; but we first need
to figure out what the recommended course of action is.

One thing I don't like about having your helper call credential-cache i=
s
that it is a layering violation; it is only guessing that putting the
data into credential-cache will be useful in the first place. But that
depends on the user's config. It could have be using an alternative
caching helper (or none at all).

So I think an explicit "it's OK to leak credentials between helpers"
flag is our best bet. And it's dirt simple to code.

-Peff
