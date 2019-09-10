Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URI_HEX
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57AA31F463
	for <e@80x24.org>; Tue, 10 Sep 2019 17:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437056AbfIJRTy (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 13:19:54 -0400
Received: from blade-b3-vm-relay.servers.aueb.gr ([195.251.255.106]:49964 "EHLO
        blade-b3-vm-relay.servers.aueb.gr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729580AbfIJRTy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Sep 2019 13:19:54 -0400
Received: from blade-a1-vm-smtp.servers.aueb.gr (blade-a1-vm-smtp.servers.aueb.gr [195.251.255.217])
        by blade-b3-vm-relay.servers.aueb.gr (Postfix) with ESMTP id 6BBD4813;
        Tue, 10 Sep 2019 20:19:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aueb.gr; s=201901;
        t=1568135991; bh=3ILMClDHA0kVz+6aXi7P8X+Ug6r3WUn6OijyZxaAyrM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gtZu3lER0/5G1RIQxuaYh+5ylxCV49zURa+Jk2LEMWlVIt5PgqJvzWuOO2sdAYF2T
         /M5iix6jM1lN5T53Tzijmk8Q9gKoNey9xwQoV94r2WXjZIcnK4SnqjXXlxO8++ZB8Q
         3Vdcshq7FyF5RXr/bjEgqoep4Bo35ENitWLjHdMV214xKLJci1kJ0FJJpF/zZfMA6u
         57JSajgrMBAzIgD5pfqjfILa6py+wNqZwSmPGgUqnChiuOTmCJP+sT2PMBH3xLKA9N
         6Qd59if3PrxZ96ClEFlP7bNJfpttsYDFljnZm5xX6CmHfy7fCKw05DtGh+hBSfvAqk
         7szSA6NjrDRUw==
Received: from [172.31.173.24] (233.56-78-194.adsl-static.isp.belgacom.be [194.78.56.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dds)
        by blade-a1-vm-smtp.servers.aueb.gr (Postfix) with ESMTPSA id BD5E6606;
        Tue, 10 Sep 2019 20:19:50 +0300 (EEST)
Subject: Re: Patching Git to handle dates before the Unix epoch
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <c12e3505-7a02-3eaf-7d71-57a3b4df28d1@aueb.gr>
 <20190910162629.GA12758@sigill.intra.peff.net>
From:   Diomidis Spinellis <dds@aueb.gr>
Phone:  +30 210 8203621
Message-ID: <7a9fdb7d-265f-a877-1a5d-619890910340@aueb.gr>
Date:   Tue, 10 Sep 2019 20:19:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190910162629.GA12758@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: el
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10-Sep-19 19:26, Jeff King wrote:
> On Tue, Sep 10, 2019 at 05:14:53PM +0300, Diomidis Spinellis wrote:
>> As people use Git to create synthetic commits of code written in the past
>> [1,2] it becomes important to handle dates before the Unix epoch (1/1/1970).
>> I see that modern C libraries, Unix kernels, and tools can handle such
>> dates.  However Git seems to mishandle such dates in several places, such as
>> in date.c [3,4].  I'm planning to work on a fix, but before I embark on this
>> I have a few questions.
[...]
>> - Can you think of any non-obvious issues (e.g. backward compatibility,
>> switch to the Gregorian calendar) I should be aware of?
> 
> The big question is: what will existing implementations do with a commit
> object that contains a negative timestamp?

Negative timestamps can already be created, because some Git libraries 
can create such objects, and one can also create them by hand; see 
http://git.661346.n2.nabble.com/Back-dating-commits-way-back-for-constitution-git-tp5365303p5367657.html

Consequently, I don't think that worrying about how existing clients 
will handle such timestamps should be a big issue, as long as we don't 
break the handling of modern dates.

 > Coincidentally I was looking into this yesterday. See below.
[...]
> Here's how far I got working on this yesterday. It's quite messy, but
> seems to work at least for basic tests like:

Amazing!  Given that you have made significant progress, I think it's 
best to leave it to you to complete it, right?

Diomidis
