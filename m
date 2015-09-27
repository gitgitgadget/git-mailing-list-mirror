From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 60/68] prefer memcpy to strcpy
Date: Sun, 27 Sep 2015 15:06:44 +0200
Message-ID: <5607E9E4.4010209@web.de>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210818.GE30946@sigill.intra.peff.net> <5607D0A9.4000506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 27 15:07:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgBfc-0007Pi-Na
	for gcvg-git-2@plane.gmane.org; Sun, 27 Sep 2015 15:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808AbbI0NHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Sep 2015 09:07:06 -0400
Received: from mout.web.de ([212.227.15.3]:58890 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755703AbbI0NHF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2015 09:07:05 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Lilcj-1aG4BC24R3-00cvuJ; Sun, 27 Sep 2015 15:06:51
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <5607D0A9.4000506@web.de>
X-Provags-ID: V03:K0:TuM98TC6tzGCNgFFfVhGI/wNOWV0g8ekarzT1shNiTYNz6j8aZG
 CXaAuwjz2lrCKxNOV5hipK1JRnV3kF2qeVMpCnwrt86xoG9r6xBttDevLKD10NlopY3oA8O
 EsUZYZFx61xgEsS/NXmFyTVdU6tspho0bAtHppnKpjomgpg/wY2ZMEUu65ZADOR7uOhMrKD
 4cueWiS22A+MZhy3C7yvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZdS24F/V5uQ=:QMk+OqZtNFzHxclC5KyCuf
 AVnQ4CyFBFlCeLET+ixOie/NIrlPqreMzMa1YXFU2Bl4j1KdoDr92qRzfeyoaqGS1BDeMbwTW
 lvnXGau8oYmctHrCyuTRZNeQOBfxBdxhrtrC9RirbRnzP0wUrEzf75I+l/tWrD5nmyktjMIEV
 AHQ6uY9/jirWEOfiFLSb9fKXtUWodXDYxDcF778NM9W+D6uMKYQ1FyPNxbXWs/MDHSwmbpAkx
 ZhvCfo1YmIaVPg6g83FUddnWxcevt9cniT2Wkd8vq0boquDehx4P1gh/+sHF8/EldZY41rxXf
 //Om0rO7J9qYUgyWfml/00OvSuQ+CEvPY76qJmoN3PvEXowxvzVn/tXSnfQOwn+ueGdVB/bNo
 /t5aiSjk8Y3bPZrWL9FTU9aFqUx6WP+SXQncNJKsVDkzjo/oA8nyHLaFZf51bqBO+FkW0OrY8
 RAoLE2RuDACNyhO69hr+sINKolm5gvxqTXiVKLZBnDraadequx1WI2CsDnCf/ly4+bv32K28Y
 USLR9nV4xowl8SLQo9bj0dBT4hog9dNv96UV2SyN/yK7h15GS9z+yXoABX4T5J3PzVoBKfBNx
 MkGB5Gdkf5BM5d4SuPD52UT2AUIaXMUlOYi8dnkrdNhsSVT7RqA/wMPw5z2tHid3V/UZqKrRs
 94OAy/fCrtjWvN2ZTR2+MmmafEB/4x2hqK6yHdse00mHWy9aVY3VgkcrB99XHcaxt1HvGX83R
 CNMDie+5m5/CCnZPukP1Zi+ALS8gzcBSjbyS7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278703>

On 2015-09-27 13.19, Ren=C3=A9 Scharfe wrote:
> Am 24.09.2015 um 23:08 schrieb Jeff King:
>> When we already know the length of a string (e.g., because
>> we just malloc'd to fit it), it's nicer to use memcpy than
>> strcpy, as it makes it more obvious that we are not going to
>> overflow the buffer (because the size we pass matches the
>> size in the allocation).
>>
>> This also eliminates calls to strcpy, which make auditing
>> the code base harder.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>>   compat/nedmalloc/nedmalloc.c | 5 +++--
>>   fast-import.c                | 5 +++--
>>   revision.c                   | 2 +-
>>   3 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmall=
oc.c
>> index 609ebba..a0a16eb 100644
>> --- a/compat/nedmalloc/nedmalloc.c
>> +++ b/compat/nedmalloc/nedmalloc.c
>> @@ -957,8 +957,9 @@ char *strdup(const char *s1)
>>   {
>>       char *s2 =3D 0;
>>       if (s1) {
>> -        s2 =3D malloc(strlen(s1) + 1);
>> -        strcpy(s2, s1);
>> +        size_t len =3D strlen(s1) + 1;
>> +        s2 =3D malloc(len);
>> +        memcpy(s2, s1, len);
>=20
> This leaves the last byte uninitialized; it was set to NUL by strcpy(=
) before.

len is =3D=3D strlen() +1, which should cover the NUL:

1 byte extra for NUL is allocated,
and memcpy will copy NUL from source.
(Or do I miss somethong ?)
