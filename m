Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788E6C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 13:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbiDHNYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiDHNYI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 09:24:08 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF39B6005E
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649423941;
    s=strato-dkim-0002; d=pdev.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=p8MJbXCoJ2dnl04ObD9MuqsSHZNc6eKye/Avh/qLDNU=;
    b=Ntg72geY6BhtM1/Zg1LRnGAq4dWPohFQy8zBpoV3JfLvjKFxmYrZZOSESahchlALaa
    HbFE5gzxl/+BiK6jzpK5fR9qoI4cZTomn/R5JSEW/itRrJDdKnXKUjCOJgNZxnwJNTTj
    cC4XwJtFURj7shix314KgxdEEoUBPiLJO+dGryoV4kSmLJ8QRZw53zKQsNZQeqzSaFdY
    400ZYhirlyPeqtwP/9kceGcJuLm8Ij79ybJcYTv51eggZCyhsP27hmNaeg9palRCay7w
    lPPY/tFm7NsB/H7Wn7wn/41NhjX6te/h4inMyuI1KmuIKF6uUytqxErfCtzg99HIFE7n
    HGhg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":Pm0UfUGtd9+G9p9stmxCE5ta4sApnuCD/i3TNd+y2/o2oXSBVgRMI6humKUuomnd1LOKegLUQetlXuwqym6WFH4wfr6SEJmh"
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2003:c8:d70c:9600:6600:6aff:fe94:255]
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id I70750y38DJ1dO2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 15:19:01 +0200 (CEST)
Message-ID: <978e7684-2b91-379b-2fdf-bf0453bff30c@pdev.de>
Date:   Fri, 8 Apr 2022 15:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] pretty format: fix colors on %+ placeholder newline
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <e8417ad5-f9f2-c1de-75f6-45be49f0011b@pdev.de>
 <20220405154529.966434-1-raphael@pdev.de> <xmqq8rshx687.fsf@gitster.g>
From:   Raphael <raphael@pdev.de>
In-Reply-To: <xmqq8rshx687.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.04.22 23:16, Junio C Hamano wrote:
> It is very good to start the proposed log message by describing the
> current behaviour, highlighting what problem it has.  Because the
> message is merely _proposing_ to make this change, which may or may
> not be accepted into the codebase, however, please describe the
> status quo in the present tense. 
I understand that for proposing changes this makes sense.
But if the change would be accepted into the code, wouldn't the text 
become the commit message? I assumed it is sensible to write the message 
for that case: Using the present tense for the state of the code at this 
commit / after the patch.

> Isn't it the problem with the "--graph" codepath, then?
> 
> It is unclear from the proposed log message why it is a good idea to
> add the new behaviour to the code that handles "%+" unconditionally.

Good point, let me explain my thinking:
I first reported this bug without the --graph option where the color on 
the second line is missing as well.
It was pointed out that this is a problem with the pager "less" and not 
a bug in git:
https://lore.kernel.org/git/220222.865yp7aj6z.gmgdl@evledraar.gmail.com/
https://lore.kernel.org/git/6f0d1c12-4cf8-bbdd-96d4-eae99317e2e4@pdev.de/

Using "cat" as a pager produces the correct coloring, but since "less" 
is the default pager I find it useful to follow its conventions: Namely 
that lines are started non-colored and escape sequences must be repeated 
at the beginning of each colored line.
This is achieved as well by my implementation.

> It also is unclear why the new behaviour to save only one "color
> escape" is sufficient.  For example, if we used
> 
>      git log --pretty='format:%h%C(green)%C(reverse)%+d test' --graph
> 
> wouldn't the effects of these two add up?

You are right, I forgot about this case.
A naive solution would be to concatenate the format escapes and clearing 
the string when the color is reset.
Is there already existing code for keeping track of which format strings 
override each other, so that only the required escape sequences must be 
stored/printed?
Or do you see a different, more elegant solution?

> Whatever approach we decide to take to solve this issue, let's have
> a test case or two added to the test suite to better document the
> issue.

Sure, I will take a look after solving the core issue.
