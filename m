From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Tue, 20 Jan 2009 10:52:58 -0600
Message-ID: <200901201053.03256.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <200901192145.21115.bss@iguanasuicide.net> <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3071477.e10qX140RC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 17:54:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPJrR-00082f-8r
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 17:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758170AbZATQwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 11:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758102AbZATQwR
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 11:52:17 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:35900 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612AbZATQwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 11:52:16 -0500
Received: from [63.167.79.115]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPJpn-0001uU-BY; Tue, 20 Jan 2009 16:52:15 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106492>

--nextPart3071477.e10qX140RC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2009 January 20 04:02:00 you wrote:
>On Mon, 19 Jan 2009, Boyd Stephen Smith Jr. wrote:
>> diff --git a/diff.c b/diff.c
>> index 9fcde96..c53e1d1 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -23,6 +23,7 @@ static int diff_detect_rename_default;
>>  static int diff_rename_limit_default =3D 200;
>>  static int diff_suppress_blank_empty;
>>  int diff_use_color_default =3D -1;
>> +static const char *diff_color_words_cfg =3D NULL;
>>  static const char *external_diff_cmd_cfg;
>
>Guess why external_diff_cmd_cfg is not set to NULL?  All variables
>defined outside a function are set to all-zero anyway.

I suppose I just initialize variables by reflex, having been bitten with to=
o=20
many sometimes-crashes due to variables that were usually-zero.  Assuming C=
=20
does guarantee that it is zeroed, I'll drop the " =3D NULL" line noise in t=
he=20
next version.

>> @@ -92,6 +93,8 @@ int git_diff_ui_config(const char *var, const char
>> *value, void *cb) }
>>  	if (!strcmp(var, "diff.external"))
>>  		return git_config_string(&external_diff_cmd_cfg, var, value);
>> +	if (!strcmp(var, "diff.color-words"))
>
>I'd call it diff.wordregex, because that's what it is.

I don't like runtogetherwords because they are hard to read for me; I tend =
to=20
choose the wrong word breaks if it is ambiguous.  There are other=20
configuration values that use camelCaseWords so I will convert over to usin=
g=20
that.

I thought "word regex" made more sense, but I wanted to match the command-l=
ine=20
option.  Will change.

>> @@ -1550,6 +1553,8 @@ static void builtin_diff(const char *name_a,
>>  				o->word_regex =3D userdiff_word_regex(one);
>>  			if (!o->word_regex)
>>  				o->word_regex =3D userdiff_word_regex(two);
>> +			if (!o->word_regex)
>> +				o->word_regex =3D diff_color_words_cfg;
>
>IMHO this is the wrong order.  config should not override attributes,
>which are by definition more specific.

You are up too late Dscho.  This ordering makes the config not override=20
attributes.  If one of the files has a diff driver, o->word_regex will be s=
et=20
to it (and become non-NULL).  That will prevent execution of the body of th=
e=20
added "if (!o->word_regex)" -- preventing the configuration option from bei=
ng=20
used.

>> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
>> index 6ebce9d..a207d9e 100755
>> --- a/t/t4034-diff-words.sh
>> +++ b/t/t4034-diff-words.sh
>> @@ -105,7 +105,7 @@ a =3D b + c<RESET>
>>  EOF
>>  cp expect.non-whitespace-is-word expect
>>
>> -test_expect_failure 'use default supplied by config' '
>> +test_expect_success 'use default supplied by config' '
>
>Let's squash the two, okay?

Will do.  I expected the code changes to be larger than the test, and when =
I=20
finished it was completely the other way.  My next patch will be all-in-one.

Thanks for your feedback.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart3071477.e10qX140RC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEUEABECAAYFAkl2AW8ACgkQdNbfk+86fC0nWQCXcyuKoE83CT65gTWYSO4biLdG
/ACdGWKCR6m/2rFoLebp6SMQIRRQCGg=
=JGjB
-----END PGP SIGNATURE-----

--nextPart3071477.e10qX140RC--
