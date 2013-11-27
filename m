From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 00/24] Index-v5
Date: Wed, 27 Nov 2013 13:00:35 +0100
Message-ID: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:01:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldoA-0001ag-4I
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab3K0MBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:01:24 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:33330 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab3K0MBX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:01:23 -0500
Received: by mail-la0-f44.google.com with SMTP id ep20so5252733lab.31
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=C8pwKkZQs/i2sLOq3fUJ2+7Rs2iVn7Rk3yEgjH/bodw=;
        b=Fk+xamwQdhpztNBPOxJ+82+TSzP7+IZhoLoykeyJevQtqvne+o3C/0A7C7IbMkxvNv
         btU5ud/ByQdIy3nyLAZCrO41P06Jb9X9DMmTzkw9QJVYi5QFDmLP2C4baw7dxHK678Gw
         AlqDLhM/uAzAGJxk3qBSHYt6yJO7yLFSg6NCVjx0QrVLY7l4WgQR7ZYsWBmjkt14IfPZ
         GYAQI4j4ZVW0nkEDdKjiqvuCE5pekxkEwKbxQ1PplFpOEhBwbn2WNswQZNRn8udBlDN6
         jj8wB98z+sZgIw1VCtzLor45ylhnhHL+I7Q705jDlEE+4/Fl0GSWII9gdcAGdc7zncRI
         qhLg==
X-Received: by 10.152.2.197 with SMTP id 5mr6880648law.17.1385553681327;
        Wed, 27 Nov 2013 04:01:21 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id iy7sm26797524lbc.4.2013.11.27.04.01.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:01:19 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238414>

Hi,

previous rounds (without api) are at $gmane/202752, $gmane/202923,
$gmane/203088 and $gmane/203517, the previous rounds with api were at
$gmane/229732, $gmane/230210 and $gmane/232488.  Thanks to Duy for
reviewing the the last round and Junio, Ramsay and Eric for additional
comments.

Since the last round I've added a POC for partial writing, resulting
in the following performance improvements for update-index:

Test                                        1063432           HEAD
------------------------------------------------------------------------------------
0003.2: v[23]: update-index                 0.60(0.38+0.20)   0.76(0.36+0.17) +26.7%
0003.3: v[23]: grep nonexistent -- subdir   0.28(0.17+0.11)   0.28(0.18+0.09) +0.0%
0003.4: v[23]: ls-files -- subdir           0.26(0.15+0.10)   0.24(0.14+0.09) -7.7%
0003.7: v[23] update-index                  0.59(0.36+0.22)   0.58(0.36+0.20) -1.7%
0003.9: v4: update-index                    0.46(0.28+0.17)   0.45(0.30+0.11) -2.2%
0003.10: v4: grep nonexistent -- subdir     0.26(0.14+0.11)   0.21(0.14+0.07) -19.2%
0003.11: v4: ls-files -- subdir             0.24(0.14+0.10)   0.20(0.12+0.08) -16.7%
0003.14: v4 update-index                    0.49(0.31+0.18)   0.65(0.34+0.17) +32.7%
0003.16: v5: update-index                   0.53(0.30+0.22)   0.50(0.28+0.20) -5.7%
0003.17: v5: ls-files                       0.27(0.15+0.12)   0.27(0.17+0.10) +0.0%
0003.18: v5: grep nonexistent -- subdir     0.02(0.01+0.01)   0.03(0.01+0.01) +50.0%
0003.19: v5: ls-files -- subdir             0.02(0.00+0.02)   0.02(0.01+0.01) +0.0%
0003.22: v5 update-index                    0.53(0.29+0.23)   0.02(0.01+0.01) -96.2%

Given this, I don't think a complete change of the in-core format for
the cache-entries is necessary to take full advantage of the new index
file format.  Instead some changes to the current in-core format would
work well with the new on-disk format.

The current in-memory format fits the internal needs of git fairly well,
so I don't think changing it to fit a better index file format would
make a lot of sense, given that we can take advantage of the new format
with the existing in-memory format.

This series doesn't use kb/fast-hashmap yet, but that should be fairly
simple to change if the series is deemed a good change.  The
performance tests for update-index test require
tg/perf-lib-test-perf-cleanup. 

Other changes, made following the review comments are:

documentation: add documentation of the index-v5 file format
  - Update documentation that directory flags are now 32-bits.  That
    makes aligned access simpler
  - offset_to_offset is no longer included in the checksum for files.
    It's unnecessary.

read-cache: read index-v5
  - Add fix for reading with different level pathspecs given
  - Use init_directory_entry to initialize all fields in a new
    directory entry
  - use memset to simplify the create_new_conflict function
  - Add comments to explain -5 when reading directories and files
  - Add comments for the more complex functions
  - Add name flex_array to the end of ondisk_directory_entry for
    simplified reading
  - Add name flex_array to the end of ondisk_cache_entry for
    simplified reading
  - Move conflict reading functions to next patch
  - mark functions as static when they are

read-cache: read resolve-undo data
  - Add comments for the more complex function
  - Read conflicts + resolve undo data as extension

read-cache: read cache-tree in index-v5
  - Add comments for the more complex function
  - Instead of sorting the directory entries, sort the cache-tree
    directly.  This also required changing the algorithms with which
    the cache entries are extracted from the directory tree.

read-cache: write index-v5
  - Free pointers allocated by super_directory
  - Rewrite condition as suggested by Duy
  - Don't check for CE_REMOVE'd entries in the writing code, they are
    already checked in the compile_directory_data code
  - Remove overly complicated directory size calculation since flags
    are now 32-bits

read-cache: write resolve-undo data for index-v5
  - Free pointers allocated by super_directory
  - Write conflicts + resolve undo data as extension

introduce GIT_INDEX_VERSION environment variable
  - Add documentation for GIT_INDEX_VERSION

test-lib: allow setting the index format version

Removed commits:
  - read-cache: don't check uid, gid, ino
  - read-cache: use fixed width integer types (independently in pu)
  - read-cache: clear version in discard_index()

Typos fixed as suggested by Eric Sunshine

Thomas Gummerer (22):
  read-cache: split index file version specific functionality
  read-cache: move index v2 specific functions to their own file
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
  t1600: add index v5 specific tests
  POC for partial writing
  perf: add partial writing test

Thomas Rast (1):
  p0003-index.sh: add perf test for the index formats

 Documentation/git.txt                            |    5 +
 Documentation/technical/api-in-core-index.txt    |   56 +-
 Documentation/technical/index-file-format-v5.txt |  294 +++++
 Makefile                                         |   10 +
 builtin/apply.c                                  |    2 +
 builtin/grep.c                                   |   69 +-
 builtin/ls-files.c                               |   36 +-
 builtin/update-index.c                           |   50 +-
 cache-tree.c                                     |   15 +-
 cache-tree.h                                     |    2 +
 cache.h                                          |  115 +-
 lockfile.c                                       |    2 +-
 read-cache-v2.c                                  |  561 +++++++++
 read-cache-v5.c                                  | 1406 ++++++++++++++++++++++
 read-cache.c                                     |  691 +++--------
 read-cache.h                                     |   67 ++
 resolve-undo.c                                   |    1 +
 t/perf/p0003-index.sh                            |   74 ++
 t/t1600-index-v5.sh                              |   25 +
 t/t2101-update-index-reupdate.sh                 |   12 +-
 t/test-lib-functions.sh                          |    5 +
 t/test-lib.sh                                    |    3 +
 test-index-version.c                             |    6 +
 unpack-trees.c                                   |    3 +-
 24 files changed, 2921 insertions(+), 589 deletions(-)
 create mode 100644 Documentation/technical/index-file-format-v5.txt
 create mode 100644 read-cache-v2.c
 create mode 100644 read-cache-v5.c
 create mode 100644 read-cache.h
 create mode 100755 t/perf/p0003-index.sh
 create mode 100755 t/t1600-index-v5.sh

-- 
1.8.4.2
