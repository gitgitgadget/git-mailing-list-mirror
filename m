From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 03/10] test-regex: expose full regcomp() to the command
 line
Date: Fri, 29 Jan 2016 14:29:25 +0000
Message-ID: <56AB7745.8010003@ramsayjones.plus.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1453982183-24124-4-git-send-email-pclouds@gmail.com>
 <20160129053143.GA17334@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 15:29:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPA3P-00026I-SP
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 15:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078AbcA2O3g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2016 09:29:36 -0500
Received: from avasout04.plus.net ([212.159.14.19]:36576 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbcA2O3f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 09:29:35 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id BqVY1s0024mu3xa01qVZcj; Fri, 29 Jan 2016 14:29:33 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=pGLkceISAAAA:8 a=CCpqsmhAAAAA:8 a=ELZSKfyc8i_JZiekLKcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160129053143.GA17334@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285077>



On 29/01/16 05:31, Eric Sunshine wrote:
> On Thu, Jan 28, 2016 at 06:56:16PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/test-regex.c b/test-regex.c
>> @@ -1,19 +1,63 @@
>>  int main(int argc, char **argv)
>>  {
>> -	char *pat =3D "[^=3D{} \t]+";
>> -	char *str =3D "=3D{}\nfred";
>> +	const char *pat;
>> +	const char *str;
>> +	int flags =3D 0;
>>  	regex_t r;
>>  	regmatch_t m[1];
>> =20
>> -	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
>> +	if (argc =3D=3D 1) {
>> +		/* special case, bug check */
>> +		pat =3D "[^=3D{} \t]+";
>> +		str =3D "=3D{}\nfred";
>> +		flags =3D REG_EXTENDED | REG_NEWLINE;
>> +	} else {
>> +		argv++;
>> +		pat =3D *argv++;
>> +		str =3D *argv++;
>=20
> I realize that this is just a test program, but it might be a good
> idea to insert:
>=20
>     if (argc < 3)
>         die("usage: ...");
>=20
> prior to the *argv++ dereferences to give a controlled failure rather
> than an outright crash when an incorrect number of arguments is
> given.
>=20
> More below...
>=20
>> +		while (*argv) {
>> +			struct reg_flag *rf;
>> +			for (rf =3D reg_flags; rf->name; rf++)
>> +				if (!strcmp(*argv, rf->name)) {
>> +					flags |=3D rf->flag;
>> +					break;
>> +				}
>> +			if (!rf->name)
>> +				die("do not recognize %s", *argv);
>> +			argv++;
>> +		}
>> +		git_setup_gettext();
>> +	}
>> +
>> +	if (regcomp(&r, pat, flags))
>>  		die("failed regcomp() for pattern '%s'", pat);
>> -	if (regexec(&r, str, 1, m, 0))
>> -		die("no match of pattern '%s' to string '%s'", pat, str);
>> +	if (regexec(&r, str, 1, m, 0)) {
>> +		if (argc =3D=3D 1)
>> +			die("no match of pattern '%s' to string '%s'", pat, str);
>> +		return 1;
>> +	}
>> =20
>>  	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3D3957  */
>> -	if (m[0].rm_so =3D=3D 3) /* matches '\n' when it should not */
>> +	if (argc =3D=3D 1 && m[0].rm_so =3D=3D 3) /* matches '\n' when it =
should not */
>>  		die("regex bug confirmed: re-build git with NO_REGEX=3D1");
>=20
> Again, I realize that this is just a test program, but sprinkling
> this 'argc =3D=3D 1' special case throughout the code makes it
> unnecessarily difficult to follow.=20

I completely agree!

>                                     Some alternatives:
>=20
> 1. Rename the existing test-regex to test-regex-bug (or
>    test-regex-bugs), and then name the new general purpose program
>    test-regex.
>=20
> 2. Drop the special case altogether and have the program emit the
>    matched text on stdout (in addition to the exit code indicating
>    success/failure). Most callers will care only about the exit
>    status, but the one special case in t0070 which wants to check for
>    the glibc bug can do so itself:
>=20
>     test_expect_success 'check for a bug in the regex routines' '
>         # if this test fails, re-build git with NO_REGEX=3D1
>         printf "fred" >expect &&
>         test-regex "[^=3D{} \t]+" "=3D{}\nfred" EXTENDED NEWLINE >act=
ual &&
>         test_cmp expect actual
>     '
>=20
>    Of course, that doesn't actually work because "\n" in the 'str'
>    argument isn't really a newline, so test-regex would have to do a
>    bit of preprocessing of 'str' first (which might be as simple as
>    calling unquote_c_style() or something).
>=20
> 3. [less desirable] Move the 'argc =3D=3D 1' special case to its own
>    function, which will result in a bit of duplicated code, but the
>    result should at least be easier to follow.

I think this is the most desirable (and was going to be my first
suggestion); the duplication is minimal and it makes the code _much_
easier to follow. [I suppose separate test programs (ie. point 1) would
be my second choice.]

ATB,
Ramsay Jones
