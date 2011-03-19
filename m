From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 2/9] vcs-svn: avoid using ls command twice
Date: Sat, 19 Mar 2011 18:03:44 +1100
Message-ID: <1300518231-20008-3-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:12:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qKr-0004lS-IX
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479Ab1CSHMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:12:24 -0400
Received: from [119.15.97.146] ([119.15.97.146]:55249 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752629Ab1CSHMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:12:12 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Mar 2011 03:12:11 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 1154FC056;
	Sat, 19 Mar 2011 18:00:31 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id llpijuZiB68d; Sat, 19 Mar 2011 18:00:28 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 10998C04C;
	Sat, 19 Mar 2011 18:00:28 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169388>

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/repo_tree.c |   24 ++++--------------------
 vcs-svn/repo_tree.h |    3 +--
 vcs-svn/svndump.c   |    3 +--
 3 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index f2466bc..67d27f0 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -8,39 +8,23 @@
 #include "repo_tree.h"
 #include "fast_export.h"
 
-const char *repo_read_path(const char *path)
+const char *repo_read_path(const char *path, uint32_t *mode_out)
 {
 	int err;
-	uint32_t dummy;
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	err = fast_export_ls(path, &dummy, &buf);
+	err = fast_export_ls(path, mode_out, &buf);
 	if (err) {
 		if (errno != ENOENT)
 			die_errno("BUG: unexpected fast_export_ls error");
+		/* Treat missing paths as directories. */
+		*mode_out = REPO_MODE_DIR;
 		return NULL;
 	}
 	return buf.buf;
 }
 
-uint32_t repo_read_mode(const char *path)
-{
-	int err;
-	uint32_t result;
-	static struct strbuf dummy = STRBUF_INIT;
-
-	strbuf_reset(&dummy);
-	err = fast_export_ls(path, &result, &dummy);
-	if (err) {
-		if (errno != ENOENT)
-			die_errno("BUG: unexpected fast_export_ls error");
-		/* Treat missing paths as directories. */
-		return REPO_MODE_DIR;
-	}
-	return result;
-}
-
 void repo_copy(uint32_t revision, const char *src, const char *dst)
 {
 	int err;
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index af2415c..eb003e6 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -11,8 +11,7 @@
 uint32_t next_blob_mark(void);
 void repo_copy(uint32_t revision, const char *src, const char *dst);
 void repo_add(const char *path, uint32_t mode, uint32_t blob_mark);
-const char *repo_read_path(const char *path);
-uint32_t repo_read_mode(const char *path);
+const char *repo_read_path(const char *path, uint32_t *mode_out);
 void repo_delete(const char *path);
 void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
 		 uint32_t url, long unsigned timestamp);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index afdfc63..15b173e 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -236,8 +236,7 @@ static void handle_node(void)
 		old_data = NULL;
 	} else if (node_ctx.action == NODEACT_CHANGE) {
 		uint32_t mode;
-		old_data = repo_read_path(node_ctx.dst.buf);
-		mode = repo_read_mode(node_ctx.dst.buf);
+		old_data = repo_read_path(node_ctx.dst.buf, &mode);
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
 			die("invalid dump: cannot modify a directory into a file");
 		if (mode != REPO_MODE_DIR && type == REPO_MODE_DIR)
-- 
1.7.3.2.846.gf4b062
