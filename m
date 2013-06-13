From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] reset: trivial refactoring
Date: Thu, 13 Jun 2013 13:15:05 -0500
Message-ID: <1371147305-20771-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 13 20:17:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnC58-0007Jz-Ji
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758872Ab3FMSRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:17:04 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:45245 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758869Ab3FMSRB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:17:01 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so15286728obc.37
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 11:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=NqOaiIM85JX9bWeN1Eep4X7N+lj4IYp5Z5hoC8qtP1k=;
        b=OWGcSlbxJYBo1oj4xG0N12wh4wbcKEumLFGDIct9Cxv/WBmG9muWd+9Mr4a/7MypPR
         uE0H9fpNmkHlUgDIIwDLOPSFWzJ3zcxwNk6hnM1DKFwlUulcmr61yiK8M2m2mYQk5yIt
         ztX3FmFIssXrhFP0m3JUJaeHIdQ6raQhUTQP/8P6y8eb81jn5ss4EDAJZvSyieURBm2b
         PIUHIDpWmVKeXHcZ+qecx+WvED73VT9soDlsByGnrlcNsZ9xdoWUIolKlz6P3YKOgJue
         IUzYL1WKXPkOPm4sn3sS52DtDwx5St/l509s7hzI0OHMEKDmU6n8+az46Qmx+unTN4sr
         +MuQ==
X-Received: by 10.182.74.131 with SMTP id t3mr1593298obv.87.1371147421317;
        Thu, 13 Jun 2013 11:17:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id r4sm40585321oem.3.2013.06.13.11.16.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 11:17:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227762>

After commit 3fde386 (reset [--mixed]: use diff-based reset whether or
not pathspec was given), some code can't be reached, and other code can
be moved to the 'reset_type == MIXED' check.

Let's remove the check that can't be reached, and move the code is
specific to MIXED.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/reset.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 6032131..68739ba 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -82,7 +82,7 @@ static int reset_index(const unsigned char *sha1, int reset_type, int quiet)
 	if (unpack_trees(nr, desc, &opts))
 		return -1;
 
-	if (reset_type == MIXED || reset_type == HARD) {
+	if (reset_type == HARD) {
 		tree = parse_tree_indirect(sha1);
 		prime_cache_tree(&active_cache_tree, tree);
 	}
@@ -323,8 +323,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		int newfd = hold_locked_index(lock, 1);
 		if (reset_type == MIXED) {
+			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(pathspec, sha1))
 				return 1;
+			refresh_index(&the_index, flags, NULL, NULL,
+				      _("Unstaged changes after reset:"));
 		} else {
 			int err = reset_index(sha1, reset_type, quiet);
 			if (reset_type == KEEP && !err)
@@ -333,12 +336,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				die(_("Could not reset index file to revision '%s'."), rev);
 		}
 
-		if (reset_type == MIXED) { /* Report what has not been updated. */
-			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
-			refresh_index(&the_index, flags, NULL, NULL,
-				      _("Unstaged changes after reset:"));
-		}
-
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(lock))
 			die(_("Could not write new index file."));
-- 
1.8.3.698.g079b096
