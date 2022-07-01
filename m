Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471C4CCA481
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 14:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiGAOgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiGAOfk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 10:35:40 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB7C3FBE1
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 07:31:11 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 07A7D3F4801;
        Fri,  1 Jul 2022 10:31:11 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1008:b01c:9358:c6b:4c4:c875:79c4])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6A08E3F47FE;
        Fri,  1 Jul 2022 10:31:10 -0400 (EDT)
Subject: Re: [PATCH v5 5/5] tr2: avoid to print "interesting" config
 repeatedly
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, derrickstolee@github.com,
        git@vger.kernel.org, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
References: <cover.1656403084.git.dyroneteng@gmail.com>
 <f3b87a33da2a9bd2cd5148fcfe1d55a6281d8b99.1656403084.git.dyroneteng@gmail.com>
 <220628.86o7ydf8gi.gmgdl@evledraar.gmail.com> <xmqqbkuck66t.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <838e1273-b704-bd11-e9ed-e25390989027@jeffhostetler.com>
Date:   Fri, 1 Jul 2022 10:31:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqbkuck66t.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/28/22 2:12 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>> Do we care in this case? I really don't know, but perhaps we can declare
>> "dedup" using the same facility we're using to wildcard-match keys, and
>> either make that optional or the default, e.g.:
>>
>> 	GIT_TRACE2_CONFIG_PARAMS='*:dedup,core.*:'
>>
>> I.e. to make it a list of <glob>[:<options>].
>>
>> Maybe not worth the effort...
> 
> I happen to think that the trace output is primarily for machine
> consumption (i.e. if you want to make it readable by humans, it is
> OK to require them to pre-process).
> 
> How does this "duplicate output" come about?  If it is because
> end-user configuration files have multiple entries that are either
> list-valued or relying on last-one-wins semantics, I suspect that it
> is better not to prematurely filter these at the trace generation
> side (which by definition is an opration that loses information).
> 
> So, to me, it smells that the whole "dedup at the source" thing is
> not just not worth the effort but is misguided.
> 

I agree.  Let's not try to dedup these.  IIRC, the tr2_cfg_cb()
machinery runs during a "read early" or "read very early" scan of
the config values and the program is still starting up (in some
sense).  For example, the command line may not have been fully
processed yet (again, IIRC).  So injecting a call here to force an 
explicit lookup could cause problems.

And you'll be arbitrarily taking the first value, which is probably
the system level setting rather than the last value, which is probably
the local setting.  So the output would be misleading.

And I don't think it is worth the effort.  Let's just log the
context (system, global, local) as you described in the previous
version and be happy that we get multiple-but-now-qualified values.

This was intended as a machine-readable feature to allow telemetry
post-processing to group or filter command events.  For example, if
we want to do some "feature-x" is ON or OFF and compute averages
for the ONs and averages for the OFFs and compare them.  Such post-
processing has (I'm assuming) in the past always looked at the last
value logged.  And I assume that that would not change here with the
additional qualification.

Also, your new qualification would help us answer support questions
using telemetry where a user thought they had a feature on (say
globally) but was actually off at another level (say locally).

Jeff
