Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25500C54EE9
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 05:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiIKF2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 01:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiIKF2K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 01:28:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655B42F036
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 22:28:07 -0700 (PDT)
Received: (qmail 18323 invoked by uid 109); 11 Sep 2022 05:28:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 11 Sep 2022 05:28:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31730 invoked by uid 111); 11 Sep 2022 05:28:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Sep 2022 01:28:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Sep 2022 01:28:06 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/18] make test "linting" more comprehensive
Message-ID: <Yx1x5lme2SGBjfia@coredump.intra.peff.net>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 01, 2022 at 12:29:38AM +0000, Eric Sunshine via GitGitGadget wrote:

> A while back, Peff successfully nerd-sniped[1] me into tackling a
> long-brewing idea I had about (possibly) improving "chainlint" performance

Oops, sorry. :)

I gave this a read-through, and it looks sensible overall. I have to
admit that I did not carefully check all of your regexes. Given the
relatively low stakes of the code (as an internal build-time tool only)
and the set of tests accompanying it, I'm willing to assume it's good
enough until we see counter-examples.

I posted some timings and thoughts on the use of threads elsewhere. But
in the end the timings are close enough that I don't care that much
either way.

I'd also note that I got some first-hand experience with the script as I
merged it with all of my other long-brewing topics, and it found a half
dozen spots, mostly LOOP annotations. At least one was a real "oops,
we'd miss a bug in Git here" spot. Several were "we'd probably notice
the problem because the loop output wouldn't be as expected". One was a
"we're on the left-hand of a pipe, so the exit code doesn't matter
anyway" case, but I am more than happy to fix those if it lets us be
linter-clean.

The output took me a minute to adjust to, just because it feels pretty
jumbled when there are several cases. Mostly this is because the
script eats indentation. So it's hard to see the "# chainlint:" comment
starts, let alone the ?! annotations. Here's an example:

-- >8 --
# chainlint: t4070-diff-pairs.sh
# chainlint: split input across multiple diff-pairs
write_script split-raw-diff "$PERL_PATH" <<-EOF &&

git diff-tree -p -M -C -C base new > expect &&

git diff-tree -r -z -M -C -C base new |
./split-raw-diff &&
for i in diff* ; do
git diff-pairs -p < $i ?!LOOP?!
done > actual &&
test_cmp expect actual
# chainlint: perf/p5305-pack-limits.sh
# chainlint: set up delta islands
head=$(git rev-parse HEAD) &&
git for-each-ref --format="delete %(refname)" |
git update-ref --no-deref --stdin &&

n=0 &&
fork=0 &&
git rev-list --first-parent $head |
while read commit ; do
n=$((n+1)) ?!AMP?!
if test "$n" = 100 ; then
echo "create refs/forks/$fork/master $commit" ?!AMP?!
fork=$((fork+1)) ?!AMP?!
n=0
fi ?!LOOP?!
done |
git update-ref --stdin &&

git config pack.island "refs/forks/([0-9]*)/"
-- 8< --

It wasn't too bad once I got the hang of it, but I wonder if a user
writing a single test for the first time may get a bit overwhelmed.  I
assume that the indentation is removed as part of the normalization (I
notice extra whitespace around "<", too). That might be hard to address.

I wonder if color output for "# chainlint" and "?!" annotations would
help, too. It looks like that may be tricky, though, because the
annotations re-parsed internally in some cases.

-Peff
