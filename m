From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/4] Teach resolve_gitlink_ref() about the .git file
Date: Wed, 20 Feb 2008 23:13:14 +0100
Message-ID: <1203545596-6337-3-git-send-email-hjemli@gmail.com>
References: <1203545596-6337-1-git-send-email-hjemli@gmail.com>
 <1203545596-6337-2-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:15:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRxEE-0006Hc-SW
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbYBTWOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 17:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761984AbYBTWOv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:14:51 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:47159 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765471AbYBTWOu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 17:14:50 -0500
Received: from localhost.localdomain (ti231210a341-0590.bb.online.no [88.88.170.78])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id m1KMEQAK024249;
	Wed, 20 Feb 2008 23:14:28 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.g3ea1f5
In-Reply-To: <1203545596-6337-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74550>

When .git in a submodule is a file, resolve_gitlink_ref() needs to pick up
the real GIT_DIR of the submodule from that file.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 refs.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 67d2a50..56de5cf 100644
--- a/refs.c
+++ b/refs.c
@@ -351,6 +351,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *re
 {
 	int len = strlen(path), retval;
 	char *gitdir;
+	const char *tmp;
 
 	while (len && path[len-1] == '/')
 		len--;
@@ -358,9 +359,19 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *re
 		return -1;
 	gitdir = xmalloc(len + MAXREFLEN + 8);
 	memcpy(gitdir, path, len);
-	memcpy(gitdir + len, "/.git/", 7);
-
-	retval = resolve_gitlink_ref_recursive(gitdir, len+6, refname, result, 0);
+	memcpy(gitdir + len, "/.git", 6);
+	len += 5;
+
+	tmp = read_gitfile_gently(gitdir);
+	if (tmp) {
+		free(gitdir);
+		len = strlen(tmp);
+		gitdir = xmalloc(len + MAXREFLEN + 3);
+		memcpy(gitdir, tmp, len);
+	}
+	gitdir[len] = '/';
+	gitdir[++len] = '\0';
+	retval = resolve_gitlink_ref_recursive(gitdir, len, refname, result, 0);
 	free(gitdir);
 	return retval;
 }
-- 
1.5.4.1.188.g3ea1f5
