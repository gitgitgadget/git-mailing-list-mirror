From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Thu, 17 Sep 2015 15:17:06 +0530
Message-ID: <CAOLa=ZQxounTiJk0t+zB2-7=UQa8oL+uJ9EQpTkWL7kYFHjxwQ@mail.gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
 <1442129035-31386-4-git-send-email-Karthik.188@gmail.com> <xmqqzj0ovlno.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQ51+TKvOiJvWa-emmJJGirAqkr9m0a_7BrQ2UbiSJdjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 11:48:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcVnL-0003ET-7w
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 11:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbbIQJru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 05:47:50 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33762 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbbIQJrg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 05:47:36 -0400
Received: by vkgd64 with SMTP id d64so7542896vkg.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PZkdYaS6O/NEY0f/gO6Ojn1uffQ+cJHO9tcJkyCdbIo=;
        b=aR1CuXnMToDjqy28hObMPGb8otlbyoOm6p4UcwH59mX+04Wi0RMzkshW9BetSRa/nY
         hBpzaGnUEPavq0v3pqUX21gA2B2ZNEayXqA0FrUPZPEAWkdQO2Ohp67N18vVu9jKjCvy
         Vb+DrYFPZbFDSpq2Jjb+OkDdvhr0RN2uQQRpyEZTXkR4dNJkH3bEGQM4JD7qVdpqM9bU
         6Scwm1+fyEflGduY67syObxQ5Xo3+ZInvUAgwJv0n6o7OqwisN3JP+TTPGE6maThskus
         57xv1e9Iaye6guC0InQyuZ+HJOYmchjuk8ihoqxPdKSovUz84hlYraCxp7JKeGq5DW2j
         vpOQ==
X-Received: by 10.31.21.149 with SMTP id 143mr34102057vkv.79.1442483255745;
 Thu, 17 Sep 2015 02:47:35 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Thu, 17 Sep 2015 02:47:06 -0700 (PDT)
In-Reply-To: <CAOLa=ZQ51+TKvOiJvWa-emmJJGirAqkr9m0a_7BrQ2UbiSJdjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278103>

On Wed, Sep 16, 2015 at 11:53 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Tue, Sep 15, 2015 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> +     /*
>>> +      * First we obtain all regular branch refs and if the HEAD is
>>> +      * detached then we insert that ref to the end of the ref_fist
>>> +      * so that it can be printed and removed first.
>>> +      */
>>>       for_each_rawref(append_ref, &cb);
>>> +     if (detached)
>>> +             head_ref(append_ref, &cb);
>>> +     index = ref_list.index;
>>> +
>>> +     /* Print detached HEAD before sorting and printing the rest */
>>> +     if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
>>> +         !strcmp(ref_list.list[index - 1].name, head)) {
>>> +             print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
>>> +                            1, remote_prefix);
>>> +             index -= 1;
>>> +     }
>>>
>>> +     qsort(ref_list.list, index, sizeof(struct ref_item), ref_cmp);
>>
>> This looks somewhat strange.  Wouldn't it be more consistent to
>> teach ref_cmp that HEAD sorts where in the collection of refs (I
>> presume that kind is checked first and then name, so if you give
>> REF_DETACHED_HEAD a low number than others, it would automatically
>> give you the ordering you want) without all of the above special
>> casing?
>
> Thats nice, we could do that, something like this perhaps:
>
>     qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
>
>     for (i = 0; i < ref_list.index; i++) {
>         int current = !detached && (ref_list.list[i].kind ==
> REF_LOCAL_BRANCH) &&
>             !strcmp(ref_list.list[i].name, head);
>         /*  If detached the first ref_item is the current ref */
>         if (detached && i == 0)
>             current = 1;
>         print_ref_item(&ref_list.list[i], maxwidth, verbose,
>                    abbrev, current, remote_prefix);
>     }
>

Although this solves the problem here, we'd still need to do something
similar when we use ref-filter APIs as in [PATCH 7/8].

So either we could introduce a new atom for sorting something like
`branch_sort` which uses the FILTER_REFS_(DETACHED_HEAD | BRANCHES | REMOTES)
to sort or we could sort after printing the detached head, as done in
this series.
I'm ok with either.

-- 
Regards,
Karthik Nayak
