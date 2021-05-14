Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E65C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 14:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595DA613FB
	for <git@archiver.kernel.org>; Fri, 14 May 2021 14:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhENOOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 10:14:04 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:33443 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhENOOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 10:14:04 -0400
Received: (Authenticated sender: greg@gpanders.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 79B1C240004;
        Fri, 14 May 2021 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1621001572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5QDITsP30oUjBRuDOudUD6dhtp9/5QpwzJWHUyTC5a4=;
        b=OvwHB4lLy7bvcRoLcwtMecMfGWofUkbJfcYJqspDuuMBBcBVTn/Gvv4jYhFOz1KbtkTSiR
        0ARKE+laG1Oyw9JlBuqUVjXFGbwMnd0dxtBOxAeUD1KeF/jTkHfFYmmfoZAgneHLCwp4C8
        FKW1kXnGpE/e43OyPnHB54D0Z35tewHHtr/hhN+5hMCmEvAb14UZQolrsjgbErsGwGg8xc
        nSTmn9QNNBD/dsX5niP6M/VuK6z7pK8VBSX9Dketfpn6iCD5dNmQZDvnxJjWpNT86o2uTh
        s5Gt9t7LC07v0Xb2/11403H055sXKRxe8C5pl+5fewhkKwoslBVdZ3L21n5PjA==
Date:   Fri, 14 May 2021 08:12:48 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] git-send-email: add option to specify sendmail command
Message-ID: <YJ6FYDBdRsl3PCcc@gpanders.com>
References: <20210513023212.72221-1-greg@gpanders.com>
 <20210513152329.22578-1-greg@gpanders.com>
 <xmqq7dk27xi2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq7dk27xi2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 May 2021 13:25 +0900, Junio C Hamano wrote:
>Are you talking about the use of $sm that is local to the debug
>output?  I think leaving $sendmail_cmd intact by using a separate
>variable is the right choice.  Isn't the problem you observed a
>consequence of send_message() getting called once for each message,
>so assigning to $sendmail_cmd in the function for the first
>invocation of the function would change its value for the second
>invocation?

Yes that is right. That makes sense. I didn't realize the subprocess was 
called twice, though that is such an obvious explanation I don't know 
why I didn't think of it.

>Also, if we have been using
>
>	--smtp-server=$(pwd)/fake.sendmail
>
>we cannot expect to use the same value like this:
>
>	--sendmail-cmd=$(pwd)/fake.sendmail
>
>because we deliberately add a space in the $(pwd) by choosing the
>name of the test directory to be "trash directory.something".  We'd
>need to do something like
>
>	--sendmail-cmd='$(pwd)/fake.sendmail'
>
>so that the shell sees '$(pwd)/fake.sendmail' literally and runs pwd
>to find out what the path to the program is, I would think.

Indeed, in prior versions of this patch I had replaced the uses of 
`--smtp-server` in the test suite with `--sendmail-cmd` which included 
those extra quotes (I reverted back to using --smtp-server after 
feedback from other reviewers in lieu of simply adding new test cases 
for --sendmail-cmd).

>> +test_expect_success $PREREQ 'test using arguments with 
>> --sendmail-cmd' '
>> +	clean_fake_sendmail &&
>> +	git send-email \
>> +		--from="Example <nobody@example.com>" \
>> +		--to=nobody@example.com \
>> +		--sendmail-cmd="\"$(pwd)/fake.sendmail\" -f nobody@example.com" \
>> +		HEAD^ &&
>> +	test_path_is_file commandline1
>> +'
>
>Hmph, if $(pwd) has a double quote character in it, this may not
>work as expected, as the shell that is expanding the command line
>arguments for "git send-email" would see $(pwd), expand it and our
>program will see
>
>    "/path/with/d"quote/git/t/trash directory.9001/fake.sendmail" -f nobody@e.c
>
>as the value of --sendmail-cmd, which would not interpolate well,
>no?
>
>We want the shell that eats the command line of 'git send-email' to see
>
>	--sendmail-cmd='$(pwd)/fake.sendmail'\" -f nobody@example.com"
>
>and because this is inside a sq pair, it would become
>
>	--sendmail-cmd='\''$(pwd)/fake.sendmail'\''\" -f nobody@example.com"
>
>after we replace each sq with '\'', or something like that, perhaps?

I'll take a look at this (as well as your followup email) and send a new 
version.

Thanks,

Greg
