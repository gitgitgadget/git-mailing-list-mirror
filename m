From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 04/10] branch: roll show_detached HEAD into regular ref_list
Date: Tue, 11 Aug 2015 18:47:31 +0530
Message-ID: <CAOLa=ZRVr9a8kj+MLbi7ybYCHJVdHrX42vzMRU8PS6nvHmB_og@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
 <1438693282-15516-4-git-send-email-Karthik.188@gmail.com> <CAPig+cRvdpv_NO8jCrWmFfpuQ+mcxaC5P_oHVrU+tQoH9DKnkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 15:18:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP9RR-0001R4-4N
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 15:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbbHKNSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 09:18:03 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:32951 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934136AbbHKNSB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 09:18:01 -0400
Received: by obbhe7 with SMTP id he7so51537839obb.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VswQjvXbeVKw6W7g0Y3RAtq6GXGQgzfwfhYzsFBqqbo=;
        b=c6+b33Ir7s4pF95PQ5x62cGD7yII/Rmmhqy1nILSrwOvjnsYXCKH1EvWdifVJ1Qysx
         dCwX9j9LR8pUVvalu5yMpSKmPk/PmUz2gNXi+QjXVYiMo0aVoVWuHTPMlohXPNRmE4tK
         eaTXPN84YT19RWVA/k2v2H4jq5aVKPMc3b3KwKc4Fu+zmZ1Qnnhugh0CVbRJRz7Zoqd4
         pIzOhXPik2YO41zfZF/1Yg9j4SuCAal1RttqUGH+aS37ES3qW33vno75gJgeGD42r/k8
         48/AukcvAn26ImFdq47BDbvIqF1KFIsfALYH5wHYyoAN5lyW7n7EWPMpOw2pDAij1dsq
         8gIA==
X-Received: by 10.60.92.37 with SMTP id cj5mr24543827oeb.30.1439299081049;
 Tue, 11 Aug 2015 06:18:01 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 11 Aug 2015 06:17:31 -0700 (PDT)
In-Reply-To: <CAPig+cRvdpv_NO8jCrWmFfpuQ+mcxaC5P_oHVrU+tQoH9DKnkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275689>

On Tue, Aug 11, 2015 at 8:11 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Aug 4, 2015 at 9:01 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Remove show_detached() and make detached HEAD to be rolled into
>> regular ref_list by adding REF_DETACHED_HEAD as a kind of branch and
>> supporting the same in append_ref(). This eliminates the need for an
>> extra function and helps in easier porting of branch.c to use
>> ref-filter APIs.
>>
>> Before show_detached() used to check if the HEAD branch satisfies the
>> '--contains' option, now that is taken care by append_ref().
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 65f6d0d..81815c9 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -535,6 +540,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>>         int color;
>>         struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
>>         const char *prefix = "";
>> +       const char *desc = item->name;
>>
>>         if (item->ignore)
>>                 return;
>> @@ -547,6 +553,10 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>>                 color = BRANCH_COLOR_REMOTE;
>>                 prefix = remote_prefix;
>>                 break;
>> +       case REF_DETACHED_HEAD:
>> +               color = BRANCH_COLOR_CURRENT;
>> +               desc = get_head_description();
>> +               break;
>>         default:
>>                 color = BRANCH_COLOR_PLAIN;
>>                 break;
>> @@ -558,7 +568,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>>                 color = BRANCH_COLOR_CURRENT;
>>         }
>>
>> -       strbuf_addf(&name, "%s%s", prefix, item->name);
>> +       strbuf_addf(&name, "%s%s", prefix, desc);
>>         if (verbose) {
>>                 int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
>>                 strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
>> @@ -581,6 +591,8 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>>         }
>>         strbuf_release(&name);
>>         strbuf_release(&out);
>> +       if (item->kind == REF_DETACHED_HEAD)
>> +               free((void *)desc);
>
> This would be cleaner, and more easily extended to other cases if you
> used a 'to_free' variable. For instance, something like this:
>
>     const char *desc = item->name;
>     char *to_free = NULL;
>     ...
>     case REF_DETACHED_HEAD:
>         ...
>         desc = to_free = get_head_description();
>         break;
>     ...
>     strbuf_addf(&name, "%s%s", prefix, desc);
>     ...
>     free(to_free);
>

This looks neater!

> Note that it's safe to free 'to_free' when it's NULL, so you don't
> need to protect the free() with that ugly specialized 'if' which
> checks for REF_DETACHED_HEAD. You can also do away with the "cast to
> non-const" when freeing.
>

Yea makes sense will change to what you suggested.

>>  }
>> @@ -642,7 +638,14 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>>         cb.ref_list = &ref_list;
>>         cb.pattern = pattern;
>>         cb.ret = 0;
>> +       /*
>> +        * First we obtain all regular branch refs and then if the
>
> s/then//
>

Thanks

-- 
Regards,
Karthik Nayak
