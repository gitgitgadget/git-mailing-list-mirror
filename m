Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1232E208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 17:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbdHOR7R (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:59:17 -0400
Received: from 6.mo176.mail-out.ovh.net ([46.105.44.204]:46124 "EHLO
        6.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbdHOR7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:59:16 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 8D9D475B7A
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 19:49:31 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 15
 Aug 2017 19:49:31 +0200
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
To:     <git@vger.kernel.org>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
Message-ID: <5c46f1e4-825e-8e10-e323-e637e170f315@morey-chaisemartin.com>
Date:   Tue, 15 Aug 2017 19:49:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: CAS3.indiv2.local (172.16.1.3) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 3759098317251143645
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrleejgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping.

I'd like to get feedback from Windows developer on patch #2
Patch#3 will probably need some updates as I expected Jeff old curl drop patches to make it in.
As it seems to be going another way a few more ifdefs will be required

Nicolas

Le 09/08/2017 à 16:43, Nicolas Morey-Chaisemartin a écrit :
> From 7.21.5, curl can be tricked into using an open fd.
> This series uses this to allow using curl over a tunnel.
>
> I have a few doubt on patch #2:
> - is socketpair working on all git supported system (windows ?)
> - should socketpair always be used or limited to the curl over tunnel case ?
>   I don't think there is too much different between an unname pipe and a socketpair but I'm not sure either :)
>
> This series also shows a "bug" in curl.
> When trying out the tunnel example fro imap-send documentation, this happends:
> Starting tunnel 'ssh -q -C localhost /usr/sbin/imapd ./Maildir'... ok
> sending 3 messages
> 16:38:54.055221 http.c:639              == Info: Hostname was NOT found in DNS cache
> 16:38:54.059505 http.c:639              == Info:   Trying ::1...
> 16:38:54.059545 http.c:639              == Info: Connected to localhost () port 143 (#0)
> 16:38:54.354379 http.c:586              <= Recv header, 0000000332 bytes (0x0000014c)
> 16:38:54.354405 http.c:598              <= Recv header: * PREAUTH [CAPABILITY IMAP4REV1 I18NLEVEL=1 LITERAL+ IDLE UIDPLUS NAMESPACE CHILDREN MAILBOX-REFERRALS BINARY UNSELECT ESEARCH WITHIN SCAN SORT THREAD=REFERENCES THREAD=ORDEREDSUBJECT MULTIAPPEND] Pre-authenticated user nmorey portia.home.nicolas.morey-chaisemartin.com IMAP4rev1 2007e.404 at Wed, 9 Aug 2017 16:38:54 +0200 (CEST)
> 16:38:54.354425 http.c:639              == Info: Bad tagged response
> 16:38:54.354448 http.c:639              == Info: Closing connection 0
> curl_easy_perform() failed: FTP: weird server reply
>
> It appears curl do not support the PREAUTH tag.
>
> However a test with "nc imap.server.ext 143" is working fine.
>
> Nicolas Morey-Chaisemartin (3):
>   imap-send: move tunnel setup to its own function
>   imap-send: use a socketpair instead of pipe to communicate with the
>     tunnel
>   imap_send: add support for curl over tunnel
>
>  Documentation/git-imap-send.txt |  4 +-
>  imap-send.c                     | 91 +++++++++++++++++++++++++++++++----------
>  2 files changed, 72 insertions(+), 23 deletions(-)
>

