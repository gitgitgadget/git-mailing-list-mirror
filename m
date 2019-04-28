Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B06F1F453
	for <e@80x24.org>; Sun, 28 Apr 2019 15:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfD1Pz1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Apr 2019 11:55:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35044 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfD1Pz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Apr 2019 11:55:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id g24so2012924otq.2
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cV9UsajgbtwAYbDBtff05shfWfDuoAwTBbfq0BBcSEA=;
        b=F0iFdLNe0uvVHCFqjpQhhXlLOrmlFAWsJ84jM7O0Hd3XSsZbohZof1uXnN6uVAh+mZ
         F0ZXwc1k08zUQrTNb8XH7+SURxeqgRyt5uq2jl3VXVaXgqH9B1xLiY2Q666UiE8oDHXI
         HJflDJLcl9yC2dLP2LdUuBzBT233s6Fh4q6XWR1lamS+YAfN/ulBJRQSnju06eDzgV4O
         /vG3WtE60l0rdCmVznG96PLiqiPD4Iaw85iErx6krEMhBSCcARu9nFnGqd8Ht+Id7coK
         /yg7MagXz7NNwUT9A3XjAxQvBOXeUumt2Xnp57DdhJAZ7ShdNBuk4dLY3WA2H+wtlym7
         vLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cV9UsajgbtwAYbDBtff05shfWfDuoAwTBbfq0BBcSEA=;
        b=S8knWgf4jlyHtHV3FAv/kYKtwykE9ZWf0Jt5Id/2OC+1NSRLUJg8J7VhtQyU94yuhv
         ATFn9R4yJ04vjp5Mc5Mm+vHIoCsNjy9SarcIcrKE66KTn57tuabGSCmhl5AevOrnTiUP
         LR38FVruR4sw/KO8ykE2nIIN4Oq+PBRBg/7bbYbqv9KOqUmvVRSMfxl60fNi67f7n1BN
         zixnkUJBfR0lX/HiQOCTgEGIP345DM08e5hCo5NCdqSK2A7f4pKdiXuMUmwfQoitzEPT
         xreE4vrEDef6sjiq+0iZ4ausfejU4CUYrqBDaPKmOE85DWYqkNegthYyaL7lNbeQMpYF
         FU8A==
X-Gm-Message-State: APjAAAXUgWFvUYVaOJ7n1d/REa8WBlRPA/URK/XOhPOj+GXyVKiBnezU
        s7Dg248IxmtDJK90YXOSoju9VvtCOt8bA8FWN9fNCXtCrpbI
X-Google-Smtp-Source: APXvYqzLMwg/fAJjWHdGbrXdrXVCXEHK+GjkbvRRezvD0KE2KjbwFTfWKTx1qVnBNf5w9q8crYoXjN+81ahQUolFdMU=
X-Received: by 2002:a9d:73d7:: with SMTP id m23mr2532790otk.5.1556466925844;
 Sun, 28 Apr 2019 08:55:25 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew DeVore <matvore@google.com>
Date:   Sun, 28 Apr 2019 08:55:15 -0700
Message-ID: <CAMfpvhKYRVwTVNLfRJYcjhHtg=FNLNPbnw8xtY93nJu228v6=g@mail.gmail.com>
Subject: Proposal: object negotiation for partial clones
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrn@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm considering implementing a feature in the Git protocol which would
enable efficient and accurate object negotiation when the client is a
partial clone. I'd like to refine and get some validation of my
approach before I start to write any code, so I've written a proposal
for anyone interested to review. Your comments would be appreciated.

Remember this is a publicly-accessible document so be sure to not
discuss any confidential topics in the comments!

Tiny URL: http://tinyurl.com/yxz747cy
Full URL: https://docs.google.com/document/d/1bcDKCgd2Dw5Cl6H9TrNi0ekqzaT8rbyK8EpPE3RcvPA/edit#

Thank you,
Matt
