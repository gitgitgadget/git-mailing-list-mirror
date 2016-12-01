Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72EEA1FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 04:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754832AbcLAEWb (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 23:22:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:49540 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754225AbcLAEWb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 23:22:31 -0500
Received: (qmail 15526 invoked by uid 109); 1 Dec 2016 04:22:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 04:22:31 +0000
Received: (qmail 28993 invoked by uid 111); 1 Dec 2016 04:23:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 23:23:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 23:22:28 -0500
Date:   Wed, 30 Nov 2016 23:22:28 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: Re: [PATCH v6 0/6] recursively grep across submodules
Message-ID: <20161201042228.ynug33mcsqkdbuoe@sigill.intra.peff.net>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1480555714-186183-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 05:28:28PM -0800, Brandon Williams wrote:

> v6 fixes a race condition which existed in the 'is_submodule_populated'
> function.  Instead of calling 'resolve_gitdir' to check for the existance of a
> .git file/directory, use 'stat'.  'resolve_gitdir' calls 'chdir' which can
> affect other running threads trying to load thier files into a buffer in
> memory.

This one passes my stress-test for t7814 (though I imagine you already
knew that).

I tried to think of things that could go wrong by using a simple stat()
instead of resolve_gitdir(). They should only differ when ".git" for
some reason does not point to a git repository. My initial thought is
that this might be more vocal about errors, because the child process
will complain. But actually, the original would already die if the
".git" file is funny, so we were pretty vocal already.

I also wondered whether the sub-process might skip a bogus ".git" file
and keep looking upward in the filesystem tree (which would confusingly
end up back in the super-project!). But it looks like we bail hard when
we see a ".git" file but it's bogus. Which is probably a good thing in
general for submodules.

I'm not sure any of that is actually even worth worrying about, as such
a setup is broken by definition. I just wanted to think it through as a
devil's advocate, and even that seems pretty reasonable.

-Peff
