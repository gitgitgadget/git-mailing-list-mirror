From: Robert Collins <robertc@robertcollins.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 09:05:12 +1000
Message-ID: <1161385512.13697.61.camel@localhost.localdomain>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
	 <200610201821.34712.jnareb@gmail.com>
	 <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
	 <Pine.LNX.4.64.0610201133260.3962@g5.osdl.org>
	 <1161382416.9241.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8DU4B3VxSq0WGpRYimJf"
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 01:05:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb3QY-0005Av-MC
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 01:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946457AbWJTXFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 19:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946475AbWJTXFS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 19:05:18 -0400
Received: from ipmail01.adl2.internode.on.net ([203.16.214.140]:40481 "EHLO
	ipmail01.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S1946457AbWJTXFR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 19:05:17 -0400
Received: from ppp245-86.static.internode.on.net (HELO lifelesswks.robertcollins.net) ([59.167.245.86])
  by ipmail01.adl2.internode.on.net with ESMTP; 21 Oct 2006 08:35:05 +0930
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAMzyOEU7p/VW/2dsb2JhbAA
X-IronPort-AV: i="4.09,336,1157293800"; 
   d="asc'?scan'208"; a="33054737:sNHT31793160"
Received: from [192.168.1.5] (helo=lifelesslap.robertcollins.net)
	by lifelesswks.robertcollins.net with esmtpa (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1Gb3QG-0003zF-Cg; Sat, 21 Oct 2006 09:05:04 +1000
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by lifelesslap.robertcollins.net with esmtp (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1Gb3QO-0003xy-Vp; Sat, 21 Oct 2006 09:05:13 +1000
To: Jeff Licquia <jeff@licquia.org>
In-Reply-To: <1161382416.9241.19.camel@localhost.localdomain>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29552>


--=-8DU4B3VxSq0WGpRYimJf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-10-20 at 18:13 -0400, Jeff Licquia wrote:
>=20
> All in all, not ideal, but it seems bzr handles this better than bk.
> Certainly, bzr doesn't silently drop anyone's changes, at least.  I
> suspect that bzr could improve its handling of this use case, but not,
> I'm sure, to Linus's specifications; some of the fun and games does
> seem to come from the use of file IDs.=20

We have a few features we're focusing on right now, but coming shortly
after them we hope to address parallel imports [which this is a case of]
better than we do now. I have a number of ideas, and I'm sure other devs
do too, about the right way to solve this. Fundamentally, I think using
1-1 mapped path ids [which can be considered a memo of the origin commit
id + path] of a path is not sufficiently rich a representation of what
happens to paths - there is a dual that you can convert to, which is
identity via ancestry traversal - each path has N <=3D M parent paths in
each of M parent revisions. Our current path ids can only represent the
case where when you traverse to the start of history this graph has a
single tail (that is, that a single file must start at one and only one
place). The graph however is not intrinsically limited in this way -
files can split and join, and we should be able to represent this more
fully.

I'll happily acknowledge that we dont need fileids per se: tracking
renames can be done without a memo of the origin.

However, I'm still convinced that tracking the user intention of renames
leads to a slicker system than renames via inference. My off the cuff
list of corner cases is:

 - change file, rename: rename the changed file/change the renamed file.
 - change file, remove: conflict on removal/text change
 - add path to dir, rename the dir: move the current contents of the
directory/add the new path to the renamed directory.
 - move paths out of a directory, rename the directory: leave the paths
moved out where they were moved to/move the paths from wherever their
new location is.
 - introduce path A + rename old A to B , change path A: change path
B/rename A to B and introduce the new A.

All these cases work roughly along the form of 'have two branches, do
one action in one, one in the other: merge other to one/merge one to
other'. I haven't yet seen an inference system get all these right.

There are other, more complex cases, but I think they all boil down to
one of those primitives to all intents and purposes.

Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-8DU4B3VxSq0WGpRYimJf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFOVYoM4BfeEKYx2ERAgGUAJ9jt4Xpa3j8bBEq0sOv+cpPH5RKpACgiKvQ
HApLNwOuIIP+CH4tYBZireU=
=DeUU
-----END PGP SIGNATURE-----

--=-8DU4B3VxSq0WGpRYimJf--
