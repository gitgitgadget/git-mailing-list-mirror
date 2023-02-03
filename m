Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9243C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 17:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjBCRgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbjBCRee (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 12:34:34 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF96A641C
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 09:34:07 -0800 (PST)
Received: (qmail 26654 invoked by uid 109); 3 Feb 2023 17:34:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Feb 2023 17:34:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10383 invoked by uid 111); 3 Feb 2023 17:34:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Feb 2023 12:34:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Feb 2023 12:34:06 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
Message-ID: <Y91FjhNgZGz6foFl@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com>
 <xmqqwn5bg695.fsf@gitster.g>
 <Y9JkMLueCwjkLHOr@coredump.intra.peff.net>
 <xmqqfsbxcmdd.fsf@gitster.g>
 <6f83ed25-a7e1-06dd-f180-d70c7e1b1973@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f83ed25-a7e1-06dd-f180-d70c7e1b1973@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 02, 2023 at 11:14:33AM +0100, Johannes Schindelin wrote:

> > I do not mind reverting the merge to 'next' to have an improved
> > version.  Your "do we really want to add a custom server based on
> > questionable codebase whose quality as a test-bed for real world
> > usage is dubious?" is a valid concern.
> 
> Except.
> 
> Except that this code base would have made for a fine base to potentially
> implement an HTTPS-based replacement for the aging and insecure
> git-daemon.

I'm skeptical that it is a good idea for Git to implement a custom http
server from scratch. There are a lot of extended features people would
want in a production-ready server. TLS, HTTP/2, and so on. The code
under discussion is pretty stripped-down. A network service is also a
pretty big attack surface for buffer overflows, etc.

It feels to me like the resources required to make it good enough for
normal users to run would be substantial. And we'd be better off trying
to integrate with an existing project that provides a web server
(whether it's a lightweight server that supports us as a CGI, or a
library that does most of the heavy lifting).

> That code base (which is hardly as questionable codebase as you make it
> sound because it has been in use for years in a slightly different form)

Perhaps I'm being too hard on git-daemon. But my operational experience
with it is that it has several flaws, mostly around the child-management
code. We rewrote that code totally to make it usable at GitHub.

As a concrete example, the parent daemon process will do a linear walk
over all children, calling waitpid() on each one. This makes handling N
children quadratic, and the daemon grinds to a halt when there are many
clients.

> In addition, it causes a loss of test coverage because Apache is not
> available in all the setups where the "questionable" code would have had
> no problem being built and validating the credential code.
> 
> Windows, for example, will now go completely uncovered in CI regarding the
> new code.

I'm sympathetic there, though it's a problem for all of the existing
http code, too. Is there some server option that would be easier to run
everywhere, but that doesn't involve us writing a server from scratch?
Certainly I have no particular love for apache or its configuration
language.

-Peff
