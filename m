Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A4BCDB482
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjJKWr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjJKWr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:47:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2E09D
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:47:54 -0700 (PDT)
Received: (qmail 20278 invoked by uid 109); 11 Oct 2023 22:47:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 22:47:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11048 invoked by uid 111); 11 Oct 2023 22:47:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 18:47:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 18:47:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: move process_address_list earlier to avoid,
 uninitialized address error
Message-ID: <20231011224753.GE518221@coredump.intra.peff.net>
References: <ZRE6q8dHPFRIQezX@debian.me>
 <20230925080010.GA1534025@coredump.intra.peff.net>
 <ZRGdvRQuj4zllGnm@pobox.com>
 <20230925161748.GA2149383@coredump.intra.peff.net>
 <ZSal-mQIZAUBaq6g@debian.me>
 <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
 <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
 <xmqq1qe0lui2.fsf@gitster.g>
 <20231011221844.GB518221@coredump.intra.peff.net>
 <xmqqzg0oiy4s.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzg0oiy4s.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 03:37:39PM -0700, Junio C Hamano wrote:

> On the other hand, I am not sure what is wrong with "after the user
> typed", actually.  As you said, anybody sane would be using --to (or
> an equivalent configuration variable in the repository) to send
> their patches to the project address instead of typing, and to them
> it is not a problem.  After getting the recipient address from the
> end user, the validation may fail due to a wrong address, in which
> case it is a good thing.  If the validation failed due to wrong
> contents of the patch (perhaps it included a change to the file with
> trade secret that appeared in the context lines), as long as the
> reason why the validation hook rejected the patches is clear enough
> (e.g., "it's the patches, not the recipients"), such "a rejection
> after typing" would be only once per a patch series, so it does not
> sound too bad, either.
> 
> But perhaps I am not seeing the reason why "fail after the user typed"
> is so disliked and being unnecessarily unsympathetic.  I dunno.

I did not look carefully at the flow of send-email, so this may or may
not be an issue. But what I think would be _really_ annoying is if you
asked to write a cover letter, went through the trouble of writing it,
and then send-email bailed due to some validation failure that could
have been checked earlier.

There is probably a way to recover your work (presumably we leave it in
a temporary file somewhere), but it may not be entirely trivial,
especially for users who are not comfortable with advanced usage of
their editor. ;)

I seem to remember we had one or two such problems in the early days
with "git commit", where you would go to the trouble to type a commit
message only to bail on some condition which _could_ have been checked
earlier. You can recover the message from .git/COMMIT_EDITMSG, but you
need to remember to do so before re-invoking "git commit", otherwise it
gets obliterated.

Now for send-email, if your flow is to generate the patches with
"format-patch", then edit the cover letter separately, and then finally
ship it all out with "send-email", that might not be an issue. But some
workflows use the --compose option instead.

-Peff
