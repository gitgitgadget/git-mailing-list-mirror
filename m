Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56BF32022A
	for <e@80x24.org>; Sun,  6 Nov 2016 10:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbcKFK2n (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 05:28:43 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:40010 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbcKFK2m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 05:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=subject:to
        :references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=ZgnEY4svQW/+5x
        j/OQv/nlbUb6oR5hoTV5+wMQ2JwS8=; b=oXstsdemn95dVASD6hakvOhOkfdrWR
        Qbsff5TlVKpQfkzdPu15G6FLRNH1fwO0Vesjeojqzz5TNJqs5Db0OmWAivzms98v
        YpHaTx9NGmHOfzWmw1IDRhA31f4hZ856sWREbhCDUydohW3KptvloHC6JGnVEcil
        pbzAq8tBZ1Cfw=
Received: (qmail 31294 invoked from network); 6 Nov 2016 11:28:37 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 6 Nov 2016 11:28:37 +0100
Subject: Re: gitk: avoid obscene memory consumption
To:     Paul Mackerras <paulus@ozlabs.org>,
        Stefan Beller <sbeller@google.com>
References: <47c374cf-e6b9-8cd3-ee0d-d877e9e96a62@jump-ing.de>
 <CAGZ79kbavzGJ2sAcz5heg+BO+tZ=TgtrhxMH1-kqeJUpNNavyw@mail.gmail.com>
 <20161105110845.GA4039@fergus.ozlabs.ibm.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Markus Hitter <mah@jump-ing.de>
Message-ID: <ff5bb36b-e30c-3998-100d-789b4b5e7249@jump-ing.de>
Date:   Sun, 6 Nov 2016 11:28:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161105110845.GA4039@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.11.2016 um 12:08 schrieb Paul Mackerras:
> On Fri, Nov 04, 2016 at 03:45:09PM -0700, Stefan Beller wrote:
>> On Fri, Nov 4, 2016 at 12:49 PM, Markus Hitter <mah@jump-ing.de> wrote:
>>>
>>> Hello all,
>>
>> +cc Paul Mackeras, who maintains gitk.
> 
> Thanks.
> 
>>>
>>> after Gitk brought my shabby development machine (Core2Duo, 4 GB RAM, Ubuntu 16.10, no swap to save the SSD) to its knees once more than I'm comfortable with, I decided to investigate this issue.
>>>
>>> Result of this investigation is, my Git repo has a commit with a diff of some 365'000 lines and Gitk tries to display all of them, consuming more than 1.5 GB of memory.
>>>
>>> The solution is to cut off diffs at 50'000 lines for the display. This consumes about 350 MB RAM, still a lot. These first 50'000 lines are shown, followed by a copyable message on how to view the full diff on the command line. Diffs shorter than this limit are displayed as before.
> 
> That sounds reasonable.
> 
>>
>> Bikeshedding: I'd argue to even lower the number to 5-10k lines.
> 
> I could go with 10k.

Thanks for the positive comments.

TBH, the more I think about the problem, the less I'm satisfied with the solution I provided. Including two reasons:

- The list of files affected to the right is still complete and clicking a file name further down results in nothing ... as if the file wasn't part of the diff.

- Local searches. Cutting off diffs makes them unreliable. Global searches still work, but actually viewing a search result in the skipped section is no longer possible.

So I'm watching out for better solutions. So far I can think of these:

- Storing only the actually viewed diff. It's an interactive tool, so there's no advantage in displaying the diff in 0.001 seconds over viewing it in 0.1 seconds. As far as I can see, Gitk currently stores every diff it gets a hold of forever.

- View the diff sparsely. Like rendering only the actually visible portion.

- Enhancing ctext. This reference diff has 28 million characters, so there should be a way to store this with color information in, let's say, 29 MB of memory.

Any additional ideas?


Markus

-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
