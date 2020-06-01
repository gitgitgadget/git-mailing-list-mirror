Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC008C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 16:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B165D20734
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 16:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgFAQyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:54:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:33430 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgFAQyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 12:54:09 -0400
Received: (qmail 29324 invoked by uid 109); 1 Jun 2020 16:54:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jun 2020 16:54:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12310 invoked by uid 111); 1 Jun 2020 16:54:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jun 2020 12:54:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Jun 2020 12:54:08 -0400
From:   Jeff King <peff@peff.net>
To:     Jan Christoph Uhde <Jan@UhdeJc.com>
Cc:     git@vger.kernel.org
Subject: Re: mmap failure in master 1aa69c73577df21f5e37e47cc40cf44fc049121e
Message-ID: <20200601165408.GA2536619@coredump.intra.peff.net>
References: <54a3a798-0387-64df-be20-af69db124042@UhdeJc.com>
 <20200601044511.GA2529317@coredump.intra.peff.net>
 <cfc79aec-ec85-dbec-e37b-6b7035b4c5a4@UhdeJc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfc79aec-ec85-dbec-e37b-6b7035b4c5a4@UhdeJc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[re-adding list to cc; I think there are some interesting bits for
discussion here]

On Mon, Jun 01, 2020 at 08:41:08AM +0200, Jan Christoph Uhde wrote:

> > Is it possible that your local repository has large number of packs? Git
> > will leave open maps to each pack's index file, plus some packs
> > themselves (ones we're accessing, plus we map+close small ones), plus
> > whatever maps are used by libc to malloc.  The kernel default limit for
> > the number of maps is 65530. If you have on the order of 30,000 packs
> > you might run into this limit.
> > 
> > You can check the number of packs with "git count-objects -v", and the
> 
> » git count-objects -v
> count: 0
> size: 0
> in-pack: 2399361
> packs: 1
> size-pack: 919395
> prune-packable: 0
> garbage: 0
> size-garbage: 0

OK, so that's just one pack (with a few million objects, which is
expected).

> > If that's the problem, the solution is to repack (which should also
> > generally improve performance). If you have trouble repacking due to the
> > limits, you can overcome the chicken and egg with:
> > 
> >    sysctl -w vm.max_map_count=131060
> 
> This fixes the problem indeed!

Now that surprises me. However, I can reproduce the issue with a fresh
clone of gcc:

  $ git clone https://github.com/gcc-mirror/gcc
  $ cd gcc
  $ git diff --quiet ;# works!
  $ find . -type f | xargs touch ;# dirty the index entry for each file
  $ git diff --quiet
  fatal: mmap failed: Cannot allocate memory

There are ~100k files in that repo. If we mmap each one as part of
diff_populate_filespec(), we're going to end up with too many maps.

So we can easily reproduce this case without having to download the huge
gcc repo:

  git init repo
  cd repo
  for i in $(seq 70); do
    mkdir $i
    for j in $(seq 1000); do
      echo "foo" >$i/$j
    done
  done
  git add .
  git commit -m 'add a bunch of files'

  git diff --quiet
  git ls-files | xargs touch
  git diff --quiet

> What could be the reason that the problem only occurs with the `--quiet` flag
> that I use in my prompt command, but not when using `git diff` without the flag.

That is curious, and I can reproduce it here.

In the non-quiet case, we queue each filepair that we find to be
stat-dirty. And then we call diffcore_skip_stat_unmatch() from
diffcore_std() on the whole list. We load each file singly, see that
it's not really a change (the index entries are just stat-dirty because
of our touch), and then discard it.

Whereas in the --quiet case, we hit this code in diff_change when
queuing each:

          if (options->flags.quick && options->skip_stat_unmatch &&
              !diff_filespec_check_stat_unmatch(options->repo, p))
                  return;

          options->flags.has_changes = 1;

That code is trying to make sure we accurately set the has_changes flag
in quick/quiet mode (because we can stop diffing as soon as we see a
single change). Since none of these changes is interesting (they're all
just stat-dirty entries), we have to keep going and look at each one.
But this code leaves the populated filespec in the queue. Doing this
makes "diff --quiet" succeed in this case:

diff --git a/diff.c b/diff.c
index d1ad6a3c4a..2535614735 100644
--- a/diff.c
+++ b/diff.c
@@ -6758,8 +6758,15 @@ void diff_change(struct diff_options *options,
 		return;
 
 	if (options->flags.quick && options->skip_stat_unmatch &&
-	    !diff_filespec_check_stat_unmatch(options->repo, p))
+	    !diff_filespec_check_stat_unmatch(options->repo, p)) {
+		/*
+		 * discard any populated data; this entry is uninteresting;
+		 * we probably ought to avoid queuing the pair at all!
+		 */
+		diff_free_filespec_data(p->one);
+		diff_free_filespec_data(p->two);
 		return;
+	}
 
 	options->flags.has_changes = 1;
 }

But that's only because these aren't "real" changes. If we swap out our
"touch" for:

  git ls-files | while read fn; do
    echo bar >$fn
  done

then we have real changes. Our --quiet case will exit immediately once
it sees a change, so it's OK. But now the non-quiet one will fail,
because it's going to load each file to confirm that it's an actual
change, but leave the mmap in place for when we do the actual
content-level diff.

So I think in general we do have problems diffing more than 65k working
tree files in a single process because of this limit. It may still be
worth doing something along the lines of the patch above, though,
because it seems more likely for somebody to have 65k stat-dirty files
than 65k actual changes.

-Peff
