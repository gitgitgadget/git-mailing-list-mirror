From: =?utf-8?Q?Damien_G=C3=A9rard?= <damien@iwi.me>
Subject: Re: git-p4: exception when cloning a perforce repository
Date: Wed, 15 Jan 2014 09:56:13 +0100
Message-ID: <843E4B24-5EDD-4451-8849-425160576A99@iwi.me>
References: <01EF41A4-533B-4A24-8952-CAEB49970272@iwi.me> <20140114001820.GA12058@padd.com> <20140114232432.GA31465@padd.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexandru Juncu <alexj@rosedu.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 09:56:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3MGs-0002Dp-UE
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 09:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbaAOI4U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jan 2014 03:56:20 -0500
Received: from catkin.iwi.me ([91.121.49.159]:55631 "EHLO catkin.iwi.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbaAOI4S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 03:56:18 -0500
Received: from imac-de-admin.private.4d.fr (unknown [194.98.194.79])
	(Authenticated sender: damien@iwi.me)
	by catkin.iwi.me (Postfix) with ESMTPSA id 114C1A2D8B;
	Wed, 15 Jan 2014 09:56:15 +0100 (CET)
In-Reply-To: <20140114232432.GA31465@padd.com>
X-Mailer: Apple Mail (2.1827)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240444>


On 15 Jan 2014, at 00:24, Pete Wyckoff <pw@padd.com> wrote:

> pw@padd.com wrote on Mon, 13 Jan 2014 19:18 -0500:
>> damien@iwi.me wrote on Mon, 13 Jan 2014 14:37 +0100:
>>> I am trying to clone a perforce repository via git and I am having =
the following backtrace :
>>>=20
>>> {14:20}~/projects/####:master =E2=9C=97 =E2=9E=AD git p4 clone //de=
pot/@all .
>>> Importing revision =E2=80=A6
>>> [...]
>>> Importing revision 59702 (45%)Traceback (most recent call last):
>> [..]
>>>  File "/opt/git/libexec/git-core/git-p4", line 2078, in streamOneP4=
=46ile
>>>    if data[-1] =3D=3D '\n':
>>> IndexError: string index out of range
>>>=20
>>> git =E2=80=94version: git version 1.8.5.2.309.ga25014b [last commit=
 from master from github.com/git/git]
>>> os : ubuntu 13.10
>>=20
>> This code:
>>=20
>>        if type_base =3D=3D "symlink":
>>            git_mode =3D "120000"
>>            # p4 print on a symlink sometimes contains "target\n";
>>            # if it does, remove the newline
>>            data =3D ''.join(contents)
>>  =3D=3D>       if data[-1] =3D=3D '\n':
>>                contents =3D [data[:-1]]
>>            else:
>>                contents =3D [data]
>>=20
>> means that data is an empty string.  Implies you've got a
>> symlink pointing to nothing.  Is that even possible?

It does not seem so but I am so sure.


>> It could be this is a regression introduced at 1292df1 (git-p4:
>> Fix occasional truncation of symlink contents., 2013-08-08).  The
>> old way of doing data[:-1] unconditionally would have worked but
>> was broken for other reasons.
>>=20
>> Could you investigate the symlink a bit?  We're looking for
>> one in change 59702 that points to nowhere.  Maybe do:
>>=20
>>    $ p4 describe -s 59702
>>=20
>> and see if you can figure out which of those could be a symlink, the=
n
>> inspect it:
>>=20
>>    $ p4 fstat //depot/symlink@59702
>>    (probably shows it is "headRev 1")
>>=20
>>    $ p4 print -q //depot/symlink#1
>>=20
>>    $ p4 print -q //depot/symlink#1 | od -c
>>=20
>> Thanks for checking this depot info first.
>=20
> I've tried to hack a test that produces a null symlink,
> and having done so, find an error later on trying to
> generate a symlink that points to "".  So the "easy"
> fix of checking for an empty string is unlikely to work
> for your repo.
>=20
> Curious as to how you managed to generate such a thing.
> If you find the file, and can get at the p4 depot, the
> full ,v file would be interesting too.
>=20



Indeed, those files are symlinks actually.  But it sems they are all va=
lid.


Here is what I can get :

Change 59702 by ##############@VS9 on 2009/03/24 15:53:39

	OpenSSL 0.9.8j

Affected files ...

=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/aes.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/asn1.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/asn1_mac.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/asn1t.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/bio.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/blowfish.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/buffer.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/cast.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/comp.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/conf.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/conf_api.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/crypto.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/des.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/des_old.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/dh.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/dsa.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/dso.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/dtls1.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/e_os2.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ebcdic.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ec.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ecdh.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ecdsa.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/engine.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/err.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/evp.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/fips.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/fips_rand.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/hmac.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/idea.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/krb5_asn.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/kssl.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/lhash.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/md2.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/md4.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/md5.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/obj_mac.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/objects.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ocsp.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/opensslconf.h#2 ed=
it
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/opensslv.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ossl_typ.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/pem.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/pem2.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/pkcs12.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/pkcs7.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/pq_compat.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/pqueue.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/rand.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/rc2.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/rc4.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ripemd.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/rsa.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/safestack.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/sha.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ssl.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ssl2.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ssl23.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ssl3.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/stack.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/store.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/symhacks.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/tls1.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/tmdiff.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/txt_db.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ui.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/ui_compat.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/x509.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/x509_vfy.h#2 edit
=2E.. //depot/openssl/0.9.8j/openssl/include/openssl/x509v3.h#2 edit


Just in case :

$ p4 describe -s 59700
59700 - no such changelist.


p4 fstat  //depot/openssl/0.9.8j/openssl/include/openssl/bn.h@59702=20
=2E.. depotFile //depot/openssl/0.9.8j/openssl/include/openssl/bn.h
=2E.. headAction edit
=2E.. headType symlink
=2E.. headTime 1237906419
=2E.. headRev 2
=2E.. headChange 59702
=2E.. headModTime 1231329423


p4 print -q //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#2 | od =
-c
0000000

p4 print  //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#1       =20
//depot/openssl/0.9.8j/openssl/include/openssl/bn.h#1 - add change 5957=
4 (text)

 p4 print  //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#2
//depot/openssl/0.9.8j/openssl/include/openssl/bn.h#2 - edit change 597=
02 (symlink)
