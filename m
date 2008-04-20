From: Luciano Rocha <luciano@eurotux.com>
Subject: [PATCH 01/02/RFC] implement a stat cache
Date: Sun, 20 Apr 2008 12:13:46 +0100
Message-ID: <20080420111346.GA13411@bit.office.eurotux.com>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 13:15:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnXVI-0002JQ-Gu
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 13:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbYDTLNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 07:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbYDTLNx
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 07:13:53 -0400
Received: from os.eurotux.com ([216.75.63.6]:43985 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbYDTLNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 07:13:52 -0400
Received: (qmail 7564 invoked from network); 20 Apr 2008 11:13:50 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 20 Apr 2008 11:13:50 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79953>

An implementation of stat(2) and lstat(2) caching. Both the return code
and returned information are cached.

Signed-off-by: Luciano Rocha <strange@nsk.no-ip.org>
---
On Sat, Apr 19, 2008 at 03:39:37PM -0700, Linus Torvalds wrote:
> Yeah. I didn't look any further, but we do a total of *nine* 'lstat()' 
> calls for each file we know about that is dirty, and *seven* when they are 
> clean. Plus maybe a few more.

That's a lot. Why not use a stat cache?

With these changes, my git status . in WebKit changes from 28.215s to
15.414s.

 stat-cache.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 stat-cache.h |    9 +++++++
 2 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 stat-cache.c
 create mode 100644 stat-cache.h

diff --git a/stat-cache.c b/stat-cache.c
new file mode 100644
index 0000000..6a33cec
--- /dev/null
+++ b/stat-cache.c
@@ -0,0 +1,69 @@
+/*
+ * Cache (l)stat operations
+ */
+
+#include "stat-cache.h"
+#include "hash.h"
+#include "path-list.h";
+
+static struct hash_table stat_cache;
+static struct hash_table lstat_cache;
+
+struct stat_result {
+	struct stat st;
+	int ret;
+};
+
+/* based on hash_name from read_cache.c */
+static unsigned int hash_path(const char *path)
+{
+	unsigned int hash = 0x123;
+
+	while (*path)
+		hash = hash*101 + *path++;
+	return hash;
+}
+
+/* cache is HASH->PATH-LIST->(return code, struct stat) */
+static int cached_stat(int (*f)(const char *, struct stat *),
+		struct hash_table *ht, const char *path, struct stat *buf)
+{
+	unsigned int hash;
+	struct path_list *list;
+	struct path_list_item *cached;
+	struct stat_result *result;
+
+	hash = hash_path(path);
+
+	list = lookup_hash(hash, ht);
+
+	if (!list) {
+		list = xcalloc(1, sizeof *list);
+		list->strdup_paths = 1;
+		insert_hash(hash, list, ht);
+	}
+
+	cached = path_list_lookup(path, list);
+
+	if (cached) {
+		result = cached->util;
+	} else {
+		result = xmalloc(sizeof *result);
+		result->ret = f(path, &result->st);
+		path_list_insert(path, list)->util = result;
+	}
+
+	if (result->ret == 0)
+		memcpy(buf, &result->st, sizeof *buf);
+	return result->ret;
+}
+
+int cstat(const char *path, struct stat *buf)
+{
+	return cached_stat(stat, &stat_cache, path, buf);
+}
+
+int clstat(const char *path, struct stat *buf)
+{
+	return cached_stat(lstat, &lstat_cache, path, buf);
+}
diff --git a/stat-cache.h b/stat-cache.h
new file mode 100644
index 0000000..754348f
--- /dev/null
+++ b/stat-cache.h
@@ -0,0 +1,9 @@
+#ifndef STAT_CACHE_H
+#define STAT_CACHE_H
+
+#include "git-compat-util.h"
+
+int cstat(const char *path, struct stat *buf);
+int clstat(const char *path, struct stat *buf);
+
+#endif /* STAT_CACHE_H */
-- 
1.5.5.76.gbb45.dirty
