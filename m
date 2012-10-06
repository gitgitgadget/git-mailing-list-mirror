From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH 08/10] Integrate wildmatch to git
Date: Sat, 6 Oct 2012 11:25:35 +0200
Message-ID: <k4otes$jll$1@ger.gmane.org>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com><1349412069-627-9-git-send-email-pclouds@gmail.com> <CACnwZYeob34c6hbMX-CNvJ67Qu5b+v7J8SbfcBOgZv6Qu+aqFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 11:31:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKQjA-0007Bu-R5
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 11:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab2JFJ0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2012 05:26:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:35878 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566Ab2JFJ0I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 05:26:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TKQe8-0004kD-Lu
	for git@vger.kernel.org; Sat, 06 Oct 2012 11:26:08 +0200
Received: from dsdf-4db51ce0.pool.mediaways.net ([77.181.28.224])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Oct 2012 11:26:08 +0200
Received: from jojo by dsdf-4db51ce0.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Oct 2012 11:26:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db51ce0.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207140>

Thiago Farina wrote:
> On Fri, Oct 5, 2012 at 1:41 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
> <pclouds@gmail.com> wrote:
>> This makes wildmatch.c part of libgit.a and builds test-wildmatch;
>> the dependency on libpopt in the original has been replaced with the
>> use
>> of our parse-options. Global variables in test-wildmatch are marked
>> static to avoid sparse warnings.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  .gitignore           |  1 +
>>  Makefile             |  3 ++
>>  t/t3070-wildmatch.sh | 27 ++++++++++++++++
>>  test-wildmatch.c     | 88
>>  ++++++++++++++++++++++------------------------------ wildmatch.c
>>  | 26 +++++----------- 5 files changed, 75 insertions(+), 70
>>  deletions(-) create mode 100755 t/t3070-wildmatch.sh
>>
>> diff --git a/test-wildmatch.c b/test-wildmatch.c
>> index 88585c2..bb726c8 100644
>> --- a/test-wildmatch.c
>> +++ b/test-wildmatch.c
>> @@ -19,34 +19,38 @@
>>
>>  /*#define COMPARE_WITH_FNMATCH*/
>>
>> -#define WILD_TEST_ITERATIONS
>> -#include "lib/wildmatch.c"
>> +#include "cache.h"
>> +#include "parse-options.h"
>> +#include "wildmatch.h"
>>
>> -#include <popt.h>
>> +#ifndef MAXPATHLEN
>> +#define MAXPATHLEN 1024
>> +#endif
>> +#ifdef NO_STRLCPY
>> +#include "compat/strlcpy.c"
>> +#define strlcpy gitstrlcpy
>> +#endif
>>
>>  #ifdef COMPARE_WITH_FNMATCH
>>  #include <fnmatch.h>
>>
>> -int fnmatch_errors =3D 0;
>> +static int fnmatch_errors =3D 0;
>>  #endif
>>
>> -int wildmatch_errors =3D 0;
>> -char number_separator =3D ',';
>> +static int wildmatch_errors =3D 0;
>>
>>  typedef char bool;
>>
>> -int output_iterations =3D 0;
>> -int explode_mod =3D 0;
>> -int empties_mod =3D 0;
>> -int empty_at_start =3D 0;
>> -int empty_at_end =3D 0;
>> -
>> -static struct poptOption long_options[] =3D {
>> -  /* longName, shortName, argInfo, argPtr, value, descrip, argDesc
>> */
>> -  {"iterations",     'i', POPT_ARG_NONE,   &output_iterations, 0,
>> 0, 0},
>> -  {"empties",        'e', POPT_ARG_STRING, 0, 'e', 0, 0},
>> -  {"explode",        'x', POPT_ARG_INT,    &explode_mod, 0, 0, 0},
>> -  {0,0,0,0, 0, 0, 0}
>> +static int explode_mod =3D 0;
> Isn't static variables like this initialized to zero by default? Ther=
e
> is a high chance that I might be wrong though.

C99,
5.1.2.1: All objects with static storage duration shall be initialized =
(set=20
to their initial values) before program startup.
6.2.4.2: An object whose identifier is declared with external or intern=
al=20
linkage, or with the storage-class specifier static has static storage=20
duration. Its lifetime is the entire execution of the program and its s=
tored=20
value is initialized only once, prior to program startup.
6.7.8.10: If an object that has automatic storage duration is not=20
initialized explicitly, its value is indeterminate. If an object that h=
as=20
static storage duration is not initialized explicitly, then:
=E2=80=94 if it has pointer type, it is initialized to a null pointer;
=E2=80=94 if it has arithmetic type, it is initialized to (positive or =
unsigned)=20
zero;
=E2=80=94 if it is an aggregate, every member is initialized (recursive=
ly) according=20
to these rules;
=E2=80=94 if it is a union, the first named member is initialized (recu=
rsively)=20
according to these rules.

So seems you're right ;-)=20
