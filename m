From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v7 0/5] git checkout: optimise away lots of lstat() calls
Date: Tue, 13 Jan 2009 13:29:03 +0100
Message-ID: <1231849748-8244-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Pete Harlan <pgit@pcharlan.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 13:30:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMiPm-0007fz-K6
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 13:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758147AbZAMM3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 07:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbZAMM3M
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 07:29:12 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:58253 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080AbZAMM3K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 07:29:10 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDE00147TCLOM10@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 13 Jan 2009 13:29:09 +0100 (CET)
Received: from localhost.localdomain ([84.48.79.194])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDE00L11TCKJ9C0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 13 Jan 2009 13:29:09 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105489>

Changes since version 6:

a) The patch-split was not correct for patch 3/3.  In v6 it could look
   like the lines:

-	char path[PATH_MAX];
+	char path[PATH_MAX + 1];

   was a random bugfix.  In this version for patch 3/5 we also change
   "&& last_slash < PATH_MAX" into "&& last_slash <= PATH_MAX" (and
   similar for the else-if part).  This could also make the intro-
   duction of the 'FL_FULLPATH' flag more readable for this patch.

b) Cleanup and added 3 comments to 'greatest_match_lstat_cache()'

c) Introduction of the 'invalidate_lstat_cache()' function.  How does
   the interface look?  good?  bad?  Does the function do what people
   expect it to do?

d) Reintroduction of the 'clear_lstat_cache()' function.

Junio, I hope it is possible to use patches 1/5, 2/5 and 3/5 from this
version instead of 1/3, 2/3 and 3/3 from version 6, for the possible
future in origin/pu?  See also a) above.  Thanks in advance!

In general, are we allowed to redesign the patch-series while the
patches is inside origin/pu?


Kjetil Barvik (5):
  lstat_cache(): more cache effective symlink/directory detection
  lstat_cache(): introduce has_symlink_or_noent_leading_path() function
  lstat_cache(): introduce has_dirs_only_path() function
  lstat_cache(): introduce invalidate_lstat_cache() function
  lstat_cache(): introduce clear_lstat_cache() function

 cache.h        |    4 +
 entry.c        |   34 +++-----
 symlinks.c     |  249 ++++++++++++++++++++++++++++++++++++++++++++++----------
 unpack-trees.c |    4 +-
 4 files changed, 222 insertions(+), 69 deletions(-)
