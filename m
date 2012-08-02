From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC 0/16] Introduce index file format version 5
Date: Thu,  2 Aug 2012 13:01:50 +0200
Message-ID: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:03:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtBD-00050c-KR
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542Ab2HBLCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:02:54 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40752 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab2HBLCx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:02:53 -0400
Received: by eeil10 with SMTP id l10so2331137eei.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=aeM4HjHu1p+SA6014CRdxF/KFUt/bEbxFezQPO3Qq04=;
        b=CegygS3OHzzy40MBLacxJ3YNDFN9CdjGkq03ftuACYM9UBH84YBUcWhkN1uQjZyKpo
         Th+HwI0Av9/f9hwtF2DshQAzBJMP7/kIg2aZkPhzY63trg9Tv8vKfvDDIA0hhV4h+yLW
         fYFKh+DvysP311uDiE0RXyX1XDojAm/fYkq0CzJeD9MfLIgPleOW21MR1leVaAcAxSof
         KzQnQFGXnB5iFNDow+5TN1YYApwFQQ2pd8+y4VUFoxeVkXIPHL9NqMmVOb4EqvgVqrwy
         fAyuAneBGL4/5K0SZnrLweqhdCmiAQn3+jmVQhnO1PgEz69QENYx8apNxzUIDCmVtgCp
         dsmg==
Received: by 10.14.211.132 with SMTP id w4mr26014485eeo.39.1343905371974;
        Thu, 02 Aug 2012 04:02:51 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id v5sm16441101eel.6.2012.08.02.04.02.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:02:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202752>

Series of patches to introduce the index version 5 file format. This
series does not include any fancy stuff like partial loading or partial
writing yet, though it's possible to do that with the new format.

There was already a POC for partial loading, which gave pretty good
results, which was however broken in all but the general case, so it's
not included yet. (for timings see: http://thread.gmane.org/gmane.comp.version-control.git/201964/focus=202019)

The first 4 patches are refactoring the old code, splitting it up into
different functions, as a preparation for index-v5.

Patches 5 and 6 fix testcases for index v5.

Patch 9..11 introduce the reader for index-v5. I've split those
patches up to read the main index first, then the resolve-undo
data and then the cache-tree, to make it easier to review them.

The same goes for patches 12..14, which introduce the writer, again
split up in writing the main index, resolve-undo data and cache-tree
data.

Patch 15 adds a option to update index to force-rewrite the index,
so rewriting it even if nothing has changed. This is later used
for performance testing, to test the performance for both the reader and
the writer.

Patch 16 adds the performance test, which compares the time for
force-rewrites for index-v[23], index-v4 and index-v5.

The default index format is still set to 3, it can be changed in
read-cache.c (INDEX_FORMAT_DEFAULT)

[PATCH 01/16] Modify cache_header to prepare for other index formats
[PATCH 02/16] Modify read functions to prepare for other index
[PATCH 03/16] Modify match_stat_basic to prepare for other index
[PATCH 04/16] Modify write functions to prepare for other index
[PATCH 05/16] t2104: Don't fail when index version is 5
[PATCH 06/16] t3700: sleep for 1 second, to avoid interfering with
[PATCH 07/16] Add documentation of the index-v5 file format
[PATCH 08/16] Make in-memory format aware of stat_crc
[PATCH 09/16] Read index-v5
[PATCH 10/16] Read resolve-undo data
[PATCH 11/16] Read cache-tree in index-v5
[PATCH 12/16] Write index-v5
[PATCH 13/16] Write index-v5 cache-tree data
[PATCH 14/16] Write resolve-undo data for index-v5
[PATCH 15/16] update-index.c: add a force-rewrite option
[PATCH 16/16] p0002-index.sh: add perf test for the index formats

Documentation/technical/index-file-format-v5.txt |  281 ++++++++++++++++++++++++++++++++++
builtin/update-index.c                           |    5 +-
cache-tree.c                                     |  145 ++++++++++++++++++
cache-tree.h                                     |    7 +
cache.h                                          |   96 +++++++++++-
read-cache.c                                     | 1519 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
resolve-undo.c                                   |  129 ++++++++++++++++
resolve-undo.h                                   |    3 +
t/perf/p0002-index.sh                            |   33 ++++
t/t2104-update-index-skip-worktree.sh            |   15 +-
t/t3700-add.sh                                   |    1 +
test-index-version.c                             |    2 +-
12 files changed, 2082 insertions(+), 154 deletions(-)
