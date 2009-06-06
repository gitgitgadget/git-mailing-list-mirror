From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] add strerror(errno) to die() calls where applicable
Date: Sat, 6 Jun 2009 15:09:10 +0200
Message-ID: <200906061509.15870.trast@student.ethz.ch>
References: <8df45fb3586160fa5c47af39d2a7eb2b8d405a3c.1243978065.git.trast@student.ethz.ch> <20090603015503.GA14166@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1469982.8GziczEhZa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 06 15:09:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCveg-00088A-07
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 15:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbZFFNJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 09:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbZFFNJU
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 09:09:20 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:13048 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245AbZFFNJT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 09:09:19 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Jun 2009 15:09:05 +0200
Received: from thomas.localnet ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Jun 2009 15:09:05 +0200
User-Agent: KMail/1.11.3 (Linux/2.6.27.21-0.1-default; KDE/4.2.3; x86_64; ; )
In-Reply-To: <20090603015503.GA14166@coredump.intra.peff.net>
X-OriginalArrivalTime: 06 Jun 2009 13:09:05.0693 (UTC) FILETIME=[F853ACD0:01C9E6A7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120915>

--nextPart1469982.8GziczEhZa
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry for not getting around to this again all week.  I'll try to
reroll later today...

Jeff King wrote:
>   1. How did you determine the set of callsites? Did you check that each
>      non-syscall function always sets errno? Are there are functions
>      which are setting errno which could also be included?

Basically by 'git grep die | grep -v errno' and then looking at the
code immediately before the die().  Rather tedious, but I couldn't see
an obvious way to automate the task.

As for the non-syscall functions, at first I had a longer list but I
eventually settled with the ones mentioned, but I decided it was too
risky and just stuck with those that are very clear:

> On Tue, Jun 02, 2009 at 11:34:33PM +0200, Thomas Rast wrote:
> >   odb_pack_keep

Tries open() in two ways, but can only return <0 by passing the return
value of the second.

> >   read_ancestry

Only returns -1 if fopen() returned NULL.

> >   read_in_full

Only returns <=3D0 if xread() returned <=3D0, which in turn only happens
if read() returned <0.

> >   strbuf_read

Returns -1 if xread() did so.

> >   strbuf_read_file

Returns -1 if open() or strbuf_read() failed.

> >   strbuf_readlink

Returns -1 if readlink() failed.  (The other option, that the buffer
was still too small at STRBUF_MAXLINK, would imply that readlink()
wanted to return more than PATH_MAX chars.)

> >   write_buffer

I'll drop this one, I missed that it actually does its own errno
reporting already.  (Other than that it's just a thin wrapper around
write_in_full.)

> >   write_in_full

Symmetric to read_in_full: only returns <=3D0 if xwrite() did, which in
turn only happens if write() returned <0.


There were lots of cases that aren't quite as clear-cut.  For example,
there are many call sites where the index is written out that look
like

	if (write_cache(fd, active_cache, active_nr) ||
	    close_lock_file(&index_lock))
		die("unable to write new_index file");

Dealing with those will be somewhat more complicated, as the error
case is not all that clearly defined.  But at least at a quick glance,
write_cache does not even indicate what file it failed to write.

>   2. Extra error conditions may leak information about the filesystem to
>      people feeding bogus paths to upload-pack. I didn't see anything
>      obvious in your patch that would cause this, but it is something to
>      consider.

Good point.

> > -		die("closing file %s: %s", path, strerror(errno));
> > +		die("closing file '%s': %s", path, strerror(errno));
>=20
> This one is actually just a style change, though I think it is
> worthwhile (and there are a few others like it).

Yes, as I was already going through the calls I thought some
consistency would be nice.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1469982.8GziczEhZa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkoqansACgkQqUud07tmzP14XgCgl/O7oB98pEb1HT8WdgVDBjAU
X80An1TftVhRpuhTzLDP6d2TmQHCq8x8
=iUrW
-----END PGP SIGNATURE-----

--nextPart1469982.8GziczEhZa--
