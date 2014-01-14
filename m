From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: exception when cloning a perforce repository
Date: Mon, 13 Jan 2014 19:18:20 -0500
Message-ID: <20140114001820.GA12058@padd.com>
References: <01EF41A4-533B-4A24-8952-CAEB49970272@iwi.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexandru Juncu <alexj@rosedu.org>
To: Damien =?iso-8859-1?Q?G=E9rard?= <damien@iwi.me>
X-From: git-owner@vger.kernel.org Tue Jan 14 01:18:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2riB-0001l9-9j
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 01:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbaANAS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jan 2014 19:18:28 -0500
Received: from honk.padd.com ([74.3.171.149]:56185 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbaANAS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 19:18:27 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 1C34370F4;
	Mon, 13 Jan 2014 16:18:26 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C0CCD20077; Mon, 13 Jan 2014 19:18:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <01EF41A4-533B-4A24-8952-CAEB49970272@iwi.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240381>

damien@iwi.me wrote on Mon, 13 Jan 2014 14:37 +0100:
> I am trying to clone a perforce repository via git and I am having th=
e following backtrace :
>=20
> {14:20}~/projects/####:master =E2=9C=97 =E2=9E=AD git p4 clone //depo=
t/@all .
> Importing revision =E2=80=A6
> [...]
> Importing revision 59702 (45%)Traceback (most recent call last):
[..]
>   File "/opt/git/libexec/git-core/git-p4", line 2078, in streamOneP4F=
ile
>     if data[-1] =3D=3D '\n':
> IndexError: string index out of range
>=20
> git =E2=80=94version: git version 1.8.5.2.309.ga25014b [last commit f=
rom master from github.com/git/git]
> os : ubuntu 13.10

This code:

        if type_base =3D=3D "symlink":
            git_mode =3D "120000"
            # p4 print on a symlink sometimes contains "target\n";
            # if it does, remove the newline
            data =3D ''.join(contents)
  =3D=3D>       if data[-1] =3D=3D '\n':
                contents =3D [data[:-1]]
            else:
                contents =3D [data]

means that data is an empty string.  Implies you've got a
symlink pointing to nothing.  Is that even possible?

It could be this is a regression introduced at 1292df1 (git-p4:
=46ix occasional truncation of symlink contents., 2013-08-08).  The
old way of doing data[:-1] unconditionally would have worked but
was broken for other reasons.

Could you investigate the symlink a bit?  We're looking for
one in change 59702 that points to nowhere.  Maybe do:

    $ p4 describe -s 59702

and see if you can figure out which of those could be a symlink, then
inspect it:

    $ p4 fstat //depot/symlink@59702
    (probably shows it is "headRev 1")

    $ p4 print -q //depot/symlink#1

    $ p4 print -q //depot/symlink#1 | od -c

Thanks for checking this depot info first.

		-- Pete
