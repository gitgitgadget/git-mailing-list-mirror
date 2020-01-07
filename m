Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8A4C33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD622075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgAGLP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:15:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:58858 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726937AbgAGLP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 06:15:57 -0500
Received: (qmail 11207 invoked by uid 109); 7 Jan 2020 11:15:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Jan 2020 11:15:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29037 invoked by uid 111); 7 Jan 2020 11:21:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2020 06:21:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jan 2020 06:15:56 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Mike Rappazzo <rappazzo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] sequencer: comment out the 'squash!' line
Message-ID: <20200107111556.GC1073219@coredump.intra.peff.net>
References: <pull.511.git.1578326648.gitgitgadget@gmail.com>
 <xmqq7e24a3t0.fsf@gitster-ct.c.googlers.com>
 <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com>
 <20200106193253.GA971477@coredump.intra.peff.net>
 <20200107033639.GH92456@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107033639.GH92456@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 06, 2020 at 07:36:39PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > But I thought that was the point of "squash" versus "fixup"? One
> > includes the commit message, and the other does not.
> >
> > I do think "commit --squash" is mostly useless for that reason, and I
> > suspect we could do a better job in the documentation about pushing
> > people to "--fixup".
> >
> > But --squash _can_ be useful with other options to populate the commit
> > message (e.g., "--edit", which just pre-populates the subject with the
> > right "squash!" line but lets you otherwise write a normal commit
> > message). If that's the workflow you're using, then I'm sympathetic to
> > auto-removing just a "squash!" line, as it's automated garbage that is
> > only meant as a signal for --autosquash.
> 
> It's a signal for --autosquash and it gives a visual signal to humans
> of where the squashed commit came from.

True, but I think any proposal here would continue to include that text
in the human-readable output (I was sloppy to say "auto-remove"; it is
really "auto-comment").

Or do you mean that it's useful in the final, squashed commit? I'd argue
that a normal subject line might be so, but the "squash!" line doesn't
saying anything that's not in the main subject already. It tells you
that there _was_ a squash, but isn't erasing that origin kind of the
point of a squash?

> --squash already implies --edit, supporting this kind of workflow.

Ah, that makes sense. I don't use it myself, so I did a quick test
earlier. But I jumped too quickly to assuming I needed "--edit" (the
"--squash" entry in git-commit(1) talks about being able to use "-m",
which I read too much into).

> If we could turn back time and start over, would we want something
> like the following?
> 
>  1. if someone leaves the squash! message as is, include it as is in
>     the commit message without commenting out
> 
>  2. if someone edits the squash! commit message to include a body
>     describing what is being squashed in, include the squash! line as
>     part of the commented marker
> 
>  3. if someone leaves the (uncommented) squash! message in after being
>     presented with an editor at --autosquash time, reopen the editor
>     with some text verifying they really meant to do that
> 
> It's rare that concatenated commit messages make sense to be used as
> is, especially when trailers (sign-offs, Fixes, etc) are involved.  I
> suspect that (3) is more important than (2) here --- we're using the
> same space in the editor for input and output, and the result is a
> kind of error-prone process of getting the output right.
> 
> Since we can't turn back time, one possibility would be to make tools
> like "git show --check" notice the squash! lines.  Would that be
> useful?

What if (3) issued a warning to stderr insted of re-invoking the editor?
Then "git commit --amend" could be used to fix it, with no change in
behavior.

-Peff
