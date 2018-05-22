Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28991F42D
	for <e@80x24.org>; Tue, 22 May 2018 06:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeEVGmH (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 02:42:07 -0400
Received: from giant.haxx.se ([80.67.6.50]:46770 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbeEVGmG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 02:42:06 -0400
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 May 2018 02:42:06 EDT
Received: from giant.haxx.se (mail [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id w4M6WheR000734
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 May 2018 08:32:43 +0200
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id w4M6Wh2b000728;
        Tue, 22 May 2018 08:32:43 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Tue, 22 May 2018 08:32:43 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        git <git@vger.kernel.org>,
        Anton Golubev <anton.golubev@gmail.com>
Subject: Re: [PATCH 1/2] remote-curl: accept all encoding supported by curl
In-Reply-To: <20180522010008.GI10623@aiede.svl.corp.google.com>
Message-ID: <alpine.DEB.2.20.1805220824440.6210@tvnag.unkk.fr>
References: <20180521234004.142548-1-bmwill@google.com> <CAGZ79kZiyi_1nxvfLttD6HPyV66Wz3pLnuAe=L7FB9ak05dGAQ@mail.gmail.com> <20180522010008.GI10623@aiede.svl.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 21 May 2018, Jonathan Nieder wrote:

>> Looking at the code here, this succeeds if enough memory is available.
>> There is no check if the given parameter is part of
>> Curl_all_content_encodings();
>
> By "this" are you referring to the preimage or the postimage?  Are you 
> suggesting a change in git or in libcurl?
>
> Curl_all_content_encodings() is an internal function in libcurl, so I'm 
> assuming the latter.

Ack, that certainly isn't the most wonderful API for selecting a compression 
method. In reality, almost everyone sticks to passing on a "" to that option 
to let libcurl pick and ask for the compression algos it knows since both gzip 
and brotli are present only conditionally depending on build options.

I would agree that the libcurl setopt call should probably be made to fail if 
asked to use a compression method not built-in/supported. Then an application 
could in fact try different algos in order until one works or ask to disable 
compression completely.

In the generic HTTP case, it usually makes sense to ask for more than one 
algorthim though, since this is asking the server for a compressed version and 
typically a HTTP client doesn't know which compression methods the server 
offers. Not sure this is actually true to the same extent for git.

-- 

  / daniel.haxx.se
