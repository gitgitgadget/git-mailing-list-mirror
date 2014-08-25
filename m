From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required amount
Date: Mon, 25 Aug 2014 16:06:52 +0200
Message-ID: <CAP8UFD2FAfg5GenJXOkOsjU9vmCO3R3Difp6-mrP_cp4zXQENg@mail.gmail.com>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
	<20140825133550.GE17288@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Arjun Sreedharan <arjun024@gmail.com>, git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 16:07:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLuvJ-0005VO-Cs
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 16:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932941AbaHYOGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 10:06:54 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36733 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923AbaHYOGx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 10:06:53 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so2815296igd.8
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=71d8xfqQahhpMB8aqOSu2rQFwFkMvrx0D6vNxjfyfQo=;
        b=FO83c68+UtQ2m88+02F54r+kxcoGR3RO0SmXdiaavFWMkaD56ds52Z/sJoWsa9EwOg
         gLnGxB3ecJP3nu/UsrH5NaFMZBEWPNE55vxdWcH+aL3Lxt1lTgvkKgFLEMkY7zY7xMZF
         q7udzgQ8QZzBcLxPTJivSS6nNbjGRhlMhqtsF2JshXe4KOsGWEwbmiN0L6H2T5HuWQXK
         eDuX/jZ0HZauZGeh5CHc8NdvXKIQxu2Z8SgNe6gdRwnhQ1cRPr8/uJ5kRmtvUdIVTDT2
         5Hh8CxFaVcGFjWKCtt4/bF1tEz2ASL89Zh1maJogf0Tfbv3pE3YrW9VFDVFvgeXXPEFY
         hhpQ==
X-Received: by 10.43.149.200 with SMTP id kl8mr6492614icc.52.1408975612270;
 Mon, 25 Aug 2014 07:06:52 -0700 (PDT)
Received: by 10.50.212.3 with HTTP; Mon, 25 Aug 2014 07:06:52 -0700 (PDT)
In-Reply-To: <20140825133550.GE17288@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255826>

On Mon, Aug 25, 2014 at 3:35 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Aug 24, 2014 at 07:47:24PM +0530, Arjun Sreedharan wrote:
>
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
>> +             struct name_decoration *r = xmalloc(sizeof(*r) + name_len);
>
> This allocation should be name_len + 1 for the NUL-terminator, no?

I wondered about that too, but as struct name_decoration is defined like this:

struct name_decoration {
        struct name_decoration *next;
        int type;
        char name[1];
};

the .name field of this struct already has one char, so the allocation
above should be ok.

> It looks like add_name_decoration in log-tree already handles half of
> what you are adding here. Can we just make that available globally (it
> is manipulating the already-global "struct decoration name_decoration")?

Yeah, it looks like it should be better.

Note that add_name_decoration() does:

int nlen = strlen(name);
struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + nlen);

so it also relies on the fact that .name contains one char.

> I also notice that we do not set r->type at all, meaning the decoration
> lookup code in log-tree will access uninitialized memory (worse, it will
> use it as a pointer offset into the color list; I got a segfault when I
> tried to run "git rev-list --bisect-all v1.8.0..v1.9.0").
>
> I think we need this:
>
> diff --git a/bisect.c b/bisect.c
> index d6e851d..e2a7682 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -219,6 +219,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
>                 struct object *obj = &(array[i].commit->object);
>
>                 sprintf(r->name, "dist=%d", array[i].distance);
> +               r->type = 0;
>                 r->next = add_decoration(&name_decoration, obj, r);
>                 p->item = array[i].commit;
>                 p = p->next;
>
> at a minimum.

Yeah if we don't use add_name_decoration() we would need that.
Thanks for noticing.

> It looks like this was a regression caused by eb3005e (commit.h: add
> 'type' to struct name_decoration, 2010-06-19). Which makes me wonder if
> anybody actually _uses_ --bisect-all (which AFAICT is the only way to
> trigger the problem), but since it's public, I guess we should keep it.

Yeah, we should probably keep it.

> I think the sane thing here is to stop advertising name_decoration as a
> global, and make all callers use add_name_decoration. That makes it
> easier for callers like this one, and would have caught the regression
> caused be eb3005e (the compiler would have noticed that we were not
> passing a type parameter to the function).

I agree.

Thanks,
Christian.
