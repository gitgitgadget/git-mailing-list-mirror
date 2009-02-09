From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v4 0/9] git checkout: more cleanups, optimisation,
 less lstat() calls
Date: Mon, 09 Feb 2009 21:54:03 +0100
Message-ID: <cover.1234211594.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 21:55:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdAQ-0002Ax-88
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 21:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbZBIUyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 15:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854AbZBIUyQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 15:54:16 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:36097 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbZBIUyP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 15:54:15 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KET00IDOGQDPR80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:13 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.166])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KET007FSGQC8090@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:13 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109120>

Changes since v3

-- patch 4/9 ---
 - use memcpy() instead of memmove()

-- patch 9/9 ---
 - NOTE/NB: this patch is only a debug patch, not be included in the
   final GIT release version.

OK, sorry that it took a while, but I was investigating why it seems
that patch 1/9 increases the user time.  As it is hard to get the
exact same test results on each run (I guess that "racy git" has
something to say in this case), I think that I should let it go, and
if necessary post a patch later on.

I have not done anything with patch 7/9, since Johannes Sixt wrote:

   "In the case of this patch, the timestamp is queried via the handle
    that made the change, and in this case special case the timestamp
    could be correct nevertheless. The guarantee doesn't cover this
    case, but it would be natural, and perhaps it Just Works?"

So, I let it be up to Johannes to decide if there should be an
"#ifndef FSTAT_UNRELIABLE" test around the fstat() usage inside patch
7/9.


Kjetil Barvik (9):
  lstat_cache(): small cleanup and optimisation
  lstat_cache(): generalise longest_match_lstat_cache()
  lstat_cache(): swap func(length, string) into func(string, length)
  unlink_entry(): introduce schedule_dir_for_removal()
  create_directories(): remove some memcpy() and strchr() calls
  write_entry(): cleanup of some duplicated code
  write_entry(): use fstat() instead of lstat() when file is open
  show_patch_diff(): remove a call to fstat()
  lstat_cache(): print a warning if doing ping-pong between cache types

 Documentation/CodingGuidelines |    3 +
 builtin-add.c                  |    2 +-
 builtin-apply.c                |    2 +-
 builtin-update-index.c         |    2 +-
 cache.h                        |   10 ++-
 combine-diff.c                 |    4 +-
 diff-lib.c                     |    2 +-
 dir.c                          |    2 +-
 entry.c                        |  108 ++++++++++++-------------
 symlinks.c                     |  176 ++++++++++++++++++++++++++++++----------
 unpack-trees.c                 |   34 ++------
 11 files changed, 207 insertions(+), 138 deletions(-)
