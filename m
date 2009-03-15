From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH 1/2] checkout bugfix: use stat.mtime instead of stat.ctime in
 two places
Date: Sun, 15 Mar 2009 12:38:55 +0100
Message-ID: <58b7f6028d593d66e4e181b60f85c8c8dd860aac.1237115791.git.barvik@broadpark.no>
References: <cover.1237115791.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 12:40:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Liohk-0001dx-RR
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 12:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbZCOLjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 07:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756018AbZCOLjE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 07:39:04 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:57828 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074AbZCOLjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 07:39:01 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGJ00A7ZPOY1PA0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 15 Mar 2009 12:38:58 +0100 (CET)
Received: from localhost.localdomain ([80.203.106.191])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KGJ001V7POXJX50@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 15 Mar 2009 12:38:58 +0100 (CET)
X-Mailer: git-send-email 1.6.2.GIT
In-reply-to: <cover.1237115791.git.barvik@broadpark.no>
In-reply-to: <cover.1237115791.git.barvik@broadpark.no>
References: <cover.1237115791.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113284>

Commit e1afca4fd "write_index(): update index_state->timestamp after
flushing to disk" on 2009-02-23 used stat.ctime to record the
timestamp of the index-file.  This is wrong, so fix this and use the
correct stat.mtime timestamp instead.

Commit 110c46a909 "Not all systems use st_[cm]tim field for ns
resolution file timestamp" on 2009-03-08, has a similar bug for the
builtin-fetch-pack.c file.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 builtin-fetch-pack.c |    2 +-
 read-cache.c         |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 0b1a356..d571253 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -806,7 +806,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 				die("shallow file was removed during fetch");
 		} else if (st.st_mtime != mtime.sec
 #ifdef USE_NSEC
-				|| ST_CTIME_NSEC(st) != mtime.nsec
+				|| ST_MTIME_NSEC(st) != mtime.nsec
 #endif
 			  )
 			die("shallow file was changed during fetch");
diff --git a/read-cache.c b/read-cache.c
index 7f74c8d..3f58711 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1563,8 +1563,8 @@ int write_index(struct index_state *istate, int newfd)
 
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
-	istate->timestamp.sec = (unsigned int)st.st_ctime;
-	istate->timestamp.nsec = ST_CTIME_NSEC(st);
+	istate->timestamp.sec = (unsigned int)st.st_mtime;
+	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 	return 0;
 }
 
-- 
1.6.2.GIT
