From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Sat, 23 May 2015 18:04:27 +0200
Message-ID: <CAP8UFD0CPLcTGYTo1Oh_QFxVkORBZF2SmwRYu0O8do66qmakPw@mail.gmail.com>
References: <555C88C2.8060902@gmail.com>
	<1432127904-21070-2-git-send-email-karthik.188@gmail.com>
	<vpqr3qagvv6.fsf@anie.imag.fr>
	<555E1CE7.8090507@gmail.com>
	<vpqbnhd157k.fsf@anie.imag.fr>
	<555F252C.2060601@gmail.com>
	<vpq8ucffj8h.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: karthik nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat May 23 18:06:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwBwI-0006Ym-4q
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 18:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757928AbbEWQEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 12:04:30 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35419 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757938AbbEWQE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 12:04:29 -0400
Received: by wgfl8 with SMTP id l8so41481243wgf.2
        for <git@vger.kernel.org>; Sat, 23 May 2015 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OrrcR78LP5XhAvyIJaEP/SUMyATMj5/aSCMg8Xi2dnw=;
        b=zvbRxqWhT+ooVxakoBuJybXQOhfeS7K6m613XZScMLeMXH7TZkjsufIcDHE1O023s9
         25pQoGKql78uGrAd+B5jmJ7KiQK1pJVge3kke+nFAdCJk1bWkGzRLUrtPg2SShb1x79Z
         yL47hfhYki9xHquB3/ecALgsmah1n1Es5z1GvFRzYp5yPWfiTcuYQ1SpMIvjVlFfKG/0
         ycuOg74qRu2S648TfJDTaKyK3WlfwQ7qQ4caD562q8uLhpYy+d6/MyweVuf7Cg1I46Xv
         fNNFZ9NZUVSx8jQLtJyFkcxBO9f1e3lbaqdq8zmXlXSE3t7JhadEHIb7FN3kgcc+Vo6q
         au1A==
X-Received: by 10.180.88.99 with SMTP id bf3mr16964108wib.75.1432397067764;
 Sat, 23 May 2015 09:04:27 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sat, 23 May 2015 09:04:27 -0700 (PDT)
In-Reply-To: <vpq8ucffj8h.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269805>

On Sat, May 23, 2015 at 4:42 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
>>> At some point, I'd expect something like
>>>
>>>    filtered_list_of_refs = filer(full_list_of_refs, description_of_filter);
>>>
>>> That would remove some refs from full_list_of_refs according to
>>> description_of_filter.
>>>
>>> (totally invented code, only to show the idea)
>>>
>>> If there's a piece of code looking like this, then you need a data
>>> structure to store list of refs (full_list_of_refs and
>>> filtered_list_of_refs) and another to describe what you're doing with it
>>> (description_of_filter).
>>>
>>> The name ref_filter implies to me that it contains the description of
>>> the filter, but looking at the code it doesn't seem to be the case.
>>>
>>
>> But it does just that, doesn't it?
>>
>> struct ref_filter {
>>       int count, alloc;
>>       struct ref_filter_item **items;
>>       const char **name_patterns;
>> };
>>
>> If you see it does contain 'name_patterns' according to which it will
>> filter the given refs,
>
> But it also contains struct ref_filter_item **items, which as I
> understand it contains a list of refs (with name, sha1 & such).
>
> That's the part I do not find natural: the same structure contains both
> the list of refs and the way it should be filtered.
>
> Re-reading the patch, I seem to understand that you're putting both on
> the same struct because of the API of for_each_ref() which takes one
> 'data' pointer to be casted, so you want both the input (filter
> description) and the output (list of refs after filtering) to be
> contained in the same struct.
>
> But I think this could be clearer in the code (and/or comment + commit
> message). Perhaps stg like:
>
> struct ref_filter_data /* Probably not the best name */ {
>         struct ref_list list;
>         struct ref_filter filter;
> };
>
> struct ref_list {
>         int count, alloc;
>         struct ref_filter_item **items;
>         const char **name_patterns;
> };

Matthieu, I think you forgot to remove "const char **name_patterns;"
in the above struct, as you put it in the "ref_filter" struct below:

> struct ref_filter {
>         const char **name_patterns;
>         /* There will be more here later */
> };

I agree that it might be clearer to separate both. In this case
instead of "ref_list" the struct might be called "ref_filter_array" as
we already have "argv_array" in argv-array.h and "sha1_array" in
"sha1-array.h".
