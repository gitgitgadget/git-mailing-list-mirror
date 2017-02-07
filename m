Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2106E1FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 22:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754757AbdBGWpp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 7 Feb 2017 17:45:45 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:18266 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752868AbdBGWpn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 17:45:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 9ABD01E2CF8;
        Tue,  7 Feb 2017 23:45:31 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WD-mFhyq0xLe; Tue,  7 Feb 2017 23:45:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 2B1131E2EF1;
        Tue,  7 Feb 2017 23:45:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KKSyEBiG4pYp; Tue,  7 Feb 2017 23:45:31 +0100 (CET)
Received: from [192.168.178.36] (aftr-185-17-204-208.dynamic.mnet-online.de [185.17.204.208])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id D8B661E2CF8;
        Tue,  7 Feb 2017 23:45:30 +0100 (CET)
Subject: Re: [RFC] mailmap.blob overrides default .mailmap
To:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
References: <77c0182b-8c4f-9727-f56f-d8e2bad8146d@tngtech.com>
 <CAGZ79kZ=ikbYpuK6E=ui1ju=bRavcVcxb3AA_dvb2Jp6cRNmJQ@mail.gmail.com>
 <20170207192801.qoncjaqjpn3axpyn@sigill.intra.peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <53836bcd-1d4d-13fb-a523-1258017d19c9@tngtech.com>
Date:   Tue, 7 Feb 2017 23:45:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170207192801.qoncjaqjpn3axpyn@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2017 08:28 PM, Jeff King wrote:
> 
> I think it was mostly that I had to define _some_ order. This made sense
> to me as similar to things like attributes or excludes, where we prefer
> clone-specific data over in-history data (so .git/info/attributes takes
> precedence over .gitattributes).
> 
> So any mailmap.* would take precedence over the in-tree .mailmap file.
> And then between mailmap.file and mailmap.blob, the "blob" form is
> more "in-tree" than the "file" form (especially because we turn it on by
> default in bare repos, so it really is identical to the in-tree form
> there).

So the clone-specific data wins over in-history makes perfect sense to me. Therefore, mailmap.file should win over mailmap.blob, agreed.

On the other hand, a checked-in .mailmap file and a mailmap-blob are both as in-history as the other to me. Now consider the following settings:

$ git config --unset mailmap.file
$ git config mailmap.blob HEAD:.mailmap
$ sed -i 's:peff@peff.com:no-valid-address:' .mailmap
$ git log -1 --author 'Jeff King'

So with the .mailmap being dirty, which address would one expect to be printed? I would expect 'no-valid-address', but it's 'peff@peff.com'.

Even though the .mailmap file is more visible and also closer to the user, the mailmap.blob wins over it. I find that somewhat counter-intuitive. Of course, setting `git config mailmap.file .mailmap`, would do the trick.

