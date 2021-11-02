Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBA4C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 01:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593F9610A0
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 01:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhKBB3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 21:29:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:51210 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhKBB3t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 21:29:49 -0400
Received: (qmail 1235 invoked by uid 109); 2 Nov 2021 01:27:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Nov 2021 01:27:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29357 invoked by uid 111); 2 Nov 2021 01:27:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Nov 2021 21:27:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Nov 2021 21:27:10 -0400
From:   Jeff King <peff@peff.net>
To:     Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: `BUG: sequencer.c:921: GIT_AUTHOR_DATE missing from author
 script` when trying to reword in interactive rebase
Message-ID: <YYCT7tLfphH049h+@coredump.intra.peff.net>
References: <000201d7cf76$a4861460$ed923d20$@ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000201d7cf76$a4861460$ed923d20$@ruhr-uni-bochum.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 02, 2021 at 12:17:29AM +0100, Jonas Kittner wrote:

> In the interactive prompt I changed `pick` to `reword`, saved and closed the
> prompt.
> Commands to repoduce see below

Thanks for the easy reproduction. Here are commands that slightly
simplify / automate things, which I used to bisect:

  rm -rf repo
  git init repo
  cd repo
  git commit --allow-empty -qm base

  touch file
  git add .
  GIT_AUTHOR_DATE='@123456789 +0000' git commit -qm "this message says pick"

  GIT_EDITOR='sed -i s/pick/reword/' \
  git.compile rebase -i --committer-date-is-author-date HEAD^

  # not strictly necessary, but when it works, you can see that the
  # timestamps correctly match, and that "pick" was changed to "reword"
  # in the message. Of course when it doesn't work, rebase aborts, so
  # that's easier to see than looking at the commit. :)
  git cat-file commit HEAD

> What happened instead? (Actual behavior)
> segfault: `BUG: sequencer.c:921: GIT_AUTHOR_DATE missing from author script`
>
> [...]
>
> https://github.com/git/git/commit/7573cec52c0274ceb166c425be4288f6b3103d6f#d
> iff-0e574dc9087fc7831bbc1403545a8561f08869576c1ccc4146aa276146ff9777R888-R88
> 9
> this seems to be not the case and needs to be handled differently I guess?

It looks like things did work back in 7573cec52c (rebase -i: support
--committer-date-is-author-date, 2020-08-17). Bisecting shows that it
broke in baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when
fast-forwarding, 2021-08-20). +cc Phillip (who wrote both commits).

-Peff
