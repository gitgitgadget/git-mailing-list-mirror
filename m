Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9481C677F1
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 02:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjASCbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 21:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASCbi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 21:31:38 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A594EA24E
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 18:31:37 -0800 (PST)
Received: (qmail 5686 invoked by uid 109); 19 Jan 2023 02:31:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Jan 2023 02:31:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28187 invoked by uid 111); 19 Jan 2023 02:31:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 21:31:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 21:31:36 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 6/6] hash-object: use fsck for object checks
Message-ID: <Y8iriP4T2FQPtBfF@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8haHL9xIWntSm0/@coredump.intra.peff.net>
 <Y8hlyr0o6gs9omI5@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8hlyr0o6gs9omI5@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 04:34:02PM -0500, Taylor Blau wrote:

> That being said, let me play devil's advocate for a second. Do the new
> fsck checks slow anything in hash-object down significantly? If so, then
> it's plausible to imagine a hash-object caller who (a) doesn't use
> `--literally`, but (b) does care about throughput if they're writing a
> large number of objects at once.
> 
> I don't know if such a situation exists, or if these new fsck checks
> even slow hash-object down enough to care. But I didn't catch a
> discussion of this case in your series, so I figured I'd bring it up
> here just in case.

That's a really good point to bring up.

Prior to timing anything, here were my guesses:

  - it won't make a big difference either way because the time is
    dominated by computing sha1 anyway

  - we might actually be a little faster for commits and tags in the new
    code, because they aren't allocating structs for the pointed-to
    objects (trees, parents, etc). Nor stuffing them into obj_hash, so
    our total memory usage would be lower.

  - trees may be a little slower, because we're doing a more analysis on
    the filenames (sort order, various filesystem specific checks for
    .git, etc)

And here's what I timed, using linux.git. First I pulled out the raw
object data like so:

  mkdir -p commit tag tree

  git cat-file --batch-all-objects --unordered --batch-check='%(objecttype) %(objectname)' |
  perl -alne 'print $F[1] unless $F[0] eq "blob"' |
  git cat-file --batch |
  perl -ne '
    /(\S+) (\S+) (\d+)/ or die "confusing: $_";
    my $dir = "$2/" . substr($1, 0, 2);
    my $fn = "$dir/" . substr($1, 2);
    mkdir($dir);
    open(my $fh, ">", $fn) or die "open($fn): $!";
    read(STDIN, my $buf, $3) or die "read($3): $!";
    print $fh $buf;
    read(STDIN, $buf, 1); # trailing newline
  '

And then I timed it like this:

  find commit -type f | sort >input
  hyperfine -L v old,new './git.{v} hash-object --stdin-paths -t commit <input'

which yielded:

  Benchmark 1: ./git.old hash-object --stdin-paths -t commit <input
    Time (mean ± σ):      7.264 s ±  0.142 s    [User: 4.129 s, System: 3.043 s]
    Range (min … max):    7.098 s …  7.558 s    10 runs

  Benchmark 2: ./git.new hash-object --stdin-paths -t commit <input
    Time (mean ± σ):      6.832 s ±  0.087 s    [User: 3.848 s, System: 2.901 s]
    Range (min … max):    6.752 s …  7.059 s    10 runs

  Summary
    './git.new hash-object --stdin-paths -t commit <input' ran
      1.06 ± 0.02 times faster than './git.old hash-object --stdin-paths -t commit <input'

So the new code is indeed faster, though really most of the time is
spent reading the data and computing the hash anyway. For comparison,
using --literally drops it to ~6.3s.

And according to massif, peak heap drops from 241MB to 80k. Which is
pretty good.

Trees are definitely slower, though. I reduced the number to fit in my
budget of patience:

  find tree -type f | sort | head -n 200000 >input
  hyperfine -L v old,new './git.{v} hash-object --stdin-paths -t tree <input'

And got:

  Benchmark 1: ./git.old hash-object --stdin-paths -t tree <input
    Time (mean ± σ):      2.470 s ±  0.022 s    [User: 1.902 s, System: 0.549 s]
    Range (min … max):    2.442 s …  2.509 s    10 runs
  
  Benchmark 2: ./git.new hash-object --stdin-paths -t tree <input
    Time (mean ± σ):      3.244 s ±  0.026 s    [User: 2.661 s, System: 0.567 s]
    Range (min … max):    3.215 s …  3.295 s    10 runs
  
  Summary
    './git.old hash-object --stdin-paths -t tree <input' ran
      1.31 ± 0.02 times faster than './git.new hash-object --stdin-paths -t tree <input'

So we indeed got a bit slower (and --literally here is ~2.2s). It's
enough that it outweighs the benefits from the commits getting faster
(especially because there tend to be more trees than commits). But those
also get diluted by blobs (which have a lot of data to hash and free
fsck checks).

So in the end, I think nobody would really care that much. The absolute
numbers are pretty small, and this is already a fairly dumb way to get
objects into your repository. The usual way is via index-pack, and it
already uses the fsck code for its checks. But I do think it was a good
question to explore (plus it found a descriptor leak in hash-object,
which I sent a separate patch for).

-Peff
