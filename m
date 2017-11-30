Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2462820954
	for <e@80x24.org>; Thu, 30 Nov 2017 10:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbdK3KAk (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 05:00:40 -0500
Received: from smtpout13.r2.mail-out.ovh.net ([54.36.141.13]:42893 "EHLO
        smtpout13.r2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750761AbdK3KAk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2017 05:00:40 -0500
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Nov 2017 05:00:39 EST
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo512.mail-out.ovh.net (Postfix) with ESMTPS id 5CA0E9EB702;
        Thu, 30 Nov 2017 10:51:03 +0100 (CET)
Received: from [10.0.2.127] (86.200.158.244) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.669.32; Thu, 30
 Nov 2017 10:51:03 +0100
Subject: Re: imap-send with gmail: curl_easy_perform() failed: URL using
 bad/illegal format or missing URL
To:     Daniel Stenberg <daniel@haxx.se>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
CC:     Jonathan Nieder <jrnieder@gmail.com>,
        Doron Behar <doron.behar@gmail.com>, <git@vger.kernel.org>
References: <20171129171301.l3coiflkfyy533yz@NUC.localdomain>
 <20171130020445.GF15098@aiede.mtv.corp.google.com>
 <50fb321e-bbfc-adae-992d-eea1b818171e@suse.de>
 <alpine.DEB.2.20.1711301041250.30591@tvnag.unkk.fr>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <44bbb765-fb0d-5b80-c697-76a9b6ff0811@morey-chaisemartin.com>
Date:   Thu, 30 Nov 2017 10:51:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101
 Thunderbird/57.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1711301041250.30591@tvnag.unkk.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.158.244]
X-ClientProxiedBy: CAS3.indiv2.local (172.16.1.3) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 15314490536864835549
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtuddrtdeggddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 30/11/2017 à 10:46, Daniel Stenberg a écrit :
> On Thu, 30 Nov 2017, Nicolas Morey-Chaisemartin wrote:
>
>> This is due to the weird "[Gmail]" prefix in the folder.
>> I tried manually replacing it with:
>>         folder = %5BGmail%5D/Drafts
>> in .git/config and it works.
>>
>> curl is doing some fancy handling with brackets and braces. It make sense for multiple FTP downloads like ftp://ftp.numericals.com/file[1-100].txt, not in our case. The curl command line has a --globoff argument to disable this "regexp" support and it seems to fix the gmail case. However I couldn't find a way to change this value through the API...
>
> That's just a feature of the command line tool, "globbing" isn't a function provided by the library. libcurl actually "just" expects a plain old URL.
>
Yep that what I figured looking a bit further in the code.

> But with the risk of falling through the cracks into the rathole that is "what is a URL" (I've blogged about the topic several times in the past and I will surely do it again in the future):
>
> A "legal" URL (as per RFC 3986) does not contain brackets, such symbols should be used URL encoded: %5B and %5D.
>
> This said: I don't know exactly why brackets cause a problem in this case. It could still be worth digging into and see if libcurl could deal with them better here...
>

It would make sense to have a way to ask libcurl to URI encode for us. I'm guessing there's already the code for that somewhere in curl and we would be wise to use it.
But to work wqith older version we'll have to do it ourselves anyway.

Nicolas
