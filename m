Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83603CDB475
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 18:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjJKSXU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Oct 2023 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjJKSXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 14:23:20 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3479994
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:23:18 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 39BIKFOS2894881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 18:20:15 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>, "'Adam Johnson'" <me@adamj.eu>
Cc:     <git@vger.kernel.org>
References: <CAMyDDM3DFyru6zph4qqf_QoaOeezvYkT7SmwinCfJNnFsnuRjQ@mail.gmail.com> <20231011181733.GA514244@coredump.intra.peff.net>
In-Reply-To: <20231011181733.GA514244@coredump.intra.peff.net>
Subject: RE: Bug: 'git stash --staged' crashes with binary files
Date:   Wed, 11 Oct 2023 14:23:05 -0400
Organization: Nexbridge Inc.
Message-ID: <046101d9fc6f$fd812910$f8837b30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG8bKoFWFbm9qWCblqk9FWw6ShlRQKXReeSsGtL9xA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, October 11, 2023 2:18 PM, Peff wrote:
>On Thu, Jun 01, 2023 at 10:26:13PM +0100, Adam Johnson wrote:
>
>> Stage a binary file and run 'git stash --staged'. The stash is created
>> but the command fails to remove changes from the index:
>>
>> $ echo -n "\0" >file
>>
>> $ git add file
>>
>> $ git stash --staged
>> Saved working directory and index state WIP on main: e7911b6 Whatever
>> error: cannot apply binary patch to 'file' without full index line
>> error: file: patch does not apply
>> Cannot remove worktree changes
>>
>> $ git status
>> ...
>> Changes to be committed:
>>         new file:   file
>>
>> The "remove from the index" step seems not to be binary-compatible.
>
>This seems like a bug. It looks like stash does pass "--binary" in some cases, but not
>all. So it's probably a matter of finding the right invocation and adding it.
>
>> The below patch adds a reproducing test.
>
>I think finding the bug and writing the test is probably 75% of the work. :)
>
>> diff --git t/t3903-stash.sh t/t3903-stash.sh index
>> 376cc8f4ab..5e3ea64f38 100755
>> --- t/t3903-stash.sh
>> +++ t/t3903-stash.sh
>> @@ -392,6 +392,13 @@ setup_stash()
>>      git stash pop &&
>>      test bar,bar4 = $(cat file),$(cat file2)  '
>> +test_expect_success 'stash --staged with binary file' '
>> +    echo -n "\0" >file &&
>
>Unfortunately "echo -n" isn't portable. But you can use:
>
>  printf "\0" >file
>
>instead.
>
>> +    git add file &&
>> +    git stash --staged &&
>> +    git stash pop &&
>> +    test "\0" = $(cat file)
>> +'
>
>I doubt this "test" will work, as the shell won't interpolate that into a NUL (and
>anyway, I think having NULs in shell variables isn't portable). You could perhaps do:
>
>  printf "\0" >expect &&
>  test_cmp expect file

Agreed. The specific test construct does not appear portable, but piping printf "\0" to expect works.
/home/randall: test "\0" != `printf "\0"`
bash: warning: command substitution: ignored null byte in input
bash: test: \0: unary operator expected

--Randall

