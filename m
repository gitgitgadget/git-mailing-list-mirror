Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC27C433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 20:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0882076B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 20:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgFAUWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:22:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:33570 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgFAUWU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 16:22:20 -0400
Received: (qmail 30389 invoked by uid 109); 1 Jun 2020 20:22:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jun 2020 20:22:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13753 invoked by uid 111); 1 Jun 2020 20:22:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jun 2020 16:22:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Jun 2020 16:22:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jan Christoph Uhde <Jan@UhdeJc.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff: discard blob data from stat-unmatched pairs
Message-ID: <20200601202218.GA2763518@coredump.intra.peff.net>
References: <54a3a798-0387-64df-be20-af69db124042@UhdeJc.com>
 <20200601044511.GA2529317@coredump.intra.peff.net>
 <cfc79aec-ec85-dbec-e37b-6b7035b4c5a4@UhdeJc.com>
 <20200601165408.GA2536619@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200601165408.GA2536619@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 01, 2020 at 12:54:08PM -0400, Jeff King wrote:

> > What could be the reason that the problem only occurs with the `--quiet` flag
> > that I use in my prompt command, but not when using `git diff` without the flag.
> 
> That is curious, and I can reproduce it here.

This turned out to be quite an interesting bug to look at. The fix is
simple, but I tried to summarize my explorations below.

I'm still curious why all of your files were stat-dirty. :) As a
workaround until you have a version of Git with the fix, you can
manually refresh the index with:

  git update-index --refresh

before running git-diff.

-- >8 --
Subject: [PATCH] diff: discard blob data from stat-unmatched pairs

When performing a tree-level diff against the working tree, we may find
that our index stat information is dirty, so we queue a filepair to be
examined later. If the actual content hasn't changed, we call this a
stat-unmatch; the stat information was out of date, but there's no
actual diff.  Normally diffcore_std() would detect and remove these
identical filepairs via diffcore_skip_stat_unmatch().  However, when
"--quiet" is used, we want to stop the diff as soon as we see any
changes, so we check for stat-unmatches immediately in diff_change().

That check may require us to actually load the file contents into the
pair of diff_filespecs. If we find that the pair isn't a stat-unmatch,
then no big deal; we'd likely load the contents later anyway to generate
a patch, do rename detection, etc, so we want to hold on to it. But if
it a stat-unmatch, then we have no more use for that data; the whole
point is that we're going discard the pair. However, we never free the
allocated diff_filespec data.

In most cases, keeping that data isn't a problem. We don't expect a lot
of stat-unmatch entries, and since we're using --quiet, we'd quit as
soon as we saw such a real change anyway. However, there are extreme
cases where it makes a big difference:

  1. We'd generally mmap() the working tree half of the pair. And since
     the OS may limit the total number of maps, we can run afoul of this
     in large repositories. E.g.:

       $ cd linux
       $ git ls-files | wc -l
       67959
       $ sysctl vm.max_map_count
       vm.max_map_count = 65530
       $ git ls-files | xargs touch ;# everything is stat-dirty!
       $ git diff --quiet
       fatal: mmap failed: Cannot allocate memory

     It should be unusual to have so many files stat-dirty, but it's
     possible if you've just run a script like "sed -i" or similar.

     After this patch, the above correctly exits with code 0.

  2. Even if you don't hit mmap limits, the index half of the pair will
     have been pulled from the object database into heap memory. Again
     in a clone of linux.git, running:

       $ git ls-files | head -n 10000 | xargs touch
       $ git diff --quiet

     peaks at 145MB heap before this patch, and 94MB after.

This patch solves the problem by freeing any diff_filespec data we
picked up during the "--quiet" stat-unmatch check in diff_changes.
Nobody is going to need that data later, so there's no point holding on
to it. There are a few things to note:

  - we could skip queueing the pair entirely, which could in theory save
    a little work. But there's not much to save, as we need a
    diff_filepair to feed to diff_filespec_check_stat_unmatch() anyway.
    And since we cache the result of the stat-unmatch checks, a later
    call to diffcore_skip_stat_unmatch() call will quickly skip over
    them. The diffcore code also counts up the number of stat-unmatched
    pairs as it removes them. It's doubtful any callers would care about
    that in combination with --quiet, but we'd have to reimplement the
    logic here to be on the safe side. So it's not really worth the
    trouble.

  - I didn't write a test, because we always produce the correct output
    unless we run up against system mmap limits, which are both
    unportable and expensive to test against. Measuring peak heap
    would be interesting, but our perf suite isn't yet capable of that.

  - note that diff without "--quiet" does not suffer from the same
    problem. In diffcore_skip_stat_unmatch(), we detect the stat-unmatch
    entries and drop them immediately, so we're not carrying their data
    around.

  - you _can_ still trigger the mmap limit problem if you truly have
    that many files with actual changes. But it's rather unlikely. The
    stat-unmatch check avoids loading the file contents if the sizes
    don't match, so you'd need a pretty trivial change in every single
    file. Likewise, inexact rename detection might load the data for
    many files all at once. But you'd need not just 64k changes, but
    that many deletions and additions. The most likely candidate is
    perhaps break-detection, which would load the data for all pairs and
    keep it around for the content-level diff. But again, you'd need 64k
    actually changed files in the first place.

    So it's still possible to trigger this case, but it seems like "I
    accidentally made all my files stat-dirty" is the most likely case
    in the real world.

Reported-by: Jan Christoph Uhde <Jan@UhdeJc.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index d1ad6a3c4a..4d46fab5d3 100644
--- a/diff.c
+++ b/diff.c
@@ -6758,8 +6758,11 @@ void diff_change(struct diff_options *options,
 		return;
 
 	if (options->flags.quick && options->skip_stat_unmatch &&
-	    !diff_filespec_check_stat_unmatch(options->repo, p))
+	    !diff_filespec_check_stat_unmatch(options->repo, p)) {
+		diff_free_filespec_data(p->one);
+		diff_free_filespec_data(p->two);
 		return;
+	}
 
 	options->flags.has_changes = 1;
 }
-- 
2.27.0.rc2.689.g04a94059a7

