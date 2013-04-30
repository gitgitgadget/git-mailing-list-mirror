From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] unpack_entry: invalidate newly added cache entry in case
 of error
Date: Tue, 30 Apr 2013 17:25:05 +0700
Message-ID: <CACsJy8Bi6UpfA-0BCFY6H=BAKMmWYgwbf-94yJXEn5Zi4gwPCA@mail.gmail.com>
References: <1367288992-14979-1-git-send-email-pclouds@gmail.com> <87ppxcxw1i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 30 12:25:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX7kj-00073k-70
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 12:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760027Ab3D3KZh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 06:25:37 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:61909 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759520Ab3D3KZg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 06:25:36 -0400
Received: by mail-oa0-f47.google.com with SMTP id n9so320142oag.6
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=GIyxq7T79wLEmZQLsjXTGGl+VkDDnOgun/qN8N7zF50=;
        b=PTKW6+8045i0Xd0wqn/hfzg1OExnqqT+YRG5oGNbHWdAjExUiKPZhgs0hnqmzUPkmT
         JU71ZCXXiAA1jzqBqCsz/JJuNFKXx4APfg/mMM3fAcutrg6thJbidadInRJ7Bi7NPGQu
         GuWEO1lms59vDWP7SdMcIpVYxt4FIUhxjdKuUkoqBQSUSm4rOAyRCYNhroSjTqlHrCeS
         18z9LjowVpIFFXsZ35ZeBAg1xEIGy6a3CIvhogLOsPzEWVVEEpnbQfRHYELuACPRUw7e
         3iSUZseEG0ZHUTUM9uXgg6F9Rd3COF4PKddK4fu9xepyTVF/o5aVqGOvwC2mrl+INP/u
         NonQ==
X-Received: by 10.60.65.68 with SMTP id v4mr25997345oes.13.1367317535677; Tue,
 30 Apr 2013 03:25:35 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Tue, 30 Apr 2013 03:25:05 -0700 (PDT)
In-Reply-To: <87ppxcxw1i.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222924>

On Tue, Apr 30, 2013 at 3:27 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> In this particular code path, we add "base" to the delta base
>> cache. Then decide to free it, but we forgot about a dangling pointe=
r
>> in the cache. Invalidate that entry when we free "base".
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Some of my changes triggered a double free fault at "free(base);" i=
n
>>  t5303. This looks like a correct thing to do, but I may be missing
>>  something (I'm not even sure how it happened). Please check.
>
> Can you describe how you triggered it?
>
> I ran all of origin/pu through valgrind tests just yesterday, and it
> found nothing (yay!), so it doesn't seem to reproduce here?

Apply this patch on top of master (no need to apply full series) and ru=
n t5303

http://article.gmane.org/gmane.comp.version-control.git/222895

>> @@ -2129,6 +2132,8 @@ void *unpack_entry(struct packed_git *p, off_t=
 obj_offset,
>>                             "at offset %"PRIuMAX" from %s",
>>                             (uintmax_t)curpos, p->pack_name);
>>                       free(base);
>> +                     if (ent)
>> +                             ent->data =3D NULL;
>>                       data =3D NULL;
>>                       continue;
>>               }
>
> Why not clear_delta_base_cache_entry(), which also handles updating t=
he
> lru pointers?

Simple. I didn't know about clear_de..entry().

> Also I wonder if removing free(base) is the right fix: since the fail=
ure
> is in decompressing the delta, the base might again be useful and we
> should keep it cached.

OK since you know this code much better than me, I withdraw my patch
(consider it a bug report) and let you work on a proper fix. I see you
already have the commit message ready :) Happy to test it for you if
the above instruction is still not reproducible for you.
--
Duy
