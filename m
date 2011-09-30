From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's
 keychain
Date: Fri, 30 Sep 2011 18:11:11 -0400
Message-ID: <20110930221111.GB9384@sigill.intra.peff.net>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
 <20110929075627.GB14022@sigill.intra.peff.net>
 <CAG+J_DwntGc+j3duCVqsnoJGV18FqnwXJ99C1XqKope_zbGHAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 00:11:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9lIb-0002eY-Ts
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 00:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758030Ab1I3WLO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 18:11:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50443
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755482Ab1I3WLN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 18:11:13 -0400
Received: (qmail 4962 invoked by uid 107); 30 Sep 2011 22:16:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Sep 2011 18:16:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2011 18:11:11 -0400
Content-Disposition: inline
In-Reply-To: <CAG+J_DwntGc+j3duCVqsnoJGV18FqnwXJ99C1XqKope_zbGHAA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182516>

On Fri, Sep 30, 2011 at 03:16:58PM -0400, Jay Soffian wrote:

> This makes no sense to me at all. Ignore OS X for the moment. You use
> git on the command-line. Why would there be any expectation of it
> interacting with the user via anything other than the terminal.

Because security prompts sometimes are out of band. In particular,
you're already interacting with the user outside of the terminal;
opening the keychain will get you an "allow git to open the keychain"
dialog.

Another example: if you're running gpg-agent, and you run "git tag -s",
you'll be prompted for your key passphrase in an out-of-band dialog.

Maybe it doesn't make sense for the actual username/password, though.

> I don't understand where you're running ssh from/to in this scenario,
> but OS X has a notion of security contexts (this is a bit of a
> tangent):
>=20
> http://developer.apple.com/library/mac/#technotes/tn2083/_index.html

I meant running sshd on OS X, and then ssh-ing in from some other box.
Your credential helper doesn't seem to work at all (I guess because it
has no access to the keychains). I don't think it's a big deal, though.
It's the minority case, and if somebody wants to figure out how to make
it work later, they can.

> I found it ugly that git's native getpass doesn't echo the username
> back, and it seems hackish to me for the credential helper to turn
> back around and invoke it in any case. :-(

Yes, but I think that's a bug that should be fixed in git. :)

As far as being hack-ish, the original design was that you could chain
these things if you wanted. But in practice, I don't know how useful
that is. In fact, after all of this discussion, I'm wondering how usefu=
l
it is that the helpers are allowed to prompt themselves at all.

The KDE one does it. But would people be happier if git simply did:

  1. ask the helper for a credential. if we get it, done

  2. prompt the user

  3. if the credential is valid, ask the helper to store

That's way less flexible. But it also makes the helpers really simple.

> > My test harness checks that this case just asks for the password wi=
thout
> > bothering to do any lookup or storage. It probably doesn't really m=
atter
> > in practice; I think git should always be providing _some_ context.
>=20
> Okay, that wasn't clear from whatever documentation I read on how
> credential helpers should behave. But why invoke the credential helpe=
r
> just to ask for a password?

Because the helper might have an alternate way of asking for the
password (e.g., the KDE helper has its own dialog). Maybe it will never
be useful. I just wanted to future-proof helpers by giving them sane
behavior for this case, on the off chance that future versions of git d=
o
actually do this.

> > Hrm. I was really hoping people wouldn't need to pick apart the "un=
ique"
> > token, and it could remain an opaque blob. If helpers are going to =
do
> > this sort of parsing, then I'd just as soon have git break it down =
for
> > them, and do something like:
> >
> > =C2=A0git credential-osxkeychain \
> > =C2=A0 =C2=A0--protocol=3Dhttps \
> > =C2=A0 =C2=A0--host=3Dgithub.com \
> > =C2=A0 =C2=A0--path=3Dpeff/git.git
> > =C2=A0 =C2=A0--username=3Dpeff
> >
> > to just hand over as much information as possible, and let the help=
er
> > throw it all together if it wants to.
>=20
> Keychain entries have distinct fields. I broke apart the token and
> stored it the way other applications mostly do on OS X.

Don't get me wrong; I think you did the only sane thing. It was more
"Hmm, I was hoping that the right way to use the various security APIs
wouldn't need to...". And clearly my hope was wrong. :)

But this is exactly the sort of feedback I was hoping for; the interfac=
e
to the helpers could be better, and we are catching it now.

> > My series will also produce "cert:/path/to/certificate" when unlock=
ing a
> > certificate. The other candidates for conversion are smtp-auth (for
> > send-email) and imap (for imap-send). =C2=A0I guess for certs, you'=
d want to
> > use the "generic" keychain type.
>=20
> Yep, I was punting on certificate for v1.

Not unreasonable. Again, my real concern is not perfect helpers, but
having helpers that exercise the helper interface enough so that we kno=
w
whether that interface is sufficient.

> Each keychain entry has an ACL of applications that are allowed to
> access it. When an application asks for an entry and the application
> isn't on that entry's ACL, OS X (not the application) presents the
> user the dialog you refer to. The application has no control over tha=
t
> dialog.
>=20
> Now, I could have the credential helper ask the user "store this
> password?" after prompting for it, but why even use a credential
> helper if you don't want it to store your credentials?

That's not an unreasonable attitude. I mostly let the browser store
passwords, but sometimes override it for specific sites. But in this
case, I think it would be more per-repo. And you can turn off the helpe=
r
for a particular repo (actually, I'm not sure you can, but you probably
should be able to).

> It is for security reasons. 99% of users will probably just click
> "Okay" no matter what. For the 1% that bother to pay attention to the
> dialog, it provides the full path to the binary. I'd be suspicious if
> /tmp/iTunes wanted a password.

Not for me (on 10.7). Doing:

  cp git-credential-osxkeychain /tmp/iTunes
  /tmp/iTunes --unique=3Dhttps:foo.tld

gives me the dialog "iTunes wants to access the 'login' keychain" with =
a
password prompt.

Anyway, that's neither here nor there. It would be nice if we could set
the text, but if we can't, then we'll have to live with it.

-Peff
