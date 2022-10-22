Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABE5C04A95
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 21:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJVVSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 17:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJVVSe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 17:18:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1127C1B5
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 14:18:33 -0700 (PDT)
Received: (qmail 21434 invoked by uid 109); 22 Oct 2022 21:18:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 21:18:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4194 invoked by uid 111); 22 Oct 2022 21:18:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Oct 2022 17:18:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Oct 2022 17:18:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael McClimon <michael@mcclimon.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
Message-ID: <Y1ReKB701QXRv64A@coredump.intra.peff.net>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221022011931.43992-1-michael@mcclimon.org>
 <20221022011931.43992-3-michael@mcclimon.org>
 <xmqq1qr0ifya.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qr0ifya.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 10:29:33PM -0700, Junio C Hamano wrote:

> I also have to wonder (and this is *not* a suggestion for inventing
> an alternative fix for perl/Git.pm) if we were creating perl/Git.pm
> from scratch today, we even need to be worried about this issue.  We
> may have Git::repo_path() helper but if we call it in a natural way
> (read: as if an interactive end-user would type commands), it is
> likely that we would run "git rev-parse --git-dir" or something
> without setting GIT_DIR, and when we need to run "git" command, say
> "git diff", we would also run "git diff" as if the end user would
> type from within their interactive session and without setting
> GIT_DIR, and everything should work.  IOW, why do we even setting
> and exporting the auto-detected value in GIT_DIR?

I think it has to in order to avoid surprises. If I do this:

  perl -MGit -e '
    my $r = Git->repository;
    chdir("/somewhere/else");
    $r->git_command(...);
  '

that command ought to run in the repository I opened earlier. So I think
to keep the illusion of a lib-ified object, creating that object has to
lock in the path.

But it really seems like we should be asking rev-parse what that path
is, not trying to do any magic ourselves.

-Peff
