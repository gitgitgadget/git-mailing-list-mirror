Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E9AC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054CB610CA
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFPIiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 04:38:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:57242 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhFPIiq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 04:38:46 -0400
Received: (qmail 12048 invoked by uid 109); 16 Jun 2021 08:36:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jun 2021 08:36:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24504 invoked by uid 111); 16 Jun 2021 08:36:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jun 2021 04:36:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Jun 2021 04:36:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] test-lib: fix "$remove_trash" regression and
 match_pattern_list() bugs
Message-ID: <YMm4F2uKZ4Dv3C4p@coredump.intra.peff.net>
References: <xmqqa6nqsd2i.fsf@gitster.g>
 <patch-1.1-436c723f4f8-20210616T082030Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-436c723f4f8-20210616T082030Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 10:24:13AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Those options will try to match an argument like --verbose-only=1*
> against a test number like "10", but since we run the match in our own
> trash directory an earlier test creating a file like "1one.txt" will
> break that option.
> 
> We cannot simply quote the $GIT_SKIP_TESTS" being passed to
> match_pattern_list(), since we are relying on the $IFS semantics.
> 
> Let's instead setup a .test-lib-trash subdirectory under the trash
> directory, and an "empty-dir" directory under that. Then let's run the
> match_pattern_list() in a sub-shell in that directory.

Looks like my email just crossed with this one. Your "cd to an empty
directory" is a fun version of my "maybe somebody can think of something
clever" statement. :)

As a general solution, it does fail if the globs may contain things that
look like absolute paths, but that is quite unlikely for our use case
here. Still, I kind of like the "set -f" version because it doesn't need
the extra directory which could cause problems with "ls-files -o", etc,
as you mentioned. You could also create the empty directory on the fly,
though if "set -f" works portably, that seems less complicated to me.

Whatever the expansion mechanism, I do think it's worth having callers
quote "$GIT_SKIP_TESTS" and then performing the expansion within
match_pattern_list. Then the nasty mechanics are all in that one place.

-Peff
