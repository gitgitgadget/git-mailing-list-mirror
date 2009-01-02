From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [TOY PATCH] diffcore-rename: replace basename_same() heuristics by
 levenshtein
Date: Fri, 2 Jan 2009 19:07:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021301560.27818@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 19:08:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIoS7-0002Vo-0V
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758767AbZABSHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758742AbZABSHe
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:07:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:50434 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758689AbZABSHa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:07:30 -0500
Received: (qmail invoked by alias); 02 Jan 2009 18:07:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 02 Jan 2009 19:07:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jI7YWigwjN4KAQ1gPKcfx/QP3VqKAYDMgb6LQZO
	kThxr5vmOu+uXQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104391>


When the environment variable GIT_USE_LEVENSHTEIN is set, the rename
score is reduced by the Damerau-Levenshtein distance.  This should
lead to a little more intuitive rename scores.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I have this in my personal tree, but I did not really use it.
	Maybe others want to play with it.

 diffcore-rename.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 168a95b..1f4b371 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "hash.h"
+#include "levenshtein.h"
 
 /* Table of rename/copy destinations */
 
@@ -187,7 +188,9 @@ static int estimate_similarity(struct diff_filespec *src,
 	if (!dst->size)
 		score = 0; /* should not happen */
 	else
-		score = (int)(src_copied * MAX_SCORE / max_size);
+		score = (int)(src_copied * MAX_SCORE / max_size)
+			- (getenv("GIT_USE_LEVENSHTEIN") ?
+			   levenshtein(src->path, dst->path, 1, 1, 1, 1) : 0);
 	return score;
 }
 
-- 
1.6.1.rc3.224.g95ac9
