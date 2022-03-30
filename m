Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E880C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 10:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245569AbiC3Kut (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 06:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245567AbiC3Kur (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 06:50:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E2736157
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 03:49:02 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KT3633d3rz67kNj;
        Wed, 30 Mar 2022 18:47:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 30 Mar 2022 12:49:00 +0200
Received: from [10.47.83.59] (10.47.83.59) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 30 Mar
 2022 11:48:59 +0100
Message-ID: <7f23ed59-c237-dce1-53a5-43f35b92c972@huawei.com>
Date:   Wed, 30 Mar 2022 11:48:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [Question] .git folder file updates for changing head commit
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
CC:     <git@vger.kernel.org>
References: <6fa76f28-063b-8964-c0a2-642dae88f1b3@huawei.com>
 <YjuCSpAHD6xHkb5G@nand.local> <220327.86tubje6bn.gmgdl@evledraar.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <220327.86tubje6bn.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.83.59]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/03/2022 16:48, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Mar 23 2022, Taylor Blau wrote:
> 
>> On Wed, Mar 23, 2022 at 03:19:06PM +0000, John Garry wrote:
>>> For building the linux perf tool we use the git head commit id as part of
>>> the tool version sting. To save time in re-building, the Makefile rule has a
>>> dependency on .git/HEAD for rebuilding. An alternative approach would be to
>>> compare git log output to check current versus previous build head commit,
>>> but that is seen as inefficient time-wise.
>> Having a Makefile recipe that depends on $GIT_DIR/HEAD seems strange to
>> me.
>>
>> Presumably your Makefile rules would map out which parts of your program
>> depend on each other, and would get invalidated when the source itself
>> changes, no?
>>
>> Perhaps you also care about the commit you're building from in order to
>> embed something into your program. But it seems like you could inject
>> the output of "git rev-parse HEAD" when you construct the version
>> identifier whenever you do need to rebuild.
> Our very own build process for git.git relies on this, see how version.o
> needs a GIT-VERSION-FILE, which we generate by shelling out and
> including.

I see.

> 
> It is unfortunate that we don't have an advertised way to do this, with
> the ref backend I think trickery using $(file) to read the HEAD will
> work to do it in pure-make, i.e. you'd need to parse it to see if it's a
> symref, then depend on the target it points to.
> 
> Or you could recursively depend on a glob of the whole refspace for
> generating the version file ...
> 
> It would be nice if we had a way to guarantee that we'd write some file
> on HEAD updates, AFAIK not even the new reference-transaction hook will
> do that (due to "git reset --hard" and friends).
> 
> And yes, this does actually matter. There's a huge performance
> difference between a Makefile that needs to shell out for every little
> thing.
> 

I'm not sure if I mentioned it before, but the main motivation for 
adding the dependency was that "git describe" may be slow. We have since 
moved away from that (using "describe", which I hope turns out to be 
ok), but your GIT-VERSION-GEN still uses it. I just found that "git 
describe" is unreliable for us as it depends on tags being pushed to a 
clone git.

> I've been optimizing our own Makefile incrementally from running in
> ~500ms down to 100-200ms for noop runs over over the last few
> months. It's possible to get it down to 10-20ms at least by getting rid
> of the remaining shell-outs.
> 
> That makes a big difference when e.g. using "make" with "git rebase -i
> -x".
> .

ok, thanks,
John
