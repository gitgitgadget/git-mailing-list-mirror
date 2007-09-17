From: martin f krafft <madduck@madduck.net>
Subject: Re: metastore
Date: Mon, 17 Sep 2007 15:30:00 +0200
Message-ID: <20070917133000.GD16773@lapse.madduck.net>
References: <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site> <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <7vwsur590q.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709161054380.5298@iabervon.org> <Pine.LNX.4.64.0709161346150.24221@asgard.lang.hm> <Pine.LNX.4.64.0709161715090.5298@iabervon.org> <Pine.LNX.4.64.0709161507130.24221@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Cc: david@lang.hm, Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 18:49:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXJmw-00035O-TD
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 18:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbXIQQt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 12:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXIQQt1
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 12:49:27 -0400
Received: from clegg.madduck.net ([82.197.162.59]:48382 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbXIQQt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 12:49:26 -0400
Received: from lapse.madduck.net (unknown [78.16.99.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 90DDDBA459;
	Mon, 17 Sep 2007 18:48:51 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 3B04B4FD3D; Mon, 17 Sep 2007 15:29:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709161507130.24221@asgard.lang.hm>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4310/Mon Sep 17 14:47:06 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58463>


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach david@lang.hm <david@lang.hm> [2007.09.17.0037 +0200]:
>> While we're at it, you probably don't even want to write the
>> permission file to the live filesystem. It's just one more thing
>> that could leak information, and changes to the permissions of
>> files that you record by committing the live filesystem would
>> presumably be done by changing the permissions of files in the
>> filesystem, not by changing the text file.
>
> the permissions and ACL's can be queried directly from the
> filesystem, so I don't see any security problems with writing the
> permission file to the filesystem.
>
> changing the permissions would be done by changing the files
> themselves (when you are running as root on a filesystem that
> supports the changes, otherwise it would need to fall back to
> writing the file and getting the changes there, but that should be
> able to be a local config option)
>
> I don't like the idea of having a file that doesn't appear on the
> local filesystem at any point, it just makes troubleshooting too
> hard.

Reading over your thoughts, I get this uneasy feeling about such
a permissions file, because it stores redundant information, and
redundant information has a tendency to get out of sync. If we
cannot attach attributes to objects in the git database, then
I understand the need for such a metastore. But I don't think it
should be checked out and visible, or maybe we should think of it
not in terms of a file anyway, but a metastore. Or how do you want
to resolve the situation when a user might edit the file, changing
a mode from 644 to 640, while in the filesystem, it was changed by
other means to 600.

=2Egitattributes is a different story since it stores git-specificy
attributes, which are present nowhere else in the checkout.

I still maintain it would be best if git allowed extra data to be
attached to object nodes. When you start thinking about
cherry-picking or even simple merges, I think that makes most sense.
And we don't need conflict markers, we could employ an iterative
merge process as e.g. git-rebase uses:

  "a conflict has been found in the file mode of ...
   ... 2750 vs. 2755 ...
   please set the file mode as it should be and do git-merge
   --continue. Or git-merge --abort. ..."

>> (Of course, you could check out the same commits as ordinary source, with
>> developer-owned 644 files and a 644 "permissions" file, and there you'd
>> have the permissions file appear in the work tree, and you could edit it
>> and check it in in a totally mundane way.)
>
> right, and the same thing if the filesystem doesn't support something in =
the=20
> permission file.

I'd much rather see something like `git-attr chmod 644
file-in-index` to make this change, rather than a file, which
introduces the potential for syntax errors.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"to me, vi is zen. to use vi is to practice zen. every command is
 a koan. profound to the user, unintelligible to the uninitiated.
 you discover truth everytime you use it."
                                       -- reddy =E4t lion.austin.ibm.com
=20
spamtraps: madduck.bogus@madduck.net

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG7oFYIgvIgzMMSnURAkbkAKDQMJWNsp78Vs3Pu8LKtSvj0OHuxgCfXdoJ
npVIpQbPtfUaynz0htrPdPc=
=wXjX
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
