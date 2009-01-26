From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v1 4/6] use fstat() instead of lstat() when we have an
 opened file
Date: Mon, 26 Jan 2009 22:17:15 +0100
Message-ID: <1233004637-15112-5-git-send-email-barvik@broadpark.no>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 22:19:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYrG-0000UB-G6
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbZAZVRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbZAZVRb
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:17:31 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:62238 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbZAZVR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:17:28 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE3003TYKH1XC90@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:17:25 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.144])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KE3001KZKGTUNC0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:17:25 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107283>

Currently inside write_entry() we do an lstat(path, &st) call on a
file which have just been opened inside the exact same function.  It
should be better to call fstat(fd, &st) on the file while it is
opened, and it should be at least as fast as the lstat() method.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 entry.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/entry.c b/entry.c
index 8543755..c932ae8 100644
--- a/entry.c
+++ b/entry.c
@@ -96,11 +96,12 @@ write_entry(struct cache_entry *ce, char *path, const struct checkout *state,
 	    int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
-	int fd, ret;
+	int fd, ret, fstat_done = 0;
 	char *new;
 	struct strbuf buf = STRBUF_INIT;
 	unsigned long size;
 	size_t wrote, newsize = 0;
+	struct stat st;
 
 	switch (ce_mode_s_ifmt) {
 	case S_IFREG:
@@ -151,6 +152,10 @@ write_entry(struct cache_entry *ce, char *path, const struct checkout *state,
 		}
 
 		wrote = write_in_full(fd, new, size);
+		if (state->refresh_cache) {
+			fstat(fd, &st);
+			fstat_done = 1;
+		}
 		close(fd);
 		free(new);
 		if (wrote != size)
@@ -174,8 +179,8 @@ write_entry(struct cache_entry *ce, char *path, const struct checkout *state,
 	}
 
 	if (state->refresh_cache) {
-		struct stat st;
-		lstat(ce->name, &st);
+		if (!fstat_done)
+			lstat(ce->name, &st);
 		fill_stat_cache_info(ce, &st);
 	}
 	return 0;
-- 
1.6.1.349.g99fa5
