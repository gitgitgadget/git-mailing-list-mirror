Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC15D20899
	for <e@80x24.org>; Mon, 21 Aug 2017 00:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbdHUAAb (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 20:00:31 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57048 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753416AbdHUAAa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Aug 2017 20:00:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2EA6A280AD
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1503273629;
        bh=+Tvh6lZl9+ol5Lp6zz7kAXeIrGKMDs3rU4LM5Qniggo=;
        h=From:To:Subject:Date:From;
        b=lax4gVoX/2exrKLPFqELn2/cEvNiQb2vYRjQuF1BRIwHb5MbJekyl4y51SC7ARKsF
         JnnXupxWOEpM4El/rww62XEIoWEMc8GEVyK4sHFUWsj4w07QUsG4vGMMnP5GgysUrw
         3QB9XBlwHfejx//L+u5geiMIZw9JhA37dK+wCkOax3DVcJJl4LuVsE/KqHuoiwx7TZ
         FJ2NsxIqTFHFaSbPoEua+YqQjgsDyck19+xxzF81Vjb5IeoRdfu1EKaI7H3+jhZGpk
         0BNZGqIky7OPyYggowu1Mxf+SEPb2tTLw75Uh6NsxYf6rhvhnxBAdXL3fjc4PX0cO9
         mr94dMoDDpYaBGTID/uTDuJrwGqBsX+zuDixMOYJSdqQZhB3L48ClkWZt+OlJM+TbM
         V0djgmNSibDyBhEuvD8SQoFJwbxPAv025pDVWCGO9NFzXDTp1UR3z60ns2tdQQhOrl
         SNDUrKuLtmRwrRwMCap7Jg+p+12qljOCKqwcfh+K0/Tp2isRfwT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 0/6] Hash Abstraction
Date:   Mon, 21 Aug 2017 00:00:16 +0000
Message-Id: <20170821000022.26729-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

= Overview

This is an RFC series proposing a basic abstraction for hash functions.

As we get closer to converting the remainder of the codebase to use
struct object_id, we should think about the design we want our hash
function abstraction to take.  This series is a proposal for one idea to
start discussion.  Input on any aspect of this proposal is welcome.

This series exposes a struct git_hash_algo that contains basic
information about a given hash algorithm that distinguishes it from
other algorithms: name, lengths, implementing functions, and empty tree
and blob constants.  It also exposes an array of hash algorithms, and a
constant for indexing them.

The series also demonstrates a simple conversion using the abstraction
over empty blob and tree values.

In order to avoid conflicting with the struct repository work and with
the goal of avoiding global variables as much as possible, I've pushed
the hash algorithm into struct repository and exposed it via a #define.
This necessitiates pulling repository.h into cache.h, which I don't
think is fatal.  Doing that, in turn, necessitated some work on the
Subversion code to avoid conflicts.

It should be fine for Junio to pick up the first two patches from this
series, as they're relatively independent and valuable without the rest
of the series.  The rest should not be applied immediately, although
they do pass the testsuite.

I proposed this series now as it will inform the way we go about
converting other parts of the codebase, especially some of the pack
algorithms.  Because we share some hash computation code between pack
checksums and object hashing, we need to decide whether to expose pack
checksums as struct object_id, even though they are technically not
object IDs.  Furthermore, if we end up needing to stuff an algorithm
value into struct object_id, we'll no longer be able to directly
reference object IDs in a pack without a copy.

This series is available from the usual places as branch hash-struct,
based against master.

= Naming

The length names are similar to the current constant names
intentionally.  I've used the "hash_algo" name for both the integer
constant and the pointer to struct, although we could change the latter
to "hash_impl" or such as people like.

I chose to name the define "current_hash" and expose no other defines.
The name is relatively short since we're going to be typing it a lot.
However, if people like, we can capitalize it or expose other defines
(say, a GIT_HASH_RAWSZ or GIT_HASH_HEXSZ) instead of or in addition to
current_hash, which would make this name less interesting.

Feel free to propose alternatives to the naming of anything in this
series.

= Open Issues

I originally decided to convert hex.c as an example, but quickly found
out that this caused segfaults.  As part of setup, we call
is_git_directory, which calls validate_headref, which ends up calling
get_sha1_hex.  Obviously, we don't have a repository, so the hash
algorithm isn't set up yet.  This is an area we'll need to consider
making hash function agnostic, and we may also need to consider
inserting a hash constant integer into struct object_id if we're going
to do that.  Alternatively, we could just paper over this issue as a
special case.

Clearly we're going to want to expose some sort of lookup functionality
for hash algorithms.  We'll need to expose lookup by name (for the
.git/config file and any command-line options), but we may want other
functions as well.  What functions should those be?  Should we expose
the structure or the constant for those lookup functions?  If the
structure, we'll probably need to expose the constant in the structure
as well for easy use.

Should we avoid exposing the array of structure altogether and wrap this
in a function?

We could expose a union of hash context structures and take that as the
pointer type for the API calls.  That would probably obviate the need
for ctxsz.

We could expose hex versions of the blob constants if desired.  This
might make converting the remaining pieces of code that use them easier.

There are probably dozens of other things I haven't thought of yet as
well.

brian m. carlson (6):
  vcs-svn: remove unused prototypes
  vcs-svn: rename repo functions to "svn_repo"
  setup: expose enumerated repo info
  Add structure representing hash algorithm
  Integrate hash algorithm support with repo setup
  Switch empty tree and blob lookups to use hash abstraction

 builtin/am.c        |  2 +-
 builtin/checkout.c  |  2 +-
 builtin/diff.c      |  2 +-
 builtin/pull.c      |  2 +-
 cache.h             | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 diff-lib.c          |  2 +-
 merge-recursive.c   |  2 +-
 notes-merge.c       |  2 +-
 repository.c        |  7 +++++++
 repository.h        |  5 +++++
 sequencer.c         |  6 +++---
 setup.c             | 48 +++++++++++++++++++++++++++---------------------
 sha1_file.c         | 29 +++++++++++++++++++++++++++++
 submodule.c         |  2 +-
 vcs-svn/repo_tree.c |  6 +++---
 vcs-svn/repo_tree.h | 13 +++----------
 vcs-svn/svndump.c   |  8 ++++----
 17 files changed, 133 insertions(+), 53 deletions(-)

