Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F82C76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 06:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjDGGMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 02:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjDGGMo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 02:12:44 -0400
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C71CA271
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 23:12:31 -0700 (PDT)
Received: from [10.93.18.190] (unknown [213.88.146.90])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id ACA873C0BAC;
        Fri,  7 Apr 2023 08:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1680847947;
        bh=kbAT1nrc0rnLZRxX6bggX2KKxVYl2hfL8T/AoVucQ7o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZkkIe4ApdMY0lPH8lTFGm+vX8Zn+4Rxt7koW/en14AN/oxxewXRiSOG0X+VloCxLa
         Qg4d6NY4w/HifLgautZJkQFVx1V4xlRht1CTpes6Q8aekLHxmSEQarIfGLyqD0hSch
         6x1OKK9gws+aOnylaW0jZPsRBSx5qpmlElZClOlhjNQtZN/CfaTZuJyCBRgLEhem1O
         1B6wtqPwsknIS9j+nEJm3Mn86mfd2bT3m8rg8UyikPAgzvM8KTPbAUmjVv1yzwXNtF
         kbq7hoi5wVCQmktfou9RZpveB1K7qxNH1WEOk+JGdL0t9J967roPNaFc+2q/eoKljB
         jH50NDZbH6egw==
Message-ID: <dda64e68-1390-0b4d-bb93-65f745ab1300@haller-berlin.de>
Date:   Fri, 7 Apr 2023 08:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Possible bug in git-rebase man page
Content-Language: de-DE, en-US
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de
References: <db535468-c991-df18-61bd-ec312fdb5ca0@haller-berlin.de>
 <51aca4bd-0f2b-0689-4b51-260349cc4151@gmail.com>
 <f3e522f6-294d-4c08-b261-34d8e5b03b46@haller-berlin.de>
 <7e99ff9b-99b7-1ea9-4131-43f507780284@gmail.com>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <7e99ff9b-99b7-1ea9-4131-43f507780284@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: --
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.04.23 14:07, Phillip Wood wrote:
> Hi Stefan
> 
> On 06/04/2023 11:48, Stefan Haller wrote:
>> On 06.04.23 11:49, Phillip Wood wrote:
>>> Hi Stefan
>>>
>>> On 05/04/2023 18:36, Stefan Haller wrote:
>>>> The git-rebase documentation has an example for a git-rebase-todo file
>>>> when --rebase-merges is used; one of the lines in that file is
>>>>
>>>>     reset refactor-button # Use the Button class for all buttons
>>>>
>>>>   From reading the code that parses the file, this doesn't seem to be a
>>>> valid line; as far as I can see, comments are not supported for
>>>> reset or
>>>> label. The label is the entire rest of the line after the command.
>>>
>>> You're right that comments are not supported for labels, but for the
>>> reset command do_reset() ignores everything after the label so it does
>>> effectively support comments.
>>
>> I don't follow; do_reset() simply uses whatever is stored in
>> item->arg_len, and this is set to go until the end of the line for
>> "label" and "reset" in parse_insn_line().
> 
> But it splits in line in do_reset()
> 
>         /* Determine the length of the label */
>         for (i = 0; i < len; i++)
>             if (isspace(name[i]))
>                 break;
>         len = i;
> 
>         commit = lookup_label(r, name, len, &ref_name);

Ah, I missed that, thanks. But it does this only after special-casing
the "[new root]" label, which does contain a space and needs to go to
the end of the line. This is weird.

This whole topic started because the todo parser that we are using in
lazygit has a bug where it doesn't recognize the "[new root]" label
properly, and this is because it does split the line at the first
whitespace, but without special-casing "[new root]" like git does.

How would you recommend we fix this? We could replicate git's current
behavior exactly, but then this would break when you introduce comments
later. Or we could anticipate that comments are added at some point, and
already split the line at the first # (trimming whitespace before that).
This would not exactly match git's current behavior, but it would be
good enough because git never actually uses whitespace in label or reset
lines except for the "[new root]" case.

I'm leaning towards the second option myself. Any thoughts?

-Stefan
