From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sun, 02 Dec 2012 14:09:29 -0500
Message-ID: <20121202190929.GG9401@odin.tremily.us>
References: <7vy5hhmcwp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=DNUSDXU7R7AVVM8C
Cc: Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 20:10:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfEvm-0007yX-L5
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 20:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab2LBTJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 14:09:54 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:20551 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab2LBTJx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 14:09:53 -0500
Received: from odin.tremily.us ([unknown] [72.68.90.212])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEF0063V3VT9190@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 02 Dec 2012 13:09:31 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id B2F7F6E4D03; Sun,
 02 Dec 2012 14:09:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354475369; bh=PXMfD5o8J+DcGCEHnHABkSwr8cU/Ta+rvXFREYGTWmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UZvGlamB55TP36fOE2vlvwX/U3XE1paQ4vHhtFkpAkaE+CO97f3d/+Kt5pHrNUZjg
 El7BBRwosUV3/1clvdfPggalQZ0zA5KtjW+3TXtT2SxCqXLAIE9k2uLteIN170K36p
 9HVYrEsmqDDt62Q69nvyFgZjvV6UV5MDps/59FkI=
Content-disposition: inline
In-reply-to: <7vy5hhmcwp.fsf@alter.siamese.dyndns.org> <50BA3412.60309@web.de>
 <20121201163714.GC4823@odin.tremily.us> <20121201181643.GF4823@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211014>


--DNUSDXU7R7AVVM8C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Before I get into the details, I'd like to point out that I actually
understand the purpose of `submodule init` now ;).  To avoid further
confusion, my current one-line command summaries would be:

  init:   mark a submodule as active for future submodule operation
  deinit: mark a submodule as inactive for future submodule operation
  sync:   update remote.<name>.origin in submodules to reflect changes
          in .gitmodules or the superproject's remote URL.

I don't think we disagree on that, we just don't agree on how to
implement it.

Currently, Git uses submodule.<name>.url in the superproject's local
configuration as a marker for submodule activation.  This is not (as
far as I know) discussed in the docs, which is why I initially
missunderstood the purpose of `init` to be =E2=80=9Csetup the superproject's
local configuration so we don't have to keep resolving the submodules
URL relative to the superproject's upstream URL=E2=80=9D.  With the proposed
`deinit` docs, this role for the submodule.<name>.url is mentioned,
but not in a place where casual users will be able to easily connect
it to the purpose of `init`.

I floated using submodule.<name>.update (with 'none' for inactive and
anything else for active) as an alternative marker:

On Sat, Dec 01, 2012 at 01:16:43PM -0500, W. Trevor King wrote:
> On Sat, Dec 01, 2012 at 07:04:05PM +0100, Jens Lehmann wrote:
> > Am 01.12.2012 18:49, schrieb W. Trevor King:
> > > I think removing `init` will cause some compatibility issues anyway,
> > > so I was re-imaging how you do it.  I don't think update=3D'none' and
> > > "don't populate my submodule" are distinct ideas, while a locally
> > > configured url=3D"somwhere" and "please populate my submodule" are (w=
ith
> > > the blank-url case defaulting to the superproject itself).
> >=20
> > Why would we want to remove "init"? It still has to copy the "url"
> > setting (and it would be a compatibility nightmare if we would change
> > that, imagine different git versions used on the same work tree).
>=20
> In my init-less rewrite, it doesn't have to copy the url setting.
> People using older versions of Git would need to run `init` using
> their old version.  Having the url defined in .git/config won't break
> my init-less submodule commands, it just means that the value in
> .gitmodules will be masked.

but that doesn't seem to be going over very well.  Junio may have been
weighing in obliquely with:

On Sat, Dec 01, 2012 at 06:00:06PM -0800, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> > [snip v1 deinit commit message]
>=20
> I fully agree with your analysis on the reason why the "url" element
> is special and has to be copied to $GIT_DIR/config, but when you
> deinit (or uninit) a submodule to say you are no longer interested
> in it and do not want it populated in the context of the
> superproject, I am not sure if removing only submodule.$name.url (so
> that when you later decide to "init" it again, you will keep the
> values for submodule.$name.update and other things from the previous
> life) is the sane thing to do, or it is better to remove
> submodule.$name.* altogether as if an earlier "init" has never
> happened.  Would it be worth analyzing the pros-and-cons here?

Let me take another stab at presenting my argument in favor of a
different activity marker.

Proposal:

Add a new boolean option, submodule.<name>.active, to explicitly mark
submodules as active (with =E2=80=9Cactive=E2=80=9D defined as =E2=80=9Cto =
be returned by
module_list()=E2=80=9D).  Strip down `init` (and the --init part of `update
--init`) to just setting this option to true.  `deinit` only sets this
option to false (but a `deinit --clean` could remove the whole
submodule.<name> section).

With this in place, extracting URLs for submodule operations be
similar to the extraction of other variables (.gitmodules defaults
with superproject-local .git/config overrides).  This also makes it
easier to track maintenance updates in .gitmodules-defined URLs,
because you aren't forced to bake overrides into your local
=2Egit/config

The upgrade path from earlier versions of Git is easy: if
submodule.<name>.active is unset, use the presence of
submodule.<name>.url to determine its initial value.

In the case where you check out an earlier superproject commit which
is missing a particular submodule (or remove a submodule without
deinit-ing), the presense of an active setting in .git/config should
not cause an error, which they currently seem to:

On Sat, Dec 01, 2012 at 11:37:14AM -0500, W. Trevor King wrote:
> On Sat, Dec 01, 2012 at 04:56:02PM +0100, Jens Lehmann wrote:
> > Am 01.12.2012 00:52, schrieb Phil Hord:
> > > If I never 'submodule init' a submodule, it does not get visited by
> > > 'git submodule foreach', among others.  I think some people use this
> > > behavior explicitly.
> > >
> > > On the other hand, I've also notice that a submodule which I have
> > > removed does not get de-inited later one.  It causes my 'git submodule
> > > foreach' to emit errors.  :-(
> >
> > I'm currently hacking on "git submodule deinit" which removes the 'url'
> > setting from git/config. This should do the trick for you, right?
> >
> > Just removing that submodule automagically would not work that well, as
> > it would deinitialize a submodule when you switch to a branch where it
> > isn't present and you'd have to reinitialize it when you come back.
>
> I think this is another case where we should be looping through
> submodules based on the revision-specific .gitmodules content, and
> querying the local config only to determine if the user wants to
> update them (to drop into them with foreach, etc.).

Thoughts?

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--DNUSDXU7R7AVVM8C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQu6dnAAoJEEUbTsx0l5OMC1wP/0nAjAjyfZOIslLKahqJiG4V
smPZlOTCTapxpjExcNtwNJKNDpD4aRZhW9olgFBl+cI8NIYHyRMpI/BBDOj+0RjV
YJtTkzfatrLAYEOUMLzVd3bwksVxN4yMxhxDvCe7rFfFs9d4saTowWbcpNqCgfDW
ilZt2qme97+wMZ7Ptdkk0hY8jHxzlS2HkSMlvhek/DrlRTnKok1I/oBNrN1DW39O
IRl791edAc7PUaAwUuMek1E0bppnysUNJ228a5+dFgTi8rgIFJ9SyLkfxTJ7jmTP
4kRd/uzCy5wkTTp6e5mTTL+E2fi9j04qQoded1D9X85cSyj0BslGM76aUujGHARX
yKMT8aTn4ddDSvj/CXppA4cqK6Ai6GVR9PuBww5iixtp8TfBcuA+hr7KjFYgrjU0
9lm27ZER1sQCZfjjZGtTXOSARuIoVaKxF5MAF9I8rlo3vxU0h5OtMIzPl3xK4ZkF
ZPBOn38ALef/F3J4GQQKeNXfiRbfFxxqPjaCngHGR1XmeRAigDrRSLa9IoAhr/GU
yAAVNT2++HHXyjQeFaJqkwg4wgDpZUAE1gRudsoTsfS0AR8zI2wkthjytVrvpqeX
uQ2PrS0SXvKlM+ulGYHeVKABYjnSdso0m4HziNxxCsMwBSz3QvsFlYOuwV9xNzcU
Ew/yW10n6ARAHJSyhAzA
=pd7H
-----END PGP SIGNATURE-----

--DNUSDXU7R7AVVM8C--
