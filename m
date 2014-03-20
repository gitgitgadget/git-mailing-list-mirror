From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] Bump core.deltaBaseCacheLimit to 128MiB
Date: Thu, 20 Mar 2014 08:38:18 +0700
Message-ID: <CACsJy8C3=bz1HmVgQuJRdixMhhb-JKouM7b1L7M047L_4PBViA@mail.gmail.com>
References: <1395232712-6412-1-git-send-email-dak@gnu.org> <xmqq38id3nfs.fsf@gitster.dls.corp.google.com>
 <87ob11g9st.fsf@fencepost.gnu.org> <xmqqlhw5260l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Kastrup <dak@gnu.org>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 02:38:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQRwc-0001On-Mz
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 02:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbaCTBiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 21:38:50 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:47213 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109AbaCTBit (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 21:38:49 -0400
Received: by mail-qc0-f178.google.com with SMTP id i8so196433qcq.9
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 18:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VWFf7ww6S405+GmPXAK5+i7MGQxioZhapZbNlrUk0lg=;
        b=ZXVM6frM+7iX8+8YLVcX5G98Iv85JpTo8YMrfBHFCkm9CoIX/7CR5UVPmivxgpdZq6
         H010zvDpoe8mgdvyXX/vr8AyVly3fixyc/mcueM++t+4auAqFBy6d74kJaEj7fmLunx9
         DflGKABkg7QOXd9LiTTQXmJJLARENd2GMatzgGfAoQOOQrAL8885y69/nSILsnSfDbEy
         okfpkX+KJY9QzfBktZwcMeoINLSPVcALud20NSSc2prR6GbUbodziQfs+c+me4q/75L8
         wUt1U/KDtI3ggh19KGRykh49pH0RiFBddKRqpq+nlY+UpESFPVBWmK4s7hKK/2+PNLCP
         BOOw==
X-Received: by 10.140.91.105 with SMTP id y96mr45234969qgd.3.1395279528623;
 Wed, 19 Mar 2014 18:38:48 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Wed, 19 Mar 2014 18:38:18 -0700 (PDT)
In-Reply-To: <xmqqlhw5260l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244514>

On Thu, Mar 20, 2014 at 5:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Kastrup <dak@gnu.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> David Kastrup <dak@gnu.org> writes:
>>>
>>>> The default of 16MiB causes serious thrashing for large delta chains
>>>> combined with large files.
>>>>
>>>> Signed-off-by: David Kastrup <dak@gnu.org>
>>>> ---
>>>
>>> Is that a good argument?  Wouldn't the default of 128MiB burden
>>> smaller machines with bloated processes?
>>
>> The default file size before Git forgets about delta compression is
>> 512MiB.  Unpacking 500MiB files with 16MiB of delta storage is going to
>> be uglier.
>>
>> ...
>>
>> Documentation/config.txt states:
>>
>>     core.deltaBaseCacheLimit::
>>             Maximum number of bytes to reserve for caching base objects
>>             that may be referenced by multiple deltified objects.  By storing the
>>             entire decompressed base objects in a cache Git is able
>>             to avoid unpacking and decompressing frequently used base
>>             objects multiple times.
>>     +
>>     Default is 16 MiB on all platforms.  This should be reasonable
>>     for all users/operating systems, except on the largest projects.
>>     You probably do not need to adjust this value.
>>
>> I've seen this seriously screwing performance in several projects of
>> mine that don't really count as "largest projects".
>>
>> So the description in combination with the current setting is clearly wrong.
>
> That is a good material for proposed log message, and I think you
> are onto something here.
>
> I know that the 512MiB default for the bitFileThreashold (aka
> "forget about delta compression") came out of thin air.  It was just
> "1GB is always too huge for anybody, so let's cut it in half and
> declare that value the initial version of a sane threashold",
> nothing more.
>
> So it might be that the problem is 512MiB is still too big, relative
> to the 16MiB of delta base cache, and the former may be what needs
> to be tweaked.  If a blob close to but below 512MiB is a problem for
> 16MiB delta base cache, it would still be too big to cause the same
> problem for 128MiB delta base cache---it would evict all the other
> objects and then end up not being able to fit in the limit itself,
> busting the limit immediately, no?
>
> I would understand if the change were to update the definition of
> deltaBaseCacheLimit and link it to the value of bigFileThreashold,
> for example.  With the presented discussion, I am still not sure if
> we can say that bumping deltaBaseCacheLimit is the right solution to
> the "description with the current setting is clearly wrong" (which
> is a real issue).

I vote make big_file_threshold smaller. 512MB is already unfriendly
for many smaller machines. I'm thinking somewhere around 32MB-64MB
(and maybe increase delta cache base limit to match). The only
downside I see is large blobs will be packed  undeltified, which could
increase pack size if you have lots of them. But maybe we could
improve pack-objects/repack/gc to deltify large blobs anyway if
they're old enough.
-- 
Duy
