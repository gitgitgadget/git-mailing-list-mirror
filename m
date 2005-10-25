From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/4] create_symref: if symlink fails, fall back to writing
 a "symbolic ref"
Date: Wed, 26 Oct 2005 01:40:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510260139250.30576@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 26 01:42:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUYPD-00055r-8s
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 01:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVJYXkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 19:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVJYXkc
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 19:40:32 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:15251 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932482AbVJYXkc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 19:40:32 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 474F213F0D4; Wed, 26 Oct 2005 01:40:31 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2BE199ABB1; Wed, 26 Oct 2005 01:40:31 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 158F39AB5F; Wed, 26 Oct 2005 01:40:31 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 063E613F0D4; Wed, 26 Oct 2005 01:40:31 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10636>

There are filesystems out there which do not understand symlinks, even if 
the OS is perfectly capable of writing them. So, do not fail right away, 
but try to write a symbolic ref first. If that fails, you can die().

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 refs.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

applies-to: ccd3f478f6bdf8174f7d5d24d54434e66fa9068e
2e920b7169ad9661385ba02412cdbdc4e69e00a1
diff --git a/refs.c b/refs.c
index 97506a4..8b544e0 100644
--- a/refs.c
+++ b/refs.c
@@ -116,14 +116,16 @@ const char *resolve_ref(const char *path
 
 int create_symref(const char *git_HEAD, const char *refs_heads_master)
 {
-#if USE_SYMLINK_HEAD
-	unlink(git_HEAD);
-	return symlink(refs_heads_master, git_HEAD);
-#else
 	const char *lockpath;
 	char ref[1000];
 	int fd, len, written;
 
+#if USE_SYMLINK_HEAD
+	unlink(git_HEAD);
+	if (!symlink(refs_heads_master, git_HEAD))
+		return 0;
+#endif
+
 	len = snprintf(ref, sizeof(ref), "ref: %s\n", refs_heads_master);
 	if (sizeof(ref) <= len) {
 		error("refname too long: %s", refs_heads_master);
@@ -144,7 +146,6 @@ int create_symref(const char *git_HEAD, 
 		return -3;
 	}
 	return 0;
-#endif
 }
 
 int read_ref(const char *filename, unsigned char *sha1)
---
0.99.8.GIT
