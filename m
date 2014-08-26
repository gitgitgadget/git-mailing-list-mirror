From: Arjun Sreedharan <arjun024@gmail.com>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required amount
Date: Tue, 26 Aug 2014 13:00:45 +0530
Message-ID: <CAJFMrCFaBGHQqGwpxSChaigOiaNL1OcBKGHjgYoJoDN-d0iE0w@mail.gmail.com>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com> <xmqqd2bol1ad.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 09:31:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMBEC-0003Hf-Az
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 09:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933949AbaHZHbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 03:31:08 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:60622 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933944AbaHZHbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 03:31:07 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so13363630qaj.21
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 00:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UG6WdYwjUPKtnlVwSNnk85IL5+81R/2YuoiF3Mp38/0=;
        b=dVZFgQLhRFpetdSxpkc4pLyK7CyML2qNqc08UMi69FoERWUy+MFhqY+cpr7ha3UidV
         YYFHtUmvIN5ZICedC4IIsV5QMtADzlfKG8N9JSZ2a0X2J2yYb3M0YC9RMKdxeFRD05HQ
         ql7Nji53bXZ85XVIiIddjwEPOyJLoNJfcOLuL/xunAp9RLCuZSAWWN9htpvGN5dnYG0q
         JYnJpoqjIP++O+O8oXU4U749KyP95/QUMAoV+hXpN71pcPK8lqBN5dwAm0v6SB3mmb3E
         Oq98UiJNfORD7Q2mZqxfseeSIC0NHfXPQen5DJ0npuPQqqIxQ9qtH9wXwsP5K6j/tCxe
         WBlg==
X-Received: by 10.140.89.5 with SMTP id u5mr41471659qgd.14.1409038265624; Tue,
 26 Aug 2014 00:31:05 -0700 (PDT)
Received: by 10.140.255.215 with HTTP; Tue, 26 Aug 2014 00:30:45 -0700 (PDT)
In-Reply-To: <xmqqd2bol1ad.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255880>

On 26 August 2014 02:44, Junio C Hamano <gitster@pobox.com> wrote:
> Arjun Sreedharan <arjun024@gmail.com> writes:
>
>> Find and allocate the required amount instead of allocating extra
>> 100 bytes
>>
>> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
>> ---
>
> Interesting.  How much memory do we typically waste (in other words,
> how big did "cnt" grew in your repository where you noticed this)?
>

I did not try to make an observation of that. I was thinking we're
anyway better off
not using a magic number to allot memory on the heap for each item in
the commit list.

>>  bisect.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/bisect.c b/bisect.c
>> index d6e851d..c96aab0 100644
>> --- a/bisect.c
>> +++ b/bisect.c
>> @@ -215,10 +215,13 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
>>       }
>>       qsort(array, cnt, sizeof(*array), compare_commit_dist);
>>       for (p = list, i = 0; i < cnt; i++) {
>> -             struct name_decoration *r = xmalloc(sizeof(*r) + 100);
>> +             char name[100];
>> +             sprintf(name, "dist=%d", array[i].distance);
>> +             int name_len = strlen(name);
>
> Decl-after-stmt.
>
> You do not have to run a separate strlen() for this.  The return
> value from sprintf() should tell you how much you need to allocate,
> I think.
>

Yes. yes.

>> +             struct name_decoration *r = xmalloc(sizeof(*r) + name_len);
>>               struct object *obj = &(array[i].commit->object);
>>
>> -             sprintf(r->name, "dist=%d", array[i].distance);
>> +             memcpy(r->name, name, name_len + 1);
>>               r->next = add_decoration(&name_decoration, obj, r);
>>               p->item = array[i].commit;
>>               p = p->next;
