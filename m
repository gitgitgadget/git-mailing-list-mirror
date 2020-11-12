Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467E9C2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0A52223C
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgKLS33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 13:29:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:56182 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgKLS31 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 13:29:27 -0500
Received: (qmail 21664 invoked by uid 109); 12 Nov 2020 18:29:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Nov 2020 18:29:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32752 invoked by uid 111); 12 Nov 2020 18:29:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Nov 2020 13:29:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Nov 2020 13:29:25 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 9/9] add -i: verify in the tests that colors can be
 overridden
Message-ID: <20201112182925.GA701197@coredump.intra.peff.net>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <38355ec98f04783367d74e38cda3ce5d6632c7ac.1605051739.git.gitgitgadget@gmail.com>
 <20201111023549.GB806755@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011111635140.18437@tvgsbejvaqbjf.bet>
 <20201111180713.GC9902@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011121448550.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2011121448550.18437@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 03:04:01PM +0100, Johannes Schindelin wrote:

> Gaaah! I totally forgot that `BASH_XTRACEFD` is only heeded by BusyBox'
> ash (and only when built with `ENABLE_ASH_BASH_COMPAT`), not by `dash`.
> 
> Sorry for the noise.

Ah, that makes more sense. And I learned something new about busybox. :)

> > Hmm. Right, I knew about that weirdness. But I assumed that the builtin
> > add-interactive was doing the diffs in-core. Otherwise, why would we
> > have seen the failure to load diff.color.frag in the first place?
> 
> Oh, that's easy to explain: as you can verify reading
> https://github.com/git/git/blob/e31aba42fb12/git-add--interactive.perl#L885-L898
> the Perl version of `git add -p` insists on (re-)constructing the hunk
> headers manually, and obviously it needs to color them manually, too. And
> https://github.com/git/git/blob/e31aba42fb12/add-patch.c#L649-L672 shows
> that the built-in version of `git add -p` slavishly follows that practice.

But that is only when we split hunks (your link to the perl script is in
split_hunks()). I agree we must color manually there when creating our
own hunk header. But outside of that and patch-editing, the perl script
does not otherwise recolor or rewrite (nor even really parse beyond
line-splitting) what it gets from the colorized version.

Whereas add-patch parses the colors off of the version and then
re-colors every hunk header. Which seems doubly weird to me. Even if we
were going to re-color every hunk (e.g., because we don't want to store
the original hunk line, but instead a parsed version of it), why bother
parsing the color version at all, and not just the machine-readable
version?

> > The answer seems to be that render_hunk() always _replaces_ the colors
> > we got from running the external diff. Whereas the perl version only
> > applied coloring when reading back in the results of an edit operation
> > (and likewise used the frag color when generating a split hunk header).
> 
> No, the Perl version also insists on applying `fraginfo_color`, see
> https://github.com/git/git/blob/e31aba42fb12/git-add--interactive.perl#L885-L898

Only when we split. Try this to give different colors between the
interactive script and diff:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index e713fe3d02..862a21ff1f 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -28,8 +28,9 @@
 my $diff_use_color = $repo->get_colorbool('color.diff');
 my ($fraginfo_color) =
 	$diff_use_color ? (
-		$repo->get_color('color.diff.frag', 'cyan'),
+		$repo->get_color('color.diff.nonsense', 'yellow'),
 	) : ();
+# noop to create split hunk
 my ($diff_plain_color) =
 	$diff_use_color ? (
 		$repo->get_color('color.diff.plain', ''),

Running "git add -p" does not result in yellow hunk headers. But issuing
a split command does.

The distinction is mostly academic, because diff-tree and the
interactive patch code should be using the same colors, so the result
should look the same. It could matter if the diff-filter chooses
different colors, though then the split headers will not match the
originals in style. We _could_ run the newly created hunk header
individually through the diff-filter, though I'm not sure how various
filters would handle that.

That's true of the perl version as well as the builtin one, but I think
the builtin one's insistence on parsing the colored output is taking us
in the wrong direction to eventually fix that.

> > I'm not sure that what the builtin version is doing is wrong, but it
> > seems like it's putting a lot of extra effort into parsing colors off of
> > the colorized version. Whereas the perl version just assumes the lines
> > match up. I do wonder if there are corner cases we might hit around
> > filters here, though. The lines we get from a filter might bear no
> > resemblance at all to diff lines. The only thing we require in the perl
> > version is that they have correspond 1-to-1 with the unfiltered diff
> > lines in meaning.
> 
> They do have to correspond 1-to-1 because the assumption is that the
> individual lines will then correspond one-to-one, too. This does not need
> to be true, of course, but then the filter is probably less useful than
> the user wants it to be.

Right, I'm not disputing the 1-to-1 thing (I was after all the one who
implemented interactive.diffilter, and added the "complain if the counts
don't line up" check). But in the perl script they only need to
correspond _semantically_, not syntactically.

-Peff
