From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 16:02:19 -0700
Message-ID: <20090405230219.GB31344@curie-int>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic> <20090405191703.GJ23521@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 01:03:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqbNe-0000c3-Sg
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 01:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbZDEXC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 19:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753625AbZDEXC1
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 19:02:27 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:58776 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753573AbZDEXC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 19:02:27 -0400
Received: (qmail 19795 invoked from network); 5 Apr 2009 23:02:21 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 05 Apr 2009 23:02:21 +0000
Received: (qmail 28458 invoked by uid 10000); 5 Apr 2009 16:02:19 -0700
Content-Disposition: inline
In-Reply-To: <20090405191703.GJ23521@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115732>


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2009 at 12:17:03PM -0700, Shawn O. Pearce wrote:
> Another option is to use rsync:// for initial clones.
>   git clone rsync://git.gentoo.org/tree.git
> rsync should be more efficient at dragging 1.6GiB over the network,
> as its only streaming the files.  But it may fall over if the server
> has a lot of loose objects; many more small files to create.
I just tried this, and ran into a segfault.

Original command:
# git clone rsync://git.overlays.gentoo.org/vcs-public-gitroot/exp/gentoo-x=
86.git

It looks at a glance like the linked list has a null value it hits during t=
he
internal while loop, not checking 'list' before using 'list->next'.

gdb> bt
#0  strcmp () at ../sysdeps/x86_64/strcmp.S:30
#1  0x000000000049474c in get_refs_via_rsync (transport=3D<value optimized =
out>, for_push=3D<value optimized out>) at transport.c:123
#2  0x000000000049234c in transport_get_remote_refs (transport=3D0x725fc9) =
at transport.c:1045
#3  0x000000000041620a in cmd_clone (argc=3D<value optimized out>, argv=3D0=
x7fff908c8550, prefix=3D<value optimized out>) at builtin-clone.c:487
#4  0x0000000000404f59 in handle_internal_command (argc=3D0x2, argv=3D0x7ff=
f908c8550) at git.c:244
#5  0x0000000000405167 in main (argc=3D0x2, argv=3D0x7fff908c8550) at git.c=
:434
gdb> up
#1  0x000000000049474c in get_refs_via_rsync (transport=3D<value optimized =
out>, for_push=3D<value optimized out>) at transport.c:123
123					(cmp =3D strcmp(buffer + 41,
gdb> print list
$1 =3D {nr =3D 0x0, alloc =3D 0x0, name =3D 0x0}

If I go into the repo thereafter and manually run git-fetch again, it does =
work
fine.

> One way around that would be to use two repositories on the server;
> a historical repository that is fully packed and contains the full
> history, and a bleeding edge repository that users would normally
> work against:
Yup, we've been considering similar. We do have one specific need with that
however: to prevent resource abuse, we would like to DENY the ability to do=
 the
initial clone with git:// then - just so that nobody tries to DoS our serve=
rs
by doing a couple of hungry initial clones at once.

> That caching GSoC project may help, but didn't I see earlier in
> this thread that you have >4.8 million objects in your repository?
> Any proposals on that project would still have Git malloc()'ing
> data per object; its ~80 bytes per object needed so that's a data
> segment of 384+ MiB, per concurrent clone client.
384MiB or even 512MiB I can cover. It's the 200+ wallclock minutes of cpu b=
urn
with no download that aren't acceptable.

P.S.
The -v output of the rsync-mode git-fetch is very devoid of output. Can we
maybe pipe the rsync progress back?


--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknZOHsACgkQPpIsIjIzwixMegCeMEfcMG8BLUy6A3+BNbmQTkt/
kIcAoMsCsmyKp5vcUuTdiwWAvH0m+vf9
=tbJT
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
