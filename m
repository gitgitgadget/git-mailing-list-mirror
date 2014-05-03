From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [RFC PATCH 0/9] Use a structure for object IDs.
Date: Sat,  3 May 2014 20:12:13 +0000
Message-ID: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 22:12:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WggIp-0005FK-Iy
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 22:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbaECUM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 16:12:28 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47526 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750972AbaECUM1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 16:12:27 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D639D28087
	for <git@vger.kernel.org>; Sat,  3 May 2014 20:12:25 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.rc0
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248054>

This is a preliminary RFC patch series to move all the relevant uses of
unsigned char [20] to struct object_id.  It should not be applied to any
branch yet.

The goal of this series to improve type-checking in the codebase and to
make it easier to move to a different hash function if the project
decides to do that.  This series does not convert all of the codebase,
but only parts.  I'm looking for feedback to see if there is consensus
that this is the right direction before investing a large amount of
time.

Certain parts of the code have to be converted before others to keep the
patch sizes small, maintainable, and bisectable, so functions and
structures that are used across the codebase (e.g. hashcmp and struct
object) will be converted later.  Conversion has been done in a roughly
alphabetical order by name of file.

The constants for raw and hex sizes of SHA-1 values are maintained.
These constants are used where the quantity is the size of an SHA-1
value, and sizeof(struct object_id) is used wherever memory is to be
allocated.  This is done to permit the struct to turn into a union later
if multiple hashes are supported.  I left the names at GIT_OID_RAWSZ and
GIT_OID_HEXSZ because that's what libgit2 uses and what Junio seemed to
prefer, but they can be changed later if there's a desire to do that.

I called the structure member "oid" because it was easily grepable and
distinct from the rest of the codebase.  It, too, can be changed if we
decide on a better name.  I specifically did not choose "sha1" since it
looks weird to have "sha1->sha1" and I didn't want to rename lots of
variables.

Comments?

brian m. carlson (9):
  Define a structure for object IDs.
  bisect.c: convert to use struct object_id
  archive.c: convert to use struct object_id
  zip: use GIT_OID_HEXSZ for trailers
  branch.c: convert to use struct object_id
  bulk-checkin.c: convert to use struct object_id
  bundle.c: convert leaf functions to struct object_id
  cache-tree: convert struct cache_tree to use object_id
  diff: convert struct combine_diff_path to object_id

 archive-zip.c          |  4 ++--
 archive.c              | 16 +++++++--------
 archive.h              |  1 +
 bisect.c               | 30 ++++++++++++++--------------
 branch.c               | 16 +++++++--------
 builtin/commit.c       |  2 +-
 builtin/fsck.c         |  4 ++--
 bulk-checkin.c         | 12 +++++------
 bundle.c               | 38 +++++++++++++++++------------------
 cache-tree.c           | 30 ++++++++++++++--------------
 cache-tree.h           |  3 ++-
 combine-diff.c         | 54 +++++++++++++++++++++++++-------------------------
 diff-lib.c             | 10 +++++-----
 diff.h                 |  5 +++--
 merge-recursive.c      |  2 +-
 object.h               | 13 +++++++++++-
 reachable.c            |  2 +-
 sequencer.c            |  2 +-
 test-dump-cache-tree.c |  4 ++--
 19 files changed, 131 insertions(+), 117 deletions(-)

-- 
2.0.0.rc0
