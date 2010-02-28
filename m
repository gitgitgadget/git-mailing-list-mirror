From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] sha1_name: fix segfault caused by invalid index access
Date: Sun, 28 Feb 2010 17:38:42 +0100
Message-ID: <1267375122-13039-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq7hpxl4cp.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 28 17:38:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlmAQ-0004vS-AL
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 17:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414Ab0B1Qit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 11:38:49 -0500
Received: from mx1.imag.fr ([129.88.30.5]:59461 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030382Ab0B1Qis (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 11:38:48 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o1SGa62l028525
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 28 Feb 2010 17:36:06 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NlmAH-0004Kh-I9; Sun, 28 Feb 2010 17:38:45 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NlmAH-0003Oz-H2; Sun, 28 Feb 2010 17:38:45 +0100
X-Mailer: git-send-email 1.7.0.231.g97960.dirty
In-Reply-To: <vpq7hpxl4cp.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 28 Feb 2010 17:36:06 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141257>

009fee477 (Detailed diagnosis when parsing an object name fails,
2009-12-07) introduced some invalid index access, inspired by the code of
get_sha1_with_mode_1, which loops over the index entries having the same
name. In the diagnosis, we just want to find whether one entry with the
name is in the index, which is the case iff cache_name_pos's return value
is positive.

Trying anything complex on negative value is not only useless, but also
buggy here, since pos could end up being greater than active_nr, causing
a segfault in active_cache[pos]. This is always the case in bare
repositories, and happens when calling "git show :inexistant" if
"inexistant" is greater than the last index entry in alphabetical order.

Bug report and initial fix by Markus Heidelberg
<markus.heidelberg@web.de>.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 sha1_name.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 43884c6..fbbe3b4 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -990,15 +990,13 @@ static void diagnose_invalid_index_path(int stage,
 
 	/* Wrong stage number? */
 	pos = cache_name_pos(filename, namelen);
-	if (pos < 0)
-		pos = -pos - 1;
-	ce = active_cache[pos];
-	if (ce_namelen(ce) == namelen &&
-	    !memcmp(ce->name, filename, namelen))
+	if (pos >= 0) {
+		ce = active_cache[pos];
 		die("Path '%s' is in the index, but not at stage %d.\n"
 		    "Did you mean ':%d:%s'?",
 		    filename, stage,
 		    ce_stage(ce), filename);
+	}
 
 	/* Confusion between relative and absolute filenames? */
 	fullnamelen = namelen + strlen(prefix);
@@ -1006,15 +1004,13 @@ static void diagnose_invalid_index_path(int stage,
 	strcpy(fullname, prefix);
 	strcat(fullname, filename);
 	pos = cache_name_pos(fullname, fullnamelen);
-	if (pos < 0)
-		pos = -pos - 1;
-	ce = active_cache[pos];
-	if (ce_namelen(ce) == fullnamelen &&
-	    !memcmp(ce->name, fullname, fullnamelen))
+	if (pos >= 0) {
+		ce = active_cache[pos];
 		die("Path '%s' is in the index, but not '%s'.\n"
 		    "Did you mean ':%d:%s'?",
 		    fullname, filename,
 		    ce_stage(ce), fullname);
+	}
 
 	if (!lstat(filename, &st))
 		die("Path '%s' exists on disk, but not in the index.", filename);
-- 
1.7.0.231.g97960.dirty
