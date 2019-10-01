Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFF871F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 13:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbfJANGn (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 09:06:43 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:37166 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJANGn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 09:06:43 -0400
Received: by mail-io1-f51.google.com with SMTP id b19so19598595iob.4
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 06:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hTmwZ9zp/b/Qu9n3O82zir1dl5qDd8zhLCB+nJ7THFE=;
        b=GU61EBt9MJKkcXqGHZNRRYBI1WliVsLTjuEWw6XYcF0gQX4OyiI6NeSsQCMc77Wp3M
         QLAf4LwLyfMt7eh+P62amgpMfWiKbmASjWD21lm+33COWXV93FLCdu5k+OoKcZoJAQ5o
         0zCHS44/IGk5doVp1J7H8K8TkRQzVX/SUN/Up+zMp75CMSsybxhT6UHoCApX0KYeqlyP
         jMMLAxqbh2VbivBoRMq/ncr5Qy4wFJWLg4M0vBjNublPbLGfjBQX4bFvQHvPix7zXM/q
         fxzxnu7EB+FnlHrHhXeGQOiFy5gNUT76dd+DZ4N2zEUKy3VTSwyoAp1DHsTJQYj+yWvG
         oInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hTmwZ9zp/b/Qu9n3O82zir1dl5qDd8zhLCB+nJ7THFE=;
        b=D5+cXqGo3bn2Y9R+01TUpqCF14DKPWL/nidZ+hlCliQdPMBotx8aMesDhab0qG/puO
         ckLEevLM2xCyUtUewtrg9ALmEihMC4rIjf7X4Bxcr6dB5npbAaO1UM4XIcHHd3I9yg9p
         dMWjadjn6UivVYHe18Gn1Q0R0+RpOfo8NJgtC4BVxleOReGTCPWrjQf0U44qOYhrEL7c
         NIbOtZOQIu9WQIm8kLe8/ND80w1KQgRHKwbjFqM3ZAhzf2pNtvIZJt+pwWpO7QfdG7cK
         7tHcts1o99mcl8gXR3KVGtzeNRj+MavuwgyyrL90I0VZ3Fp7M2NcSiBPBuoXs4OTp75V
         c8uA==
X-Gm-Message-State: APjAAAXiJWHVgTAgkMbgOb7gQXUHUVb5lANpa5fjWh4AYX4tRy7m+mt1
        sbbLR2GKf5LIYH/KmHl3l4uUoneXDeci0E7ia8vANYugNRA=
X-Google-Smtp-Source: APXvYqxAAtF4pZ+okkUiwuQGSJhsuubN8r1AqwoNjtr0gKZVAJw7ue9OeyjybLsa8LDDpW/fjFC8OP2fp3T0og4+OaY=
X-Received: by 2002:a6b:7116:: with SMTP id q22mr24286584iog.280.1569935202303;
 Tue, 01 Oct 2019 06:06:42 -0700 (PDT)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 1 Oct 2019 10:06:31 -0300
Message-ID: <CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com>
Subject: git-grep in sparse checkout
To:     git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

During Git Summit it was mentioned that git-grep searches outside
sparsity pattern which is not aligned with user expectation. I took a
quick look at it and it seems the reason is
builtin/grep.c:grep_cache() (which also greps worktree) will grep the
object store when a given index entry has the CE_SKIP_WORKTREE bit
turned on.

From what I understand, this bit is used exactly for sparse checkouts
(as described in Documentation/technical/index-format.txt[1]). But
should we perhaps ignore it in git-grep to have the expected behavior?
I'll be happy to send the patch if so, but I wanted to check with you
first.

Grepping with --cached or in given trees objects would still grep
outside the cone, but that is what one would expect, right? Or should
we filter out what is outside of the cone for cached grep as well?

Thanks,
Matheus

[1]: https://github.com/git/git/blob/master/Documentation/technical/index-format.txt#L101
