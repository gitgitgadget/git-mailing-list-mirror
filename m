From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 5/9] ref-filter: add option to match literal pattern
Date: Tue, 30 Jun 2015 19:06:37 +0530
Message-ID: <CAOLa=ZSfpjumz6Cu7O3DF8vmVGofpibiJmpPo4irjn32f9WHxg@mail.gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
 <1435232596-27466-1-git-send-email-karthik.188@gmail.com> <1435232596-27466-5-git-send-email-karthik.188@gmail.com>
 <xmqqy4j29y0o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 15:37:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9vir-0001Al-8r
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 15:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbbF3NhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 09:37:09 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34648 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbbF3NhH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 09:37:07 -0400
Received: by obbkm3 with SMTP id km3so6501448obb.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Y6hv/90qqVTuskLxySRVkv/HsTbHWqYI9K2LlgpmwiQ=;
        b=i04QcrE+J6abM29bss5FLAs7tcN41H/EXdS3TyxTJO0F7Ia25VoGRQYpyyJlNgHC5B
         OhrlX/euikAH4yXfjF9CSSRD4OnSk8PJkTz9Fb4CYKdAEfNhnN4b25AOhS3grGs1dEEi
         fGrnha8tJZPUqblXAM9b3sa+MtVLwUn4zKXFm5AmtqVArhSMu9kIoSy56gwnWDKBaWDj
         KIHWgs8hj2ssTI6Kj/X4b1cWG85BkP1CjZSxFzUSPCTLDOdjx7mQwYjHkukqeCLXpzm1
         E7Vzd+hwEiNTa2TjAySElMWkptNPKwmbM+GcdZOf7AAeJ5TkPjjfhGsicLiGIl2poxvE
         Y79w==
X-Received: by 10.60.36.165 with SMTP id r5mr19320966oej.84.1435671426951;
 Tue, 30 Jun 2015 06:37:06 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Tue, 30 Jun 2015 06:36:37 -0700 (PDT)
In-Reply-To: <xmqqy4j29y0o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273062>

On Mon, Jun 29, 2015 at 11:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Since 'ref-filter' only has an option to match path names.
>
> That is not a whole sentence ;-)
>

Argh! Noted.

>> Add an option for regular pattern matching.
>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
>> -     if (flag & REF_BAD_NAME) {
>> -               warning("ignoring ref with broken name %s", refname);
>> -               return 0;
>> -     }
>> -
>
> Hmm, where did this check go in the new code?  Or is it now OK not
> to warn or ignore, and if so why?
>

Merge conflict, I've replied with a fixing patch, shouldn't be there
in the next version :)

>>       if (flag & REF_ISBROKEN) {
>>               warning("ignoring broken ref %s", refname);
>>               return 0;
>>       }
>>
>> -     if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
>> +     if (!filter_pattern_match(filter, refname))
>>               return 0;
>>
>>       if (!match_points_at(&filter->points_at, oid->hash, refname))
>
>> diff --git a/ref-filter.h b/ref-filter.h
>> index 6b6fb96..a4809c8 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -54,7 +54,8 @@ struct ref_filter {
>>       } merge;
>>       struct commit *merge_commit;
>>
>> -     unsigned int with_commit_tag_algo: 1;
>> +     unsigned int with_commit_tag_algo: 1,
>> +             match_as_path: 1;
>
> Lose SP on both sides of the colon, or have SP on both sides
> (same for the last patch in the previous series).

Will Do!

Thanks for the quick review.

-- 
Regards,
Karthik Nayak
