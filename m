From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] dir_struct: add collect_ignored option
Date: Mon, 11 Jun 2007 09:39:50 -0400
Message-ID: <20070611133950.GB7008@coredump.intra.peff.net>
References: <20070611123045.GA28814@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 15:40:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxk7l-0006x6-AP
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 15:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbXFKNjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 09:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbXFKNjx
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 09:39:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2595 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643AbXFKNjw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 09:39:52 -0400
Received: (qmail 2537 invoked from network); 11 Jun 2007 13:40:04 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Jun 2007 13:40:04 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2007 09:39:50 -0400
Content-Disposition: inline
In-Reply-To: <20070611123045.GA28814@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49850>

When set, this option will cause read_directory to keep
track of which entries were ignored. While this shouldn't
effect functionality in most cases, it can make warning
messages to the user much more useful.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c |   12 ++++++++++++
 dir.h |    5 ++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index e810258..1ffc1e5 100644
--- a/dir.c
+++ b/dir.c
@@ -291,6 +291,15 @@ struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int
 	return dir->entries[dir->nr++] = dir_entry_new(pathname, len);
 }
 
+struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
+{
+	if(cache_name_pos(pathname, len) >= 0)
+		return NULL;
+
+	alloc_grow(dir->ignored, dir->ignored_nr, dir->ignored_alloc);
+	return dir->ignored[dir->ignored_nr++] = dir_entry_new(pathname, len);
+}
+
 enum exist_status {
 	index_nonexistent = 0,
 	index_directory,
@@ -463,6 +472,8 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 				continue;
 
 			exclude = excluded(dir, fullname);
+			if (exclude && dir->collect_ignored)
+				dir_add_ignored(dir, fullname, baselen + len);
 			if (exclude != dir->show_ignored) {
 				if (!dir->show_ignored || DTYPE(de) != DT_DIR) {
 					continue;
@@ -609,6 +620,7 @@ int read_directory(struct dir_struct *dir, const char *path, const char *base, i
 	read_directory_recursive(dir, path, base, baselen, 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
+	qsort(dir->ignored, dir->ignored_nr, sizeof(*dir->ignored), cmp_name);
 	return dir->nr;
 }
 
diff --git a/dir.h b/dir.h
index 172147f..c94f3cb 100644
--- a/dir.h
+++ b/dir.h
@@ -31,11 +31,14 @@ struct exclude_list {
 
 struct dir_struct {
 	int nr, alloc;
+	int ignored_nr, ignored_alloc;
 	unsigned int show_ignored:1,
 		     show_other_directories:1,
 		     hide_empty_directories:1,
-		     no_gitlinks:1;
+		     no_gitlinks:1,
+		     collect_ignored:1;
 	struct dir_entry **entries;
+	struct dir_entry **ignored;
 
 	/* Exclude info */
 	const char *exclude_per_dir;
-- 
1.5.2.1.958.gbaa74-dirty
