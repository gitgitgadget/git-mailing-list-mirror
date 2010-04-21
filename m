From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t1304,t2007: quell output to stdout and stderr
Date: Wed, 21 Apr 2010 16:53:20 +0200
Message-ID: <4BCF1160.6020304@drmicha.warpmail.net>
References: <00e68c9727f8dd3426db6f78d6b583a0dcec4d13.1271858119.git.git@drmicha.warpmail.net> <20100421144535.GA8481@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 16:56:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4bLs-0006y4-AR
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 16:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab0DUO40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 10:56:26 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48759 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755339Ab0DUO4Z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 10:56:25 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4F7B8EBEE9;
	Wed, 21 Apr 2010 10:56:25 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 21 Apr 2010 10:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3N3Ug2jJGUdyWwx/yuBkH3IKAHI=; b=lIntzAuNELAmrNWTTSn1PsnWyipkMgNPe1zV5fbPcrXHej0otIXoJMYxU+wyc7aLXfs76TljyalboFyOGa7b6XmaH1W5qCuWZUskaBA7mLDTw0wXfiZV5Z+6K5k2fnYQZZVTcw5Z18jCkXqCCzijx2Zd1AHkQWmkthLC00b0IEE=
X-Sasl-enc: 6le1M745xb0RcgXa14lC3/aWB8wiYVhSl9pcZ2rMo9BI 1271861785
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9A29835D79;
	Wed, 21 Apr 2010 10:56:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100421144535.GA8481@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145436>

Jonathan Nieder venit, vidit, dixit 21.04.2010 16:45:
> Hi Michael,
>=20
> Michael J Gruber wrote:
>=20
>> --- a/t/t1304-default-acl.sh
>> +++ b/t/t1304-default-acl.sh
>> @@ -15,7 +15,7 @@ umask 077
>>  # is a good candidate: exists on all unices, and it has permission
>>  # anyway, so we don't create a security hole running the testsuite.
>> =20
>> -if ! setfacl -m u:root:rwx .; then
>> +if ! setfacl -m u:root:rwx . 2>/dev/null; then
>>      say "Skipping ACL tests: unable to use setfacl"
>>      test_done
>>  fi
> [and a similar suppression of =E2=80=98git checkout=E2=80=99 output]
>=20
> In the spirit of commit 4a45f7d (Use test_expect_success for test
> setups, 2010-03-20), might it make sense to turn these into tests?

In principle yes, of course, I've done this in other cases. But note
that here, on both occasions, the test script wants to exit if
prerequisites are not met. I don't think it's OK to exit or test_done
from within test_expect_something, is it?

> I am imagining something like this.
>=20
> diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
> index b26d2e8..8b3ff7a 100755
> --- a/t/t1304-default-acl.sh
> +++ b/t/t1304-default-acl.sh
> @@ -15,7 +15,15 @@ umask 077
>  # is a good candidate: exists on all unices, and it has permission
>  # anyway, so we don't create a security hole running the testsuite.
> =20
> -if ! setfacl -m u:root:rwx . 2>/dev/null; then
> +test_expect_success 'Setup: try to set an ACL' '
> +	if setfacl -m u:root:rwx .
> +	then
> +		test_set_prereq ACL
> +	fi
> +'
> +
> +if ! test_have_prereq ACL
> +then
>      say "Skipping ACL tests: unable to use setfacl"
>      test_done
>  fi
> diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.s=
h
> index fc5db05..f8f40e5 100755
> --- a/t/t2007-checkout-symlink.sh
> +++ b/t/t2007-checkout-symlink.sh
> @@ -44,11 +44,12 @@ test_expect_success 'switch from symlink to dir' =
'
> =20
>  '
> =20
> -rm -fr frotz xyzzy nitfol &&
> -git checkout -q -f master || exit
> -
>  test_expect_success 'switch from dir to symlink' '
> =20
> +	rm -fr frotz xyzzy nitfol &&
> +	git rm -fr . &&
> +	git checkout -f master &&
> +
>  	git checkout side
> =20
>  '
