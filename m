From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 00/24] Index-v5
Date: Sun, 18 Aug 2013 21:41:49 +0200
Message-ID: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8xP-0003Yv-Aj
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab3HRTsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:05 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:50684 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab3HRTsD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:03 -0400
Received: by mail-wg0-f42.google.com with SMTP id j13so2609794wgh.1
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=WUNyt9olmUIkdkOyszDTxn5sZtS+FkuV3il3VnZRvfo=;
        b=BdWIfw+C+n7ixbIS+aXram78t6ZkF0L4v0AacPyA98/IQnXqtqKxkm9R8KIAKViM0P
         t0cbO3FXn6pA3kvxyKA0+mA+6H+EY5vetKYpLOsMMKVvfo/qi+kraSm2H0dWMw3Q2CFl
         L6zjqyFBrQ8f24PVzb/Yb4fsUtKTrQ7ZQ7Op+SZ7NudSbOoIynklVltOltUGCQJ2jLDO
         NsRM2ZCuW0vQbGCgTBFkY++m6f/tLqzbwWWr9s/xQsnzx8CnlJgNom564JmfHxd5DEsa
         cyN3Jqcve8HWv1iS/DX2z0EdLCuBEiNM3aguz8GLbjtjZyilBUvVTxNbb7zePTjVvI8b
         amzQ==
X-Received: by 10.180.160.240 with SMTP id xn16mr5493006wib.62.1376855281787;
        Sun, 18 Aug 2013 12:48:01 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id fz8sm11971954wic.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232488>

Hi,

previous rounds (without api) are at $gmane/202752, $gmane/202923,
$gmane/203088 and $gmane/203517, the previous rounds with api were at
$gmane/229732 and $gmane/230210.  Thanks to Duy for reviewing the the
last round and Junio and Ramsay for additional comments.

Changes since the previous round:

read-cache: move index v2 specific functions to their own file
  - set istate->ops to NULL in discard_index

read-cache: add index reading api
  - style fixes
  - instead of using internal_ops struct, do for_each_index_entry in
    read-cache.c

grep.c: use index api
  - remove duplicate call to match_pathspec_depth

ls-files.c: use index api
  - load the whole index if there is a trai

documentation: add documentation of the index-v5 file format
  - fix typo
  - change the position of nfile and ndir in the index file
  - document that the conflicts are also stored in the fileentries
    block
  - document invalid flag

read-cache: read index-v5
  - restrict partial loading a bit more, by being more careful when
    adjusting the pathspec
  - move the ondisk structs from cache.h to read-cache-v5.c
  - merge for and while loop in read_entries
  - keep a directory tree instead of a flat list when reading the
    directories
  - ce_queue_push moved to read-cache: write index-v5 using a next_ce
    pointer instead of the next pointer that's already used by
    name-hash.
  - fix reading if there are extensions that are not yet supported
  - ignore entries that have the invalid flag set

read-cache: read cache-tree in index-v5
  - use the tree structure which is now used in read index-v5

read-cache: write index-v5
  - simplify compile_directory_data

changes to the index file format:
  - store the number of files before the number of directories in the
    header, so that the file command still can recognize the number of
    files in the repository correctly.
  - store all staged entries in the fileentries block. Doesn't hurt
    the performance a lot but simplifies the code.
  - add an invalid flag for entries that should be ignored.  currently
    unused but respected when reading.  will be used once the conflict
    resolution is done by flipping a bit in the conflict entries at the
    end of the index.
  
added commits:
  - read-cache: use fixed width integer types
  - read-cache: clear version in discard_index()
  - read-cache: Don't compare uid, gid and ino on cygwin
  - introduce GIT_INDEX_VERSION environment variable
  - test-lib: allow setting the index format version

Thomas Gummerer (23):
  t2104: Don't fail for index versions other than [23]
  read-cache: use fixed width integer types
  read-cache: split index file version specific functionality
  read-cache: clear version in discard_index()
  read-cache: move index v2 specific functions to their own file
  read-cache: Don't compare uid, gid and ino on cygwin
  read-cache: Re-read index if index file changed
  add documentation for the index api
  read-cache: add index reading api
  make sure partially read index is not changed
  grep.c: use index api
  ls-files.c: use index api
  documentation: add documentation of the index-v5 file format
  read-cache: make in-memory format aware of stat_crc
  read-cache: read index-v5
  read-cache: read resolve-undo data
  read-cache: read cache-tree in index-v5
  read-cache: write index-v5
  read-cache: write index-v5 cache-tree data
  read-cache: write resolve-undo data for index-v5
  update-index.c: rewrite index when index-version is given
  introduce GIT_INDEX_VERSION environment variable
  test-lib: allow setting the index format version

Thomas Rast (1):
  p0003-index.sh: add perf test for the index formats

 Documentation/technical/api-in-core-index.txt    |   54 +-
 Documentation/technical/index-file-format-v5.txt |  301 +++++
 Makefile                                         |   10 +
 builtin/apply.c                                  |    2 +
 builtin/grep.c                                   |   69 +-
 builtin/ls-files.c                               |   36 +-
 builtin/update-index.c                           |    6 +-
 cache-tree.c                                     |    2 +-
 cache-tree.h                                     |    1 +
 cache.h                                          |   93 +-
 read-cache-v2.c                                  |  550 +++++++++
 read-cache-v5.c                                  | 1417 ++++++++++++++++++++++
 read-cache.c                                     |  685 +++--------
 read-cache.h                                     |   61 +
 t/perf/p0003-index.sh                            |   63 +
 t/t2104-update-index-skip-worktree.sh            |    1 +
 t/test-lib-functions.sh                          |    5 +
 t/test-lib.sh                                    |    3 +
 test-index-version.c                             |    6 +
 unpack-trees.c                                   |    3 +-
 20 files changed, 2786 insertions(+), 582 deletions(-)
 create mode 100644 Documentation/technical/index-file-format-v5.txt
 create mode 100644 read-cache-v2.c
 create mode 100644 read-cache-v5.c
 create mode 100644 read-cache.h
 create mode 100755 t/perf/p0003-index.sh

-- 
1.8.3.4.1231.g9fbf354.dirty
