From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] filter-branch: strip pgp signature in commit messages
Date: Thu, 8 Oct 2015 10:15:48 +0200
Message-ID: <56162634.2010800@drmicha.warpmail.net>
References: <20151008050122.GA21369@freya.jamessan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>
To: James McCoy <vega.james@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 10:17:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk6Mq-0006PB-NM
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 10:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbbJHIPz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2015 04:15:55 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50219 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458AbbJHIPv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 04:15:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 1AADF205E8
	for <git@vger.kernel.org>; Thu,  8 Oct 2015 04:15:51 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 08 Oct 2015 04:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=NfTPSrt+UGPKjiKxgBKCk2mDZS8=; b=S8YtpC
	jkQ223dtvw8r82L90+e1rpn/LP2JsIMP7D8eI6onkoYIstCqpYgw/HL2m7mQXkIm
	FjRlcpbJuGO/KV6Mt/EK7JsLpbkJwxBhDrvYFHCAN3eRts4sD13lj7NdErx4o0Jh
	XHxFVHLxpEwz8dEFcaNu/Q8OAJ08RKSWdw3a0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=NfTPSrt+UGPKjiK
	xgBKCk2mDZS8=; b=b32hVwRDcLjTYU+Iv01uKEoL/jFuUjVXpDQuxxM9V33SCA1
	7G94ZrIW+fB1Tvfj8hGikU/XVsODvnpV9w3DwGFvVYk5eqVeSiTB0SmFZtHFqMkd
	DjkoGSZwJJugb5VHuGiMoUeDTb+163rhOS9CuPi7j4ZF0LBmj+QchTc2cIfQ=
X-Sasl-enc: 9IDhKBjD10bvpzhsyTe2usQZTZQIIBJjCldAXmOTreep 1444292150
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6C6C5C0001A;
	Thu,  8 Oct 2015 04:15:49 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151008050122.GA21369@freya.jamessan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279222>

James McCoy venit, vidit, dixit 08.10.2015 07:01:
> df062010 (filter-branch: avoid passing commit message through sed)
> introduced a regression when filtering gpg signed commits.  The gpgsi=
g
> header is multi-line and contains an empty line.  Although the signat=
ure
> is indented, making the line a whitespace only line, this still resul=
ts
> in $header_line being empty, causing the =E2=80=9Cskip header lines=E2=
=80=9D loop to
> exit.
>=20
> The rest of the commit object is then re-used as the rewritten commit
> message, causing the new message to include the signature of the
> original commit.

I had to wrap my head around that commit message quite a bit and ended
up testing the issue myself. So the catch is:

df062010 (filter-branch: avoid passing commit message through sed)
introduced a regression when filtering gpg signed commits. As a
consequence, "filter-branch --msg-filter cat" (which should leave the
commit message unchanged) spills the signature (without the BEGIN line,
but with the END line) into (in front of) the original commit message.

The reason is that although...

=2E.. original commit.

=46ix this by keeping track of the in/out-of signature state when parsi=
ng
the header lines.


[No, this does not alleviate my dislike for the commit signature
implementation, and I have not checked the patch - the test looks good
to me, though.]

> Signed-off-by: James McCoy <vega.james@gmail.com>
> ---
>  git-filter-branch.sh     | 14 +++++++++++---
>  t/t7003-filter-branch.sh | 14 ++++++++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 5b3f63d..dd49b13 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -347,10 +347,18 @@ while read commit parents; do
>  	fi
> =20
>  	{
> -		while read -r header_line && test -n "$header_line"
> +		while read -r header_line &&
> +			( test -n "$header_line" || test -n "$gpg_signature" )
>  		do
> -			# skip header lines...
> -			:;
> +			# skip header lines... but track whether we are in a
> +			# PGP signature, since it will have a whitespace only
> +			# line which causes $header_line to be empty
> +			if [ "${header_line#gpgsig}" !=3D "$header_line" ]; then
> +				gpg_signature=3D1
> +			elif test -n "$gpg_signature" &&
> +				expr "$header_line" : ".*END PGP" >/dev/null; then
> +				gpg_signature=3D
> +			fi
>  		done
>  		# and output the actual commit message
>  		cat
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 855afda..377c648 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -2,6 +2,7 @@
> =20
>  test_description=3D'git filter-branch'
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-gpg.sh"
> =20
>  test_expect_success 'setup' '
>  	test_commit A &&
> @@ -292,6 +293,19 @@ test_expect_success 'Tag name filtering strips g=
pg signature' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success GPG 'Filtering retains message of gpg signed com=
mit' '
> +	mkdir gpg &&
> +	touch gpg/foo &&
> +	git add gpg &&
> +	test_tick &&
> +	git commit -S -m "Adding gpg" &&
> +
> +	git log -1 --format=3D"%s" > expect &&
> +	git filter-branch -f --msg-filter "cat" &&
> +	git log -1 --format=3D"%s" > actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'Tag name filtering allows slashes in tag names'=
 '
>  	git tag -m tag-with-slash X/1 &&
>  	git cat-file tag X/1 | sed -e s,X/1,X/2, > expect &&
>=20
