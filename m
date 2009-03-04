From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH 1/2] stat_tracking_info(): only count real commits
Date: Wed, 04 Mar 2009 18:47:39 +0100
Message-ID: <6f183d66558114720e5f193ed028eba53727b330.1236187259.git.barvik@broadpark.no>
References: <cover.1236187259.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 18:49:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LevDV-0000US-NO
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 18:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbZCDRrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 12:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753673AbZCDRrq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 12:47:46 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:44530 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbZCDRro (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 12:47:44 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFZ00CFFTFHM710@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Mar 2009 18:47:41 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.182])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KFZ00BZKTFGLP50@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Mar 2009 18:47:41 +0100 (CET)
X-Mailer: git-send-email 1.6.1.GIT
In-reply-to: <cover.1236187259.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112230>

stat_tracking_info() in remote.c is used to collect the statistics to
be able to say (for instance) from the output of "git checkout':

  Your branch and 'foo' have diverged,
  and have X and Y different commit(s) each, respectively.

Currently X and Y also includes the count of merges.  This patch
excludes the merges from being counted.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---

  I hope this is a correct fix, and that it is realy a bugfix.

  ~~

  By the way, I have noticed that when the Y number above is large
  (for instance for a branch I have where Y is ~ 600), then the
  function get_merge_bases_many() and in particular merge_bases_many()
  in commit.c will take a noticable amount of user time (aprox 0.4
  seconds).  So if the chekcout results in that few files need to be
  updated (< 10), this will sometimes acount for much of the total
  time needed for the 'git checkout' command.

  It seems that even though only max 4000 or so unique commits is
  touched (when Y ~ 600), each commit is touched over 250 times, for
  instancce by the insert_by_date() function inside the while-loop in
  merge_bases_many().

  Do someone think it is possible to have a better algorithm here?
  Maybe O(Nlog(n)) or better?  Does someone has a hint about how to
  make it better?


 remote.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index d7079c6..06c414e 100644
--- a/remote.c
+++ b/remote.c
@@ -1310,9 +1310,10 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	if (theirs == ours)
 		return 0;
 
-	/* Run "rev-list --left-right ours...theirs" internally... */
+	/* Run "rev-list --no-merges --left-right ours...theirs" internally... */
 	rev_argc = 0;
 	rev_argv[rev_argc++] = NULL;
+	rev_argv[rev_argc++] = "--no-merges";
 	rev_argv[rev_argc++] = "--left-right";
 	rev_argv[rev_argc++] = symmetric;
 	rev_argv[rev_argc++] = "--";
-- 
1.6.1.GIT
