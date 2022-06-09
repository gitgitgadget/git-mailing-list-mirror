Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69047C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 11:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiFILNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiFILNo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 07:13:44 -0400
Received: from nmsh7.e.nsc.no (nmsh7.e.nsc.no [148.123.160.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8DD36E06
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 04:13:40 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh7.e.nsc.no (smtp.online.no) with ESMTPSA id A8BA5E60DB;
        Thu,  9 Jun 2022 13:13:37 +0200 (CEST)
Message-ID: <736a5f12-2ab3-977c-8cba-45529e9ebee0@online.no>
Date:   Thu, 9 Jun 2022 13:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7] git-prompt: make colourization consistent
Content-Language: en-GB
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
References: <20220606175022.8410-1-joak-pet@online.no>
 <20220607115024.64724-1-joak-pet@online.no>
 <20220609090302.GA1738@szeder.dev>
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <20220609090302.GA1738@szeder.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.201
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/06/2022 11:03, SZEDER Gábor wrote:
> This patch seems to break colorization when __git_ps1() is invoked
> from $PROMPT_COMMAND:
> 
>    ~/src/git (master)$ echo $PROMPT_COMMAND
> __git_ps1 "\[\e]0;\w - Terminal\a\e[01;32m\]\h\[\e[01;34m\] \w" "\[\e[01;34m\]\$\[\e[00m\] " " \[\e[01;34m\](%s\[\e[01;34m\])"
>    ~/src/git (master)$ git checkout 9470605a1b
>    HEAD is now at 9470605a1b git-prompt: make colourization consistent
>    ~/src/git ((9470605a1b...))$ source contrib/completion/git-prompt.sh
>    ~/src/git (\[\e[31m\](9470605a1b...)\[\e[0m\])$ # uh-oh
>    ~/src/git (\[\e[31m\](9470605a1b...)\[\e[0m\])$ git checkout 9470605a1b^
>    Previous HEAD position was 9470605a1b git-prompt: make colourization consistent
>    HEAD is now at 2668e3608e Sixth batch
>    ~/src/git (\[\e[31m\](2668e3608e...)\[\e[0m\])$ source contrib/completion/git-prompt.sh
>    ~/src/git ((2668e3608e...))$ # Looks good.
> 

While I did test this on my own prompt for v6 (which is identical to v7
in terms of code) and not see any breakage, I have the same issue with
v7. Maybe I forgot to re-source the changed git-prompt.sh. Either way,
The issue stems from $b being wrapped in $__git_ps1_branch_name and then
back into itself after colouring. Moving this wrapping to before colour
is applied fixes this. I will submit a v8 shortly.
