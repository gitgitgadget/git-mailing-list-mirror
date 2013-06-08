From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sat, 08 Jun 2013 15:22:05 +0200
Message-ID: <51B32FFD.5070302@lsrfire.ath.cx>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com> <1370644168-4745-3-git-send-email-felipe.contreras@gmail.com> <51B31651.6020307@lsrfire.ath.cx> <CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 15:22:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJ5y-0002KY-Q5
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 15:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab3FHNWL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 09:22:11 -0400
Received: from india601.server4you.de ([85.25.151.105]:58948 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab3FHNWK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 09:22:10 -0400
Received: from [192.168.2.105] (p579BEA5D.dip0.t-ipconnect.de [87.155.234.93])
	by india601.server4you.de (Postfix) with ESMTPSA id 186F3239;
	Sat,  8 Jun 2013 15:22:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226818>

Am 08.06.2013 14:15, schrieb Felipe Contreras:
> On Sat, Jun 8, 2013 at 6:32 AM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>>> diff --git a/read-cache.c b/read-cache.c
>>> index 5e30746..a1dd04d 100644
>>> --- a/read-cache.c
>>> +++ b/read-cache.c
>>> @@ -1451,6 +1451,7 @@ int read_index_from(struct index_state *istat=
e,
>>> const char *path)
>>>          istate->version =3D ntohl(hdr->hdr_version);
>>>          istate->cache_nr =3D ntohl(hdr->hdr_entries);
>>>          istate->cache_alloc =3D alloc_nr(istate->cache_nr);
>>> +       free(istate->cache);
>>>          istate->cache =3D xcalloc(istate->cache_alloc,
>>> sizeof(*istate->cache));
>>>          istate->initialized =3D 1;
>>
>>
>> You wrote earlier that this change is safe with current callers and =
that it
>> prevents leaks with the following sequence:
>>
>> discard_cache();
>> # add entries
>> read_cache();
>>
>> Do we currently have such a call sequence somewhere?
>
> I don't know.
>
>> Wouldn't that be a
>> bug, namely forgetting to call discard_cache before read_cache?
>
> Why would it be a bug? There's nothing in the API that hints there's =
a
> problem with that.

A comment before read_index_from says "remember to discard_cache()=20
before reading a different cache!".  That is probably a reminder that=20
read_index_from does nothing if ->initialized is set.  Entries added=20
before calling read_index_from make up a different cache, however, so I=
=20
think this comment applies for the call sequence above as well.

Only read_index_from and add_index_entry allocate ->cache, and only=20
discard_index frees it, so the two are a triple like malloc, realloc an=
d=20
free.

Granted, these hints are not part of the API -- that looks like a=20
documentation bug, however.

Side note: I wonder why we need to guard against multiple=20
read_index_from calls in a row with ->initialized.  Wouldn't it be=20
easier to avoid the duplicate calls in the first place?  Finding them=20
now might be not so easy, though.

>> I've added a "assert(istate->cache_nr =3D=3D 0);" a few lines above =
and the test
>> suite still passed.  With the hunk below, ->cache is also always NUL=
L and
>> cache_alloc is always 0 at that point.  So we don't need that free c=
all
>> there in the cases covered by the test suite at least -- better leav=
e it
>> out.
>
> Why leave it out? If somebody makes the mistake of doing the above
> sequence, would you prefer that we leak?

Leaking is better than silently cleaning up after a buggy caller becaus=
e=20
it still allows the underlying bug to be found.  Even better would be a=
n=20
assert, but it's important to make sure it doesn't trigger for existing=
=20
use cases.

Ren=C3=A9
