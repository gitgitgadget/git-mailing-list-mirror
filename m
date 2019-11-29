Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF44AC432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 22:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3408208E4
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 22:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfK2WhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 17:37:22 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:45090 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfK2WhV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 17:37:21 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47PqBk4jCmz5tl9;
        Fri, 29 Nov 2019 23:37:18 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 07D001AE7;
        Fri, 29 Nov 2019 23:37:18 +0100 (CET)
Subject: Re: [PATCH 3/4] mingw: spawned processes need to inherit only
 standard handles
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
 <feb197792814701bf36cb15b73e1e73aae2baa4d.1574433665.git.gitgitgadget@gmail.com>
 <00ef72f5-b1fa-f449-0e00-23713bed0187@kdbg.org>
 <nycvar.QRO.7.76.6.1911291036320.31080@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <653e0604-3fd0-235d-564e-8f8a5900a0ae@kdbg.org>
Date:   Fri, 29 Nov 2019 23:37:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1911291036320.31080@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.11.19 um 14:52 schrieb Johannes Schindelin:
> On Thu, 28 Nov 2019, Johannes Sixt wrote:
>> Am 22.11.19 um 15:41 schrieb Johannes Schindelin via GitGitGadget:
>>> +		    !getenv("SUPPRESS_HANDLE_INHERITANCE_WARNING")) {
>>
>> ... and the variable isn't set, so we continue here. (But I don't think
>> it is important.)

It's actually not that unimportant because ...

>>
>>> +			DWORD fl = 0;
>>> +			int i;
>>> +
>>> +			setenv("SUPPRESS_HANDLE_INHERITANCE_WARNING", "1", 1);
>>> +
>>> +			for (i = 0; i < stdhandles_count; i++) {
>>> +				HANDLE h = stdhandles[i];
>>> +				strbuf_addf(&buf, "handle #%d: %p (type %lx, "
>>> +					    "handle info (%d) %lx\n", i, h,
>>> +					    GetFileType(h),
>>> +					    GetHandleInformation(h, &fl),
>>> +					    fl);

... ERANGE happens here in the second iteration, in particular, when
strbuf_vaddf needs to grow the buffer. vsnprintf generates it.

>>> +			}
>>> +			strbuf_addstr(&buf, "\nThis is a bug; please report it "
>>> +				      "at\nhttps://github.com/git-for-windows/"
>>> +				      "git/issues/new\n\n"
>>> +				      "To suppress this warning, please set "
>>> +				      "the environment variable\n\n"
>>> +				      "\tSUPPRESS_HANDLE_INHERITANCE_WARNING=1"
>>> +				      "\n");
>>> +		}

-- Hannes
