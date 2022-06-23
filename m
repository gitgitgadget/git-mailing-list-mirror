Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116BFC433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiFWPOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiFWPOb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:14:31 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F333A181
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:14:29 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6D6833F4114;
        Thu, 23 Jun 2022 11:14:28 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1015:b06d:d6ec:b96f:7ca6:e624:cbcd])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 015563F40F3;
        Thu, 23 Jun 2022 11:14:27 -0400 (EDT)
Subject: Re: [PATCH v3 5/5] bitmap: add trace2 outputs during open "bitmap"
 file
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
References: <78966fb1-d5be-2fb5-0f68-0fce0b93d249@jeffhostetler.com>
 <20220623093836.113288-1-dyroneteng@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a4dda985-a319-2c24-2957-5116831142b8@jeffhostetler.com>
Date:   Thu, 23 Jun 2022 11:14:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20220623093836.113288-1-dyroneteng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/23/22 5:38 AM, Teng Long wrote:
> On Wed, 22 Jun 2022 08:51:18 -0400, Jeff Hostetler wrote:
> 
[...]
> I remove the changes of "repo_config_bool" from my v4 patch
> then I try to know about "GIT_TRACE2_CONFIG_PARAMS" and
> "trace2.configparams". Thereby, when I:
> 
> Execute "GIT_TRACE2_PERF=1 GIT_TRACE2_CONFIG_PARAMS=core.multipackIndex git rev-list  --test-bitmap HEAD"
> 
> 15:21:38.812782 git.c:461                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false
> 15:21:38.812797 git.c:461                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false
> 
> I checked my configs, I found if there exists multiple level configs.
> it'll print multiple times. Like If I config all the global, system
> and local on "core.multipackIndex=false" , the output will be:
> 
> 15:41:50.614108 git.c:462                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false
> 15:41:50.614123 git.c:462                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false
> 15:41:50.614136 git.c:462                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false
> 
> And if I modified the local scope of core.multipackIndex to "true",
> the output will be:
> 
> 15:45:39.200172 git.c:462                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false
> 15:45:39.200186 git.c:462                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false
> 15:45:39.200200 git.c:462                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:true
> 
> I'm not sure it's an intentional design or here should be only
> print the final value that takes effect or should print all the
> values if config multiple scopes on the same config.
> 
> Hence, I made a temporary patch below to try to add some
> identifying information to know why we output these lines, like:

I had intended it to only print the final "effective" value
that the command would actually use.  I don't remember if I
ever experimented with config values that are set at multiple
levels, but testing it now shows that you're right it does
print a "def_param" message for each level.

I would suggest we fix it to only print the final value
since we really just want to know whether the command will
or will not use a feature.  The inheritance is somewhat
irrelevant.

But the change to do that may be quite a mess, so printing
the scope name as you have here is fine.  And may help with
support when debugging users having confusing problems, so
I'm fine with it.

Thanks,
Jeff

