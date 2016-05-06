From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: /* compiler workaround */ - what was the issue?
Date: Fri, 6 May 2016 21:21:16 +0100
Message-ID: <572CFCBC.3020103@ramsayjones.plus.com>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net>
 <17E04501C9474282B87758C7998A1F5B@PhilipOakley>
 <xmqqtwic9o88.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CBuU8H8r_f4KsnLkhLtfRv0nDo4hGS31LVn0e1Y_3OAQ@mail.gmail.com>
 <51C902B1F7464CF2B58EB0E495F86BB5@PhilipOakley>
 <572CDCFF.9050607@ramsayjones.plus.com>
 <xmqq60ur3tlu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 22:21:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aymFa-0003rV-G5
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 22:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758849AbcEFUVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 16:21:22 -0400
Received: from avasout07.plus.net ([84.93.230.235]:55943 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758275AbcEFUVV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 16:21:21 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id r8MG1s0032D2Veb018MHmt; Fri, 06 May 2016 21:21:19 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=EBOSESyhAAAA:8 a=pby0gxbhwaeXBOcSHH0A:9 a=pILNOxqGKmIA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <xmqq60ur3tlu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293858>



On 06/05/16 19:54, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>=20
>> The patch below applies to master (I haven't checked for any more
>> additions).
>>
>>  	if (bisect_list) {
>> -		int reaches =3D reaches, all =3D all;
>> +		int reaches =3D 0, all =3D 0;
>=20
> One thing that is somewhat sad is that this makes future readers
> wonder if these values '0' are sensible initial values.
>=20
> Having to wonder "is it sensible to initialize this variable to 0?
> Shouldn't it be initialized to INT_MAX instead?" is wasting their
> time exactly because we _know_ these are not even "initial values".
> We know these do not have to be initialized, because some more
> appropriate values will get assigned to them before they are used,
> and have these only because some compilers get it wrong.
>=20
> The original "reaches =3D reaches" had the documentation value (at
> least for those who knew the convention) to save the readers from
> wasting their time that way.  Now these 0 are indistinguishable from
> the other initializations that require to be zero.

Ah, I think I remember now why I hadn't sent this patch before. ;-)
[This started off as one patch, was then split into two (int and pointe=
r),
and then back into one again - presumably because I had by that time
forgotten why I split it up!]

I have a very vague recollection of you expressing your dislike of
these parts of the patch before. I had intended to investigate why
gcc was incorrectly issuing these warnings - but I couldn't get my
currently installed compiler to complain. That would have meant
building various gcc versions, so that I could bisect ...

So, that's why I didn't get around to it ... :-D

I still can't get gcc to complain, e.g. (on top of above):

  $ git diff
  diff --git a/builtin/rev-list.c b/builtin/rev-list.c
  index deae1f3..845fcdc 100644
  --- a/builtin/rev-list.c
  +++ b/builtin/rev-list.c
  @@ -377,7 +377,7 @@ int cmd_rev_list(int argc, const char **argv, con=
st char *prefix)
                  mark_edges_uninteresting(&revs, show_edge);
  =20
          if (bisect_list) {
  -               int reaches =3D 0, all =3D 0;
  +               int reaches, all;
  =20
                  revs.commits =3D find_bisection(revs.commits, &reache=
s, &all,
                                                bisect_find_all);
  $ rm builtin/rev-list.o
  $ make V=3D1 CFLAGS=3D'-g -O3 -Wall -Wextra -Wuninitialized -Wno-unus=
ed-parameter' builtin/rev-list.o
  cc -o builtin/rev-list.o -c -MF builtin/.depend/rev-list.o.d -MQ buil=
tin/rev-list.o -MMD -MP  -g -O3 -Wall -Wextra -Wuninitialized -Wno-unus=
ed-parameter -I. -DHAVE_ALLOCA_H -DUSE_CURL_FOR_IMAP_SEND  -DHAVE_PATHS=
_H -DHAVE_DEV_TTY -DXDL_FAST_HASH -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MON=
OTONIC -DHAVE_GETDELIM -DSHA1_HEADER=3D'<openssl/sha.h>'  -DNO_STRLCPY =
-DNO_MKSTEMPS -DSHELL_PATH=3D'"/bin/sh"'  builtin/rev-list.c
  In file included from ./cache.h:4:0,
                   from builtin/rev-list.c:1:
  ./git-compat-util.h: In function =91xsize_t=92:
  ./git-compat-util.h:838:10: warning: comparison between signed and un=
signed integer expressions [-Wsign-compare]
    if (len > (size_t) len)
            ^
  $=20
 =20
[Note: gcc (Ubuntu 4.8.4-2ubuntu1~14.04.1) 4.8.4]

>=20
>> diff --git a/read-cache.c b/read-cache.c
>> index d9fb78b..978d6b6 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1870,7 +1870,7 @@ static int ce_write_entry(git_SHA_CTX *c, int =
fd, struct cache_entry *ce,
>>  {
>>  	int size;
>>  	struct ondisk_cache_entry *ondisk;
>> -	int saved_namelen =3D saved_namelen; /* compiler workaround */
>> +	int saved_namelen =3D 0;
>=20
> I wonder if can we come up with a short and sweet notation to remind
> futhre readers that this "initialization" is not initializing but
> merely squelching warnings from stupid compilers, and agree to use
> it consistently?

Nothing comes to mind.

Do current compilers complain?

ATB,
Ramsay Jones
