Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF16E7B60F
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 13:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242640AbjJDNVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 09:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjJDNVh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 09:21:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65F298
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 06:21:33 -0700 (PDT)
Received: (qmail 7316 invoked by uid 109); 4 Oct 2023 13:21:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Oct 2023 13:21:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4926 invoked by uid 111); 4 Oct 2023 13:21:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Oct 2023 09:21:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Oct 2023 09:21:32 -0400
From:   Jeff King <peff@peff.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org
Subject: Re: Is SANITIZE=leak make test unreliable for anyone else?
Message-ID: <20231004132132.GC607079@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
 <878r8j2mu1.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r8j2mu1.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 08:33:26PM -0500, Eric W. Biederman wrote:

> My big question is:
> 
>     Do other people see random test failures when SANITIZE=leak is enabled?
> 
> Is it just me?

Yes, I've seen this. You mentioned that you were testing with v2.42,
which lacks 370ef7e40d (test-lib: ignore uninteresting LSan output,
2023-08-28). Try using the current version of 'master', or just
cherry-picking that commit onto v2.42.

A few other tips to avoid confusing results (though they at least do not
vary from run to run):

  - use the LEAK_LOG option, since you otherwise miss some cases (it
    looks like you already are from what you posted above)

  - gcc and clang sometimes produce different results. Right now I get
    no leak from gcc on t9004, but clang reports one (I think clang is
    right here)

  - turn off compiler optimizations; we've had cases where code
    reordering/removal creates false positives. Oh, hmm, I forgot we do
    this by default since d3775de074 (Makefile: force -O0 when compiling
    with SANITIZE=leak, 2022-10-18), so your v2.42 should be covered.

-Peff
