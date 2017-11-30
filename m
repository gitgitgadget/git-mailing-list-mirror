Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638D720954
	for <e@80x24.org>; Thu, 30 Nov 2017 09:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdK3Jjt (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 04:39:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:47846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbdK3Jjs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 04:39:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2207FAAB9;
        Thu, 30 Nov 2017 09:39:47 +0000 (UTC)
Subject: Re: imap-send with gmail: curl_easy_perform() failed: URL using
 bad/illegal format or missing URL
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Doron Behar <doron.behar@gmail.com>
Cc:     git@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
References: <20171129171301.l3coiflkfyy533yz@NUC.localdomain>
 <20171130020445.GF15098@aiede.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <50fb321e-bbfc-adae-992d-eea1b818171e@suse.de>
Date:   Thu, 30 Nov 2017 10:39:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101
 Thunderbird/57.0
MIME-Version: 1.0
In-Reply-To: <20171130020445.GF15098@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 30/11/2017 à 03:04, Jonathan Nieder a écrit :
> (+cc: Nicolas)
> Hi,
>
> Doron Behar wrote:
>
>> I'm trying to send a patch with the command `git imap-send`, I used the
>> examples in the manual page as the main reference for my configuration:
>>
>> ```
>> [imap]
>> 	folder = "[Gmail]/Drafts"
>> 	host = imaps://imap.gmail.com
>> 	user = doron.behar@gmail.com
>> 	port = 993
>> 	sslverify = false
>> ```
>>
>> This is my `cat patch.out | git imap-send` output:
>>
>> ```
>> Password for 'imaps://doron.behar@gmail.com@imap.gmail.com':
>> sending 3 messages
>> curl_easy_perform() failed: URL using bad/illegal format or missing URL
>> ```
> Thanks for reporting this.  I suspect this is related to
> v2.15.0-rc0~63^2 (imap-send: use curl by default when possible,
> 2017-09-14) --- e.g. perhaps our custom IMAP code was doing some
> escaping on the username that libcurl does not do.
>
> "man git imap-send" says this is a recommended configuration, so I
> don't think it's a configuration error.
>
> What platform are you on?  What version of libcurl are you using?
>
> In libcurl::lib/easy.c I am also seeing
>
>     if(mcode)
>       return CURLE_URL_MALFORMAT; /* TODO: return a proper error! */
>
> which looks suspicious.
>
> Nicolas, am I on the right track?
>
> Thanks,
> Jonathan
>

This is due to the weird "[Gmail]" prefix in the folder.
I tried manually replacing it with:
        folder = %5BGmail%5D/Drafts
in .git/config and it works.

curl is doing some fancy handling with brackets and braces. It make sense for multiple FTP downloads like ftp://ftp.numericals.com/file[1-100].txt, not in our case.
The curl command line has a --globoff argument to disable this "regexp" support and it seems to fix the gmail case.
However I couldn't find a way to change this value through the API...

I guess we should open a bug upstream to get access to this setting through the API and add a patch that HTTP encode brackets and braces in the meantime.

Nicolas

