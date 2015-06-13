From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 00/10] object_id part 2
Date: Sat, 13 Jun 2015 22:16:33 +0000
Message-ID: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 00:17:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3tjs-0002tS-HI
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 00:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbbFMWQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 18:16:57 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:42849 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751135AbbFMWQu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 18:16:50 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2CFD52808F;
	Sat, 13 Jun 2015 22:16:48 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
X-Spam-Score: -1 ALL_TRUSTED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271592>

This is another series of conversions to struct object_id.

This series converts more of the refs code and struct object to use
struct object_id.  It introduces an additional helper function,
has_object_file, which is the equivalent of has_sha1_file.  The name was
chosen to be slightly more logical than has_oid_file, although it can be
changed if desired.

The next-to-last patch in this series is the conversion of struct object
to use struct object_id.  This is a necessarily large patch because of
the large number of places this code is used.  That patch will most
likely be too large to make it through to the list, so this series is
available in the object-id-part2 branch from:

https://github.com/bk2204/git.git
https://git.crustytoothpaste.net/git/bmc/git.git

Changes from v1:
* Rebase on newer master.
* Drop parse_oid_hex.  It ended up not being very useful (only 4 uses
  over 47 patches) and a better version, like the one Michael Haggerty
  suggested, can be introduced later if it's beneficial.
* Fix the code that caused the httpd unit tests to fail.  This series
  passes the testsuite on each commit, including the httpd tests.
* Convert the remaining places touched by the first patch to use
  object_id.  These were split out into their own patches to keep
  patches to a reasonable size.  Some of these were in the original
  series, and some were not.
* Convert remote.c as well.  As part of the previous item, I went
  through remote.c and converted the places touched by the first patch,
  and realized that it was trivial to convert the rest of the file.
  This patch is at the end as we can get slightly better conversion by
  doing it after the conversion of struct object, meaning we can avoid
  making another pass later.  I blame Michael for the inspiration to do
  this. :-)

brian m. carlson (10):
  refs: convert some internal functions to use object_id
  sha1_file: introduce has_object_file helper.
  Convert struct ref to use object_id.
  add_sought_entry_mem: convert to struct object_id
  parse_fetch: convert to use struct object_id
  get_remote_heads: convert to struct object_id
  push_refs_with_export: convert to struct object_id
  ref_newer: convert to use struct object_id
  Convert struct object to object_id
  remote: convert functions to struct object_id

 archive.c                |   6 +--
 bisect.c                 |  10 ++--
 branch.c                 |   2 +-
 builtin/blame.c          |  46 +++++++++---------
 builtin/branch.c         |   2 +-
 builtin/checkout.c       |  24 +++++-----
 builtin/clone.c          |  18 +++----
 builtin/commit-tree.c    |   4 +-
 builtin/commit.c         |   8 ++--
 builtin/describe.c       |  20 ++++----
 builtin/diff-tree.c      |  12 ++---
 builtin/diff.c           |  12 ++---
 builtin/fast-export.c    |  34 +++++++-------
 builtin/fetch-pack.c     |  14 +++---
 builtin/fetch.c          |  54 ++++++++++-----------
 builtin/fmt-merge-msg.c  |   6 +--
 builtin/for-each-ref.c   |  12 ++---
 builtin/fsck.c           |  34 +++++++-------
 builtin/grep.c           |   6 +--
 builtin/index-pack.c     |  10 ++--
 builtin/log.c            |  24 +++++-----
 builtin/ls-remote.c      |   2 +-
 builtin/merge-base.c     |   8 ++--
 builtin/merge-tree.c     |   6 +--
 builtin/merge.c          |  60 ++++++++++++------------
 builtin/name-rev.c       |  12 ++---
 builtin/notes.c          |   2 +-
 builtin/pack-objects.c   |  16 +++----
 builtin/receive-pack.c   |   2 +-
 builtin/reflog.c         |   4 +-
 builtin/remote.c         |  12 ++---
 builtin/replace.c        |   2 +-
 builtin/reset.c          |   6 +--
 builtin/rev-list.c       |  18 +++----
 builtin/rev-parse.c      |   4 +-
 builtin/shortlog.c       |   2 +-
 builtin/show-branch.c    |   8 ++--
 builtin/tag.c            |   4 +-
 builtin/unpack-objects.c |  10 ++--
 bundle.c                 |  10 ++--
 cache-tree.c             |   2 +-
 cache.h                  |   3 ++
 combine-diff.c           |   4 +-
 commit.c                 |  32 ++++++-------
 connect.c                |  22 +++++----
 decorate.c               |   2 +-
 diff-lib.c               |   2 +-
 fetch-pack.c             |  24 +++++-----
 fsck.c                   |  10 ++--
 http-backend.c           |   2 +-
 http-push.c              |  88 +++++++++++++++++-----------------
 http.c                   |   2 +-
 line-log.c               |   6 +--
 list-objects.c           |   4 +-
 log-tree.c               |  32 ++++++-------
 merge-blobs.c            |   4 +-
 merge-recursive.c        |  22 ++++-----
 merge.c                  |   2 +-
 notes-merge.c            |  24 +++++-----
 object.c                 |   8 ++--
 object.h                 |   2 +-
 pack-bitmap-write.c      |  16 +++----
 pack-bitmap.c            |  34 +++++++-------
 patch-ids.c              |   6 +--
 pretty.c                 |  18 +++----
 refs.c                   | 106 ++++++++++++++++++++---------------------
 remote-curl.c            |  20 ++++----
 remote.c                 | 120 +++++++++++++++++++++++------------------------
 remote.h                 |   8 ++--
 revision.c               |  48 +++++++++----------
 send-pack.c              |  16 +++----
 sequencer.c              |  38 +++++++--------
 server-info.c            |   2 +-
 sha1_file.c              |   5 ++
 sha1_name.c              |  20 ++++----
 shallow.c                |   6 +--
 submodule.c              |   8 ++--
 tag.c                    |  10 ++--
 test-match-trees.c       |   2 +-
 transport-helper.c       |  24 +++++-----
 transport.c              |  32 ++++++-------
 transport.h              |   8 ++--
 tree.c                   |  10 ++--
 upload-pack.c            |  26 +++++-----
 walker.c                 |  18 +++----
 wt-status.c              |   2 +-
 86 files changed, 729 insertions(+), 717 deletions(-)

-- 
2.4.0
