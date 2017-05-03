Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D19207F8
	for <e@80x24.org>; Wed,  3 May 2017 22:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbdECWza (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 18:55:30 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39811 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751151AbdECWz2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 May 2017 18:55:28 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D1638209E0
        for <git@vger.kernel.org>; Wed,  3 May 2017 18:55:27 -0400 (EDT)
Received: from web2 ([10.202.2.212])
  by compute5.internal (MEProxy); Wed, 03 May 2017 18:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=frankpf.com; h=
        content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=9LyIthXHErPIvoZOGbdQfcv+JgNPs4dEG7NMrGJG/OA=; b=CY3GJI9m
        /J3lMNRn2FnD2qYPJHkuSnCRKJCo+Sb2KBW+DZjOPAuE+un8ph3KlMm1EY2XNug/
        SvJkvXYJYqXN2lDEqyNdx2Xf0QDtFmIwwDyTTRdD74K2SXWkxwVC1PvVy+CDMPkx
        gh+eOpFsNFeNHu7jQLoWs7KIdYgkI28NcvLzN/sc1mK2wzFFkJzl9UNM9BovHkY+
        6w8B7RqO5DdwVM+b+aoBPTeIDFs5BQN6h7LxFYS1BcRWR9BMiW8xr3kF2oyvq6Fe
        KDJIpJo/eVK6Sq10IeF/B4TBHkB42NgsT/NNY5aYDp/UO04I4qIuH+kDD0KoOUAg
        6RAk4tVzLewZFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=9LyIthXHErPIvoZOGbdQfcv+JgNPs
        4dEG7NMrGJG/OA=; b=kPIB7R1+BFXFe6BAE4wbYv0/Lu9p6PTskUBALcynuslv/
        lQ0LNEfyCOCSY3Ysnn0oBun+42D6ryp0XJ8dBkVHENUr2lyxafWN33cDIm+HkWoV
        /bZzw6NCZKT8mJGdk/kFlUk2zQpGR0xyush8NnfD8Ibl6jxSaKgTpBxecusEexzb
        TAGPh42niAascw9Hv7fGrDgBhRfXRPi7LMrK4612CjHiWfLKqgAu3c+RksD0XbH8
        hdpzUXFgTozR01Bx0IGe3T5oR7PFIIcPKCDuaYlSTkFSYn6wyCraBef/rzkwFnnQ
        Ivgpk5egJYnhXtpLVslQglr4yBptgUQBdBtG60HZQ==
X-ME-Sender: <xms:318KWaeBr7ReN0lHtH_I-GkMer4ssNmH-O2BCcx5fewX2ZQj_IDVjg>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id A9B6262704; Wed,  3 May 2017 18:55:27 -0400 (EDT)
Message-Id: <1493852127.2480170.965025544.54B1448D@webmail.messagingengine.com>
From:   Frank Paulo Filho <me@frankpf.com>
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-88a795dc
Subject: Incorrect handling of interactive rebases with root flag
Date:   Wed, 03 May 2017 19:55:27 -0300
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I run an interactive rebase on a branch without the --root flag, git
does not modify (change the hash, etc.) any initial commits that are
being "pick"ed in the same order. However, if I use --root, every single
commit is modified. 

Here's an example:

* Old (immediately after running "git rebase -i --root"):
    pick d89 root
    pick 3e7 bar
    pick 57e baz

* New (after editing the "git-rebase-todo" file):
    pick d89 root
    pick 57e baz
    pick 3e7 bar

After this, AFAIK, only baz and bar's hashes should change. However, the
root commit's hash (d89) also changes.

A simpler way to reproduce this is to just run `git rebase -i  --root`
and rebase without changing anything. Every commit will be modified.

Is this supposed to happen?
