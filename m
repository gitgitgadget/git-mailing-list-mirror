Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E651CC43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 01:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbiGTBmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 21:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241774AbiGTBma (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 21:42:30 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EC63C8C2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 18:40:29 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1oDyhO-0005TG-4U
        for git@vger.kernel.org; Wed, 20 Jul 2022 03:40:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Gregory Szorc <gregory.szorc@gmail.com>
Subject: Re: Race condition between repack and loose-objects maintenance task
Date:   Tue, 19 Jul 2022 18:40:19 -0700
Message-ID: <da675dd2-c9cf-c3b4-0231-58b3cf3ce9d7@gmail.com>
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local>
 <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
 <YryKCl5J1Em89d3e@nand.local>
 <CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com>
 <Yr0WLebMfBXZ1K7D@nand.local> <Yr0XMWWyD5C9uhlb@nand.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     git@vger.kernel.org, stolee@gmail.com
Content-Language: en-US
In-Reply-To: <Yr0XMWWyD5C9uhlb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2022 8:23 PM, Taylor Blau wrote:
> On Wed, Jun 29, 2022 at 11:19:09PM -0400, Taylor Blau wrote:
>>> However, I think there is yet another bug at play: running
>>> `incremental-repack` appears to be able to repack the cruft packfile.
>>> In doing so, it deletes its .mtimes file and the metadata inside.
>>
>> That sounds like a bug to me. I'll take a look into it and see what I
>> can find.
> 
> I actually think that there are two bugs here.
> 
> One is that we run a MIDX repack and expire, which could lead to us
> repacking the entire contents of the cruft pack and then expiring the
> metadata file. This is a bug, and we should exclude cruft packs from
> this computation.
> 
> Another bug can happen when the cruft pack gets written into the MIDX
> and is MIDX-expireable (meaning that no objects are selected from the
> cruft pack). In that case, the `git multi-pack-index expire` step would
> remove the cruft pack entirely, which is also incorrect.
> 
> I'll take a look at fixing both of these, and thanks for pointing them
> out!

For posterity, when I disabled cruft packfiles after having it enabled 
for a few weeks, the next `git gc` invocation on a high traffic repo 
resulted in >100k loose objects/files being created before they were 
summarily deleted by the GC's prune. This is significantly greater than 
the unreferenced object creation rate of the underlying repo. So it 
appears as if the MIDX stripping of the cruft packfile mtimes
effectively disabled pruning, leading to a build-up of unreferenced objects.

Fortunately I hadn't deployed cruft packfiles to production. If I had, 
the excessive filesystem churn on NFS would have caused an incident due 
to degraded performance.

Since the interaction between cruft packfiles and MIDX appears to be 
buggy, I think I'm going to leave cruft packfiles disabled until these 
features work better together.


