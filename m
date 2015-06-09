From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/8] object_id part 2
Date: Tue,  9 Jun 2015 16:28:28 +0000
Message-ID: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:29:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2MPM-0001p9-6L
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 18:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbbFIQ3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 12:29:38 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:38323 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753418AbbFIQ3S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 12:29:18 -0400
Received: from vauxhall.crustytoothpaste.net (107-1-110-101-ip-static.hfc.comcastbusiness.net [107.1.110.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A49B02808F;
	Tue,  9 Jun 2015 16:29:11 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271200>

This is another series of conversions to struct object_id.

This series converts more of the refs code and struct object to use
struct object_id.  It introduces two additional helper functions.  One
is has_object_file, which is the equivalent of has_sha1_file.  The name
was chosen to be slightly more logical than has_oid_file, although it
can be changed if desired.

The second helper function is parse_oid_hex.  It works much like
get_oid_hex, but it takes an optional length argument and returns the
number of bytes parsed on success (40) and 0 on error.  It's designed to
be more useful in conditionals and to enable us to avoid having to write
GIT_SHA1_HEXSZ in favor of simply using the return value.

The final piece in this series is the conversion of struct object to use
struct object_id.  This is a necessarily large patch because of the
large number of places this code is used.

brian m. carlson (8):
  refs: convert some internal functions to use object_id
  sha1_file: introduce has_object_file helper.
  Convert struct ref to use object_id.
  Add a utility function to make parsing hex values easier.
  add_sought_entry_mem: convert to struct object_id
  parse_fetch: convert to use struct object_id
  ref_newer: convert to use struct object_id
  Convert struct object to object_id

 archive.c                |   6 +--
 bisect.c                 |  10 ++---
 branch.c                 |   2 +-
 builtin/blame.c          |  46 ++++++++++----------
 builtin/branch.c         |   2 +-
 builtin/checkout.c       |  24 +++++------
 builtin/clone.c          |  18 ++++----
 builtin/commit-tree.c    |   4 +-
 builtin/commit.c         |   8 ++--
 builtin/describe.c       |  20 ++++-----
 builtin/diff-tree.c      |  12 +++---
 builtin/diff.c           |  12 +++---
 builtin/fast-export.c    |  34 +++++++--------
 builtin/fetch-pack.c     |  14 ++++---
 builtin/fetch.c          |  54 ++++++++++++------------
 builtin/fmt-merge-msg.c  |   6 +--
 builtin/for-each-ref.c   |  12 +++---
 builtin/fsck.c           |  34 +++++++--------
 builtin/grep.c           |   6 +--
 builtin/index-pack.c     |  10 ++---
 builtin/log.c            |  24 +++++------
 builtin/ls-remote.c      |   2 +-
 builtin/merge-base.c     |   8 ++--
 builtin/merge-tree.c     |   6 +--
 builtin/merge.c          |  60 +++++++++++++--------------
 builtin/name-rev.c       |  12 +++---
 builtin/notes.c          |   2 +-
 builtin/pack-objects.c   |  16 +++----
 builtin/receive-pack.c   |   2 +-
 builtin/reflog.c         |   4 +-
 builtin/remote.c         |  12 +++---
 builtin/replace.c        |   2 +-
 builtin/reset.c          |   6 +--
 builtin/rev-list.c       |  18 ++++----
 builtin/rev-parse.c      |   4 +-
 builtin/shortlog.c       |   2 +-
 builtin/show-branch.c    |   8 ++--
 builtin/tag.c            |   4 +-
 builtin/unpack-objects.c |  10 ++---
 bundle.c                 |  10 ++---
 cache-tree.c             |   2 +-
 cache.h                  |  12 ++++++
 combine-diff.c           |   4 +-
 commit.c                 |  32 +++++++-------
 connect.c                |   2 +-
 decorate.c               |   2 +-
 diff-lib.c               |   2 +-
 fetch-pack.c             |  24 +++++------
 fsck.c                   |  10 ++---
 hex.c                    |   7 ++++
 http-backend.c           |   2 +-
 http-push.c              |  88 +++++++++++++++++++--------------------
 http.c                   |   2 +-
 line-log.c               |   6 +--
 list-objects.c           |   4 +-
 log-tree.c               |  32 +++++++-------
 merge-blobs.c            |   4 +-
 merge-recursive.c        |  22 +++++-----
 merge.c                  |   2 +-
 notes-merge.c            |  24 +++++------
 object.c                 |   8 ++--
 object.h                 |   2 +-
 pack-bitmap-write.c      |  16 +++----
 pack-bitmap.c            |  34 +++++++--------
 patch-ids.c              |   6 +--
 pretty.c                 |  18 ++++----
 refs.c                   | 106 +++++++++++++++++++++++------------------------
 remote-curl.c            |  21 +++++-----
 remote.c                 |  68 +++++++++++++++---------------
 remote.h                 |   8 ++--
 revision.c               |  48 ++++++++++-----------
 send-pack.c              |  16 +++----
 sequencer.c              |  38 ++++++++---------
 server-info.c            |   2 +-
 sha1_file.c              |   5 +++
 sha1_name.c              |  20 ++++-----
 shallow.c                |   6 +--
 submodule.c              |   8 ++--
 tag.c                    |  10 ++---
 test-match-trees.c       |   2 +-
 transport-helper.c       |  18 ++++----
 transport.c              |  32 +++++++-------
 transport.h              |   8 ++--
 tree.c                   |  10 ++---
 upload-pack.c            |  26 ++++++------
 walker.c                 |  18 ++++----
 wt-status.c              |   2 +-
 87 files changed, 706 insertions(+), 679 deletions(-)

-- 
2.4.0
