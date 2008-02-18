From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/5] Teach resolve_gitlink_ref() about the .git file
Date: Mon, 18 Feb 2008 11:44:21 +0100
Message-ID: <1203331463-13857-4-git-send-email-hjemli@gmail.com>
References: <1203331463-13857-1-git-send-email-hjemli@gmail.com>
 <1203331463-13857-2-git-send-email-hjemli@gmail.com>
 <1203331463-13857-3-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 11:47:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR3WZ-0003zj-QD
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 11:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbYBRKq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 05:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755610AbYBRKq1
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 05:46:27 -0500
Received: from mail45.e.nsc.no ([193.213.115.45]:52797 "EHLO mail45.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbYBRKq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 05:46:26 -0500
Received: from localhost.localdomain (ti231210a341-0179.bb.online.no [88.88.168.179])
	by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id m1IAjYWL026988;
	Mon, 18 Feb 2008 11:45:37 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.g3ea1f5
In-Reply-To: <1203331463-13857-3-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74260>

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
