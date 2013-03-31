From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: Re: [PATCH v7 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 17:21:53 +0200
Message-ID: <51585491.1070604@physik.tu-berlin.de>
References: <20130331133332.GD2286@serenity.lan> <cover.1364738348.git.jaseg@physik-pool.tu-berlin.de> <51584955.40007@physik.tu-berlin.de> <20130331144452.GF2286@serenity.lan> <87mwtjwqzz.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 17:22:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMK5s-0001Eq-3P
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 17:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556Ab3CaPWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 11:22:14 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:2757 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518Ab3CaPWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 11:22:13 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1UMK5A-00014G-FA; Sun, 31 Mar 2013 17:22:12 +0200
Received: from [94.45.250.108] (unknown [94.45.250.108])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id D2ADE11403;
	Sun, 31 Mar 2013 17:22:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <87mwtjwqzz.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219630>

On 03/31/2013 05:03 PM, Thomas Rast wrote:
> John Keeping <john@keeping.me.uk> writes:
>=20
>> On Sun, Mar 31, 2013 at 04:33:57PM +0200, Sebastian G=C3=B6tte wrote=
:
>>> diff --git a/commit.c b/commit.c
>>> index eda7f90..bb2d9ad 100644
>>> --- a/commit.c
>>> +++ b/commit.c
>>> @@ -1029,6 +1029,8 @@ static struct {
>>>  } sigcheck_gpg_status[] =3D {
>>>  	{ 'G', "[GNUPG:] GOODSIG " },
>>>  	{ 'B', "[GNUPG:] BADSIG " },
>>> +	{ 'U', "[GNUPG:] TRUST_NEVER" },
>>> +	{ 'U', "[GNUPG:] TRUST_UNDEFINED" },
>>>  };
>>> =20
>>>  static void parse_gpg_output(struct signature_check *sigc)
>>> @@ -1050,11 +1052,12 @@ static void parse_gpg_output(struct signatu=
re_check *sigc)
>>>  			found +=3D strlen(sigcheck_gpg_status[i].check);
>>>  		}
>>>  		sigc->result =3D sigcheck_gpg_status[i].result;
>>> -		sigc->key =3D xmemdupz(found, 16);
>>> -		found +=3D 17;
>>> -		next =3D strchrnul(found, '\n');
>>> -		sigc->signer =3D xmemdupz(found, next - found);
>>> -		break;
>>> +		if (sigc->result !=3D 'U') {
>>
>> This could use a comment; we know now that only GOODSIG and BADSIG
>> are followed by a signature, but someone looking at this code in the
>> future will probably appreciate an explanation.
>=20
> Wouldn't it be even less magical if there was an explicit field in th=
e
> struct that says whether we need to read a sig from such a line?
I think that special-case if a few lines below is OK for now.
> And furthermore, to use an enum instead of a char so that you can eas=
ily
> spell out the details in the code?  This also has the advantage that =
the
> compiler can check that your 'switch'es cover all cases.
This char is actually from Junios original code. I think we can afford
three chars. This could be changed if we ever need more than that. Anot=
her
possible future feature would be to distinguish between "no signature" =
and
"public key not found" and to allow pass-through of that GPG "retrieve
missing public keys from keyserver" option.

> That's of course assuming that I interpret the logic right; my curren=
t
> understanding is that:
>=20
> * U means untrusted, which is bettern than B but worse than G;
Correct. Also, BADSIG is never followed by trust information.
> * GPG guarantees that the last line matching any of the patterns is t=
he
>   one we care about, so we can blindly override one with the other
Actually, we are searching *all* GPG status lines for every search stri=
ng
in the array. This way, first GOODSIG may be matched to fill in the key
and signer information, but a subsequent TRUST_* match finally sets the
result code.
