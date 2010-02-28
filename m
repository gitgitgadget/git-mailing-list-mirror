From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] sha1_name: fix segfault caused by invalid index access
Date: Sun, 28 Feb 2010 16:49:15 +0100
Message-ID: <1267372155-7578-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 16:49:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NllOc-0001Hy-2t
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 16:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968729Ab0B1PtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 10:49:14 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:54075 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968717Ab0B1PtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 10:49:14 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id AA4A315097EC8;
	Sun, 28 Feb 2010 16:48:58 +0100 (CET)
Received: from [91.19.18.251] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1NllO3-0004ng-00; Sun, 28 Feb 2010 16:48:56 +0100
X-Mailer: git-send-email 1.7.0.97.g2d6a2
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX183DTuPIktGHrI+7Yv5dE/02r3rJkvsbeEhCwYB
	KWyMk2trDRntNju/h9Z9MGbP3zmibUMTJuuizJFw+6v4npWz1X
	xfuNtRDdS83VwsBoHtUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141253>

It can be reproduced in a bare repository with
    $ git show :anyfile

I didn't find a recipe for reliably reproducing it in a repository with
working tree, it happened depending on the filename and the repository.
    $ git show :nonexistentfile

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

It seemed to happen more likely with high letters (x, y, z) as the first
character of the filename. This always worked for me:
    $ git show :z
But I found this to be too strange to be added to the commit message.

The affected code path was introduced by commit 009fee477 (Detailed diagnosis
when parsing an object name fails., 2009-12-07).

 sha1_name.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 43884c6..bf92417 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -992,13 +992,15 @@ static void diagnose_invalid_index_path(int stage,
 	pos = cache_name_pos(filename, namelen);
 	if (pos < 0)
 		pos = -pos - 1;
-	ce = active_cache[pos];
-	if (ce_namelen(ce) == namelen &&
-	    !memcmp(ce->name, filename, namelen))
-		die("Path '%s' is in the index, but not at stage %d.\n"
-		    "Did you mean ':%d:%s'?",
-		    filename, stage,
-		    ce_stage(ce), filename);
+	if (pos < active_nr) {
+		ce = active_cache[pos];
+		if (ce_namelen(ce) == namelen &&
+		    !memcmp(ce->name, filename, namelen))
+			die("Path '%s' is in the index, but not at stage %d.\n"
+			    "Did you mean ':%d:%s'?",
+			    filename, stage,
+			    ce_stage(ce), filename);
+	}
 
 	/* Confusion between relative and absolute filenames? */
 	fullnamelen = namelen + strlen(prefix);
@@ -1008,13 +1010,15 @@ static void diagnose_invalid_index_path(int stage,
 	pos = cache_name_pos(fullname, fullnamelen);
 	if (pos < 0)
 		pos = -pos - 1;
-	ce = active_cache[pos];
-	if (ce_namelen(ce) == fullnamelen &&
-	    !memcmp(ce->name, fullname, fullnamelen))
-		die("Path '%s' is in the index, but not '%s'.\n"
-		    "Did you mean ':%d:%s'?",
-		    fullname, filename,
-		    ce_stage(ce), fullname);
+	if (pos < active_nr) {
+		ce = active_cache[pos];
+		if (ce_namelen(ce) == fullnamelen &&
+		    !memcmp(ce->name, fullname, fullnamelen))
+			die("Path '%s' is in the index, but not '%s'.\n"
+			    "Did you mean ':%d:%s'?",
+			    fullname, filename,
+			    ce_stage(ce), fullname);
+	}
 
 	if (!lstat(filename, &st))
 		die("Path '%s' exists on disk, but not in the index.", filename);
-- 
1.7.0.97.g2d6a2
