From: Max Horn <max@quendi.de>
Subject: Re: fast-import deltas
Date: Wed, 2 Apr 2014 01:29:13 +0200
Message-ID: <A0BF7D05-E351-4A5B-8F0F-DD0FAD391656@quendi.de>
References: <20140401102554.GA32231@glandium.org> <20140401114502.GA15549@sigill.intra.peff.net> <20140401130703.GA1479@glandium.org> <20140401131512.GA19321@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_EDE3E8F0-39DC-4D36-80ED-BAD4DBA908F3"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 11:31:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVdtN-00026v-4L
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbaDAX32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 19:29:28 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:47089 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751511AbaDAX3S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 19:29:18 -0400
Received: from ip-84-118-176-11.unity-media.net ([84.118.176.11] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WV87H-00017u-1u; Wed, 02 Apr 2014 01:29:15 +0200
In-Reply-To: <20140401131512.GA19321@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1396394958;2507d6c8;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245670>


--Apple-Mail=_EDE3E8F0-39DC-4D36-80ED-BAD4DBA908F3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 01.04.2014, at 15:15, Jeff King <peff@peff.net> wrote:

> On Tue, Apr 01, 2014 at 10:07:03PM +0900, Mike Hommey wrote:
>=20
>>> For my own curiosity, how does this differ from what is in
>>> contrib/remote-helpers/git-remote-hg?
>>=20
>> contrib/remote-helpers/git-remote-hg does a local mercurial clone =
before
>> doing the git conversion. While this is not really a problem for most
>> mercurial projects, it tends to be slow with big ones, like the =
firefox
>> source code. What I'm aiming at is something that can talk directly =
to a
>> remote mercurial server.
>=20
> Ah, that makes sense. Thanks for explaining.


Hm, myself, I am not quite convinced. Yes, there is an overhead, but it =
is one-time (well, the space overhead is not, but Mike only mentioned =
time, not space). I wonder if it is really worth the effort to start yet =
another project on this... Moreover, I don't see a fundamental reason =
why one could not modify git-remote-hg to work this way. At least =
optionally - myself, I would strongly prefer the current way, as =
translating between git and hg 100% round trip clean is provably =
impossible [1].

Thing is, there are by now more than half a dozen projects of this kind. =
In my impression, all do the low hanging fruit, some go slightly beyond =
that, but *none* solves all the tough parts and itty-gritty details...

Just to mention a few of the problems that are usually ignored, even =
though they have real world impact:

- the concept of Mercurial branches has no counterpart in git, making =
all kinds of translations hard. As a consequence, many translators =
ignore hg branches completely (e.g. hg-git -- at least it used to do =
that, not sure whether that changed) or handle them only partially (e.g. =
contrib/remote-helpers/git-remote-hg: It does not deal with multiple =
heads or with closed branches)
(this can cause sever issues with git-remote-hg, by the way, with =
dangling refs, which, when pruned by an auto-gc, can wipe your =
fast-import marks file, causing major pain...)

- in the other direction, git branches most closely correspond to hg =
bookmarks. But what if a hg repository has both a branch "foo" and a =
bookmark "foo"? git-remote-hg partially deals with that (by mapping the =
hg bookmark "foo" to the git branch "foo", and mapping the hg branch =
"foo" to the git branch "branches/foo"), but this still has issues =
(besides being annoying for users, it clearly still not avoids ref name =
conflicts)

- git and hg also allow different characters sets in branch and bookmark =
names

- in hg you can simultaneously have things called "foo" and "foo/bar". =
In git, you can't.

There is plenty more. Of course, some of this might just be impossible =
[1] to handle nicely. But I find it kind of sad that everybody seems to =
prefer to start yet another solution, then leave it as 80%, instead of =
trying to improve upon existing work :-(.

By the way, to get back to the speed bottleneck: We found that by far =
the slowest part in importing large repositories like the Mozilla one =
was not the initial cloning of the hg repository (althoug that could =
sometimes take ages) but rather an unfortunate mismatch between the hg =
and git storage approach. When creating a fast-import stream, the normal =
way to go about that is to import things commit by commit. But if you do =
that, then extracting file data from Mercurial and its revlog data =
format easily can degenerate into the worst case quadratic runtime :-/. =
Now, if one know that one is going to import the whole repository =
anyway, one could do better by first exporting all file revisions, =
generating many blobs and their marks, and keeping these in memory, =
*then* exporting the commits, reverting to these blob marks.=20

However, this stops being a great idea once you are working in =
incremental mode. That said, it certainly would make sense to =
investigate this possibility (regardless of whether one uses a local hg =
clone or directly talks to the remote repository); at least in theory, =
even if one only uses this approach during the initial import, it should =
be a strict improvement over the current situation.

In closing, I should mention that the problems caused by translating =
between hg and git concepts are by far not the only ones; the =
fast-import interface itself still has limitations that make some things =
annoying. E.g. when a remote is renamed, the remote handler does not =
know that, which can lead to awkward situations that right now may =
require some trickery to resolve correctly, if it is possible at all. Or =
if a user manually removed a commit that a remote-helper previously =
referenced in a marks file, and that remote helper than uses that marks =
file, fast-import just dies, complaining about the invalid mark. As a =
result, every proper remote helper basically would need to fully parse =
and verify those marks files, detect "broken" marks, and deal with that =
-- there is no way to benefit from the existing mark verification code =
in fast-import right now.

Please don't get me wrong. I don't want to whine, and I hope I can =
contribute to solving some of these issues at some point (though lack of =
time is a nasty issue). In the meantime, I'd love if other people were =
interested in improving one of the existing solutions to the problem =
(such as git-remote-hg, gitifyhg or hg-git), instead of creating yet =
another half-way solution... :-)


Cheers,
Max

[1] That is, unless you are willing to use a custom server, such as Kiln =
Harmony <http://blog.fogcreek.com/kiln-harmony-internals-the-basics/>. =
But that is cheating, as this is not a real round-trip conversion; =
rather, you keep a git and a hg repository in perfect sync all the time =
and present them as a single entity to the outside world.

--Apple-Mail=_EDE3E8F0-39DC-4D36-80ED-BAD4DBA908F3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlM7S8wACgkQIpJVslrhe1kdewD+MpbEtk5PJT/+SCMJ8gngHyDV
5oeqAvcIwMIjxatq5RwBAKlecYqpYOjLkQHX8dXHSt1KwUKZS9yF0mqurnmI1i9e
=4SRI
-----END PGP SIGNATURE-----

--Apple-Mail=_EDE3E8F0-39DC-4D36-80ED-BAD4DBA908F3--
