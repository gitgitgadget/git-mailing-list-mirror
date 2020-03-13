Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68921C5ACC0
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D30206EB
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCMRwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:52:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:39246 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726414AbgCMRwi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 13:52:38 -0400
Received: (qmail 24446 invoked by uid 109); 13 Mar 2020 17:52:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Mar 2020 17:52:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8686 invoked by uid 111); 13 Mar 2020 18:02:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Mar 2020 14:02:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Mar 2020 13:52:36 -0400
From:   Jeff King <peff@peff.net>
To:     Erlend Aasland <Erlend-A@innova.no>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] Make rev-parse -q and --is-* quiet
Message-ID: <20200313175236.GB549554@coredump.intra.peff.net>
References: <4B2A0C64-FD4A-457C-A7CF-5B680AF38BC9@innova.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4B2A0C64-FD4A-457C-A7CF-5B680AF38BC9@innova.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 13, 2020 at 12:13:52PM +0000, Erlend Aasland wrote:

> If rev-parse is called with both -q and an --is-* option, the result is
> provided as the return code of the command, iso. printed to stdout.
> 
> This simplifies using these queries in shell scripts:
> git rev-parse --is-bare-repository && do_stuff
> git rev-parse --is-shallow-repository && do_stuff

I left some comments in the other part of the thread, but another
potential downside here is that the exit code also tells us whether the
command was unable to run for unrelated reasons (i.e., the answer is
really a tristate: yes, no, or "we don't know the answer").

One obvious reason to exit non-zero would be that we're not in a
repository at all. I _think_ that works OK with all of these
conditionals, because if we're not in a repo, then we are obviously not
inside a git-dir, and so on.

Another reason is that the caller misspelled the option name. :) That
might be an acceptable risk, though. It's not like it isn't present in
other commands, probably people are doing:

  test "$(git rev-parse --is-whatever") = "true" && do_stuff

anyway, which has the same problem. Though perhaps the simplicity there
is an argument that we don't need the new exit-code mechanism.

-Peff
