Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D214C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574B064F6F
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhCDUxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:53:11 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:55419 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhCDUwj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:52:39 -0500
X-Originating-IP: 50.39.163.217
Received: from localhost (unknown [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B096E1C0005;
        Thu,  4 Mar 2021 20:51:43 +0000 (UTC)
Date:   Thu, 4 Mar 2021 12:51:40 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     linux-kernel@vger.kernel.org, git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: A note on the 5.12-rc1 tag
Message-ID: <YEFIXFyP5tWrPDMw@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[CCing the git list]

On Wed, Mar 03, 2021 at 12:53:18PM -0800, Linus Torvalds wrote:
> Hey peeps - some of you may have already noticed that in my public git
> tree, the "v5.12-rc1" tag has magically been renamed to
> "v5.12-rc1-dontuse". It's still the same object, it still says
> "v5.12-rc1" internally, and it is still is signed by me, but the
> user-visible name of the tag has changed.
> 
> The reason is fairly straightforward: this merge window, we had a very
> innocuous code cleanup and simplification that raised no red flags at
> all, but had a subtle and very nasty bug in it: swap files stopped
> working right.  And they stopped working in a particularly bad way:
> the offset of the start of the swap file was lost.
> 
> Swapping still happened, but it happened to the wrong part of the
> filesystem, with the obvious catastrophic end results.
[...]
> One additional reason for this note is that I want to not just warn
> people to not run this if you have a swapfile - even if you are
> personally not impacted (like I am, and probably most people are -
> swap partitions all around) - I want to make sure that nobody starts
> new topic branches using that 5.12-rc1 tag. I know a few developers
> tend to go "Ok, rc1 is out, I got all my development work into this
> merge window, I will now fast-forward to rc1 and use that as a base
> for the next release". Don't do it this time. It may work perfectly
> well for you because you have the common partition setup, but it can
> end up being a horrible base for anybody else that might end up
> bisecting into that area.

Even if people avoid basing their topic branches on 5.12-rc1, it's still
possible for a future bisect to end up wandering to one of the existing
dangerous commits, if someone's trying to find a historical bug and git
happens to choose that as a halfway point. And if they happen to be
using a swap file, they could end up with serious data loss, years from
now when "5.12-rc1 is broken" isn't on the top of their mind or even
something they heard about originally.

Would it make sense to add a feature to git that allows defining a
"dangerous" region for bisect? Rough sketch:
- Add a `/.git-bisect-dangerous` file to the repository, containing a
  list of of commit range expressions (contains commit X, doesn't
  contain commit Y) and associated messages ("Do not use these kernels
  if you have a swap file; if you need to bisect into here, disable swap
  files first").
- git-bisect, as it navigates commits, always checks that file for any
  commit it processes, and adds any new entries it sees into
  `.git/bisect-dangerous`; it never removes entries from there.
- git-bisect avoids choosing bisection points anywhere in that range
  until it absolutely has to (because it's narrowed an issue to that
  range). This can use something similar to the existing `git bisect
  skip` machinery. Manual bisections print the message at that point.
  Automated bisections (`git bisect run`) stop and print the range
  without narrowing further, unless the user passes something like
  `--dangerous-ok=commit-range`.

(git notes would be nice for this, but they're hard to share reliably;
the above mechanism to accumulate entries from a file in the repo seems
simpler. I can imagine other possibilities.)

Does something like this seem potentially reasonable, and worth doing to
help people avoid future catastrophic data loss?


- Josh Triplett
