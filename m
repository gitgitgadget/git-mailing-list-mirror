From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 00/16] Speed up Counting Objects with bitmap data
Date: Tue, 25 Jun 2013 01:22:57 +0200
Message-ID: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:23:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG6q-00031D-Pb
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab3FXXXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:23:40 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:47077 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab3FXXXj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:23:39 -0400
Received: by mail-we0-f182.google.com with SMTP id p60so8588458wes.41
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/JIRMwMmJFWH4i/M8A5N5tfgk9UYJgnQZ5FNPDKX5n8=;
        b=iSN9JeSP9+HUr9BDFoouUqPvWHKIUZ32x6qvpjDYTttrlnQk+QWEm9OyHRsQcSPBK+
         Cb6pqVBTMy0BCvBai+mc8IFrZ6smRZkEWg/sFjm/1shOD/e6VFaCdrNU5A+41GJh8RWJ
         qfZa85yKltGUQIeLDWaaQ0M1JEKgwBSYIkl7MPYPcV7pZaaOmMbkETCJPfszNiOBmv5K
         KoGrEwFgu1TATEec4mibqzd63ghjaXAKsA+0ZQszR8U+L8J9f4LpoJX9Q3bj5fzsYMmL
         rsNH0xWpREYFgNzbwyMjbkTrYyoCB7YKO3Dgoh0rrI+7g9fzc5z0eJhjCLbXFUzlw6Bp
         5i4A==
X-Received: by 10.181.13.106 with SMTP id ex10mr7404154wid.16.1372116217903;
        Mon, 24 Jun 2013 16:23:37 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.23.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:23:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228918>

Hello friends and enemies from the lovevely Git Mailing list.

I bring to you a patch series that implement a quite interesting performance
optimization: the removal of the "Counting Objects" phase during `pack-objects`
by using a pre-computed bitmap to find the reachable objects in the packfile.

As you probably know, Shawn Pearce designed this approach a few months ago and
implemented it for JGit, with very exciting results.

This is a not-so-straightforward port of his original design: The general approach
is the same, but unfortunately we were not able to re-use JGit's original on-disk
format for the `.bitmap` files.

There is a full technical spec for the new format (v2) in patch 09, including
benchmarks and rationale for the new design. The gist of it is that JGit's
original format is not `mmap`able (JGit tends to not mmap anything), and that
becomes very costly in practice with `upload-pack`, which spawns a new process
for every upload.

The header and metadata for both formats are however compatible, so it should be
trivial to update JGit to read/write this format too. I intend to do this on the
coming weeks, and I also hope that the v2 implementation will be slightly faster
than the actual, even with the shortcomings of the JVM.

The patch series, although massive, is rather straightforward.

Most of the patches are isolated refactorings that enable access to a few functions
that were previously hidden (re. packfile data). These functions are needed for
reading and writing the bitmap indexes.

Patch 03 is worth noting because it implements a performance optimization for
`pack-objects` which isn't particularly good in normal invocations (~10% speed up)
but that will show great benefits in later patches when it comes to writing the
bitmap indexes.

Patch 10 is the core of the series, implementing the actual loading of bitmap indexes
and optimizing the Counting Objects phase of `pack-objects`. Like with every other
patch that offers performance improvements, sample benchmarks are provided (spoiler:
they are pretty fucking cool).

Patch 11 and 16 are samples of using the new Bitmap traversal API to speed up other
parts of Git (`rev-list --objects` and `rev-list --count`, respectively).

Patch 12, 13 and 15 implement the actual writing of bitmap indexes. Like JGit, patch
12 enables writing a bitmap index as part of the `pack-objects` process (and hence
as part of a normal `gc` run). On top of that, I implemented a new plumbing command
in patch 15 that allows to write bitmap indexes for already-existing packfiles.

I'd love your feedback on the design and implementation of this feature. I deem it
rather stable, as we've been testing it on production on the world's largest Git
host (Git Hub Dot Com The Web Site) with good results, so I'd love it to have it
upstreamed on Core Git.

Strawberry kisses,
vmg

Jeff King (1):
  list-objects: mark tree as unparsed when we free its buffer

Vicent Marti (15):
  sha1_file: refactor into `find_pack_object_pos`
  pack-objects: use a faster hash table
  pack-objects: make `pack_name_hash` global
  revision: allow setting custom limiter function
  sha1_file: export `git_open_noatime`
  compat: add endinanness helpers
  ewah: compressed bitmap implementation
  documentation: add documentation for the bitmap format
  pack-objects: use bitmaps when packing objects
  rev-list: add bitmap mode to speed up lists
  pack-objects: implement bitmap writing
  repack: consider bitmaps when performing repacks
  sha1_file: implement `nth_packed_object_info`
  write-bitmap: implement new git command to write bitmaps
  rev-list: Optimize --count using bitmaps too

 Documentation/technical/bitmap-format.txt |  235 ++++++++
 Makefile                                  |   11 +
 builtin.h                                 |    1 +
 builtin/pack-objects.c                    |  362 +++++++-----
 builtin/pack-objects.h                    |   33 ++
 builtin/rev-list.c                        |   35 +-
 builtin/write-bitmap.c                    |  256 +++++++++
 cache.h                                   |    5 +
 ewah/bitmap.c                             |  229 ++++++++
 ewah/ewah_bitmap.c                        |  703 ++++++++++++++++++++++++
 ewah/ewah_io.c                            |  199 +++++++
 ewah/ewah_rlw.c                           |  124 +++++
 ewah/ewok.h                               |  194 +++++++
 ewah/ewok_rlw.h                           |  114 ++++
 git-compat-util.h                         |   28 +
 git-repack.sh                             |   10 +-
 git.c                                     |    1 +
 khash.h                                   |  329 +++++++++++
 list-objects.c                            |    1 +
 pack-bitmap-write.c                       |  520 ++++++++++++++++++
 pack-bitmap.c                             |  855 +++++++++++++++++++++++++++++
 pack-bitmap.h                             |   64 +++
 pack-write.c                              |    2 +
 revision.c                                |    5 +
 revision.h                                |    2 +
 sha1_file.c                               |   57 +-
 26 files changed, 4212 insertions(+), 163 deletions(-)
 create mode 100644 Documentation/technical/bitmap-format.txt
 create mode 100644 builtin/pack-objects.h
 create mode 100644 builtin/write-bitmap.c
 create mode 100644 ewah/bitmap.c
 create mode 100644 ewah/ewah_bitmap.c
 create mode 100644 ewah/ewah_io.c
 create mode 100644 ewah/ewah_rlw.c
 create mode 100644 ewah/ewok.h
 create mode 100644 ewah/ewok_rlw.h
 create mode 100644 khash.h
 create mode 100644 pack-bitmap-write.c
 create mode 100644 pack-bitmap.c
 create mode 100644 pack-bitmap.h

-- 
1.7.9.5
