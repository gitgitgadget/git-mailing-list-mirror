Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33975C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 00:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbiCOAFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 20:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiCOAFa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 20:05:30 -0400
X-Greylist: delayed 1121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Mar 2022 17:04:18 PDT
Received: from outmail149113.authsmtp.com (outmail149113.authsmtp.com [62.13.149.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A91B79C
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 17:04:18 -0700 (PDT)
Received: from punt23.authsmtp.com (punt23.authsmtp.com [62.13.128.122])
        by punt17.authsmtp.com. (8.15.2/8.15.2) with ESMTP id 22ENjZYh045905
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 23:45:35 GMT
        (envelope-from david@cantrell.org.uk)
Received: from mail-c237.authsmtp.com (mail-c237.authsmtp.com [62.13.128.237])
        by punt23.authsmtp.com. (8.15.2/8.15.2) with ESMTP id 22ENjYZI047494;
        Mon, 14 Mar 2022 23:45:34 GMT
        (envelope-from david@cantrell.org.uk)
Received: from [10.13.12.171] (199.80.155.90.in-addr.arpa [90.155.80.199])
        (authenticated bits=0)
        by mail.authsmtp.com (8.15.2/8.15.2) with ESMTPA id 22ENjXZR045696;
        Mon, 14 Mar 2022 23:45:33 GMT
        (envelope-from david@cantrell.org.uk)
Message-ID: <2ae04989-156c-63a2-c191-67f97bb6c7b9@cantrell.org.uk>
Date:   Mon, 14 Mar 2022 23:45:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] tab completion of filenames for 'git restore'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <pull.1227.git.git.1647032857097.gitgitgadget@gmail.com>
 <xmqqlexel59r.fsf@gitster.g>
From:   David Cantrell <david@cantrell.org.uk>
In-Reply-To: <xmqqlexel59r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Server-Quench: d72ea523-a3f0-11ec-ba2e-8434971169dc
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd2ZQ4QB1ZZRRob BgsPBSlcUwghIltL GxBFMAhMJUcNSQVJ NksadBtFaQFbYFhD HGQLWVZEUl57XWZ/ aAkfZAVDY09LQQ1q TklAS01XHAJ3AVID BGtgCHEYFQVCfXh5 YwhmWHFdEhB9dxMs R0xXCDwFM2d9aWFK A10KJgEBbQtOfRtM bVF+UnpZMitlM3Bw LDcaAxsRCH1DIS4d SQYINVYfXUcMGHY7 SVgMHDEiG0QASj57 IRs8YhETHVpZKEgp LVw7VB1w
X-Authentic-SMTP: 61633535363534.1024:7600
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/03/2022 06:45, Junio C Hamano wrote:
> "David Cantrell via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>      Improved bash tab completion for 'git restore' - adds support for
>>      auto-completing filenames
>>      
>>      This adds tab-completion of filenames to the bash completions for git
>>      restore.
> Two questions
> 
>   - "restore" is a castrated half "checkout"; shouldn't the latter
>     also be getting the same feature?

`git checkout <tab>` already completes to a list of branches and tags, 
which is I think more useful in that case.

>   - is "complete_index_file --committable" the right thing to use?
> 
>     It boils down to running "diff-index HEAD", which means path with
>     differences from the HEAD commit is listed.  By default "restore"
>     checks out the contents of the given path from the index to the
>     working tree, so after "edit F && git add F", "diff-index HEAD"
>     may show F in its output (i.e. F is "committable"), but "restore
>     F" would be a no-op.  Which feels a bit iffy.

I'd not thought of that. --modified is better.

>> @@ -2883,14 +2883,21 @@ _git_restore ()
>>   	case "$cur" in
>>   	--conflict=*)
>>   		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
>> +		return
>>   		;;
>>   	--source=*)
>>   		__git_complete_refs --cur="${cur##--source=}"
>> +		return
>>   		;;
>> ...
> Do you need to sprinkle return's?  Instead you could just add
> another case arm, like
> 
> +	*)
> +		... whatever you want to do when
> +		... $cur is not a --dashed-option
> +		;;

Liberal sprinkling of return like that seems to be the norm for the rest 
of the file so I stuck with it.

-- 
David Cantrell
