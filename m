Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28571F597
	for <e@80x24.org>; Fri,  3 Aug 2018 13:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeHCPoN (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 11:44:13 -0400
Received: from mail.nic.cz ([217.31.204.67]:58768 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeHCPoN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 11:44:13 -0400
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Aug 2018 11:44:12 EDT
Received: from localhost (unknown [IPv6:2001:1488:fffe:6008:78e5:96e4:5a5a:22c1])
        by mail.nic.cz (Postfix) with ESMTPSA id 305F7624C1;
        Fri,  3 Aug 2018 15:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1533303533; bh=k2FISH23zZ9w8CZjT3koiP4kPldZxMCcglRcCVCvAQ8=;
        h=Date:From:To;
        b=Oo8N3h92IrR/ePAa+ExpgtEqS04CPKobA9vGp+stAPTlW7LXzzJLbD7G9mBHql9Ib
         ZYfiSLNksSQJy8WXq016YzHhhlSCePOvwRFk/h8oQ0Bb+0ozIZJpjWWm7zPyaxvpkk
         D+gB+rsSKvpKZZzvhX71JWkMfGbUsJjTRkIZ/raE=
Date:   Fri, 3 Aug 2018 15:36:30 +0200
From:   Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180803133630.32oxubwttealvhxk@work-pc>
References: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
 <20180801001942.GC45452@genre.crustytoothpaste.net>
 <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uozw34giqrg754ph"
Content-Disposition: inline
In-Reply-To: <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uozw34giqrg754ph
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2018 at 08:25:47PM -0400, Santiago Torres wrote:
> On Wed, Aug 01, 2018 at 12:19:42AM +0000, brian m. carlson wrote:
> > On Tue, Jul 31, 2018 at 10:05:22PM +0200, Vojtech Myslivec wrote:
> > > Hello,
> > >=20
> > > me and my colleague are struggling with automation of verifying git
> > > repositories and we have encountered that git verify-commit and
> > > verify-tag accepts untrusted signatures and exit successfully.
> >=20
> > I don't have strong feelings on your change one way or the other, but
> > for automation it may be useful to use the --raw flag, which gives you
> > the raw gpg output and much greater control.  For example, you can
> > require that a subkey is or is not used or require certain algorithms.
> >=20
> > I will say that most signatures are untrusted in my experience, so
> > unless people are using TOFU mode or making local signatures, git will
> > exit nonzero for most signatures.  I think the current status is to exit
> > on a good signature, even if it isn't necessarily a valid signature.
> >=20
> > I'm interested to hear others' thoughts on this.
>=20
> I'd find it odd that we deviate from the gpg behavior, that returns 0
> when verifyng an untrusted signatures. Tooling around gpg is generally
> difficult for this reason, but using the raw output should be enough to
> discard signatures with untrusted keys.
>=20
> Another alternative is to use a keyring with trusted keys *only* and
> disable fetching keys from hkp servers. This way signature verification
> should fail.
>=20
> Thanks,
> -Santiago.

This is not a deviation. GPG correctly recognizes difference between truste=
d,
untrusted and unknown levels. git on the other hand does not. Well it did u=
ntil
the commit a4cc18f29. That one removed GPG exit code propagation.

I think that core of the problem is that git considers both 'TRUST_NEVER' a=
nd
'TRUST_UNDEFINED' as being the same. In git they both should result in erro=
r or at
lest 'TRUST_NEVER' should (the same way as it does with just GPG).

There is an illustration of difference of untrusted and unknown key verific=
ation
at the end of this mail. You can test it just by using your own GPG key (ju=
st use
our fingerprint instead).

My and my colleague's expectations are that 'git verify-commit branch' would
handle the commit on the tip of `branch` the  same way as 'git merge
--verify-signature branch'.

It is also confusing that untrusted key is ok but expired or missing one re=
sults
in error. GPG's primary usage is for building web of trust. And I think that
untrusted keys are more problematic in that sense than expired ones.


I also disagree with idea that using --raw should be only way how to check =
if we
trust a key. It is handy in scripts for sure if some additional info about
signature is required but I think that it should not be primary way to chec=
k for
signature validity. Exit code should serve that purpose the same way as in =
case of
GPG itself.

Small example would be that to replace current GPG behavior in portable way
(shells such as dash or ash) it is required to do at least this:

set -e
RES=3D"$(git verify-tag --raw v1.1 2>&1)"
! echo "$RES" | grep -q "^\[GNUPG:\] TRUST_NEVER"

And that will for sure get more complicated when I use other trust levels a=
nd/or
trust database and different trust model but direct.

Overall I thing that deviation from returning GPG exit code was not the bes=
t and I
don't understand why it was done. Decision if signature validity is reporte=
d as
error should be on GPG not on git specially when there is almost no configu=
ration
possibility for GPG in git.

Note that our proposed change is conservative and drawn as a unification of
behavior of pull/merge and verify-*. To make it really optimal for automati=
on it
would be best to return exit code of GPG command.

With regards
Karel Ko=C4=8D=C3=AD


Illustration of difference between unknown and untrusted key:

$ gpg --sign file
$ mkdir -m 700 gpgt
$ export GNUPGHOME=3D$PWD/gpgt
$ echo 'trust-model:0:"direct' | gpgconfg --change-options gpg
$ gpg --recv-keys 2B1F70F95F1B48DA2265A7FAA6BC8B8CEB31659B
$ gpg --list-key
/home/cynerd/gpgt/pubring.kbx
-----------------------------
pub   rsa2048 2016-07-07 [SC]
      2B1F70F95F1B48DA2265A7FAA6BC8B8CEB31659B
uid           [ unknown] Karel Ko=C4=8D=C3=AD (nic.cz) <karel.koci@nic.cz>
uid           [ unknown] Karel Ko=C4=8D=C3=AD (cynerd.cz) <cynerd@email.cz>
uid           [ unknown] Karel Ko=C4=8D=C3=AD (sh.cvut.cz) <k.koci@sh.cvut.=
cz>
uid           [ unknown] Karel Ko=C4=8D=C3=AD (fel.cvut.cz) <kocikare@fel.c=
vut.cz>
sub   rsa2048 2016-07-07 [E]
sub   rsa4096 2016-09-27 [S]
$ gpg --verify file.gpg
gpg: Signature made Fri 03 Aug 2018 02:01:49 PM CEST
gpg:                using RSA key 46D715A0ED0E0C433CBF5963D83BD732AC2BD828
gpg:                issuer "karel.koci@nic.cz"
gpg: Good signature from "Karel Ko=C4=8D=C3=AD (nic.cz) <karel.koci@nic.cz>=
" [marginal]
gpg:                 aka "Karel Ko=C4=8D=C3=AD (cynerd.cz) <cynerd@email.cz=
>" [marginal]
gpg:                 aka "Karel Ko=C4=8D=C3=AD (sh.cvut.cz) <k.koci@sh.cvut=
=2Ecz>" [marginal]
gpg:                 aka "Karel Ko=C4=8D=C3=AD (fel.cvut.cz) <kocikare@fel.=
cvut.cz>" [marginal]
gpg: WARNING: This key is not certified with sufficiently trusted signature=
s!
gpg:          It is not certain that the signature belongs to the owner.
$ echo $?
0
$ echo "2B1F70F95F1B48DA2265A7FAA6BC8B8CEB31659B:4:" | gpg --import-ownertr=
ust
$ gpg --list-key
/home/cynerd/gpgt/pubring.kbx
-----------------------------
pub   rsa2048 2016-07-07 [SC]
      2B1F70F95F1B48DA2265A7FAA6BC8B8CEB31659B
uid           [  never ] Karel Ko=C4=8D=C3=AD (nic.cz) <karel.koci@nic.cz>
uid           [  never ] Karel Ko=C4=8D=C3=AD (cynerd.cz) <cynerd@email.cz>
uid           [  never ] Karel Ko=C4=8D=C3=AD (sh.cvut.cz) <k.koci@sh.cvut.=
cz>
uid           [  never ] Karel Ko=C4=8D=C3=AD (fel.cvut.cz) <kocikare@fel.c=
vut.cz>
sub   rsa2048 2016-07-07 [E]
sub   rsa4096 2016-09-27 [S]
$ gpg --verify file.gpg
gpg: WARNING: unsafe permissions on homedir '/home/cynerd/gpgt'
gpg: Signature made Fri 03 Aug 2018 02:01:49 PM CEST
gpg:                using RSA key 46D715A0ED0E0C433CBF5963D83BD732AC2BD828
gpg:                issuer "karel.koci@nic.cz"
gpg: Good signature from "Karel Ko=C4=8D=C3=AD (nic.cz) <karel.koci@nic.cz>=
" [never]
gpg:                 aka "Karel Ko=C4=8D=C3=AD (cynerd.cz) <cynerd@email.cz=
>" [never]
gpg:                 aka "Karel Ko=C4=8D=C3=AD (sh.cvut.cz) <k.koci@sh.cvut=
=2Ecz>" [never]
gpg:                 aka "Karel Ko=C4=8D=C3=AD (fel.cvut.cz) <kocikare@fel.=
cvut.cz>" [never]
gpg: WARNING: We do NOT trust this key!
gpg:          The signature is probably a FORGERY.
$ echo $?
1

--uozw34giqrg754ph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERtcVoO0ODEM8v1lj2DvXMqwr2CgFAltkWl4ACgkQ2DvXMqwr
2ChldA/8C3cyvIubm9R6kcj5jRXlioe2GR2BWnkQ9FXzdJsQHe6pTmO5xIsP8rWR
8QLeY8dsEvNmAzJj8siRyrNfcrT2ytegl87gIPk1IEp4W1IG29bmUQcJh9zQy+99
JvwCFYdn1rFhl16YPwd5VjZBpPuWY+xQ170OoTduD6I7TBIlExEilnzT8PLv2t0q
fgSbAIjZ0G7c/ptxyN4UZ/ouEi+oLGnPLNf2gtADQYBR2gL5T8TItxRU0cuPwaK9
4gzGqCRc5KVIW6RkG1tPqiVrTm5I0Rp8K8FnTSQzvsSU0sRfBl0AOSIyDRfon0T3
3LZhQcr54Kv7FsnTTsNGO0DvEgO+wp2qXLK9J/+h576SS1TMdHtYjGk2mtjP9Aof
co7B5G+W0l8C0MdD11cLj5Phf1ALNvVi6fVXbg71EBRwSaWNtyYvwvtm81w8Ocgm
yfVeFnIqs03jjPXjuyR9ASmDuPy09Y6bxB9gHSyvK7RrLWgsIjPiXB2yeti0NqQA
TtX/4CN3UpiZcdCUl87kWwP+03iz4zUDN8uMAiBMIgLtNQxoyHIv34upMQrTNfLH
OUp7gtYHL+W+zpaDTorzm/9qHudJONUNZ3EDtKjoZyvANPXQTokT+R13GH+hX+mI
sO/ANewM5rO5pq070IdG5QD0NUvRw2l8UVBQN0dKPGJm3e1p7ro=
=Pdvj
-----END PGP SIGNATURE-----

--uozw34giqrg754ph--
