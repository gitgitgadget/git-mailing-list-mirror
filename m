From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 10/11] for-each-ref: introduce filter_refs()
Date: Tue, 09 Jun 2015 00:07:31 +0530
Message-ID: <5575E0EB.5030704@gmail.com>
References: <1433598496-31287-10-git-send-email-karthik.188@gmail.com>	<1433673373-16441-1-git-send-email-karthik.188@gmail.com> <xmqqd216awxz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:37:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z21va-00063d-3m
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbbFHShi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:37:38 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33689 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbbFHShh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:37:37 -0400
Received: by pdjn11 with SMTP id n11so72609341pdj.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=c7qq9Og8dAnRSXxcH3y+5LxKKSJom68Qx9a4RJke31w=;
        b=mImqRsQedgRdwwXdD398wdKQBmSz4aNRk4fzyr8YMfPMMD9CHFiQ8FgLZ0O1/GYYWv
         hK9QQ3tJ09oRFnhSPyD18yi03gZ3s2mm18M2tms40qwaF9HXAQBNHAd4ESBuYLrHnwH8
         8je16Iuw40dxUUjNm/DC8hQFwBJHRBjCexwi2/Uk+fUjVwYNsM2ljqA5Pmn67Nd225hD
         mwtH4OvlZqYzdZ5u+kzSSxFE/3PWsTiKKO2KzEVB0KjNxBme3oxWnQ9tfqfppEExYNg2
         5pxV6JiT5a4yjnymFmGEpWBs1Q7OgMhZaCf4AF4jgs7LvBV+y4GcYmvKtF24Du7yWbYB
         NUPQ==
X-Received: by 10.68.179.228 with SMTP id dj4mr31319418pbc.141.1433788656435;
        Mon, 08 Jun 2015 11:37:36 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id j9sm3272727pdm.53.2015.06.08.11.37.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 11:37:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqd216awxz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271105>

On 06/08/2015 11:45 PM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +/*
>> + * API for filtering a set of refs. The refs are provided and iterated
>> + * over using the for_each_ref_fn(). The refs are stored into and filtered
>> + * based on the ref_filter_cbdata structure.
>> + */
>> +int filter_refs(int (for_each_ref_fn)(each_ref_fn, void *), struct ref_filter_cbdata *data)
>> +{
>> +	return for_each_ref_fn(ref_filter_handler, data);
>> +}
>
> I do not think it is such a good idea to allow API callers to
> specify for-each-ref-fn directly.  See my message in an earlier
> review.
 >

I did read your previous message. I misunderstood some things.

>
> I also think ref_filter_cbdata is an implementation detail of
> filter_refs and may not have to be exposed to the API callers.
> It probably is more sensible for them to pass
>
>   - an array of refs to receive filtered results (your ref_array thing)
>   - the criteria to use when filtering (your ref_filter thing)
>

This could be done.

 >
> as two separate parameters to this function, together with other
> parameters that lets you (meaning the implementation of filter_refs())
> to decide which for-each-ref iterator to call, e.g. do you want to
> use raw iteration?  do you want to iterate only over refs/heads? etc.
>
> In other words, the caller of this API should not have to know that
> you (meaning the implementation of filter_refs()) are internally
> using for_each_ref() API.
>

I'm a little confused about this, how exactly do you propose we go about 
doing something like this? I mean, usually the user of the API
knows what exactly they want, like in tag.c, branch.c and for-each-ref.c
But I'm not sure what you mean by "parameters that lets you (meaning the 
implementation of filter_refs()) to decide which for-each-ref iterator 
to call". A small example maybe? Thanks!

-- 
Regards,
Karthik
