Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B229B1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 03:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfKKDlM (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 22:41:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:44098 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726742AbfKKDlM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 22:41:12 -0500
Received: (qmail 14724 invoked by uid 109); 11 Nov 2019 03:41:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 03:41:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1288 invoked by uid 111); 11 Nov 2019 03:44:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 10 Nov 2019 22:44:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 10 Nov 2019 22:41:11 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Change behavior of git add --patch on newly added file?
Message-ID: <20191111034111.GB5912@sigill.intra.peff.net>
References: <20191108225035.GA60198@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191108225035.GA60198@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 08, 2019 at 02:50:35PM -0800, Emily Shaffer wrote:

> Is there a reason that git add -p can't do whole-file support this way?
> While I'm less sure about what I'd like to see for copied files, I do
> feel like there's a strong argument for patch adding new or deleted
> files.

I have been mildly annoyed by trying to "add -p" an untracked file
before, too. But there is some complexity with broader pathspecs, I
think. For instance, imagine I have a subdirectory in my repo with three
files:

  - subdir/tracked -- this one is a real tracked file with modifications

  - subdir/new -- this is a new file I've just added

  - subdir/cruft -- this is some junk I wrote while debugging

Then what should:

  git add -p subdir

do? Obviously it should ask about "tracked". And we'd want it to do the
"add -N" thing on "new", but not on "cruft".

I don't mind being _asked_ about the "cruft" file if I can just say "n"
to ignore it. But I wouldn't want it left in the index as intent-to-add.
So just pretending that it was the same as:

  git add -N "$@" && git add -p "$@"

seems poor. But it would be fine if instead we tentatively consider
files matching the pathspec as tracked (assuming they're not
.gitignored), and then the end result for each path is either that it
has content staged by "-p", or it's left unchanged (including untracked
if it was not previously tracked).

I'm not sure when you intended for this to kick in. The case of "git add
-p an-actual-file", where the pathspec matches exactly one file, is an
obvious one. But because the shell expands wildcards, too, I don't know
if it's a good heuristic for "the user really meant to mention this
file". I.e., if I do:

  git add -p *.c

Git will see individual filenames on the command-line, but the user may
not have wanted to include all of them.

There's also a question of what "git add -p" without any pathspecs
should do. I'd think you would probably want no change from the current
behavior (i.e., not even asking about untracked files).

-Peff
