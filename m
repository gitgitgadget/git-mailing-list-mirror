Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48115C4332F
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 17:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJGR2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJGR2h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 13:28:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13018D73DE
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 10:28:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 411B114594D;
        Fri,  7 Oct 2022 13:28:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hh4CIF/Rev8CdEujFe/PKLIHZDphs/1xMZGCL7
        dMnZw=; b=kRqpGMJI5r9oAubEujzu+ykCqBk2mWX4jfZeNAR3loa6t2dL008X5Y
        jrPt8OJUzcgnneyLkSXYuEva3qSKEzSHH0yDhyWfxjlQRmVmOyvNG0Vo7fcOkab+
        W5oSa4TcvbiDUnlL0hkMaifT1Bp0qR5bEWNYvBESYDwWHYFyexbHU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 394C714594C;
        Fri,  7 Oct 2022 13:28:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F7F314594B;
        Fri,  7 Oct 2022 13:28:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Daniel Sonbolian via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Daniel Sonbolian <dsal3389@gmail.com>
Subject: Re: [PATCH v2 1/2] git-p4: minor optimization in read_pip_lines
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
        <pull.1355.v2.git.git.1665153486.gitgitgadget@gmail.com>
        <dd81a2cadec3e3f131d7b573bf110d4b6cc8f40d.1665153486.git.gitgitgadget@gmail.com>
        <69d57d56-2b74-5ee0-a279-de5eb10df7bf@dunelm.org.uk>
Date:   Fri, 07 Oct 2022 10:28:33 -0700
In-Reply-To: <69d57d56-2b74-5ee0-a279-de5eb10df7bf@dunelm.org.uk> (Phillip
        Wood's message of "Fri, 7 Oct 2022 16:17:33 +0100")
Message-ID: <xmqqy1trfsqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 789010EC-4665-11ED-9EF8-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Daniel
>
> On 07/10/2022 15:38, Daniel Sonbolian via GitGitGadget wrote:
>> From: Daniel Sonbolian <dsal3389@gmail.com>
>> checking for an error condition before reading and/or decoding
>> lines from the pip stream to avoid unnecessary computation
>
> It would be helpful to say a little more about what the error is
> you're detecting why it is better to detect it earlier. Having looked
> at the changes I'm not really sure what these changes are trying to
> improve

Thanks for the comments.

Also, even though Documentation/SubmittingPatches does not mention
in its [[describe-changes]] section, we do use the usual
capitalization in the body of the commit log message (after the
<area>: prefix on the commit title is the only exception).

I agree with everything you said in your review about the code.
Unless what pipe.readlines() would read is so small that it fits in
the OS pipe buffer, waiting for the subprocess to finish without
reading its output is likely to deadlock.

Thanks.

>> Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
>> ---
>>   git-p4.py | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>> diff --git a/git-p4.py b/git-p4.py
>> index d26a980e5ac..097272a5543 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -399,11 +399,15 @@ def read_pipe_lines(c, raw=False, *k, **kw):
>>         p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
>>       pipe = p.stdout
>> +
>> +    if p.wait():
>> +        die('Command failed: {}'.format(' '.join(c)))
>
> I'm not a python programmer, but the documentation for Popen.wait()
> says that this will wait for the process to finish, so I think calling
> it before reading the lines below is an error.
>
>>       lines = pipe.readlines()
>> +    pipe.close()
>
> You're now ignoring the return value of pipe.close() - is that safe?
>
>> +
>>       if not raw:
>> -        lines = [decode_text_stream(line) for line in lines]
>> -    if pipe.close() or p.wait():
>> -        die('Command failed: {}'.format(' '.join(c)))
>> +        return [decode_text_stream(line) for line in lines]
>>       return lines
>
> I'm not really sure what you're tying to achieve here - what was wrong
> with the original code?
>
> Best Wishes
>
> Phillip
