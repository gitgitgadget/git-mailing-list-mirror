Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1EC3201CF
	for <e@80x24.org>; Sat, 20 May 2017 06:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756285AbdETGst (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 02:48:49 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:57822 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756151AbdETGss (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 02:48:48 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wVFrG6x2Wz5tlG;
        Sat, 20 May 2017 08:48:46 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A7D4642E7;
        Sat, 20 May 2017 08:48:46 +0200 (CEST)
Subject: Re: [Bug] git branch -v has problems with carriage returns
To:     Atousa Duprat <atousa.p@gmail.com>
Cc:     Animi Vulpis <animi.vulpis@gmail.com>, git@vger.kernel.org
References: <CALKRkrxHNao6NY+-_UmznHdq29yVJJynu8Xx5M__YfK9UkdOAw@mail.gmail.com>
 <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3d02b958-5f72-9676-bce9-afca962c07df@kdbg.org>
Date:   Sat, 20 May 2017 08:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.05.2017 um 23:55 schrieb Atousa Duprat:
> I have tried to repro this issue but git goes out of its way to store
> the commit messages using unix end-of-line format.
> I think that git itself cannot create a repo exhibiting this problem.

Here is a recipe to reproduce the error:

   git init
   git commit --allow-empty -m initial
   git branch crlf $(printf '%s\r\n' subject '' line3_long line4 |
        git commit-tree HEAD:)

The reason for the "bug" is obviously that a line having CR in addition 
to LF is not "an empty line". Consequently, the second line is not 
treated as a separator between subject and body, whereupon Git 
concatenates all lines into one large subject line. This strips the LFs 
but leaves the CRs in tact, which, when printed on a terminal move the 
cursor to the beginning of the line, so that text after the CRs 
overwrites what is already in the terminal.

This is just to give you a head start. I'm not going to look into this.

-- Hannes

>> If I do `git branch -v` with such a subject line somehow the third and
>> second line get combined before the hash. Example:
>>
>> $ git branch -v
>> See merge request !XXXX temp space 84e18d22fd Merge branch
>> 'feature-XXX' into 'develop'
>> # <begins with third line> <ending of seconds line (if longer than
>> third)> <commit hash (correct)> <subject line (correct)>
>>
>> Before git v2.13.0 `git branch -v` worked completely normal.
