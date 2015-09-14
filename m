From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Mon, 14 Sep 2015 20:18:52 +0530
Message-ID: <CAOLa=ZQR8dJH_tAJX1wFwgTgsA178C9Ok8CvKUixywTbsUK_Eg@mail.gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
 <1442129035-31386-4-git-send-email-Karthik.188@gmail.com> <vpqa8sqv7p1.fsf@anie.imag.fr>
 <CAPig+cTzEQ=+FKa2j2RbfHv_NP35_vPDq1NZCeek8LX9fJF3aQ@mail.gmail.com> <CAPig+cR42jzxeeqpVh2sMojSCVD7Xg4RF6TDfTeg0y10o-2TLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 16:49:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbV4R-0006H9-QH
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 16:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbbINOtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 10:49:23 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34786 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbbINOtW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 10:49:22 -0400
Received: by vkhf67 with SMTP id f67so60606564vkh.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=27FFo/I1czPuodhp4j4bhdDl9zyICiOxLr9+YWf9YIU=;
        b=VB2uHxPGkGtGipdreoXmOnj/LO7YrM4zdlELfCDaXTI9vtCtpjetW48IJUU4TPhYH7
         OQIRhWuXuunphaGMdhi+Oj7Kp9eHPJlkLahF9EgU9RVKSlh4eo/cZtQUkwJzGFtIJLjL
         9nIW7JtSAXvnOYuQL0Rb6BdC6uj6tFkoHuDqqgZsT/osdtBt7hEcbo6WUCNGoigY0vXC
         RSZI9uKW7gcu0clZ+N1Ilc8A+T6NMNzPYA8umnbsOzedkN51YxnAnGfYbvbIgg7CKXRH
         cfy1sHB2hJCHCw6ajpg+vme4GWHFuzXM3lrO8eBcWXLG6jmU52ldRuepGiZF/UURCXlu
         wMrQ==
X-Received: by 10.31.50.196 with SMTP id y187mr13795313vky.142.1442242161759;
 Mon, 14 Sep 2015 07:49:21 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Mon, 14 Sep 2015 07:48:52 -0700 (PDT)
In-Reply-To: <CAPig+cR42jzxeeqpVh2sMojSCVD7Xg4RF6TDfTeg0y10o-2TLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277831>

On Mon, Sep 14, 2015 at 12:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Sep 13, 2015 at 12:46 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Sep 13, 2015 at 8:12 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> @@ -679,15 +682,20 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>>>>       if (verbose)
>>>>               maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
>>>>
>>>> -     qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
>>>> +     index = ref_list.index;
>>>> +
>>>> +     /* Print detached HEAD before sorting and printing the rest */
>>>> +     if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
>>>> +         !strcmp(ref_list.list[index - 1].name, head)) {
>>>> +             print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
>>>> +                            1, remote_prefix);
>>>> +             index -= 1;
>>>> +     }
>>>
>>> I think Eric already mentionned it, but I don't remember the conclusion
>>> and can't find it in the archives. Wouldn't it be cleaner to actually
>>> remove the detached head from the array (do "ref_list.index -= 1"
>>> instead of "index -= 1", and possibly free() what needs to be freed?
>>
>> I think Michael Haggerty mentioned something along those lines...
>
> Specifically, I think you're referring to [1] (?).
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/276363/focus=276676

No not that, that is handled in the previous patch series.

I can't find the reference either, but the comment was along the lines of what
Matthieu just mentioned above, But like I replied on [Patch 6/8] Its
taken care of
in that particular patch. Here it doesn't seem to be needed.

-- 
Regards,
Karthik Nayak
