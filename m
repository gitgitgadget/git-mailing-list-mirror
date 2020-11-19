Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D502C6369E
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 14:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D3224655
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 14:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgKSOLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 09:11:17 -0500
Received: from siwi.pair.com ([209.68.5.199]:14634 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgKSOLR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 09:11:17 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8F51E3F5FC7;
        Thu, 19 Nov 2020 09:11:15 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 56FE53F5FC2;
        Thu, 19 Nov 2020 09:11:15 -0500 (EST)
Subject: Re: RFC: auto-enabling parallel-checkout on NFS
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gerardu@amazon.com,
        Derrick Stolee <stolee@gmail.com>
References: <20201115194359.67901-1-matheus.bernardino@usp.br>
 <87y2ixpvos.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e0ddf00d-785b-9220-0082-8be54fb7a7c6@jeffhostetler.com>
Date:   Thu, 19 Nov 2020 09:11:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87y2ixpvos.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/19/20 4:01 AM, Ævar Arnfjörð Bjarmason wrote:
> 
>> The major downside is that detecting the file system type is quite
>> platform-dependent, so there is no simple and portable solution. (Also,
>> I'm not sure if the optimal number of workers would be the same on
>> different OSes). But we decided to give it a try, so this is a
>> rough prototype that would work for Linux:
>> https://github.com/matheustavares/git/commit/2e2c787e2a1742fed8c35dba185b7cd208603de9
> 
> I'm not intrinsically opposed to hardcoding some "nr_threads = is_nfs()
> ? x : y" as a stopgap.
> 
> I do think we should be thinking about a sustainable way of doing this
> sort of thing, this method of testing once and hardcoding something
> isn't a good approach.
> 
> It doesn't anticipate all sorts of different setups, e.g. in this case
> NFS is not a FS, but a protocol, there's probably going to be some
> implementations where parallel is much worse due to a quirk of the
> implementation.
> 
> I think integrating an optimization run with the relatively new
> git-maintenance is a better way forward.
> 
> You'd configure e.g.:
> 
>      maintenance.performanceTests.enabled=true
>      maintenance.performanceTests.writeConfig=true
> 
> Which would run e.g.:
> 
>      git config --type bool core.untrackedCache $(git update-index --test-untracked-cache && echo true || echo false)
>      git config checkout.workers $(git maintenance--helper auto-discover-config checkout.workers)
> 
> Such an implementation can be really basic at first, or even just punt
> on the test and use your current "is it NFS?" check.
> 
> But I think we should be moving to some helper that does the actual test
> locally when asked/configured by the user, so we're not making a bunch
> of guesses in advance about the size/shape of the repository, OS/nfs/fs
> etc.
> 

I kinda like this idea.  It would give us a chance to let maintenance
periodically probe the repo/system and improve some of these tuning
knobs.

Jeff
