Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E77205C9
	for <e@80x24.org>; Sat,  7 Jan 2017 08:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbdAGIXX (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 03:23:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:36388 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbdAGIXV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 03:23:21 -0500
Received: (qmail 27457 invoked by uid 109); 7 Jan 2017 08:23:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 08:23:20 +0000
Received: (qmail 23610 invoked by uid 111); 7 Jan 2017 08:24:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 03:24:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Jan 2017 03:23:19 -0500
Date:   Sat, 7 Jan 2017 03:23:19 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Tolsch <btolsch@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org
Subject: [PATCH] rebase--interactive: count squash commits above 10 correctly
Message-ID: <20170107082318.jj3izthx2ylscrns@sigill.intra.peff.net>
References: <CAMWRQeRaQQQcJ-R8eHc7f0KqZF2eEkYJOyTb9n7ds78pTqV-AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMWRQeRaQQQcJ-R8eHc7f0KqZF2eEkYJOyTb9n7ds78pTqV-AA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 01:04:05AM -0800, Brandon Tolsch wrote:

> git --version: 2.11.0
> 
> When using git rebase -i to squash a series of commits that includes
> more than 10 commits, the generated commit message you are given to
> edit counts the old messages incorrectly.  It will say the total
> number of commits is (actual % 10) (if they were 0-based) and it will
> also count the commits as (actual % 10).

Looks like a regression in v2.10. Here's the fix.

-- >8 --
Subject: rebase--interactive: count squash commits above 10 correctly

We generate the squash commit message incrementally running
a sed script once for each commit. It parses "This is
a combination of <N> commits" from the first line of the
existing message, adds one to <N>, and uses the result as
the number of our current message.

Since f2d17068fd (i18n: rebase-interactive: mark comments of
squash for translation, 2016-06-17), the first line may be
localized, and sed uses a pretty liberal regex, looking for:

  /^#.*([0-9][0-9]*)/

The "[0-9][0-9]*" tries to match double digits, but it
doesn't quite work.  The first ".*" is greedy, so if you
have:

  This is a combination of 10 commits.

it will eat up "This is a combination of 1", leaving "0" to
match the first "[0-9]" digit, and then skipping the
optional match of "[0-9]*".

As a result, the count resets every 10 commits, and a
15-commit squash would end up as:

  # This is a combination of 5 commits.
  # This is the 1st commit message:
  ...
  # This is the commit message #2:
  ... and so on ..
  # This is the commit message #10:
  ...
  # This is the commit message #1:
  ...
  # This is the commit message #2:
  ... etc, up to 5 ...

We can fix this by making the ".*" less greedy. Instead of
depending on ".*?" working portably, we can just limit the
match to non-digit characters, which accomplishes the same
thing.

Reported-by: Brandon Tolsch <btolsch@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---

I didn't include a test here, mostly because this bug is so weirdly
specific that it seems unlikely to happen again. Especially in light of
this code going away in favor of the C rebase helper, which Dscho
already confirmed is not buggy (and I did not look at the code, but it
cannot possibly do anything as gross as these repeated sed invocations).

It also is a little tricky to automatically extract the comments (you
have to override GIT_EDITOR, but we also invoke GIT_EDITOR for the insn
sheet).

I was able to replicate and confirm the fix manually with:

  git commit -q --allow-empty -m base
  git commit -q --allow-empty -m squash
  git tag base
  for i in $(seq 15); do
    echo $i >$i
    git add $i
    git commit -qm "squash! squash"
  done
  git rebase --autosquash -i base

I'd also suggest that "the commit message #4" is grammatically
questionable. Probably "This is commit message #4" would be fine.

 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b0a6f2b7ba..4734094a3f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -425,7 +425,7 @@ update_squash_messages () {
 	if test -f "$squash_msg"; then
 		mv "$squash_msg" "$squash_msg".bak || exit
 		count=$(($(sed -n \
-			-e "1s/^$comment_char.*\([0-9][0-9]*\).*/\1/p" \
+			-e "1s/^$comment_char[^0-9]*\([0-9][0-9]*\).*/\1/p" \
 			-e "q" < "$squash_msg".bak)+1))
 		{
 			printf '%s\n' "$comment_char $(eval_ngettext \
-- 
2.11.0.527.gfef230ca76

