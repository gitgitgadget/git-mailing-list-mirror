Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E46D202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 18:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754153AbdCHSu5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 13:50:57 -0500
Received: from siwi.pair.com ([209.68.5.199]:42568 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754115AbdCHSu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 13:50:56 -0500
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5059E845F8;
        Wed,  8 Mar 2017 13:50:54 -0500 (EST)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com, jonathantanmy@google.com
Subject: [PATCH 00/10] RFC Partial Clone and Fetch
Date:   Wed,  8 Mar 2017 18:50:29 +0000
Message-Id: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>


[RFC] Partial Clone and Fetch
=============================


This is a WIP RFC for a partial clone and fetch feature wherein the client
can request that the server omit various blobs from the packfile during
clone and fetch.  Clients can later request omitted blobs (either from a
modified upload-pack-like request to the server or via a completely
independent mechanism).

The purpose here is to reduce the size of packfile downloads and help
git scale to extremely large repos.

I use the term "partial" here to refer to a portion of one or more commits
and to avoid use of loaded terms like "sparse", "lazy", "narrow", and "skeleton".

The concept of a partial clone/fetch is independent of and can complement
the existing shallow-clone, refspec, and limited-ref filtering mechanisms
since these all filter at the DAG level whereas the work described here
works *within* the set of commits already chosen for download.


A. Requesting a Partial Clone/Fetch
===================================

Clone, fetch, and fetch-pack will accept one or more new "partial"
command line arguments as described below.  The fetch-pack/upload-pack
protocol will be extended to include these new arguments.  Upload-pack
and pack-objects will be updated accordingly.  Pack-objects will filter
out the unwanted blobs as it is building the packfile.  Rev-list and
index-pack will be updated to not complain when missing blobs are
detected in the received packfile.

[1] "--partial-by-size=<n>[kmg]"
Where <n> is a non-negative integer with an optional unit.

Request that only blobs smaller than this be included in the packfile.
The client might use this to implement an alternate LFS or ODB mechanism
for large blobs, such as suggested in:
    https://public-inbox.org/git/20161130210420.15982-1-chriscool@tuxfamily.org/

A special case of size zero would omit all blobs and is similar to the
commits-and-trees-only feature described in:
    https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/

[2] "--partial-special"
Request that special files, such as ".gitignore" and .gitattributes",
be included.

[3] *TODO* "--partial-by-profile=<sparse-checkout-path>"
Where <sparse-checkout-path> is verson-controlled file in the repository
(either present in the requested commit or the default HEAD on the server).

    [I envision a ".gitsparse/<path>" hierarchy where teams can store
     common sparse-checkout profiles.  And then they can reference
     them from their private ".git/info/sparse-checkout" files.]

Pack-objects will use this file and the sparse-checkout rules to only
include blobs in the packfile that would be needed to do the corresponding
sparse-checkout (and let the client avoid having to demand-load their
entire enlistment).


When multiple "partial" options are given, they are treated as a simple OR
giving the union of the blobs selected.

The patch series describes the changes to the fetch-pack/upload-pack
protocol:
    Documentation/technical/pack-protocol.txt
    Documentation/technical/protocol-capabilities.txt


B. Issues Backfilling Omitted Blobs
===================================

Ideally, if the client only does "--partial-by-profile" fetches, it
should not need to fetch individual missing blobs, but we have to allow
for it to handle the other commands and other unexpected issues.

There are 3 orthogonal concepts here:  when, how and where?


[1] When:
(1a) a pre-command or hook to identify needed blobs and pre-fetch them
before allowing the actual command to start;
(1b) a dry-run mode for the command to likewise pre-fetch them; or
(1c) "fault" them in as necessary in read_object() while the command is
running and without any pre-fetch (either synchronously or asynchronously
and with/without a helper process).

Ideas for (1c) are being addressed in the following threads:
    https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
    https://public-inbox.org/git/20170117184258.sd7h2hkv27w52gzt@sigill.intra.peff.net/
    https://public-inbox.org/git/20161130210420.15982-1-chriscool@tuxfamily.org/
so I won't consider them here.

Ideas (1a) and (1b) have the advantage that they try to obtain all
required blobs before allowing an operation to start, so there is
less opportunity to leave the user in a weird state.

The best solution may be a combination of (1a) and (1b) and may depend
on the individual command.  However, (1b) will further complicate the
source in the existing commands, so in some cases it may be simpler to
just take the ideas and implement stand-alone pre-commands.

For now, I'm going to limit this RFC to (1a).


[2] How:
(2a) augment the existing git protocols to include blob requests;
(2b) local external process (such as a database client or a local bulk
fetch daemon);

Ideas for (2b) are being addressed in the above threads, so I won't
consider them here.

So I'm going to limit this RFC to (2a).


[3] Where:
(3a) the same remote server used for the partial clone/fetch;
(3b) anywhere else, such as a proxy server or Azure or S3 blob store.

There's no reason that the client should be limited to going back to
the same server, but I'm not going to consider it here, so I'm going
to limit this RFC to (3a).



C. New Blob-Fetch Protocol (2a)
===============================

*TODO* A new pair of commands, such as fetch-blob-pack and upload-blob-pack,
will be created to let the client request a batch of blobs and receive a
packfile.  A protocol similar to the fetch-pack/upload-pack will be spoken
between them.  (This avoids complicating the existing protocol and the work
of enumerating the refs.)  Upload-blob-pack will use pack-objects to build
the packfile.

It is also more efficient than requesting a single blob at a time using
the existing fetch-pack/upload-pack mechanism (with the various allow
unreachable options).

*TODO* The new request protocol will be defined in the patch series.
It will include: a list of the desired blob SHAs.  Possibly also the commit
SHA, branch name, and pathname of each blob (or whatever is necessary to let
the server address the reachability concerns).  Possibly also the last
known SHA for each blob to allow for deltafication in the packfile.


D. Pre-fetching Blobs (1a)
==========================

On the client side, one or more special commands will be created to assemble
the list of blobs needed for an operation and passed to fetch-blob-pack.


Checkout Example:  After running a command like:
    'clone --partial-by-size=1m --no-checkout'

and before doing an actual checkout, we need a command to essentially do:
    (1) "ls-tree -r <tree-ish>",
    (2) filter that by the sparse-checkout currently in effect,
    (3) filter that for missing blobs,
    (4) and pass the resulting list to fetch-blob-pack.

Afterwards, checkout should complete without faulting.

A new "git ls-partial <treeish>" command has been created to do
steps 1 thru 3 and print the resulting list of SHAs on stdout.


E. Unresolved Thoughts
======================

*TODO* The server should optionally return (in a side-band?) a list 
of the blobs that it omitted from the packfile (and possibly the sizes
or sha1_object_info() data for them) during the fetch-pack/upload-pack
operation.  This would allow the client to distinguish from invalid
SHAs and missing ones.  Size information would allow the client to
maybe choose between various servers.

*TODO* The partial clone arguments should be recorded in ".git/info/"
so that subsequent fetch commands can inherit them and rev-list/index-pack
know to not complain by default.

*TODO* Update GC like rev-list to not complain when there are missing blobs.

*TODO* Extend ls-partial to include the "-m" and 3 tree-ish arguments
like read-tree, so we can pre-fetch for merges that may require file
merges (that may or may not be within our sparse-checkout).

*TODO* I also need to review the RFC that Mark Thomas submitted over
the weekend:
    https://public-inbox.org/git/20170304191901.9622-1-markbt%40efaref.net/t





Jeff Hostetler (10):
  pack-objects: eat CR in addition to LF after fgets.
  pack-objects: add --partial-by-size=n --partial-special
  pack-objects: test for --partial-by-size --partial-special
  upload-pack: add partial (sparse) fetch
  fetch-pack: add partial-by-size and partial-special
  rev-list: add --allow-partial option to relax connectivity checks
  index-pack: add --allow-partial option to relax blob existence checks
  fetch: add partial-by-size and partial-special arguments
  clone: add partial-by-size and partial-special arguments
  ls-partial: created command to list missing blobs

 Documentation/technical/pack-protocol.txt         |  14 ++
 Documentation/technical/protocol-capabilities.txt |   7 +
 Makefile                                          |   2 +
 builtin.h                                         |   1 +
 builtin/clone.c                                   |  26 ++
 builtin/fetch-pack.c                              |   9 +
 builtin/fetch.c                                   |  26 +-
 builtin/index-pack.c                              |  20 +-
 builtin/ls-partial.c                              | 110 +++++++++
 builtin/pack-objects.c                            |  64 ++++-
 builtin/rev-list.c                                |  22 +-
 connected.c                                       |   3 +
 connected.h                                       |   3 +
 fetch-pack.c                                      |  17 ++
 fetch-pack.h                                      |   2 +
 git.c                                             |   1 +
 partial-utils.c                                   | 279 ++++++++++++++++++++++
 partial-utils.h                                   |  93 ++++++++
 t/5316-pack-objects-partial.sh                    |  72 ++++++
 transport.c                                       |   8 +
 transport.h                                       |   8 +
 upload-pack.c                                     |  32 ++-
 22 files changed, 813 insertions(+), 6 deletions(-)
 create mode 100644 builtin/ls-partial.c
 create mode 100644 partial-utils.c
 create mode 100644 partial-utils.h
 create mode 100644 t/5316-pack-objects-partial.sh

-- 
2.7.4

