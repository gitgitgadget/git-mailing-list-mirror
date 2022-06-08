Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A9FC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 23:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiFHXgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 19:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiFHXgl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 19:36:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C46149ABE
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 16:36:40 -0700 (PDT)
Received: (qmail 6261 invoked by uid 109); 8 Jun 2022 23:36:39 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jun 2022 23:36:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Wed, 8 Jun 2022 19:36:39 -0400
From:   Jeff King <peff@peff.net>
To:     Tassilo Horn <tsdh@gnu.org>
Cc:     Tao Klerks <tao@klerks.biz>, git@vger.kernel.org
Subject: Re: [BUG?] Major performance issue with some commands on our repo's
 master branch
Message-ID: <YqEyh5opAaJxph2+@coredump.intra.peff.net>
References: <87h750q1b9.fsf@gnu.org>
 <CAPMMpohzqKo-+q-tOcXymmzGxuOY-mf2NPRviHURm8-+3MPjZg@mail.gmail.com>
 <87y1yb2xc8.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1yb2xc8.fsf@gnu.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 05, 2022 at 12:46:15PM +0200, Tassilo Horn wrote:

> Still maybe someone might want to have a look at the "git show" issue to
> double-check if the performance burden in this specific case (no diff
> should be generated) is warranted.  But at least I can work again with
> no coffee-break long pauses, so I'm all satisfied. :-)

I suspect the issue may be quite subtle. Even you asked for
"--no-patch", the underlying diff may still be used for other things.
For example, simplifying away TREESAME commits. I.e., ones which did not
change anything from their parents after applying path restrictions,
diff-filters, etc. There may be other cases, too (e.g., --follow).

I think the code could be written to realize that none of those features
are in use, and disable the diff entirely in favor of checking whether
the two trees has the same object id. That would yield _mostly_ the same
behavior, though there are probably corner cases (e.g., a tree with an
odd mode entry, say, may get parsed so as to produce an empty diff, even
though it's not byte for byte identical). That may be an acceptable
tradeoff. But I think the code would be a bit brittle (it needs to know
about all the cases where a diff might matter, and we may add more
later).

In general, I think Git assumes that tree-level diffs aren't too painful
to produce. "git log" will do them, too, but just doesn't tickle your
particular case because it doesn't look at merges. So probably setting
diff.renamelimit correctly is not that bad a solution.

-Peff
