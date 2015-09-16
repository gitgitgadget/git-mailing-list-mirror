From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Wed, 16 Sep 2015 11:53:15 +0530
Message-ID: <CAOLa=ZQ51+TKvOiJvWa-emmJJGirAqkr9m0a_7BrQ2UbiSJdjA@mail.gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
 <1442129035-31386-4-git-send-email-Karthik.188@gmail.com> <xmqqzj0ovlno.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 08:23:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc68J-0004ai-Ow
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 08:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbbIPGXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 02:23:46 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36366 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbbIPGXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 02:23:45 -0400
Received: by vkfp126 with SMTP id p126so94408461vkf.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 23:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=b99yaOYWeYp2eiSW8oX1k1jNrm4NOAr/LGr0GIjD2KA=;
        b=qwmTt3+x+LglHVKd6mMkcvuqLL9VLnAJsKMm2iBBnijFpIRTAkTcHZk2XRXlkS/li/
         fNRhK6lenWyBarknBUo/veLqcosURLIMPDQkL/TzKYc8tG9oy02dWdrxNrYQU/q/gY1A
         3KbsnLEfapY+JACurHUg9gNAOcJGZJhnCbJ6sJaR6AcxWMT1H0vFBVeRGvJGszylorHF
         jn53Nyn9MiGmmLeIxG/vOWdOH9eCIkUgOUGB5W9Qg0f3wB1eKxmDh/xrlxYB1zuOnqey
         /ok+22qfr9jvkmMquw69C8yFw2bs4SFq4eiIFDNb7+zBqqQJK9qfMcjUxDAroUIOzERh
         kKtQ==
X-Received: by 10.31.149.143 with SMTP id x137mr26430684vkd.17.1442384625127;
 Tue, 15 Sep 2015 23:23:45 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Tue, 15 Sep 2015 23:23:15 -0700 (PDT)
In-Reply-To: <xmqqzj0ovlno.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278004>

On Tue, Sep 15, 2015 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +     /*
>> +      * First we obtain all regular branch refs and if the HEAD is
>> +      * detached then we insert that ref to the end of the ref_fist
>> +      * so that it can be printed and removed first.
>> +      */
>>       for_each_rawref(append_ref, &cb);
>> +     if (detached)
>> +             head_ref(append_ref, &cb);
>> +     index = ref_list.index;
>> +
>> +     /* Print detached HEAD before sorting and printing the rest */
>> +     if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
>> +         !strcmp(ref_list.list[index - 1].name, head)) {
>> +             print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
>> +                            1, remote_prefix);
>> +             index -= 1;
>> +     }
>>
>> +     qsort(ref_list.list, index, sizeof(struct ref_item), ref_cmp);
>
> This looks somewhat strange.  Wouldn't it be more consistent to
> teach ref_cmp that HEAD sorts where in the collection of refs (I
> presume that kind is checked first and then name, so if you give
> REF_DETACHED_HEAD a low number than others, it would automatically
> give you the ordering you want) without all of the above special
> casing?

Thats nice, we could do that, something like this perhaps:

    qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);

    for (i = 0; i < ref_list.index; i++) {
        int current = !detached && (ref_list.list[i].kind ==
REF_LOCAL_BRANCH) &&
            !strcmp(ref_list.list[i].name, head);
        /*  If detached the first ref_item is the current ref */
        if (detached && i == 0)
            current = 1;
        print_ref_item(&ref_list.list[i], maxwidth, verbose,
                   abbrev, current, remote_prefix);
    }

-- 
Regards,
Karthik Nayak
