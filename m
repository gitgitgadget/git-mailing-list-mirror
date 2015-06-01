From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: git gc gives "error: Could not read..."
Date: Mon, 1 Jun 2015 11:14:27 +0200
Message-ID: <556C2273.4030405@atlas-elektronik.com>
References: <556C0BAD.80106@atlas-elektronik.com> <20150601081450.GA32634@peff.net> <556C1A95.9010704@atlas-elektronik.com> <20150601085226.GA20537@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 11:14:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzLo3-0007Jk-2Q
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 11:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbbFAJOm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 05:14:42 -0400
Received: from mail96.atlas.de ([194.156.172.86]:29409 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbbFAJOk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 05:14:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 272AA10139;
	Mon,  1 Jun 2015 11:14:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jj1XeC8Xjdhe; Mon,  1 Jun 2015 11:14:28 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Mon,  1 Jun 2015 11:14:28 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 13E9627169;
	Mon,  1 Jun 2015 11:14:28 +0200 (CEST)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server id 8.3.327.1; Mon, 1 Jun 2015
 11:14:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150601085226.GA20537@peff.net>
OpenPGP: id=2DF5E01B09C37501BCA99666829B49C5922127AF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270383>

Am 01.06.2015 um 10:52 schrieb Jeff King:
> On Mon, Jun 01, 2015 at 10:40:53AM +0200, Stefan N=C3=A4we wrote:
>=20
>> Turns out to be a tree:
>>
>> tree 7713c3b1e9ea2dd9126244697389e4000bb39d85
>> parent d7acfc22fbc0fba467d82f41c90aab7d61f8d751
>> author Stefan Naewe <stefan.naewe@atlas-elektronik.com> 1429536806 +=
0200
>> committer Stefan Naewe <stefan.naewe@atlas-elektronik.com> 142953680=
6 +0200
>=20
> Yeah, I bungled the grep earlier. That message can come from a missin=
g
> tag, tree, or commit object. But I think the root cause is the same.

Maybe this one:

   d3038d (prune: keep objects reachable from recent objects)

??
That's what 'git bisect' told me.

>> Not exactly. My msysgit is merge-rebase'd (or rebase-merge'd...) ont=
o v2.2.0...
>> I'll try older versions (pre v2.2.0) on linux.
>=20
> OK, that makes more sense then.
>=20
>> I also cloned from local filesystem (widnows drive) to a samba share=
=2E
>=20
> And that, too.
>=20
> I've managed to create a small test case that replicates the problem:
>=20
> diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
> index 157f3f9..015b0da 100755
> --- a/t/t6501-freshen-objects.sh
> +++ b/t/t6501-freshen-objects.sh
> @@ -129,4 +129,19 @@ for repack in '' true; do
>  	'
>  done
> =20
> +test_expect_failure 'do not complain about existing broken links' '
> +	cat >broken-commit <<-\EOF &&
> +	tree 0000000000000000000000000000000000000001
> +	parent 0000000000000000000000000000000000000002
> +	author whatever <whatever@example.com> 1234 -0000
> +	committer whatever <whatever@example.com> 1234 -0000
> +
> +	some message
> +	EOF
> +	commit=3D$(git hash-object -t commit -w broken-commit) &&
> +	git gc 2>stderr &&
> +	verbose git cat-file -e $commit &&
> +	test_must_be_empty stderr
> +'
> +
>  test_done
>=20
> which produces:
>=20
>   'stderr' is not empty, it contains:
>   error: Could not read 0000000000000000000000000000000000000002
>   error: Could not read 0000000000000000000000000000000000000001
>   error: Could not read 0000000000000000000000000000000000000002
>   error: Could not read 0000000000000000000000000000000000000001
>=20
> Unfortunately the fix is a little bit invasive. I'll send something o=
ut
> in a few minutes.

It would be really helpful if you sent the patch as an attachment.
I know that's not the normal wokflow but our mail server garbles every
message so that I can't (or don't know how to...) use 'git am' to test
the patch, which I'm willing to do!

Thanks,
  Stefan
--=20
----------------------------------------------------------------
/dev/random says: The cost of feathers has risen... Now even DOWN is up=
!
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"=20
GPG Key fingerprint =3D 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 2=
7AF
