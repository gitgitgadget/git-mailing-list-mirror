From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix http-fetch
Date: Sat, 29 Jul 2006 02:10:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607290208580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jul 29 02:10:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6cPK-00070k-MU
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 02:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbWG2AKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 20:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbWG2AKK
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 20:10:10 -0400
Received: from mail.gmx.net ([213.165.64.21]:38022 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752058AbWG2AKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 20:10:09 -0400
Received: (qmail invoked by alias); 29 Jul 2006 00:10:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 29 Jul 2006 02:10:08 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24405>


With the latest changes in fetch.c, http-fetch crashed accessing 
write_ref[i], where write_ref was NULL.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fetch.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch.c b/fetch.c
index 2151c7b..aeb6bf2 100644
--- a/fetch.c
+++ b/fetch.c
@@ -245,7 +245,7 @@ void pull_targets_free(int targets, char
 {
 	while (targets--) {
 		free(target[targets]);
-		if (write_ref[targets])
+		if (write_ref && write_ref[targets])
 			free((char *) write_ref[targets]);
 	}
 }
@@ -263,7 +263,7 @@ int pull(int targets, char **target, con
 	track_object_refs = 0;
 
 	for (i = 0; i < targets; i++) {
-		if (!write_ref[i])
+		if (!write_ref || !write_ref[i])
 			continue;
 
 		lock[i] = lock_ref_sha1(write_ref[i], NULL, 0);
@@ -295,7 +295,7 @@ int pull(int targets, char **target, con
 		msg = NULL;
 	}
 	for (i = 0; i < targets; i++) {
-		if (!write_ref[i])
+		if (!write_ref || !write_ref[i])
 			continue;
 		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
 		lock[i] = NULL;
-- 
1.4.2.rc2.g0d86-dirty
