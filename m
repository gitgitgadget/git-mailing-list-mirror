Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0563DC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC346138D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhKRQwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:52:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52782 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbhKRQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4C9EB218CE
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WkjyHM+8SpihdZK99VKvHxpVjGcMpEJFfyHDCIokn4k=;
        b=jop9/nc6l6NVCG36VQ8N1U4IAA613fdmC2VN8UIXR7l9G4dznTLEGmFy3L6CsfvGY3yg6L
        Ty6NxCZIgXg5Vmrlm7qVyarAR7xOSen2/F4QnAS7vUdu+nwUqMu4bn94UjFe/0f5NrhXMF
        Cuq5wOzPN/PB67HLwhwN/vW807KBq8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WkjyHM+8SpihdZK99VKvHxpVjGcMpEJFfyHDCIokn4k=;
        b=kDFEp2veYg+3GzqXWCFedmKsC32h4Lkzf0qGnUOYssZzp4u1VsDqc4eu5HOoj/fK9MKwmc
        y2A9Qjq4WfB9BkCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 1B57DA3B88;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 711851F2C95; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: Stochastic bisection support
Date:   Thu, 18 Nov 2021 17:49:13 +0100
Message-Id: <20211118164940.8818-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

In some cases regressions (or generally changes) we are trying to bisect have
probabilistic nature. This can for example happen for hard to trigger race
condition where it is difficult to distinguish working state from just not
hitting the race or it can happen for performance regressions where it is
sometimes difficult to distinguish random workload fluctuations from the
regression we are looking for. With standard bisection the only option we have
is to repeatedly test suggested bisection point until we are sure enough which
way to go. This leads to rather long bisection times and still a single wrong
decision whether a commit is good to bad renders the whole bisection useless.

Stochastic bisection tries to address these problems. When deciding whether a
commit is good or bad, you can also specify your confidence in the decision.
For performance tests you can usually directly infer this confidence from the
distance of your current result from good/bad values, for hard to reproduce
races you are usually 100% confident for bad commits, for good commits you need
to somehow estimate your confidence based on past experience with reproducing
the issue. The stochastic bisection algorithm then uses these test results
and confidences to suggest next commit to try, tracking for each commit the
probability the commit is the bad one given current test results. Once some
commit reaches high enough probability (set when starting bisection) of being
the bad one, we stop bisecting and annouce this commit.

Example:

Consider an example of a stochastic bisection of the following commits:

A--B--C--D-----F-----H--------K
 \     \  \-E-/     /        /
  \     \--------G-/        /
   \------------------I--J-/

And suppose commit I is the bad one. Let's start bisection with:

# We ask bisection for 90% confidence in the identified commit being bad
git bisect start --confidence 0.9 %K %A

# Bisection tells us to test %F. Let's assume test went well and we trust
# our test results on 70%. So:
git bisect good --confidence 0.7

# Bisection tells us to test %H. Again same result:
git bisect good --confidence 0.7

# Bisection tells us to test %J. The test should fail for %J (remember %I is
# the bad commit) but let's assume the test is falsely positive. So:
git bisect good --confidence 0.7

# We are asked to test %H second time. Assume correct result so:
git bisect good --confidence 0.7

# We are asked to test %J second time. Assume correct result so:
git bisect bad --confidence 0.7

# We are asked to test %J again. Assume correct result so:
git bisect bad --confidence 0.7

# And %J once more. Assume false positive so:
git bisect good --confidence 0.7

# And %J once more. Assume correct result so:
git bisect bad --confidence 0.7

# And %J again. Assume correct result so:
git bisect bad --confidence 0.7

# And now we are asked to test %I. Assume correct result so:
git bisect bad --confidence 0.7

# We are asked to test %I second time. Assume false positive so:
git bisect good --confidence 0.7

# And %I once again. Assume correct result so:
git bisect bad --confidence 0.7

# And %I once again. Assume correct result so:
git bisect bad --confidence 0.7

# And %I once again. Assume correct result so:
git bisect bad --confidence 0.7

And now git tells us %I is the bad commit with desired confidence. We can see
the bisection was able to identify the bad commit although there were three
false positive tests (out of total 14 tests).

------

This patch set implements stochastic bisection for git. The first part of the
series improves some tests so that they accept other valid decisions for
bisection points. This is needed because to make it easier to share some logic
between normal and stochastic bisection, I needed to slightly change some bits
for normal bisection and then since commit weights will be computed in a
somewhat different order, also chosen bisection points are sometimes different.

The second part of the series then implements stochastic bisection itself.
Note that I didn't integrate any tests for stochastic bisection into 'make
test' run yet (so far I did only manual tests) and I still need to update
manpages etc. I plan to do that but I've decided to post the series now to get
some early feedback.

								Honza

PS: Please leave me in CC for replies. I'm not subscribed to the git mailing
list.
