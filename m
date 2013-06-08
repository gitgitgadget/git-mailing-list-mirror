From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sat, 8 Jun 2013 07:15:30 -0500
Message-ID: <CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com>
	<1370644168-4745-3-git-send-email-felipe.contreras@gmail.com>
	<51B31651.6020307@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jun 08 14:15:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlI3e-00087v-8o
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 14:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab3FHMPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 08:15:32 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49679 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab3FHMPb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jun 2013 08:15:31 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so2992963lbi.19
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 05:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KmpXiCWy/h7zwTEKmQwuBnDjISMGlJcHfi6dgoucv9Y=;
        b=gCIWih+Y6YgsvuTGG8fGRWtmZu7X5ylIKxv1rDXCYGMlIBvTguTlm5so8EnxgwnV+D
         Fmve44Bl6ca4au9WgQOm/ZS7kw/ueqThOCC5aGbpMIo6VXkmIxeiERDwAbvm368lq9tC
         ZnaC4nu2acYZyJ4LRM9DiuOM1+dKPOjpUV3TDDd4RMhp92ia+scSCsoa+K0ZWBN6QqoB
         5/QJTq8ldUAyH7fta9+Q3FoJ9a8Uckb4REW+3+0nVhWSxG0ACTfQm1Wz3UhO7Dn/mv77
         2VPwGF7ul3npzn/0L4ZW0Xd+3fhcA8z1+MeVoo3BHRIYw5bJkyzc52fR5qfIgs3e1f98
         lSPw==
X-Received: by 10.112.16.163 with SMTP id h3mr2987206lbd.85.1370693730487;
 Sat, 08 Jun 2013 05:15:30 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 05:15:30 -0700 (PDT)
In-Reply-To: <51B31651.6020307@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226808>

On Sat, Jun 8, 2013 at 6:32 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 08.06.2013 00:29, schrieb Felipe Contreras:
>
>> We are not freeing 'istate->cache' properly.
>>
>> We can't rely on 'initialized' to keep track of the 'istate->cache',
>> because it doesn't really mean it's initialized. So assume it always=
 has
>> data, and free it before overwriting it.
>
>
> That sounds a bit backwards to me.  If ->initialized doesn't mean tha=
t the
> index state is initialized then something is fishy.  Would it make se=
nse and
> be sufficient to set ->initialized in add_index_entry?

I don't know.

> Or to get rid of it and check for ->cache_alloc instead?

That might make sense. I was thinking on renaming 'initialized' to
'loaded', but I really don't care.

>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>   read-cache.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index 5e30746..a1dd04d 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1451,6 +1451,7 @@ int read_index_from(struct index_state *istate=
,
>> const char *path)
>>         istate->version =3D ntohl(hdr->hdr_version);
>>         istate->cache_nr =3D ntohl(hdr->hdr_entries);
>>         istate->cache_alloc =3D alloc_nr(istate->cache_nr);
>> +       free(istate->cache);
>>         istate->cache =3D xcalloc(istate->cache_alloc,
>> sizeof(*istate->cache));
>>         istate->initialized =3D 1;
>
>
> You wrote earlier that this change is safe with current callers and t=
hat it
> prevents leaks with the following sequence:
>
> discard_cache();
> # add entries
> read_cache();
>
> Do we currently have such a call sequence somewhere?

I don't know.

> Wouldn't that be a
> bug, namely forgetting to call discard_cache before read_cache?

Why would it be a bug? There's nothing in the API that hints there's a
problem with that.

> I've added a "assert(istate->cache_nr =3D=3D 0);" a few lines above a=
nd the test
> suite still passed.  With the hunk below, ->cache is also always NULL=
 and
> cache_alloc is always 0 at that point.  So we don't need that free ca=
ll
> there in the cases covered by the test suite at least -- better leave=
 it
> out.

Why leave it out? If somebody makes the mistake of doing the above
sequence, would you prefer that we leak?

--=20
=46elipe Contreras
