Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1D2C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 04:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiGVEeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 00:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVEep (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 00:34:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128B081496
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658464484; x=1690000484;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kGD6w6x8OVa4FF/GupuiUtgYzj4IPCVks3CRWAGM7Rw=;
  b=O2n4/1VTrLQFAjNaHAUaQFrGsdjphy6Jkf28yTDGiTQoT2o4OAZl2IK8
   XibmJmCdVFRfKpEfYlKnM0BlIklUWn+HrDT1hWtGk/0F9mF1wzdwEWxbR
   mrP24pSJ5KZLDE0zrowb0P90SxX+fyaIZ+LFxj+aREYTDSSWba7BR8JFo
   1wixJOQa7GhTPK9R2OXLz23RWt8Q4hVhmrgFBuBTLDGw0iwRGVfTROkAK
   wxo/QjYpKA5zvglWbf4BMUk4cAnmdYsaZLqZd5kfuY1xbUPz4iVYl7ypp
   2RAzspI/JDPMrRDdKsgufNKi+QdB0Nf9td5Wf1C9J+RshkyR/rC9IV4rh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="270269070"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="270269070"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 21:34:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="657062032"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.239.13.96]) ([10.239.13.96])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 21:34:42 -0700
Message-ID: <679c7d1f-edf9-3b6f-26dd-848f8ebcd9f7@intel.com>
Date:   Fri, 22 Jul 2022 12:34:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [Bug Report] The since date of "git log" will have influence on
 the until date of it.
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <6cfda280-44bb-cdcc-a6fb-e0e4795edc65@intel.com>
 <xmqqwnc5dbv3.fsf@gitster.g>
From:   "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <xmqqwnc5dbv3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is the git log process involving some random methods? I tested the same 
command of the same repo with the same git version (37.1) on two 
different machines (i.e., just the machine is different), but the output 
is totally different...

BR,
Lei

On 7/22/2022 12:12 PM, Junio C Hamano wrote:
> "Wang, Lei" <lei4.wang@intel.com> writes:
>
>> The since date of "git log --since" will have influence on the until
>> date of it.
>>
>> How to reproduce?
>>
>> 1. clone this repo https://erol.kernel.org/lkml/git/8/
>> 2. run "git log --since="2020-05-30" --until="2020-06-02"", it won't
>>     output anything
>> 3. change the since date to 2020-05-29: run "git log
>>     --since="2020-05-29" --until="2020-06-02""
>> 4. it will output the commits in 2020-06-02 (The until date)
>>
>> Why would that happen, I just change the since date from 2020-05-30 to
>> 2020-05-29, why it suddenly output the commits in 2020-06-02?
> Perhaps there are clock skews in the history recorded in the
> repository?  IOW, some commits have committer dates that are older
> than those of their ancestors?
>
> For example, if you had a commit that has committer date of June 1st
> noon, and one of its children has committer date of May 29th noon,
> starting the history traversal from that misdated child and saying
> "I don't want to see commits before May 30th midnight, so stop the
> traversal immediately if you see a commit with timestamp older than
> that" with "--since=May.30th", the traversal stops even before the
> misdated child is shown.  If you shift the cut-off date and ask to
> stop at May 29th midnight, then the misdated child is newer than
> that cut-off date and would be shown, and its parent, which has the
> date of June 1st, would also be shown.
>
