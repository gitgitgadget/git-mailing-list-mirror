From: Roger Leigh <rleigh@codelibre.net>
Subject: Re: git mailinfo strips important context from patch subjects
Date: Mon, 29 Jun 2009 22:36:26 +0100
Message-ID: <20090629213625.GA5397@codelibre.net>
References: <20090628193858.GA29467@codelibre.net>
 <20090628200259.GB8828@sigio.peff.net>
 <7vfxdkez96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 23:36:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOWl-0004h9-2E
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 23:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbZF2Vga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 17:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbZF2Vg3
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 17:36:29 -0400
Received: from nagini.codelibre.net ([80.68.93.164]:37097 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbZF2Vg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 17:36:28 -0400
Received: by nagini.codelibre.net (Postfix, from userid 107)
	id 6714C18225; Mon, 29 Jun 2009 22:36:29 +0100 (BST)
Received: from hardknott (unknown [78.148.79.113])
	by nagini.codelibre.net (Postfix) with ESMTPSA id ECFBE181C0;
	Mon, 29 Jun 2009 22:36:25 +0100 (BST)
Received: by hardknott (Postfix, from userid 1000)
	id 3F4AE120C1; Mon, 29 Jun 2009 22:36:26 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vfxdkez96.fsf@alter.siamese.dyndns.org>
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 19:33:15 up 8 min,  2 users,  load average: 0.92, 0.41, 0.18
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122463>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2009 at 04:04:37PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Sun, Jun 28, 2009 at 08:38:58PM +0100, Roger Leigh wrote:
> >
> >> In most of the projects I work on, the git commit message has
> >> the affected subsystem or component in square brackets, such as
> >>=20
> >>   [foo] change bar to baz
> >>
> >> [...]
> >>
> >> The [sbuild] prefix has been dropped from the Subject, so an
> >> important bit of context about the patch has been lost.
> >>=20
> >> It's a bit of a bug that you can't round trip from a git-format-patch
> >> to import with git-am and then not be able to produce the exact same
> >> patch set with git-format-patch again (assuming preparing and applying
> >> to the same point, of course).
> >
> > As an immediate solution, you probably want to use "-k" when generating
> > the patch (not to add the [PATCH] munging) and "-k" when reading the
> > patch via "git am" (which will avoid trying to strip any munging).
> >
> > However:
> >
> >> Would it be possible to change the git-mailinfo logic to use a less
> >> greedy pattern match so it leaves everything after
> >> ([PATCH( [0-9/])+])+ in the subject?  AFAICT this is cleanup_subject in
> >> builtin-mailinfo.c?  Could this rather complex function not just do a
> >> simple regex match which can also take care of stripping ([Rr]e:) ?
> >
> > Yes, I think in the long run it makes sense to strip just the _first_
> > set of brackets. I don't think we want to be more specific than that in
> > the match, because we allow arbitrary cruft inside the brackets (like
> > "[RFC/PATCH]", etc). But if format-patch always puts exactly one set of
> > brackets, and am strips exactly one set, then that should retain your
> > subject in practice, even if it starts with [foo].
>=20
> I think it may still make sense to insist that PATCH appears somewhere in
> the first set of brackets, but I have stop and wonder if it is even
> necessary.

I imagine not.  I've submitted a patch separately which implements
this behaviour (more on that below).

> Because git removes [sbuild] at the beginning, Roger is unhappy.
>=20
>  * Is he happy that git removes [PATCH]?  In E-mail based workflow it is
>    a good practice to mark messages that are patches clearly so that they
>    can be quickly found among the discussions that lead to them, and it is
>    plausible that his project accepted that as an established practice
>    supported well by git.

I'm perfectly happy that [PATCH] is removed.  My requirement is that
the commit created by "git am" is identical to the commit represented
in the patch created with "git format-patch".  The removal of this
is IMO correct, and I agree that it's presence is useful in an email-
based workflow.

>  * Is he happy that git treats the first paragraph of the commit message
>    specially from the rest of the message?  In a project with many
>    commits, it is essential that people write good commit summaries that
>    fits on a single line so that tools like shortlog and gitweb can be
>    used to get a bird-eye view of what happened recently.  Perhaps his
>    project picked it up as the best current practice supported well by
>    git.

I'm also happy with this, and make use of it.  As for the previous
paragraph, I would like the commit message to be preserved correctly
so that the message committed by "git am" matches the original
commit message exactly.

>  * Is he happy that git takes "---" as the end of message marker, so that
>    any other commentary can be added to the message to facilitate the
>    communication without adding noise to the commits?  Perhaps he is and
>    his project picked it up as a good practice supported well by git.

This sounds just fine, though I have not yet had the need to use it.

> _An_ established (note that I did not say _the_ nor _best current_)
> practice supported well by git to note the area being affected in a
> project of nontrivial size is to prefix the single line summary with the
> name of the area followed by a colon.  There is no difference between
> "[sbuild] foo" and "sbuild: foo" at the information content point-of-view,
> but the latter has an advantage of being one letter shorter and less
> distracting in MUA.  He does not have a very strong reason to choose
> something different only to make his life harder, does he?

Well, I sometimes use the format

  [foo] bar: baz

but my more general point was not my specific usage but that the
existing behaviour was causing loss of information.  I think it
would be preferable to guarantee that data from the original
commit is not lost and is preserved exactly if at all possible.

> Supporting a slightly different convention may seem to be accomodating and
> nice, but if there is no real technical difference between the two (and
> again, "area:" is one letter shorter ;-), letting people run with
> different convention longer, when they can switch easily to another
> convention that is already well supported, may actually hurt them in the
> long run.  "[sbuild]" will not match "--area=3Dsbuild" that will internal=
ly
> become "--grep-only-first-line=3Dsbuild:" so either he will miss out
> benefiting from the new feature, or the implementation of the new feature
> unnecessarily needs more code.

This is a nice feature I wasn't aware of, so thanks for pointing it
out.  It might be useful to alter my workflow to allow it to be used,
or alternatively customisation to allow a custom regex stored e.g.
in .git/config would allow me to match both forms?

The patch I sent to the list separately replaces the existing
cleanup_subject string munging (which is rather complex and
hairy), with a single regular expression to match the bits of
the string we don't want such as '^Re:' and the first set of
square brackets.  We then just keep the remainder.  I initally
went with the following extended regex:

  ^([Rr]e: )?(.*PATCH[^]]*\\] )(.*)$

but as per your comments above about removing the first set of
brackets whatever the contents, chose the following more
general expression:

  ^([Rr]e:)?([^]]*\\[[^]]+\\])(.*)$

This should be rather more maintainable and flexible than the
existing code, because one can just tweak the regex rather than
fiddling with hairy string offsets.  This preserves the
existing behaviour with the exception of matching the first []
pair only rather than being "greedy" and removing everything up
to the last "]".


Regards,
Roger

--=20
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkpJM9kACgkQVcFcaSW/uEhLDQCdGIJ/rGD7fJ94QsWbiYTW0dAJ
RHsAoLt7vjeVo0HNAV/cR85P/A1kzeBq
=5WN6
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
