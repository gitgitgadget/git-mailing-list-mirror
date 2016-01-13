From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 4/4] t0060: verify that basename() and dirname() work
 as expected
Date: Wed, 13 Jan 2016 16:34:43 +0000
Message-ID: <56967CA3.7040103@ramsayjones.plus.com>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
 <cover.1452585382.git.johannes.schindelin@gmx.de>
 <7d73267984ab029df022477e341c536e111eafdd.1452585382.git.johannes.schindelin@gmx.de>
 <5695E4FB.2060705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:35:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJONu-0000Ps-M7
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbcAMQey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2016 11:34:54 -0500
Received: from avasout07.plus.net ([84.93.230.235]:53785 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789AbcAMQew (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:34:52 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id 5Uap1s0034mu3xa01Uaq8X; Wed, 13 Jan 2016 16:34:51 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=EBOSESyhAAAA:8
 a=N659UExz7-8A:10 a=uZvujYp8AAAA:8 a=BbEEpIT8zjU0FaJ18BcA:9 a=pILNOxqGKmIA:10
 a=GHMR23ioTDIA:10 a=wRzW3n7C4pIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <5695E4FB.2060705@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283928>



On 13/01/16 05:47, Torsten B=F6gershausen wrote:
> On 01/12/2016 08:57 AM, Johannes Schindelin wrote:
>=20
[snip]

>> +
>> +static struct test_data basename_data[] =3D {
>> +	/* --- POSIX type paths --- */
>> +	{ NULL,              "."    },
>> +	{ "",                "."    },
>> +	{ ".",               "."    },
>> +	{ "..",              ".."   },
>> +	{ "/",               "/"    },
>> +#if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
> Why the !defined(NO_LIBGEN_H)

These tests were derived from a standalone test program which
I was using to test my implementation of gitbasename() *and*
to document the differences between it and the system versions
of the <libgen.h> basename(). (I didn't bother with the GNU version
of basename, which is somewhat strange).

This particular section documents what is almost certainly a bug
in the cygwin basename() and also documents my choice of 'fix'.
(ie. in my implementation I chose to return '/' for '//', which
is one of the possible options that POSIX allows.)

>=20
> Shouldn't CYGWIN always behave the same ?
> And, in general, shouldn't all Windows version behave the same ?

Hmm, cygwin is not really a 'Windows version', so ... (We have been
caught out before by cygwin 'supporting' UNC paths, so support for
'//' is open to question. Also, some git programs on cygwin kinda
sorta support dos paths ...)

> (This would mean, that we always use ../compat/basename.c for all kin=
d
> of Windows Git implementattion. Would there be a drawback ?)

And maybe not just Windows ...

>=20
>=20
> The main problem is, that t0060 fails under Mac OS (with mac ports in=
stalled):
> expecting success: test-path-utils dirname
> error: FAIL: dirname(//) =3D> '/' !=3D '//'

Yep, not surprised. Again that test file was developed and tested on
only the five platforms available to me at the time, namely: Linux (bot=
h
32 and 64bit), Windows XP 32-bit (MSVC), MinGW 32-bit and Cygwin 32-bit=
=2E

POSIX says, in part [1]:

    If the string pointed to by path consists entirely of the '/' chara=
cter,
    basename() shall return a pointer to the string "/". If the string =
pointed
    to by path is exactly "//", it is implementation-defined whether '/=
' or "//"
    is returned.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/functions/basename.=
html

So we should expect other systems to differ, even if they support POSIX=
=2E (and maybe
not just this test case.)

>=20
> not ok 2 - dirname
> #       test-path-utils dirname
>=20
> To my understanding the treatment of a path name like "//"
> is defined as "undefined":
> If /string/ is "//", it is implementation-defined whether steps 3 to =
6 are skipped or processed.
> http://pubs.opengroup.org/onlinepubs/009695399/utilities/basename.htm=
l
>=20
> What I understand is that a path like "//XX/YY/ZZ" can be handled in =
3 different ways:
> a) Same as "/XX/YY/ZZ", silently turning "//" into "/"
> b) Same as "\\XX\YY\ZZ", using UNC names under Windows. # Note: this =
reads as "\\\\XX\\YY\\ZZ" in a C program
> c) As invalid
>=20
>=20
> Does it make sense to use the compat/basename.c for all Git implement=
ations ?
> (Or at least for CYGWIN, Mac OS, MSYS, MSVC)
>=20

Maybe, I hadn't got that far yet ... :-D

ATB,
Ramsay Jones
