Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9B9C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 18:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbjAISQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 13:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjAISMz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 13:12:55 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BBF6D526
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 10:10:28 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AF83ECA1237;
        Mon,  9 Jan 2023 13:10:27 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:c84a:e48d:8958:a583] (unknown [IPv6:2600:1700:840:e768:c84a:e48d:8958:a583])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 70FB5CC83B8;
        Mon,  9 Jan 2023 13:10:27 -0500 (EST)
Message-ID: <b96c674c-6525-1e5a-3d70-0356f3cc3a01@jeffhostetler.com>
Date:   Mon, 9 Jan 2023 13:08:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/4] do full type check in BARF_UNLESS_COPYABLE
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
 <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
 <4f161041-b299-f79a-e01b-cc00e2880850@web.de> <xmqqy1qdxz67.fsf@gitster.g>
 <3e04e283-cad0-7be4-d85c-65d0a52289e2@web.de> <xmqqfsckwcw3.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqfsckwcw3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/8/23 11:27 PM, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
>> We compare the types of the elements, so effectively we do this:
>>
>>     __builtin_types_compatible_p(__typeof__(const char *),  __typeof__(char *))
>>
>> ... which returns 0.
> 
> True.  I wonder if (const const char *) and (const char *) are
> deemed compatible?  Even if so, probably we cannot write
> 
> 	__builtin_types_compatible_p(const __typeof__(*(dst)),
> 				     const __typeof__(*(src)))
> 
> so that line of thoguht would lead nowhere X-<.
> 
>> We can remove the const like we already do for Visual Studio.  But
>> then we have to add two casts when passing on argv2, like in
>> mingw_execv(), because adding a const to a pointer of a pointer
>> must be done explicitly in C (even though Visual Studio seems to
>> do it implicitly without complaining).  Feels a bit silly. :-|
> 
> Indeed.  Let's see what folks, whom "git blame" tells us to be area
> experts around here, think.  The "if _MSC, add const" was added in
> 12fb9bd8 (msvc: mark a variable as non-const, 2019-06-19) by JeffH,
> and try_shell_exec() function itself came from f1a4dfb8 (Windows:
> Wrap execve so that shell scripts can be invoked., 2007-12-04),
> added by J6t.

I added the ifNdef.  The existing code already had the const
that MSVC didn't like.  I don't remember why I didn't just remove
the const completely.  If I had to guess I'd say that dropping
probably caused a small cascade of caller/callee type changes
and that would have distracted from the focus of my patch series
at the time.

Personally, I think we should just remove the const from all
versions.

Thanks,
Jeff


...
>>   		int exec_id;
>>   		int argc = 0;
>> -#ifndef _MSC_VER
>> -		const
>> -#endif
>>   		char **argv2;
>>   		while (argv[argc]) argc++;
>>   		ALLOC_ARRAY(argv2, argc + 1);
>>   		argv2[0] = (char *)cmd;	/* full path to the script file */
>>   		COPY_ARRAY(&argv2[1], &argv[1], argc);
>> -		exec_id = trace2_exec(prog, argv2);
>> -		pid = mingw_spawnv(prog, argv2, 1);
>> +		exec_id = trace2_exec(prog, (const char **)argv2);
>> +		pid = mingw_spawnv(prog, (const char **)argv2, 1);
>>   		if (pid >= 0) {
>>   			int status;
>>   			if (waitpid(pid, &status, 0) < 0)
>> --
>> 2.38.1.windows.1
