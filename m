From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] builtins: search builtin commands via binary search.
Date: Sat, 27 Jul 2013 10:49:27 +0200
Message-ID: <51F38997.9010507@googlemail.com>
References: <1374871850-24323-1-git-send-email-stefanbeller@googlemail.com> <20130726205737.GI14690@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD8459645991EC8BB2B851C89"
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 10:49:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V30Bt-0005Mc-QJ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 10:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979Ab3G0ItZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 04:49:25 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:58131 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab3G0ItW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 04:49:22 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so1625207wiw.7
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=vtB+aErAwkdpT7ClUy5thFMP8CM9y0tSVop6VVk1+YM=;
        b=fUELRqNqZpu1QGwm7+aXJ9vb3277jsbb+/GUF/EzDOJMAqOnl6v0R60wErW7HhV2yR
         4/oLO3H/8zoYuIXRVFXTUilQOs8y3xao+mKXm+u6aRkBvbEPlSVRq0tTb4htwAVKWq4t
         WVv0ZN5jafZHEtRYsu1NEyy2zpHAqE9gZL/U8uyL20qwRi/eGdfBF5ya0faVnKkZn4Ql
         4qQ53yog090QMF0NotsJcDkV6/TFoRFvmyfmibGXs9oESj0elfC8+z+iLBeB5FQ/Bv3c
         B0xQCOUVkfjSQMRcNfqTBIQ5QWMa9XcVvSZxhJV5oiBGKb11QWVZtRj0iHv+OVzZjv+Z
         HE7g==
X-Received: by 10.180.208.104 with SMTP id md8mr1406084wic.57.1374914960618;
        Sat, 27 Jul 2013 01:49:20 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id u9sm9342108wif.6.2013.07.27.01.49.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Jul 2013 01:49:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130726205737.GI14690@google.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231230>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD8459645991EC8BB2B851C89
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/26/2013 10:57 PM, Jonathan Nieder wrote:
> Hi,
>=20
> Stefan Beller wrote:
>=20
>> --- a/git.c
>> +++ b/git.c
>> @@ -309,9 +309,18 @@ static int run_builtin(struct cmd_struct *p, int =
argc, const char **argv)
>>  	return 0;
>>  }
>> =20
>> +static int compare_internal_command(const void *a, const void *b) {
>> +	/* The first parameter is of type char* describing the name,
>> +	   the second is a struct cmd_struct */
>=20
> Style:
>=20
> 	/*
> 	 * Multi-line comments in git look like this, with an initial
> 	 * "/*" line, a leading "*" on each line with text, and a line
> 	 * with '*' '/' at the end.
> 	 */
>=20
> [...]

Thanks for noting, however as Eric points out, that comment was not enlig=
htening, so I removed it.


>> @@ -447,12 +456,12 @@ static void handle_internal_command(int argc, co=
nst char **argv)
>>  		argv[0] =3D cmd =3D "help";
>>  	}
>> =20
>> -	for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
>> -		struct cmd_struct *p =3D commands+i;
>> -		if (strcmp(p->cmd, cmd))
>> -			continue;
>> +	struct cmd_struct *p =3D (struct cmd_struct *)bsearch(cmd, commands,=

>> +				ARRAY_SIZE(commands), sizeof(struct cmd_struct),
>> +				compare_internal_command);
>=20
> No need to cast --- this is C.

Also removed.

>=20
> Fun.  Does this result in a measurable speedup, or is it just for more
> pleasant reading?
>=20
> Thanks and hope that helps,
> Jonathan
>=20

premature optimization is the root of all evil....
I tried hard to come up with a benchmark, but this is lost in the
noise. I could not figure out a way to reproducably make sure this
patch is really faster.
So I tried to `time git add COPYING` to show it's not getting slower
for the first entries in the list as well as `git fast-external-command`
whereas the fast-external-command is just an int main() {return 0; }
to check if the external commands, which are executed after searching=20
through all the internals come up faster.

However I could not find a speedup.
So if the patch is accepted, it would only be for readability.

I was fiddling around with make now to include the suggestion of Eric to
check the arguments for being sorted in make. However I do not=20
seem to fully understand the syntax yet.
My approach would have been:

sorted_internal_cmds: git.c
	{ awk '/cmd_struct commands/,/};/ { if (match($2,/"/)) print $2 }' <git.=
c >builtin.actual && \
	sort <builtin.actual >builtin.expect && \
	cmp -s builtin.expect builtin.actual && \
	rm builtin.expect builtin.actual \
	}

all:: sorted_internal_cmds

But then there is=20
$ make=20
=2E..
	}
/bin/sh: 5: Syntax error: end of file unexpected (expecting "}")

So I suspect the { within the shell code inside the awk parameter is mess=
ing up?

Thanks,
Stefan



--------------enigD8459645991EC8BB2B851C89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR84mXAAoJEJQCPTzLflhqLEkP/RKnUTNQoRMNZeJK26F6a8wO
PyWQYUYySg/KwtE8heoQpmng7ABUzI+Sm338H9Bcs3asYToBVd/UBEk9pS6yQkIH
4x022nP6NT2kN2AXNiqXsVfts77y8F9Wdqe6UCUzDjnqmD2fwZKMas7RFGdJI67m
sVZt8hIJdH2PAO5J7oShd7FlV0CbFpXLGo4Rq9DmSTCpGG5Bq2GKV6n1s1LqZQSM
vOCY5mu+fufywEbiqOeZB5olKZy2A8znxton8R+aerGqtv7lhxPHM9UiaIFATbS+
ib8OJ6mbF/t5OS093yn6LvMSg9MjXvAK4o2lQJIbgk5HgTfbM1I15qUerisQ1X2y
weBS2exunKq9r/lPwS3vlRnnZDXYQptYdau8cHIO5iACmOmskunWPYfDSjWbsGxG
czPm/lFlZp11DdZWKpt45J26ATJjxnVxWBQzRiXXKkijPkNJU3iCKNQBGsxaKl5A
cDSpIxOajVQqaWta6N7JKwRQEmHgbxPllsaAjRdIaLDS2w1ptrp7R3frMTT5yqer
JVh6e7vOG8/lRz6rxR5noZVgglyMwTdhnxMKKy7CYOeEI1xMuXLiJYPVax6bzEjB
wa/KDmtqlA+nkBKn1xHvRt7ZspQ7Th+ZSLcbDa1IT17n0lw+5LO2i9jbiTIUL4di
7PgpuW2BICaepohnIxXB
=Ot4l
-----END PGP SIGNATURE-----

--------------enigD8459645991EC8BB2B851C89--
