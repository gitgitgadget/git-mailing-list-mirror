Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC13CC433DB
	for <git@archiver.kernel.org>; Fri, 25 Dec 2020 10:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A877E23137
	for <git@archiver.kernel.org>; Fri, 25 Dec 2020 10:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgLYKNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Dec 2020 05:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgLYKNi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Dec 2020 05:13:38 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77102C061573
        for <git@vger.kernel.org>; Fri, 25 Dec 2020 02:12:57 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4D2N6M4Q4YzQlRk
        for <git@vger.kernel.org>; Fri, 25 Dec 2020 11:12:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m-reimer.de; s=MBO0001;
        t=1608891145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8bHL0avYix/fSF02uIlrQm/waIeN4U3RJcSRmgMizY=;
        b=adasqp44SjQlhbIB2utXeT17Ka9TlzS8ZhXgHKLxxtqbeMWiDvm/RqwHXBUEy4jocgjYiI
        Z2MDVA0aJto2j7F0XDZiUOipuqe8RB16D29aMx/Pe+NkNbZTYNqsJuQ9po9ECRVo5mdHF5
        3q+p2qNae6CHpSKKaWmn8Jmm/Iba1ccPnr3Qzj0vlfmZBboJmj38Wv85cuEl8GdbXVE/FI
        zlIWhL5jmhOxB7IB9GSlHpQr5kfiE9IOISG/ZwlUnDwTYoM1wVumr6GeIi04f4JGAf/DcM
        QzmosZBJAZ/Wbq7IN8o+Fzzx2rVJhrPIk7C9PygRSAET7KJ8h4ZjEOIJ59gCbA==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id pij_WmFthz69 for <git@vger.kernel.org>;
        Fri, 25 Dec 2020 11:12:24 +0100 (CET)
Subject: Re: How to integrate external repo into existing directory of a
 bigger repo (git subtree)?
From:   Manuel Reimer <mail+git@m-reimer.de>
To:     git@vger.kernel.org
References: <e30c1de9-9449-78d6-99eb-c3bbad673903@m-reimer.de>
Message-ID: <31b0d4a2-249f-ec18-8b7c-24b4a6165e7b@m-reimer.de>
Date:   Fri, 25 Dec 2020 11:12:23 +0100
MIME-Version: 1.0
In-Reply-To: <e30c1de9-9449-78d6-99eb-c3bbad673903@m-reimer.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.35 / 15.00 / 15.00
X-Rspamd-Queue-Id: A5DD01718
X-Rspamd-UID: 593fcb
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24.12.20 15:53, Manuel Reimer wrote:
> What I want to do is porting this over to "git subtree" somehow, but:
> 
> - I would prefer to not loose history in the "big repo"
> - I can't force-push to the small external repositories (blocked)

Just for the record: I found a way to fix this properly.

The way to go is:

- Create a new, empty, GIT repository (git init)
- For some reason (bug?) "git subtree" fails on a completely new repo, 
so I had to add one initial commit (I used this to add a small helper 
shellscript that I want to use to simplify my "git subtree" work).
- Now add all the wanted "git subtrees" from their existing "external 
repositories" to the, so far, nearly empty repo. This creates a proper 
"Add ..." commit which seems to be the key to not break pushing to the 
external repo.
- After adding all subtrees, pull from the "big repo", resolve conflicts 
and create a merge commit.

At this point I was able to "git subtree push" without needing to force. 
This also transferred proper history for the subtrees to the individual 
external repos. Even the final push to my "big repo" worked without forcing.

Regards,

Manuel
