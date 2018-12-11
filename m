Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B332A20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 20:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeLKUgK (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 15:36:10 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:27862 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbeLKUgK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 15:36:10 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43DsCq5d73z5tlG;
        Tue, 11 Dec 2018 21:36:07 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0D44220B4;
        Tue, 11 Dec 2018 21:36:07 +0100 (CET)
Subject: Re: [PATCH 2/2] mingw: allow absolute paths without drive prefix
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.96.git.gitgitgadget@gmail.com>
 <50ac31ef7f4380f37a0e2d3b75e82b324afee9e3.1544467631.git.gitgitgadget@gmail.com>
 <11b17e5d-e843-463b-77da-263e8e3b7598@kdbg.org>
 <nycvar.QRO.7.76.6.1812111134250.43@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8a484f86-1d43-fc0a-22b4-39c770cda6cb@kdbg.org>
Date:   Tue, 11 Dec 2018 21:36:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1812111134250.43@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.12.18 um 12:25 schrieb Johannes Schindelin:
> On Mon, 10 Dec 2018, Johannes Sixt wrote:
>>> diff --git a/compat/mingw.c b/compat/mingw.c
>>> index 34b3880b29..4d009901d8 100644
>>> --- a/compat/mingw.c
>>> +++ b/compat/mingw.c
>>> @@ -928,11 +928,19 @@ unsigned int sleep (unsigned int seconds)
>>>    char *mingw_mktemp(char *template)
>>>    {
>>>    	wchar_t wtemplate[MAX_PATH];
>>> +	int offset = 0;
>>> +
>>>     if (xutftowcs_path(wtemplate, template) < 0)
>>>    		return NULL;
>>> +
>>> +	if (is_dir_sep(template[0]) && !is_dir_sep(template[1]) &&
>>> +	    iswalpha(wtemplate[0]) && wtemplate[1] == L':') {
>>> +		/* We have an absolute path missing the drive prefix */
>>
>> This comment is true for the source part, template, but I can't find
>> where the destination, wtemplate, suddenly gets the drive prefix. As far
>> as I can see, xutftowcs_path() just does a plain textual conversion
>> without any interpretation of the text as path. Can you explain it?
> 
> It is legal on Windows for such a path to lack the drive prefix, also in
> the wide-character version. So the explanation is: even `wtemplate` won't
> get the drive prefix. It does not need to.

I'm sorry, my question was extremely fuzzy. I actually wanted to know 
how the condition that you introduce in this patch can ever be true.

And after looking at the Git for Windows code, I could answer it myself: 
it cannot. Not with this patch alone. In GfW, there is additional code 
in xutftowcs_path() that massages wtemplate to receive a drive prefix; 
but vanilla Git does not have that code, so that is_dir_sep(template[0]) 
and iswalpha(wtemplate[0]) can never be true at the same time at this point.

-- Hannes
