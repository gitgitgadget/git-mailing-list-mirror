Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154E2C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04A1617C9
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhELHAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 03:00:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:52074 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhELHAn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 03:00:43 -0400
Received: (qmail 26618 invoked by uid 109); 12 May 2021 06:59:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 06:59:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2732 invoked by uid 111); 12 May 2021 06:59:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 May 2021 02:59:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 May 2021 02:59:34 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Message-ID: <YJt81neO7zsGz2ah@coredump.intra.peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <YJt0Dv7HP2VnLLwv@coredump.intra.peff.net>
 <YJt1/DO1cXNTRNxK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJt1/DO1cXNTRNxK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 02:30:20AM -0400, Jeff King wrote:

> On Wed, May 12, 2021 at 02:22:06AM -0400, Jeff King wrote:
> 
> > With that change, plus a patch I'll send in a minute, it's easy to run
> > doc-diff on the result.
> 
> And here that is (note that if you don't apply the flags fix I showed,
> then doc-diff gets confused, because it expects back-to-back runs of
> "make" to handle the changed flags correctly).
> 
> Feel free to add it to your series if it helps (I had originally thought
> it would just be a one-off to look at the output, but there are enough
> changes, both correctness and style, that it may be useful to have this
> option around).

Adding in the "\e" to the extensions string fixes many problems. Just
skimming over the remaining changes (from asciidoctor+xmlto to
asciidoctor direct), here are some things I see:

Both of the xmlto pipelines seem to insert extra space before a literal.
The direct version fixes that. E.g.:

  -           Files to add content from. Fileglobs (e.g.  *.c) can be given to
  [...]
  +           Files to add content from. Fileglobs (e.g. *.c) can be given to add

So that's good. But what you can't see in the doc-diff rendered version
is that we've lost the bolding on literals (this is from the <pathspec>
option in git-add.1).

Another is that the direct version is less willing to break linkgit
targets across lines:

  -           explained for the configuration variable core.quotePath (see git-
  -           config(1)). See also --pathspec-file-nul and global
  +           explained for the configuration variable core.quotePath (see
  +           git-config(1)). See also --pathspec-file-nul and global

That seems fine to me, though it unfortunately does make the diff quite
noisy.

We seem to have a problem with some escape codes. E.g.:

  -           of nothing). The other file, git-add--interactive.perl, has 403
  -           lines added and 35 lines deleted if you commit what is in the
  -           index, but working tree file has further modifications (one
  +           of nothing). The other file, git-add&#x2d;&#x2d;interactive.perl,
  +           has 403 lines added and 35 lines deleted if you commit what is in
  +           the index, but working tree file has further modifications (one

and:

  -           Added content is represented by lines beginning with "+". You can
  -           prevent staging any addition lines by deleting them.
  +           Added content is represented by lines beginning with "&#43;". You
  +           can prevent staging any addition lines by deleting them.

which is a pretty bad regression.

The trailer misses the version field:

  -Git omitted                       1970-01-01                        GIT-ADD(1)
  +Git                               1970-01-01                        GIT-ADD(1)

The "omitted" is part of doc-diff's attempt to reduce noise in the
diff. But you can see that it's missing entirely in the direct version.

There are lots of whitespace changes for lists. They mostly seem fine
either way. It also formats numbered lists differently:

  -            1. Delete the remote-tracking branches "todo", "html" and
  +           (1) Delete the remote-tracking branches "todo", "html" and
                  "man". The next fetch or pull will create them again
                  unless you configure them not to. See git-fetch(1).
  -            2. Delete the "test" branch even if the "master" branch (or
  +           (2) Delete the "test" branch even if the "master" branch (or
                  whichever branch is currently checked out) does not have
                  all commits from the test branch.

I prefer the original, but could live with the latter (IIRC, this is
something that can be configured via asciidoctor, but I didn't dig).

This one is quite curious (from gitworkflows(7)):

  -       Example 1. Merge upwards
  +       Rule: Merge upwards

The source looks like this:

  .Merge upwards
  [caption="Rule: "]

So it looks like it takes the caption, rather than the phrase "example"
that I guess is coming from deep within the bowls of docbook. Both
asciidoc and asciidoctor produce the "Example" text when going through
xmlto, but both produce "Rule" when generating HTML. So I imagine the
latter was the intent, and this is a fix.

Links are a bit harder to read. E.g.:

   SEE ALSO
          git-check-ref-format(1), git-fetch(1), git-remote(1), “Understanding
  -       history: What is a branch?”[1] in the Git User’s Manual.
  +       history: What is <user-manual.html#what-is-a-branch> a branch?”" in the
  +       Git User’s Manual.

There may be more lurking, but it's hard to tell given how noisy the
diff is.

-Peff
