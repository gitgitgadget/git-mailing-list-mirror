From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v4 7/9] write_entry(): use fstat() instead of lstat() when file
 is open
Date: Mon, 09 Feb 2009 21:54:51 +0100
Message-ID: <989e0b547a09f372d16375ea08397d1115331470.1234211595.git.barvik@broadpark.no>
References: <cover.1234211594.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 21:56:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdB5-0002TR-BY
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 21:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbZBIUzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 15:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbZBIUy7
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 15:54:59 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:36121 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbZBIUy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 15:54:57 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KET00IFGGRJPR80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:55 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.166])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KET007G9GRH8090@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:55 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1234211594.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109126>

Currently inside write_entry() we do an lstat(path, &st) call on a
file which have just been opened inside the exact same function.  It
should be better to call fstat(fd, &st) on the file while it is open,
and it should be at least as fast as the lstat() method.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 entry.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/entry.c b/entry.c
index 1f53588..5daacc2 100644
--- a/entry.c
+++ b/entry.c
@@ -94,11 +94,12 @@ static void *read_blob_entry(struct cache_entry *ce, unsigned long *size)
 static int write_entry(struct cache_entry *ce, char *path, const struct checkout *state, int to_tempfile)
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
@@ -145,6 +146,11 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		}
 
 		wrote = write_in_full(fd, new, size);
+		/* use fstat() only when path == ce->name */
+		if (state->refresh_cache && !to_tempfile && !state->base_dir_len) {
+			fstat(fd, &st);
+			fstat_done = 1;
+		}
 		close(fd);
 		free(new);
 		if (wrote != size)
@@ -161,8 +167,8 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
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
