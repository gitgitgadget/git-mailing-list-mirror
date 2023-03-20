Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB466C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 19:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjCTTQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 15:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjCTTQd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 15:16:33 -0400
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636A32D6A
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 12:08:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 7134F160045;
        Mon, 20 Mar 2023 12:00:23 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id unkCvSIIrHNx; Mon, 20 Mar 2023 12:00:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id A4DD816006A;
        Mon, 20 Mar 2023 12:00:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.9.2 zimbra.cs.ucla.edu A4DD816006A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=78364E5A-2AF3-11ED-87FA-8298ECA2D365; t=1679338822;
        bh=BAITqEZewhBFJbmv5v9DLRPv7PcJb94Th5eWGg/MBf0=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
         Content-Transfer-Encoding;
        b=j9mcO9zFuZg0WbXPKw2bh2PbBgPiJSZBH0IBv7n3lvRsyjlICW0Iy2oDMmecRsk8c
         V7PGAMeHHEG8Ho70dxXjqghOnJdlJsAlkISOEyiJmDBEaS271L8Sx8BHJ7CwrxgPdD
         kzIBZ/1dKQUc/Ho4yoJeXeT4MAo0LmcOwqks3Spc=
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2wf-jXM3juS9; Mon, 20 Mar 2023 12:00:22 -0700 (PDT)
Received: from [131.179.64.200] (Penguin.CS.UCLA.EDU [131.179.64.200])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 88DC8160045;
        Mon, 20 Mar 2023 12:00:22 -0700 (PDT)
Message-ID: <047178a8-ccf5-1cab-e670-8f1c64f9ca3c@cs.ucla.edu>
Date:   Mon, 20 Mar 2023 12:00:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] git-compat-util: use gettimeofday for current time
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
 <20230319064353.686226-3-eggert@cs.ucla.edu> <20230319193449.M629601@dcvr>
 <xmqqh6ufo01u.fsf@gitster.g> <xmqqr0tjmk6d.fsf@gitster.g>
Content-Language: en-US
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <xmqqr0tjmk6d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/20/23 10:01, Junio C Hamano wrote:

>> I however wonder if we should follow our
>> usual pattern of implementing git_time() with the identical function
>> signature as what we replace (i.e. system's time()), and #undef/#define
>> the symbol we replace with git_time, though.  Wouldn't it make [1/2]
>> a lot smaller and future-proof?

Yes, something like that would work too. (Sorry, I didn't know about the 
usual pattern.)


> +# Define OVERRIDE_TIME to override time(2) and replace it with an
> +# implementation based on gettimeofday(2).  THis is necessary when
> +# glibc 2.31+ on Linux is used, where in the first 1 to 2.5 ms of
> +# every second, time(NULL) returns a value that is one less than the
> +# tv_sec part of higher-resolution timestamps used in the file system.

THis -> This

It might be simpler to use the gettimeofday workaround on all platforms, 
rather than having an OVERRIDE_TIME flag and complicating 
config.mak.uname. gettimeofday should be portable, as it's already used 
elsewhere in Git without configury.

If we're going with the more-complicated solution, config.mak.uname will 
need changes in its AIX and MS-Windows sections because the problem is 
known to occur there too. Although AIX configuration is simple, I'm not 
sure how to go about the MS-Windows part as there seem to be a lot of 
ifdefs there. Also, because the time problem does not occur with musl 
libc (used in Alpine Linux 3.17), on the Linux side the workaround could 
be employed only if glibc 2.31+ is in use.

