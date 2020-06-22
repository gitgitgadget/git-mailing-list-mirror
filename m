Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5F9C433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 13:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94A320738
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 13:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgFVNkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:40:12 -0400
Received: from dovecot.mat.umk.pl ([158.75.2.81]:54291 "EHLO
        poczta1.mat.umk.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgFVNkM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 09:40:12 -0400
Received: from dovecot.mat.umk.pl (localhost.localdomain [127.0.0.1])
        by poczta1.mat.umk.pl (Postfix) with ESMTP id D85079568C4;
        Mon, 22 Jun 2020 15:40:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mat.umk.pl
Received: from poczta1.mat.umk.pl ([127.0.0.1])
        by dovecot.mat.umk.pl (poczta1.mat.umk.pl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zpTooQcY4TQR; Mon, 22 Jun 2020 15:40:07 +0200 (CEST)
Received: from [192.168.0.7] (host-89-229-7-83.dynamic.mm.pl [89.229.7.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jnareb)
        by poczta1.mat.umk.pl (Postfix) with ESMTPSA id B8F3F9568C0;
        Mon, 22 Jun 2020 15:40:06 +0200 (CEST)
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC] Metadata vs Generation Data Chunk
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org
References: <20200622093451.GA1719@Abhishek-Arch>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <10d99e37-8870-6401-d9aa-21a359b30835@gmail.com>
Date:   Mon, 22 Jun 2020 15:40:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622093451.GA1719@Abhishek-Arch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.06.2020 at 11:34, Abhishek Kumar wrote:

> One of the remaining pre-requisites for implementing generation number
> v2 was distinguishing between corrected commit dates with monotonically
> increasing offsets and topological level without incrementing generation
> number version.
> 
> Two approaches were proposed [1]:
> 1. New chunk for commit data (generation data chunk, "GDAT")
> 2. Metadata/versioning chunk

Actually in [1] there was also proposed another distinct approach,
namely to 'rename' the "CDAT" chunk to something else, like "CDA2"
(or proposed here "GDAT").

If I read the code correctly, with old Git if one of required chunks
is missing then Git would continue work as if commit-graph was not
present -- as opposed to current handling of unknown commit-graph
file format version number, where Git would stop working with an
error message.

> 
> Since both approaches have their advantages and disadvantages, I wrote
> up a prototype [2] to investigate their performance.
> 
> [1]: https://lore.kernel.org/git/86mu87qj92.fsf@gmail.com/
> [2]: https://github.com/abhishekkumar2718/git/pull/1

That's very nice.  Thanks for investigating that.

> 
> TL;DR: I recommend we should use generation data chunk approach.
> 
> Generation Data Chunk
> =====================
> 
> We could move the generation number v2 into a separate chunk, storing
> topological levels in CDAT and the corrected commit date into a new,
> "GDAT" chunk.  Thus, old Git would use generation number v1, and
> new Git would use corrected commit dates from GDAT.
> 
> Using generation data chunk has the advantage that we would no longer
> be restricted to using 30 bits for generation number. It also works
> well for commit-graph chains with a mix of v1 and v2 generation numbers.
> 
> However, it increases the time required for I/O as commit data and
> generation numbers are no longer contiguous.
> 
> Note: While it also increases disk space required for storing
> commit-graph files by 8 bytes per commit, I don't consider it relevant,
> especially on modern systems. A repo of the size of Linux repo would be
> larger by a mere 7.2 Mb.

All right.

Another advantage: we don't have to store the corrected committer date
_offset_, we can store the date (as epoch) directly.  This saves some
calculation, though a minuscule amount.

Yet another advantage: we don't need backward-compatibility for
generation number v2, i.e. corrected commit date.

Another disadvantage: we need to compute both topological levels and
corrected commit date when creating a commit-graph file or a chunk of
it.  This means that `git commit-graph write` could be slightly more
expensive.

> 
> Metadata / Versioning Chunk
> ===========================
> 
> We could also introduce an optional metadata chunk to store generation
> number version and store corrected date offsets in CDAT. Since the
> offsets are backward compatible, Old Git would still yield correct
> results by assuming the offsets to be topological levels. New Git would
> correctly use the offsets to create corrected commit dates.

This also means that we need to use backward-compatible generation
number v2, that is corrected commit date with strictly monotonic
offsets.  Which may lead to more cases where 30 bits for label is not
enough, and thus worse performance (no detailed reachability
information for newest commits).

> 
> It works just as well as generation number v1 in parsing and writing
> commit-graph files.
> 
> However, the generation numbers are still restricted to 30 bits in CDAT
> chunk and it does not work well with commit-graph chains with a mix of
> v1 and v2 generation numbers.


CDAT chunk replaced with another chunk
======================================

In this approach the "CDAT" chunk is missing from the commit-graph file.
We can craft the replacement ("CDA2") however we like, but it can also
look like the "CDAT" chunk, only with the offsets for corrected commit
date rather than topological level for generation number part (30 bits).

If we choose to follow the "CDAT" format (modified), then the file
size would not change, and neither would change the amount of I/O
needed -- there would be the same access structure as in current
version.

There should be no confusion with a mix of v1 and v2 generation numbers.

The disadvantage is of course that older version of Git would no longer
be able to make use of serialized commit-graph if the file was written
by newer version of Git.

> 
> Performance
> ===========

What is the repository where those benchmarks took place?

> | Command                        | Master | Metadata | Generation Data |
> |--------------------------------|--------|----------|-----------------|
> | git commit-graph write         | 14.45s | 14.28s   | 14.63s          |
> | git log --topo-order -10000    | 0.211s | 0.206s   | 0.208s          |
> | git log --topo-order -100 A..B | 0.019s | 0.015s   | 0.015s          |
> | git merge-base A..B            | 0.137s | 0.137s   | 0.137s          |

Nice.

How those two (or three) approaches work on gen-test [3] test cases,
both in terms of commits walked (extracted via trace2 mechanism) and
actual wall-time clock, like in the result above?

[3]: https://github.com/derrickstolee/gen-test

> - Metadata and generation data chunks perform better than master on
>    using commit-graph files since they use corrected commit dates.
> 
> - The increased I/O time for parsing GDAT does not affect performance as
>    much as expected.
> 
> - Generation data commit-graph takes longer to write since more
>    information is written into the file.
> 
> As using the commit-graph is much more frequent than writing, we can
> consider both approaches to perform equally well.
> 
> I prefer generation data chunk approach as it also removes 30-bit length
> restriction on generation numbers.

Thank you for your work.

Best,

P.S. I hope I haven't sent it twice...
-- 
Jakub Narębski
