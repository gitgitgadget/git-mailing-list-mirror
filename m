From: Christian Thaeter <ct@pipapo.org>
Subject: [PATCH 3/5] provide a reset_packed_git() function
Date: Mon,  7 Jan 2008 06:47:33 +0100
Message-ID: <1199684855-14246-3-git-send-email-ct@pipapo.org>
References: <1199684855-14246-1-git-send-email-ct@pipapo.org>
 <1199684855-14246-2-git-send-email-ct@pipapo.org>
Cc: gitster@pobox.com, Christian Thaeter <ct@pipapo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 06:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBkqJ-0006Yg-Tw
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 06:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbYAGFrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 00:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbYAGFro
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 00:47:44 -0500
Received: from pipapo.org ([217.140.77.75]:1100 "EHLO mail.pipapo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755211AbYAGFrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 00:47:41 -0500
Received: from localhost (mercur.pipapo.org [10.20.70.10])
	by mail.pipapo.org (Postfix) with SMTP id 1B0A834F5C00C;
	Mon,  7 Jan 2008 06:47:39 +0100 (CET)
Received: by localhost (sSMTP sendmail emulation); Mon, 07 Jan 2008 06:47:38 +0100
X-Mailer: git-send-email 1.5.3.7
In-Reply-To: <1199684855-14246-2-git-send-email-ct@pipapo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69765>

this frees packs and pack-windows allocated by former operations and
reset some variables to let prepare_packed_git() reinit the packs on the
next call.

find_pack_entry() uses a static pointer to cache the last_found pack
which will be reseted too.

Signed-off-by: Christian Thaeter <ct@pipapo.org>
---
 sha1_file.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6583797..139d5a2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -418,6 +418,7 @@ static unsigned int pack_open_windows;
 static size_t peak_pack_mapped;
 static size_t pack_mapped;
 struct packed_git *packed_git;
+static struct packed_git *last_found_packed_git = (void *)1;
 
 void pack_report(void)
 {
@@ -969,6 +970,22 @@ void reprepare_packed_git(void)
 	prepare_packed_git();
 }
 
+void reset_packed_git(void)
+{
+	/* certainly not the best way to release all windows, but should work for now */
+	while (unuse_one_window(NULL, -1))
+		; /* nothing */
+
+	while (packed_git) {
+		struct packed_git* p = packed_git;
+		packed_git = packed_git->next;
+		free(p);
+	}
+
+	last_found_packed_git = (void *)1;
+	prepare_packed_git_run_once = 0;
+}
+
 int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size, const char *type)
 {
 	unsigned char real_sha1[20];
@@ -1705,14 +1722,13 @@ int matches_pack_name(struct packed_git *p, const char *name)
 
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
 {
-	static struct packed_git *last_found = (void *)1;
 	struct packed_git *p;
 	off_t offset;
 
 	prepare_packed_git();
 	if (!packed_git)
 		return 0;
-	p = (last_found == (void *)1) ? packed_git : last_found;
+	p = (last_found_packed_git == (void *)1) ? packed_git : last_found_packed_git;
 
 	do {
 		if (ignore_packed) {
@@ -1741,16 +1757,16 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, cons
 			e->offset = offset;
 			e->p = p;
 			hashcpy(e->sha1, sha1);
-			last_found = p;
+			last_found_packed_git = p;
 			return 1;
 		}
 
 		next:
-		if (p == last_found)
+		if (p == last_found_packed_git)
 			p = packed_git;
 		else
 			p = p->next;
-		if (p == last_found)
+		if (p == last_found_packed_git)
 			p = p->next;
 	} while (p);
 	return 0;
-- 
1.5.3.7
