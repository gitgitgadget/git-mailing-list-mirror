Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F18920964
	for <e@80x24.org>; Tue,  4 Apr 2017 15:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754415AbdDDPHq (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 11:07:46 -0400
Received: from siwi.pair.com ([209.68.5.199]:20900 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754408AbdDDPHp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 11:07:45 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1066E846D6;
        Tue,  4 Apr 2017 11:07:39 -0400 (EDT)
Subject: Re: [PATCH/RFC] gitperformance: add new documentation about git
 performance tuning
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20170403211644.26814-1-avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <658ab318-43d6-6940-50e6-0b32ecd2543f@jeffhostetler.com>
Date:   Tue, 4 Apr 2017 11:07:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170403211644.26814-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/3/2017 5:16 PM, Ævar Arnfjörð Bjarmason wrote:
> Add a new manpage that gives an overview of how to tweak git's
> performance.
>
> There's currently no good single resource for things a git site
> administrator might want to look into to improve performance for his
> site & his users. This unfinished documentation aims to be the first
> thing someone might want to look at when investigating ways to improve
> git performance.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>
> I've been wanting to get something like this started for a while. It's
> obviously woefully incomplete. Pointers about what to include would be
> great & whether including something like this makes sense.
>
> Things I have on my TODO list:
>
>  - Add a section discussing how refs impact performance, suggest
>    e.g. archiving old tags if possible, or at least run "git remote
>    prune origin" regularly on clients.
>
>  - Discuss split index a bit, although I'm not very confident in
>    describing what its pros & cons are.
>
>  - Should we be covering good practices for your repo going forward to
>    maintain good performance? E.g. don't have some huge tree all in
>    one directory (use subdirs), don't add binary (rather
>    un-delta-able) content if you can help it etc.
>
> - The new core.checksumIndex option being discussed on-list. Which
>   actually drove my to finally write this up (hrm, this sounds useful,
>   but unless I was watching the list I'd probably never see it...).

You might also consider core.preloadIndex.

For people with very large trees, talk about sparse-checkout.

And (on Windows) core.fscache.  Or leave a place for
an addendum for Windows that we can fill in later.

>
>
>  Documentation/Makefile           |   1 +
>  Documentation/gitperformance.txt | 107 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
>  create mode 100644 Documentation/gitperformance.txt
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index b5be2e2d3f..528aa22354 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -23,6 +23,7 @@ MAN5_TXT += gitrepository-layout.txt
>  MAN5_TXT += gitweb.conf.txt
>
>  MAN7_TXT += gitcli.txt
> +MAN7_TXT += gitperformance.txt
>  MAN7_TXT += gitcore-tutorial.txt
>  MAN7_TXT += gitcredentials.txt
>  MAN7_TXT += gitcvs-migration.txt
> diff --git a/Documentation/gitperformance.txt b/Documentation/gitperformance.txt
> new file mode 100644
> index 0000000000..0548d1e721
> --- /dev/null
> +++ b/Documentation/gitperformance.txt
> @@ -0,0 +1,107 @@
> +giteveryday(7)
> +==============
> +
> +NAME
> +----
> +gitperformance - How to improve Git's performance
> +
> +SYNOPSIS
> +--------
> +
> +A guide to improving Git's performance beyond the defaults.
> +
> +DESCRIPTION
> +-----------
> +
> +Git is mostly performant by default, but ships with various
> +configuration options, command-line options, etc. that might improve
> +performance, but for various reasons aren't on by default.
> +
> +This document provides a brief overview of these features.
> +
> +The reader should not assume that turning on all of these features
> +will increase performance, depending on the repository, workload &
> +use-case turning some of them on might severely harm performance.
> +
> +This document serves as a starting point for things to look into when
> +it comes to improving performance, not as a checklist for things to
> +enable or disable.
> +
> +Performance by topic
> +--------------------
> +
> +It can be hard to divide the performance features into topics, but
> +most of them fall into various well-defined buckets. E.g. there are
> +features that help with the performance of "git status", and couldn't
> +possibly impact repositories without working copies, and then some
> +that only impact the performance of cloning from a server, or help the
> +server itself etc.
> +
> +git status
> +~~~~~~~~~~
> +
> +Running "git status" requires traversing the working tree & comparing
> +it with the index. Several configuration options can help with its
> +performance, with some trade-offs.
> +
> +- config: "core.untrackedCache=true" (see linkgit:git-config[1]) can
> +  save on `stat(2)` calls by caching the mtime of filesystem
> +  directories, and if they didn't change avoid recursing into that
> +  directory to `stat(2)` every file in them.
> ++
> +pros: Can drastically speed up "git status".
> ++
> +cons: There's a speed hit for initially populating & maintaining the
> +cache. Doesn't work on all filesystems (see `--test-untracked-cache`
> +in linkgit:git-update-index[1]).
> +
> +- config: "status.showUntrackedFiles=no" (see
> +  linkgit:git-config[1]). Skips looking for files in the working tree
> +  git doesn't already know about.
> ++
> +pros: Speeds up "git status" by making it do a lot less work.
> ++
> +cons: If there's any new & untracked files anywhere in the working
> +tree they won't be noticed by git. Makes it easy to accidentally miss
> +files to "git add" before committing, or files which might impact the
> +code in the working tree, but which git won't know exist.
> +
> +git grep
> +~~~~~~~~
> +
> +- config: "grep.patternType=perl" (see linkgit:git-config[1]) will use
> +  the PCRE library when "git grep" is invoked by default. This can be
> +  faster than POSIX regular expressions in many cases.
> ++
> +pros: Can, depending on the use-case, be faster than default "git grep".
> ++
> +cons: Can also be slower, and in some edge cases produce different
> +results.
> +
> +- config: "grep.threads=*" (see linkgit:git-config[1] &
> +  linkgit:git-grep[1]). Tunes the number of "git grep" worker threads.
> ++
> +pros: Giving this a more optimal value might result in a faster grep.
> ++
> +cons: It might not.
> +
> +Server options to help clients
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +These features can be enabled on git servers, they won't help the
> +performance of the servers themselves, but will help clients that need
> +to talk to those servers.
> +
> +- config: "repack.writeBitmaps=true" (see
> +  linkgit:git-config[1]). Spend more time during repack to produce
> +  bitmap index, helps clients with "fetch" & "clone" performance.
> ++
> +pros: Once enabled & run regularly as part of "git repack" speeds up
> +"clone" and "fetch".
> ++
> +cons: Takes extra time during repack, requires doing full
> +non-incremental repacks with `-A` or `-a`.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
>
