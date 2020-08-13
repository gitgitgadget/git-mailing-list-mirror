Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57EEC433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 19:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F63420791
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 19:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHMTdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:33:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37157 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHMTdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 15:33:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id y3so6325494wrl.4
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 12:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSde7dpWd1dKchvYYYv8tA1j9ZFl2nt4u4YdczFobwM=;
        b=G//h1f7wTF7IlBzOl7/7tiD8mewot4UMHvpcn2zYcGWUXAXEjwqc4Um2eHRbzOR75J
         RK8dNH5WK+/i+Npx+ZB0zS+NKdBvYi+0r4XCFey+GS97Tdz109J1UP8FXEavfPH8SdHP
         6qYIsJONMDA95q6irtg1Tm0UA4NYC/+/En2pwH/wfbYQpnHvpdmdm5BJb/JqGsH6Oxzj
         lJqh6lSbX3oih1b4ledVLPKIbanIRZiAWwEP4wYI4fx730rZI6zkdhAXCpbQWP1VLxSg
         7v0tWb16cTsVFSQyL/OiNi/2LDAS8U7GdGM87+SwzL5G/ASebseCSgKQvheuRhoEF3Tq
         bFwA==
X-Gm-Message-State: AOAM532R5ekErcT7D7DQk+43//1K4oNjQNLHv9gi6CM+Q25/pB3bYdBM
        wqamzHmA9/Vpd7QIt0zDnxCdhWhbQ4VfSYg/Df6vcFF+
X-Google-Smtp-Source: ABdhPJz/4fWJwQlnHxYX5kOZu9uGqbhgPlese0OirlP/BSChDlrQik+lA2OFxmOH+ns4MvNFGV73zItgL97O3qZXV3g=
X-Received: by 2002:adf:b352:: with SMTP id k18mr5643556wrd.386.1597347187782;
 Thu, 13 Aug 2020 12:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200813155426.GA896769@coredump.intra.peff.net>
In-Reply-To: <20200813155426.GA896769@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Aug 2020 15:32:56 -0400
Message-ID: <CAPig+cTOcQymWWtSY3UN73_fpaWUs3u66+EZWBp1SvXeUrgsQQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] UNLEAK style fixes
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 11:54 AM Jeff King <peff@peff.net> wrote:
> (As a side note, if we want to declare UNLEAK() a failure because nobody
> cares enough to really use it, I'm OK with that, too).

Perhaps the reason that UNLEAK() has not been particularly successful,
in general, is that it requires extra knowledge and reasoning to know
when to use it and how to do so properly. Couple that with the fact
that the scope of cases where it can be used is quite narrow compared
to sum total of all code in project for which we simply free resources
when we're done with them. So, it's hard to keep the specialized
UNLEAK() knowledge in one's head.

Speaking from personal experience, the several times I have had to
deal with UNLEAK(), I had to re-learn it from scratch each time. That
meant studying the header comment, studying the implementation, and
studying existing callers before things "clicked" enough to be able to
feel confident about how to use it (assuming it wasn't false
confidence).

Even today, reading this patch series, I had to go through all that
again just to understand the changes made by the patches, and
especially the commit message of patch [1/2]. It took several
re-reads, plus re-examining UNLEAK() documentation, plus looking at
the UNLEAK() implementation a couple times before the [1/2] commit
message finally "clicked".

That all represents a lot of cognitive overhead versus the common
practice of simply freeing resources when you're done with them, which
requires no extra cognitive load since it is something we think about
_always_ when working with a language like C with no built-in garbage
collection.

So, I for one would not be especially sad to see UNLEAK() retired.

(The patch series itself looked fine and made sense once I had
re-acquired the necessary UNLEAK() knowledge.)
