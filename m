Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3A31F404
	for <e@80x24.org>; Tue, 11 Sep 2018 14:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeIKTYz (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 15:24:55 -0400
Received: from siwi.pair.com ([209.68.5.199]:40456 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeIKTYz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 15:24:55 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 04ADD3F40BE;
        Tue, 11 Sep 2018 10:25:21 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BA2473F40BC;
        Tue, 11 Sep 2018 10:25:20 -0400 (EDT)
Subject: Re: [PATCH v2 2/2] mingw: fix mingw_open_append to work with named
 pipes
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     jeffhost@microsoft.com,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.35.git.gitgitgadget@gmail.com>
 <pull.35.v2.git.gitgitgadget@gmail.com>
 <f0361dd306d19fa741c813885d240e041dc09a7a.1536599118.git.gitgitgadget@gmail.com>
 <a309396f-bb33-477d-5d92-a98699f5a856@kdbg.org>
 <xmqqbm95rp27.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <26f3d84d-cfa4-bb03-a2f8-d2e0fe5ad12e@jeffhostetler.com>
Date:   Tue, 11 Sep 2018 10:25:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqbm95rp27.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/10/2018 6:00 PM, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>>>    +#define IS_SBS(ch) (((ch) == '/') || ((ch) == '\\'))
> 
> I think you already have mingw_is_dir_sep() and its shorter alias
> is_dir_sep() available to you.

good catch. thanks.


>>> +/*
>>> + * Does the pathname map to the local named pipe filesystem?
>>> + * That is, does it have a "//./pipe/" prefix?
>>> + */
>>> +static int mingw_is_local_named_pipe_path(const char *filename)
> 
> There is no need to prefix mingw_ to this function that is file
> local static.  Isn't is_local_named_pipe() descriptive and unique
> enough?

right. will do.


>>> +{
>>> +	return (IS_SBS(filename[0]) &&
>>> +		IS_SBS(filename[1]) &&
>>> +		filename[2] == '.'  &&
>>> +		IS_SBS(filename[3]) &&
>>> +		!strncasecmp(filename+4, "pipe", 4) &&
>>> +		IS_SBS(filename[8]) &&
>>> +		filename[9]);
>>> +}
>>> +#undef IS_SBS
> 
> It is kind-of surprising that there hasn't been any existing need
> for a helper function that would allow us to write this function
> like so:
> 
> 	static int is_local_named_pipe(const char *path)
> 	{
> 		return path_is_in_directory(path, "//./pipe/");
> 	}
> 
> Not a suggestion to add such a thing; as long as we know there is no
> other codepath that would benefit from having one, a generalization
> like that can and should wait.

Yeah, I don't think we need something that general just yet.  Named
pipes exist in a special namespace using the UNC/network-share syntax
(rather than the DOS drive-letter syntax), and we don't do much with
UNC paths yet.

Perhaps, later we could have something to try splitting a UNC
path into <server>, <volume>, and <relative-path> and then have
is_local_named_pipe() verify the first 2 are as expected.
Or have a function like is_path_in_volume(path, server, volume)
that does the tests without cutting up strings and allocating.
We could do either, but I don't think we need to be that general
yet.

Thanks,
Jeff
		
