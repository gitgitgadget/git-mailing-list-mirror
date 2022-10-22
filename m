Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E153CC433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 20:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJVU4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 16:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJVU4F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 16:56:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F51810C9
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 13:56:01 -0700 (PDT)
Received: (qmail 21196 invoked by uid 109); 22 Oct 2022 20:56:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 20:56:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3784 invoked by uid 111); 22 Oct 2022 20:56:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Oct 2022 16:56:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Oct 2022 16:55:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michael McClimon <michael@mcclimon.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
Message-ID: <Y1RY38RULkqd9pBN@coredump.intra.peff.net>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221022011931.43992-1-michael@mcclimon.org>
 <20221022011931.43992-3-michael@mcclimon.org>
 <221022.86eduzeiek.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221022.86eduzeiek.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 22, 2022 at 09:45:14PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The vulnerability safe.directory was supposed to address was one where
> you'd set your fsmonitor hook via a config variable, so running "diff",
> "status" etc. would unexpectedly execute arbitrary code.
> 
> Especially on Windows where apparently the equivalent of the root of a
> shared mounted volume routinely has global write permissions (user's
> subdirectories being less permissive).
> 
> An alternative I raised on the security list was to narrowly target just
> the fsmonitor config, since that was the vulnerability.
>
> [...]
>
> I'm unaware of any other variable(s) that provide a similar vector, and
> safe.directory is encouraging users (especially in core.sharedRepository
> settings) to mark a dir as "safe", and we'd then later have an exploit
> from a user with rw access who'd use the fsmonitor hook vector.

Here are a few off the top of my head that you can trigger via git-diff:

  - core.pager will run an arbitrary program

  - pager.diff will run an arbitrary program

  - diff.*.textconv runs an arbitrary program; you need matching
    .gitattributes, but those are under the control of the repository.
    (not diff.*.command, though, as you need to pass --ext-diff)

  - browser/man paths if you run "git diff --help"

And of course as you expand the set of commands there are more options.
E.g., credential helper commands if you do anything that wants auth,
interactive diff-filter for "add -p", hooks for git-commit, git-push,
etc. Those commands are less likely to be run in an untrusted repository
than inspection commands like "status" or "diff", but the boundary is
getting quite fuzzy.

fsmonitor _might_ be the only one that is triggered by git-prompt.sh,
because it has a limited command palette, generally reads (or sends to
/dev/null) the stdout of commands (preventing pager invocation), and
doesn't do text diffs (so no textconv). Even if true, I'm not sure if
that's a good place to draw the line, though. People do tend to run "git
log" themselves.

-Peff
