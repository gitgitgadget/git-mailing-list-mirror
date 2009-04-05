From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 16:38:31 -0700
Message-ID: <20090405T230552Z@curie.orbis-terrarum.net>
References: <20090404220743.GA869@curie-int> <20090405195714.GA4716@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 01:40:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqbwh-00073L-QY
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 01:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbZDEXil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 19:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbZDEXik
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 19:38:40 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:41857 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753551AbZDEXij (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 19:38:39 -0400
Received: (qmail 31245 invoked from network); 5 Apr 2009 23:38:35 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 05 Apr 2009 23:38:35 +0000
Received: (qmail 2681 invoked by uid 10000); 5 Apr 2009 16:38:31 -0700
Content-Disposition: inline
In-Reply-To: <20090405195714.GA4716@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115739>


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2009 at 03:57:14PM -0400, Jeff King wrote:
> > During an initial clone, I see that git-upload-pack invokes
> > pack-objects, despite the ENTIRE repository already being packed - no
> > loose objects whatsoever. git-upload-pack then seems to buffer in
> > memory.
> We need to run pack-objects even if the repo is fully packed because we
> don't know what's _in_ the existing pack (or packs). In particular we
> want to:
>   - combine multiple packs into a single pack; this is more efficient on
>     the network, because you can find more deltas, and I believe is
>     required because the protocol sends only a single pack.
>=20
>   - cull any objects which are not actually part of the reachability
>     chain from the refs we are sending
>=20
> If no work needs to be done for either case, then pack-objects should
> basically just figure that out and then send the existing pack (the
> expensive bit is doing deltas, and we don't consider objects in the same
> pack for deltas, as we know we have already considered that during the
> last repack). It does mmap the whole pack, so you will see your virtual
> memory jump, but nothing should require the whole pack being in memory
> at once.
While my current pack setup has multiple packs of not more than 100MiB
each, that was simply for ease of resume with rsync+http tests. Even
when I already had a single pack, with every object reachable,
pack-objects was redoing the packing.

> pack-objects streams the output to upload-pack, which should only ever
> have an 8K buffer of it in memory at any given time.
>=20
> At least that is how it is all supposed to work, according to my
> understanding. So if you are seeing very high memory usage, I wonder if
> there is a bug in pack-objects or upload-pack that can be fixed.
>=20
> Maybe somebody more knowledgeable than me about packing can comment.
Looking at the source, I agree that it should be buffering, however top and=
 ps
seem to disagree. 3GiB VSZ and 2.5GiB RSS here now.

%CPU %MEM     VSZ     RSS STAT START   TIME COMMAND
 0.0  0.0  140932    1040 Ss   16:09   0:00 \_ git-upload-pack /code/gentoo=
/gentoo-git/gentoo-x86.git=20
32.2  0.0       0       0 Z    16:09   1:50     \_ [git-upload-pack] <defun=
ct>
80.8 44.2 3018484 2545700 Sl   16:09   4:36     \_ git pack-objects --stdou=
t --progress --delta-base-offset=20

Also, I did another trace, using some other hardware, in a LAN setting, and
noticed that git-upload-pack/pack-objects only seems to start output to the
network after it reaches 100% in 'remote: Compressing objects:'.

Relatedly, throwing more RAM (6GiB total, vs. the previous 2GiB) at the ser=
ver
in this case cut the 200 wallclock minutes before any sending too place dow=
n to
5 minutes.


> > During 'remote: Counting objects: 4886949, done.', git-upload-pack peak=
s at
> > 2474216KB VSZ and 1143048KB RSS.=20
> > Shortly thereafter, we get 'remote: Compressing objects:   0%
> > (1328/1994284)', git-pack-objects with ~2.8GB VSZ and ~1.8GB RSS. Here,
> > the CPU burn also starts. On our test server machine (w/ git 1.6.0.6),
> > it takes about 200 minutes walltime to finish the pack, IFF the OOM
> > doesn't kick in.
> Have you tried with a more recent git to see if it is any better? There
> have been a number of changes since 1.6.0.6, although it looks like
> mostly dealing with better recovery from corrupted packs.
Testing right now, the above on the LAN setup was w/ current git HEAD.

> > For the initial clone, can the git-upload-pack algorithm please send
> > existing packs, and only generate a pack containing the non-packed
> > items?
>=20
> I believe that would require a change to the protocol to allow multiple
> packs. However, it may be possible to munge the pack header in such a
> way that you basically concatenate multiple packs. You would still want
> to peek in the big pack to try deltas from the non-packed items, though.
>=20
> I think all of this falls into the realm of the GSOC pack caching project.
> There have been other discussions on the list, so you might want to look
> through those for something useful.
Yes, both changing the protocol, and recognizing that existing packs may be
suitable to send could be considered as part of the caching project, as they
fall under the aegis of making good use of what's stored in the cache alrea=
dy
to send.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknZQPcACgkQPpIsIjIzwixOZQCePfNTnfWhTCBlIGi7pB5rNK94
rNcAnRsjaoWk7cWNFI/sVZGjSQzoEtYM
=yOD5
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
