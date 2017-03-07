Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24DDB1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 19:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756028AbdCGTez (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 14:34:55 -0500
Received: from forward6h.cmail.yandex.net ([87.250.230.217]:50004 "EHLO
        forward6h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755292AbdCGTd5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Mar 2017 14:33:57 -0500
X-Greylist: delayed 1002 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Mar 2017 14:33:56 EST
Received: from smtp2m.mail.yandex.net (smtp2m.mail.yandex.net [77.88.61.129])
        by forward6h.cmail.yandex.net (Yandex) with ESMTP id 32E53228BD;
        Tue,  7 Mar 2017 21:59:16 +0300 (MSK)
Received: from smtp2m.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp2m.mail.yandex.net (Yandex) with ESMTP id AA2A92300EA6;
        Tue,  7 Mar 2017 21:59:13 +0300 (MSK)
Received: by smtp2m.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id X5x3sz8UFe-xCImsen0;
        Tue, 07 Mar 2017 21:59:12 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1488913152;
        bh=TBjd4dwdEwt/m/nWpKnIjp1sWOIxGBiPDifCeNo63Vo=;
        h=Date:From:Reply-To:Subject:To:Cc:Message-Id;
        b=MPMuIqs//7/rZDCau8AylI5sVsa9P9I4uq3/HOntBzK9J2EtzrIKad/cU2z09dWqM
         ld67TjT5H46Q2Z1v15Iwz2RfjYEanJzslGeSmsZUNB07mDYnzf0MLR5qJa851uevKg
         BfkN696CSjRCW4/SZA2TovQMoGXmqXa0Y6Xbxt6I=
Authentication-Results: smtp2m.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 0,1 0,1 1130000030716801,1 0
Date:   Tue, 07 Mar 2017 21:59:10 +0300
From:   Valery Tolstov <me@vtolstov.org>
Reply-To: CAGZ79kZbc394rmxYDUxCbysKNbEQCB7aLJkf6MGcCeXKAxiKhA@mail.gmail.com
Subject: Re: git init --separate-git-dir does not update symbolic .git links
 for submodules
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, me@vtolstov.org,
        sven@cs-ware.de
Message-Id: <1488913150.8812.0@smtp.yandex.ru>
X-Mailer: geary/0.11.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think we can reuse code from module_clone that writes .git link.
Possibly this code fragment needs to be factored out from module_clone

Also, to fix all the links, we need to obtain the list of submodules
and then iterate over them. module_list command iterates
and prints the result to stdout. Maybe we can reuse this output.
Or create separate function that returns the list of submodules.

Can we call these functions from submodule--helper inside init command,
or run them thorugh internal command interface?

In my opinion, make submodule--helper fully responsible for link fixes
would be a good solution. Then we create two additional function, one
that fixes all submodules on the current level, and another that
fixes individual submodule.
Although it looks good, I'm not quite sure that it's really good.

So, maybe we can do link fixes like this:

    1. Start fixing from init command using submodule--helper, with
       subcommand that fixes all submodules on current level
    2. Each submodule processed with another subcommand/function in
       submodule--helper individually
    3. Repeat for current submodule recursively

Glad to see your advices.

Regards,
  Valery Tolstov



