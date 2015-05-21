From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/4] for-each-ref: convert to ref-filter
Date: Thu, 21 May 2015 12:21:44 +0530
Message-ID: <555D8080.1020504@gmail.com>
References: <555C88C2.8060902@gmail.com>	<1432127904-21070-3-git-send-email-karthik.188@gmail.com> <xmqqvbfmlsfu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 08:51:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvKKg-0005Cq-TO
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 08:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbbEUGvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 02:51:50 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36619 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbbEUGvt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 02:51:49 -0400
Received: by pdfh10 with SMTP id h10so97643177pdf.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 23:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kwVX1LtPtPIqj6X2TIh+Jm1IeN6+BpYgPdsCoCI1pVg=;
        b=TmAYdjV6Zo9QMcxuJV0nkXYe2COU0YnEowdbHi/r40Ndk/zb75irWyR7FNjuJuCTE4
         l8t+91fQvWzGbbkctBT5DRIJyhGxWsO9Z9goOtnCzD3l4px2sJvEFiR+kuEiLvzKSrWZ
         SLw6wbqd5jZ8OSoDxnmQpKFG5qYMvK0emRzVHJ1Y5zV6GovhO1Kb2Y4XSQCzyfVFMe3l
         yNzOTYMozV8O8p0DHs+jkNovqPqsIgIDP8Vfq3odFETiZx9uy3/1JJNtQEG+UMkWwyxV
         zM/Sabl2T6N7VFonJbqPi/aDcXtyIBcpsGXbkMg3Rhhy7wQVwmvw4E6Uap87FJlWjmcc
         FyEg==
X-Received: by 10.70.16.65 with SMTP id e1mr2593656pdd.87.1432191109256;
        Wed, 20 May 2015 23:51:49 -0700 (PDT)
Received: from [192.168.0.104] ([103.227.98.178])
        by mx.google.com with ESMTPSA id ue9sm18071758pbc.78.2015.05.20.23.51.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 23:51:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqvbfmlsfu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269562>



On 05/21/2015 05:20 AM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> convert 'for-each-ref' to use the common API provided by 'ref-filter'.
>
> Start a sentence with capital?
>
> More importantly, the above is misleading, as if you invented a new
> ref-filter API and made for-each-ref build on that new
> infrastructure.
>
> This series is in a form that is very unfriendly to reviewers.  The
> previous step did not introduce any callers to ref-filter, so for
> the purpose of review, it needs to be read together with this step
> anyway.
>
> And when reading these patches that way, what this half is really
> doing is to move the code from for-each-ref to ref-filter, but it
> does unnecessary or unrelated renaming of a handful of symbols.  It
> makes it even harder to compare and contrast the original code that
> was in the original for-each-ref and moved code that ends up in the
> new ref-filter.  Don't do that.
>
> You would probably want to organize them in these two steps instead:
>
>   * Rename symbols as necessary while all the code is still in
>     for-each-ref. Do not create ref-filter in this step. Justify it
>     along the lines of "some symbol names were fine while they were
>     file scope static implementation detail of for-each-ref, but we
>     will make the machinery available from other commands by moving
>     it to a library-ish place, so rename X to foo_X to clarify that
>     this is about foo (which is now necessary as it is not specific
>     to for-each-ref"...
>
>   * If you want to do other tweaks like wrapping refs & num_refs into
>     a single structure, do so while the code is still in
>     for-each-ref.  You can do that in the same patch as the above
>     (i.e. it's just part of preparatory step for a move).
>
>   * Create ref-filter by _moving_ code from for-each-ref. Do not
>     touch these moved lines in this step. You would need to add
>     include at the top of for-each-ref and ref-filter, of course.
>
Thanks for the suggestion's Junio, will follow with the path you've 
mentioned.
>
>> -	for_each_rawref(grab_single_ref, &cbdata);
>> -	refs = cbdata.grab_array;
>> -	num_refs = cbdata.grab_cnt;
>> +	refs.name_patterns = argv;
>> +	for_each_rawref(ref_filter_add, &refs);
>
> I think ref_filter_add() may be misnamed as a public API function.
> grab_single_ref() was OK only because it was an implementation
> dtail, but if you are making it public, the name should make it
> clear that it is meant to be used as a for_each_*ref() callback
> function.  Otherwise people may be tempted to add random parameter
> to it in the future, but the signature of that function is dictated
> by for_each_*ref() API.
>

Looking through the current each_ref_f() names, I thought I could use
'ref_filter_handler()' instead of 'ref_filter_add()', as per your 
suggestion. What do you think?
