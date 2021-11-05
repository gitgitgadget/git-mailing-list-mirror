Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BE1C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 12:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496126124F
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 12:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhKEMIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 08:08:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:53824 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232837AbhKEMIn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 08:08:43 -0400
Received: (qmail 11548 invoked by uid 109); 5 Nov 2021 12:06:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 12:06:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18073 invoked by uid 111); 5 Nov 2021 12:06:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 08:06:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 08:06:02 -0400
From:   Jeff King <peff@peff.net>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
Message-ID: <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
References: <20211104192533.2520-1-adam@dinwoodie.org>
 <xmqq7ddn3dlt.fsf@gitster.g>
 <20211105112525.GA25887@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211105112525.GA25887@dinwoodie.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 11:25:25AM +0000, Adam Dinwoodie wrote:

> > ... I am not quite sure how this explains "tests relating to ssh
> > signing failing on Cygwin".  After all, this piece of code is
> > lazy_prereq, which means that ssh-keygen in this block that fails
> > (due to a less restrictive permissions) would merely mean that tests
> > that are protected with GPGSSH prerequisite will be skipped without
> > causing test failures.  After all that is the whole point of
> > computing prereq on the fly.
> 
> The issue is that the prerequisite check isn't _just_ checking a
> prerequisite: it's also creating an SSH key that's used without further
> modification by the tests.

This is sort of a side note to your main issue, but I think that relying
on a lazy_prereq for side effects is an anti-pattern. We make no
promises about when or how often the prereqs might be run, and we try to
insulate them from the main tests (by putting them in a subshell and
switching their cwd).

It does happen to work here because the prereq script writes directly to
$GNUPGHOME, and we run the lazy prereqs about when you'd expect. So I
don't think it's really in any danger of breaking, but it is definitely
not using the feature as it was intended. :)

I think the more usual way would be to have an actual
test_expect_success block that creates the keys as a setup step
(possibly triggered by a function, since it's included via lib-gpg.sh).
If we don't want to decide whether we have the GPGSSH prereq until then,
then that test can call test_set_prereq. See the LONG_REF case in t1401
for an example.

Again, that's mostly a tangent to your issue, and maybe not worth
futzing with at this point in the release cycle. I'm mostly just
registering my surprise. ;)

> There are three cases to consider:
> 
> - On systems where this prerequisite check fails, a key may or may not
>   be created, but the tests that rely on the key won't be run, so it
>   doesn't matter either way.
> 
> - On (clearly the mainline) systems where this check passes and there
>   are no ACL problems, the key that's generated is stored with
>   sufficiently restrictive permissions that the tests that rely on the
>   key can pass.
> 
> - On my system, where ACLs are a problem, the prerequisite check passes,
>   and a key is created, but it has permissions that are too permissive.
>   As a result, when a test calls OpenSSH to use that key, OpenSSH
>   refuses due to the permissions, and the test fails.

FWIW, that explanation makes perfect sense to me (and your patch seems
like the right thing to do).

-Peff
