Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2406C54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 14:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjAMO5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 09:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjAMO4p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 09:56:45 -0500
Received: from mail.turbocat.net (turbocat.net [88.99.82.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15EE63C1
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 06:42:51 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 7582926001F;
        Fri, 13 Jan 2023 15:42:49 +0100 (CET)
Message-ID: <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
Date:   Fri, 13 Jan 2023 15:42:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
To:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
Content-Language: en-US
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <009701d9275a$678416b0$368c4410$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/13/23 15:21, rsbecker@nexbridge.com wrote:
> On January 13, 2023 8:40 AM, Hans Petter Selasky wrote:
>> On 1/13/23 14:30, Konstantin Khomoutov wrote:
>>> On Fri, Jan 13, 2023 at 01:59:44PM +0100, Hans Petter Selasky wrote:
>>>
>>>> Currently GIT only supports cryptographic hashes for its commit tags.
>>> [...]
>>>
>>> https://github.com/git/git/blob/9bf691b78cf906751e65d65ba0c6ffdcd9a5a1
>>> 2c/Documentation/technical/hash-function-transition.txt
>>>
>>> It's not clear why are you referring to Gitorious in your mail's
>>> subject and then talk about Git.
>>>
>>
>> Hi,
>>
>> I thought that Git was short for Gitorious? My bad.
>>
>> The document you refer to really highlights my concerns, that a strong
>> cryptographic hash algorithm is the highway to hell.
>>
>> Do _not_ use a cryptographic hash for Git. Use plain good old CRC hashes.
>>
>> Just imagine the consequences of finding child porn inside a 10-year old firmware
>> binary blob in the Linux kernel. Will you just ignore it, or will you fix it?
>>
>> That's why I say, that it must be possible to forge the hashes by default.
> 

Hi,

> I do not understand the goal of this request. If it is possible to forge hashes, then nothing in a git repository can ever be trusted. Signed content will no longer be verifiable. The whole Merkel Tree representing the commit history becomes easily corruptible by hackers and no upstream remote repository can ever be trusted - or someone's own if someone targets a repo with malware that rewrites hashes. Imagine a scenario when malware replaces a blob in a repo and then forges the hash to pretend that the replacement never occurred. Using git as a supply chain audit trail becomes impossible. This is a potential vector for ransomware invading the git ecosystem. This seems like a really fatal path to take for the product.

If a hacker replaces a blob, everyone on the project will see it, 
because such changes typically generate a commit e-mail. And then an 
action will be made to revoke the access of that hacker. Now a clever 
hacker wouldn't do that. A clever hacker would just flip one bit 
somewhere in a random blob, looking like a hardware fault, and then 
force the project to rewind to backups every day, because the repository 
can no longer be verified.

> The advantage of how git functions is that it is possible to mirror or clone repositories, protecting from hardware errors. Repositories exist in distributed form, so there may be hundreds or thousands of copies in case someone's copy is corrupted by a disk or memory write error - so that takes hash reconstruction out of the requirement set. If the git architecture was based on a central repository model only, then this might be a reasonable request, but that is not how git works. If, for instance, a main GitHub repo is somehow corrupted, it can be repaired by a push --force or a clone from a different instance.
> 

There is no advantage from protecting from hardware errors, unless you 
can recover from them! Cryptographic hash algorithms are not suitable to 
recover bits. They only tell data is OK or NOK, and if there is no 
backup, you loose it! It is no solution for big repositories to rewind 
to backups just because of bit-flips. Such problems should be fixed w/o 
the need to roll-back, because that stops the entire production!

 > it can be repaired by a push --force

Hobby projects can do that, but not big projects like FreeBSD and the 
Linux kernel.

> Unless I am missing your point.

Yes, a little bit :-)

--HPS

