From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v10 0/5] git checkout: optimise away lots of lstat() calls
Date: Sun, 18 Jan 2009 16:14:49 +0100
Message-ID: <1232291694-18083-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 16:16:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZNu-00060X-H0
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763032AbZARPO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762419AbZARPO6
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:14:58 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:56566 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759681AbZARPO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:14:57 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDO00A8EACVIU70@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 18 Jan 2009 16:14:55 +0100 (CET)
Received: from localhost.localdomain ([80.203.29.59])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDO00BSIACUNG70@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 18 Jan 2009 16:14:55 +0100 (CET)
X-Mailer: git-send-email 1.6.1.83.gd727f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106217>

Changes since version 9

--- patch 1/5 ---
bug fix (missed optimisation):
If we have track_flags = FL_SYMLINK|FL_DIR, and:

     cache  =>   A/B/C/D/S   (a symlink)
     name   =>   A/B/C       (a directory)

The cache would return with a (cached) FL_DIR result as expected,
_but_ it would set the cache to "A/B/C", so we lose some information.

--- patch 4/5 ---
bug fix: if we get a match from the cache for the name to invalidate,
we reset the cache if we are not allowed to track directories (inside
the invalidate_lstat_cache() function).


Kjetil Barvik (5):
  lstat_cache(): more cache effective symlink/directory detection
  lstat_cache(): introduce has_symlink_or_noent_leading_path() function
  lstat_cache(): introduce has_dirs_only_path() function
  lstat_cache(): introduce invalidate_lstat_cache() function
  lstat_cache(): introduce clear_lstat_cache() function

 cache.h        |    4 +
 entry.c        |   34 +++-----
 symlinks.c     |  263 ++++++++++++++++++++++++++++++++++++++++++++++---------
 unpack-trees.c |    4 +-
 4 files changed, 238 insertions(+), 67 deletions(-)
