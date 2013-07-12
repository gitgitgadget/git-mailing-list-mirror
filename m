From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 00/19] Index-v5
Date: Fri, 12 Jul 2013 19:26:45 +0200
Message-ID: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:27:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh7o-0002WU-CQ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105Ab3GLR1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:27:16 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:64417 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab3GLR1P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:27:15 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so9223966pbc.16
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=acbCcjyPPbL+Z8B/+166FovUEvdt1/kcSX6SLeCCgoM=;
        b=0nZmSXjTR7qonaDRjYnhC+GYQQhAK44yydO/WbSv/IqDDnjfsRMCtbTZMwcW/LVPSy
         EaNhBT6/wI4JtEeGPgfCubQdKl9qw7rGp1WSEt1s60hCxEyDfRjHkEm4pKtWNAB1qwSq
         svra8/sN1H9ZtYIxyG5tBi0p5z0YLNn2OiLjvGSyyuh/CKp9CQWWSYumaYnRbuO+EQcd
         Mftk8jtAbQv+Z4zV75/161kFKbTGIWtWzbHRb7YficAIjqjJ6AupgmEXJa8Irqxr0Nlz
         eF/VkSCnrYWpSy7uzUd6h6riWSGrpF5FoORfvHtc8VQnQ+tDEukGq7YpThztp0wNYmZI
         l6Sw==
X-Received: by 10.68.164.33 with SMTP id yn1mr43195808pbb.71.1373650035026;
        Fri, 12 Jul 2013 10:27:15 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id jf4sm46407957pbb.19.2013.07.12.10.27.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:27:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230210>

Hi,

previous rounds (without api) are at $gmane/202752, $gmane/202923,
$gmane/203088 and $gmane/203517, the previous round with api was at
$gmane/229732.  Thanks to Junio, Duy and Eric for their comments on
the previous round.

Changes since the previous round:

Add documentation for the index reading api (was sent later in the
previous series as 5.5/22).

read-cache: add index reading api

  - Remove the next_ce pointer, and use index_state->cache[] as part
    of the api, making a few functions unnecessary (next_index_entry,
    get_index_entry_by_name, sort_index). Those were removed.

  - Replace const char **pathspec with const struct pathspec

  - remove the index_change_filter_opts function.  For better
    performance the caller should make up its mind before reading
    anything which part of the index file should be read.  Changing
    the filter_opts later makes us read part of the index again, which
    is sub-optimal.

  - set the filter_opts to NULL when discarding the cache.

  - discussed and didn't change: replacing the pathspec with
    tree_entry_interesting doesn't work well.  Using common_prefix()
    to calculate the adjusted_pathspec would work, but has some
    disadvantages when glob is used in the pathspec.

make sure partially read index is not changed

  - instead of using the index_change_filter_opts function to set the
    filter_opts to NULL before changing the index, die() when the
    caller tries that.  

  - use filter_opts to check if the index was partially read instead
    of an extra flag.

  - die() when trying to re-read a partially read index.

patches (6,7,8,9,12/22) were removed, as they are no longer needed
when keeping index_state->cache[] as part of the api.

ls-files: use index api

  - only use the new api for loading the filtered index, but don't use
    the for_each_index_entry function, as it would need to change the
    filter_opts after reading the index.  That will be made obsolete
    by a series that Duy has cooking [1], after which the loops can be
    switched out by using for_each_index_entry.

Other than that, the typos found by Eric were fixed.

[1] http://thread.gmane.org/gmane.comp.version-control.git/229732/focus=230023

Thomas Gummerer (18):
  t2104: Don't fail for index versions other than [23]
  read-cache: split index file version specific functionality
  read-cache: move index v2 specific functions to their own file
  read-cache: Re-read index if index file changed
  Add documentation for the index api
  read-cache: add index reading api
  make sure partially read index is not changed
  grep.c: Use index api
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

Thomas Rast (1):
  p0003-index.sh: add perf test for the index formats

 Documentation/technical/api-in-core-index.txt    |   54 +-
 Documentation/technical/index-file-format-v5.txt |  296 +++++
 Makefile                                         |    3 +
 builtin/grep.c                                   |   71 +-
 builtin/ls-files.c                               |   31 +-
 builtin/update-index.c                           |    8 +-
 cache-tree.c                                     |    2 +-
 cache-tree.h                                     |    6 +
 cache.h                                          |  140 +-
 read-cache-v2.c                                  |  589 +++++++++
 read-cache-v5.c                                  | 1516 ++++++++++++++++++++++
 read-cache.c                                     |  676 +++-------
 read-cache.h                                     |   65 +
 t/perf/p0003-index.sh                            |   59 +
 t/t2104-update-index-skip-worktree.sh            |    1 +
 test-index-version.c                             |    7 +-
 16 files changed, 2942 insertions(+), 582 deletions(-)
 create mode 100644 Documentation/technical/index-file-format-v5.txt
 create mode 100644 read-cache-v2.c
 create mode 100644 read-cache-v5.c
 create mode 100644 read-cache.h
 create mode 100755 t/perf/p0003-index.sh

-- 
1.8.3.453.g1dfc63d
