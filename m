From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 5/7] move create_symref() past log_ref_write()
Date: Fri, 26 Jan 2007 17:26:09 -0500
Message-ID: <11698503722922-git-send-email-nico@cam.org>
References: <1169850371517-git-send-email-nico@cam.org>
 <11698503712588-git-send-email-nico@cam.org>
 <11698503712998-git-send-email-nico@cam.org>
 <1169850372648-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 23:26:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAZWn-0004YX-5I
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 23:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbXAZW0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 17:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbXAZW0T
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 17:26:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60997 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbXAZW0O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 17:26:14 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCH00AEPYBNA4H0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Jan 2007 17:26:12 -0500 (EST)
In-reply-to: <1169850372648-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.0.rc2.g6e2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37893>

This doesn't change the code at all.  It is done to makes the next patch
more obvious.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 refs.c |   86 ++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/refs.c b/refs.c
index 92fa2e4..f91e853 100644
--- a/refs.c
+++ b/refs.c
@@ -309,49 +309,6 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 	return ref;
 }
 
-int create_symref(const char *ref_target, const char *refs_heads_master)
-{
-	const char *lockpath;
-	char ref[1000];
-	int fd, len, written;
-	const char *git_HEAD = git_path("%s", ref_target);
-
-#ifndef NO_SYMLINK_HEAD
-	if (prefer_symlink_refs) {
-		unlink(git_HEAD);
-		if (!symlink(refs_heads_master, git_HEAD))
-			return 0;
-		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
-	}
-#endif
-
-	len = snprintf(ref, sizeof(ref), "ref: %s\n", refs_heads_master);
-	if (sizeof(ref) <= len) {
-		error("refname too long: %s", refs_heads_master);
-		return -1;
-	}
-	lockpath = mkpath("%s.lock", git_HEAD);
-	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);	
-	written = write_in_full(fd, ref, len);
-	close(fd);
-	if (written != len) {
-		unlink(lockpath);
-		error("Unable to write to %s", lockpath);
-		return -2;
-	}
-	if (rename(lockpath, git_HEAD) < 0) {
-		unlink(lockpath);
-		error("Unable to create %s", git_HEAD);
-		return -3;
-	}
-	if (adjust_shared_perm(git_HEAD)) {
-		unlink(lockpath);
-		error("Unable to fix permissions on %s", lockpath);
-		return -4;
-	}
-	return 0;
-}
-
 int read_ref(const char *ref, unsigned char *sha1)
 {
 	if (resolve_ref(ref, sha1, 1, NULL))
@@ -1022,6 +979,49 @@ int write_ref_sha1(struct ref_lock *lock,
 	return 0;
 }
 
+int create_symref(const char *ref_target, const char *refs_heads_master)
+{
+	const char *lockpath;
+	char ref[1000];
+	int fd, len, written;
+	const char *git_HEAD = git_path("%s", ref_target);
+
+#ifndef NO_SYMLINK_HEAD
+	if (prefer_symlink_refs) {
+		unlink(git_HEAD);
+		if (!symlink(refs_heads_master, git_HEAD))
+			return 0;
+		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
+	}
+#endif
+
+	len = snprintf(ref, sizeof(ref), "ref: %s\n", refs_heads_master);
+	if (sizeof(ref) <= len) {
+		error("refname too long: %s", refs_heads_master);
+		return -1;
+	}
+	lockpath = mkpath("%s.lock", git_HEAD);
+	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);	
+	written = write_in_full(fd, ref, len);
+	close(fd);
+	if (written != len) {
+		unlink(lockpath);
+		error("Unable to write to %s", lockpath);
+		return -2;
+	}
+	if (rename(lockpath, git_HEAD) < 0) {
+		unlink(lockpath);
+		error("Unable to create %s", git_HEAD);
+		return -3;
+	}
+	if (adjust_shared_perm(git_HEAD)) {
+		unlink(lockpath);
+		error("Unable to fix permissions on %s", lockpath);
+		return -4;
+	}
+	return 0;
+}
+
 static char *ref_msg(const char *line, const char *endp)
 {
 	const char *ep;
-- 
1.5.0.rc2.g6e2c
