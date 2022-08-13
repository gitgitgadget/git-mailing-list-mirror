Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC21EC19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 10:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbiHMKP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 06:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMKPz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 06:15:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22D011836
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660385754; x=1691921754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6TpTlOuFmzFUPGTE2j0XAdx5OzagIeW5D9CxltnMj9E=;
  b=J/ZmuaoX3SZ+QsmUAOv4jjhAql2SpW2ID9jGRrZxSO9C53st2nj1g0hR
   ke7Uvcta3vZEBds/OMyKwUF+IK/1pIlWkUwpb+nsGdz32avLCbdjRBkhd
   rIXMl4xHSl5HfIPeZzHk1jbXOYBUWLZAaa1Hs94/dFMipE9bZB8IKGH5H
   6yrG5Ne7CQ0Ws6JKvWgBK4Cd1g5EC82LjcgR9hehw1uKsLfBDvc4/R9cu
   9J/Fls8+lJ70QPKQS82n8w9Bfof2BHC1fa1C1VmF6d7AHfEfnCNpg3k+X
   b1JYqdl9V9KcEJzPc4yn12T0O3znparwQBr1LPQtRmdMfXhhWFiKOTZtr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291742556"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="291742556"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 03:15:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="666121492"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.254.213.221]) ([10.254.213.221])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 03:15:53 -0700
Message-ID: <27fe218d-886d-2c26-e436-104acd2b9bf6@intel.com>
Date:   Sat, 13 Aug 2022 18:15:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [Question]: Does "git log" involve some stochastic operations?
Content-Language: en-US
To:     Chris Torek <chris.torek@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <20d7c54f-7438-1124-7a9e-fdc902a4cc18@intel.com>
 <CAPx1GveLZm0NH7hBqRSKHJMXttT8Wwnqm3ebjUEpbEXNwh+61w@mail.gmail.com>
From:   "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <CAPx1GveLZm0NH7hBqRSKHJMXttT8Wwnqm3ebjUEpbEXNwh+61w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wonderful! That make sense that each time I do the calculation, the 
result will be slightly different.

BR,
Lei

On 8/13/2022 10:35 AM, Chris Torek wrote:
> On Fri, Aug 12, 2022 at 7:11 PM Wang, Lei <lei4.wang@intel.com> wrote:
>>   > git log --numstat --since="2022-06-01" --until="2022-06-21"
>> --no-merges --format=%n%n%s%n%H%n%cs%n%an\<%ae
>>
>> The number of the commits in the output is slightly different. I didn't
>> do any sync operation in the repo, so the only reason I can found is
>> that maybe git log involves some stochastic operations, so each time the
>> output will be a little changed. Is my assumption right?
> The `--since` and `--until` date values use the *current time* if you do
> not specify an exact time.  For instance, "yesterday" means "precisely
> 24 hours ago" (86400 seconds ago), and "--since 2022-06-01" means
> "since 1 June 2022 at whatever time of day it is right now".  If you want
> commits with timestamps that are since *midnight* on that day, include
> the midnight part in the date.
>
> (This is probably a UX bug, of sorts: to mean "at now-oclock on a given
> date" we should probably have a syntax like "2022-06-21:(now)" and
> when a specific date is given, the default should be midnight for "since"
> and 23:59:59 for "until", or 23:59:60 if that's a leap-second date.  But
> changing this is probably not in the cards.)
>
> Chris
