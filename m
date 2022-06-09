Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4B4C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 11:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbiFILQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbiFILQe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 07:16:34 -0400
Received: from nmsh7.e.nsc.no (nmsh7.e.nsc.no [148.123.160.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B059A17E0E
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 04:16:33 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh7.e.nsc.no (smtp.online.no) with ESMTPSA id 2DC38E61DE;
        Thu,  9 Jun 2022 13:16:32 +0200 (CEST)
Message-ID: <2b48b94e-44e7-9abb-4afe-51060b6b298a@online.no>
Date:   Thu, 9 Jun 2022 13:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7] git-prompt: make colourization consistent
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
References: <20220606175022.8410-1-joak-pet@online.no>
 <20220607115024.64724-1-joak-pet@online.no> <xmqqzgiozbn8.fsf@gitster.g>
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <xmqqzgiozbn8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.201
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/06/2022 18:22, Junio C Hamano wrote:
> Joakim Petersen <joak-pet@online.no> writes:
> 
>> The short upstream state indicator inherits the colour of the last short
>> state indicator before it (if there is one), and the sparsity state
>> indicator inherits this colour as well. This behaviour was introduced by
>> 0ec7c23cdc6 (git-prompt: make upstream state indicator location
>> consistent, 2022-02-27), while before this change the aforementioned
>> indicators were white/the default text colour. Some examples to
>> illustrate this behaviour (assuming all indicators are enabled and
>> colourization is on):
>>   * If there is something in the stash, both the '$' and the short
>>     upstream state indicator following it will be blue.
>>   * If the local tree has new, untracked files and there is nothing in
>>     the stash, both the '%' and the short upstream state indicator
>>     will be red.
>>   * If all local changes are added to the index and the stash is empty,
>>     both the '+' and the short upstream state indicator following it will
>>     be green.
>>   * If the local tree is clean and there is nothing in the stash, the
>>     short upstream state indicator will be white/${default text colour}.
>>
>> This appears to be an unintended side-effect of the change, and makes
>> little sense semantically (e.g. why is it bad to be in sync with
>> upstream when you have uncommitted local changes?). The cause of the
>> change in colourization is that previously, the short upstream state
>> indicator appeared immediately after the rebase/revert/bisect/merge
>> state indicator (note the position of $p in $gitstring):
>>
>> 	local f="$h$w$i$s$u"
>> 	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
>> 	
>> Said indicator is prepended with the clear colour code, and the short
>> upstream state indicator is thus also uncoloured. Now, the short
>> upstream state indicator follows the sequence of colourized indicators,
>> without any clearing of colour (again note the position of $p, now in
>> $f):
>>
>> 	local f="$h$w$i$s$u$p"
>> 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
>>
>> If the user is in a sparse checkout, the sparsity state indicator
>> follows a similar pattern to the short upstream state indicator.
>> However, clearing colour of the colourized indicators changes how the
>> sparsity state indicator is colourized, as it currently inherits (and
>> before the change referenced also inherited) the colour of the last
>> short state indicator before it. Reading the commit message of the
>> change that introduced the sparsity state indicator, afda36dbf3b
>> (git-prompt: include sparsity state as well, 2020-06-21), it appears
>> this colourization also was unintended, so clearing the colour for said
>> indicator further increases consistency.
>>
>> Make the colourization of these state indicators consistent by making
>> all colourized indicators clear their own colour. Make colouring of $c
>> dependent on it not being empty, as it is no longer being used to colour
>> the branch name. Move clearing of $b's prefix to before colourization so
>> it gets cleared properly when colour codes are inserted into it. These
>> changes make changing the layout of the prompt less prone to unintended
>> colour changes in the future.
>>
>> Change coloured Bash prompt tests to reflect the colourization changes:
>>   * Move the colour codes to wrap the expected content of the expanded
>>     $__git_ps1_branch_name in all tests.
>>   * Insert a clear-colour code after the symbol for the first indicator
>>     in "prompt - bash color pc mode - dirty status indicator - dirty
>>     index and worktree", to reflect that all indicators should clear
>>     their own colour.
>>
>> Signed-off-by: Joakim Petersen <joak-pet@online.no>
>> ---
>> Changes since v6:
>>   * Remove repeated statements and move all explanation of what the patch
>>     does to the latter part of the message.
>>   * Add a short statement about other benefits of the behavioural change.
> 
> The handling of $w is different from the original (it used to be
> that only '*' was painted in red, now any non-empty strings do), but
> '*' is the only value that can be assigned to $w, so there is no
> material difference.
> 
> Looking good.  Will queue.  Thanks.
> 

The change regarding $w was mentioned below --- for v5:
 > Changes since v4:
 >  * The check for whether to colourize $w has been altered to match the
 >    checks for the other indicators.
I'll add a mention of this to the commit message as well.
