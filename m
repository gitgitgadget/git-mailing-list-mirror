From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v7 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 17:03:44 +0200
Message-ID: <87mwtjwqzz.fsf@linux-k42r.v.cablecom.net>
References: <20130331133332.GD2286@serenity.lan>
	<cover.1364738348.git.jaseg@physik-pool.tu-berlin.de>
	<51584955.40007@physik.tu-berlin.de>
	<20130331144452.GF2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Sun Mar 31 17:04:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMJnu-0002Si-KC
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 17:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471Ab3CaPDu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 11:03:50 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:7487 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3CaPDu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Mar 2013 11:03:50 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 17:03:47 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (213.55.184.251) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Sun, 31 Mar 2013 17:03:46 +0200
In-Reply-To: <20130331144452.GF2286@serenity.lan> (John Keeping's message of
	"Sun, 31 Mar 2013 15:44:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.55.184.251]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219629>

John Keeping <john@keeping.me.uk> writes:

> On Sun, Mar 31, 2013 at 04:33:57PM +0200, Sebastian G=C3=B6tte wrote:
>> diff --git a/commit.c b/commit.c
>> index eda7f90..bb2d9ad 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -1029,6 +1029,8 @@ static struct {
>>  } sigcheck_gpg_status[] =3D {
>>  	{ 'G', "[GNUPG:] GOODSIG " },
>>  	{ 'B', "[GNUPG:] BADSIG " },
>> +	{ 'U', "[GNUPG:] TRUST_NEVER" },
>> +	{ 'U', "[GNUPG:] TRUST_UNDEFINED" },
>>  };
>> =20
>>  static void parse_gpg_output(struct signature_check *sigc)
>> @@ -1050,11 +1052,12 @@ static void parse_gpg_output(struct signatur=
e_check *sigc)
>>  			found +=3D strlen(sigcheck_gpg_status[i].check);
>>  		}
>>  		sigc->result =3D sigcheck_gpg_status[i].result;
>> -		sigc->key =3D xmemdupz(found, 16);
>> -		found +=3D 17;
>> -		next =3D strchrnul(found, '\n');
>> -		sigc->signer =3D xmemdupz(found, next - found);
>> -		break;
>> +		if (sigc->result !=3D 'U') {
>
> This could use a comment; we know now that only GOODSIG and BADSIG
> are followed by a signature, but someone looking at this code in the
> future will probably appreciate an explanation.

Wouldn't it be even less magical if there was an explicit field in the
struct that says whether we need to read a sig from such a line?

And furthermore, to use an enum instead of a char so that you can easil=
y
spell out the details in the code?  This also has the advantage that th=
e
compiler can check that your 'switch'es cover all cases.

That's of course assuming that I interpret the logic right; my current
understanding is that:

* U means untrusted, which is bettern than B but worse than G;

* GPG guarantees that the last line matching any of the patterns is the
  one we care about, so we can blindly override one with the other

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
