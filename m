From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 12/22] simplify write_cache() calling sequence
Date: Mon, 12 Sep 2005 10:56:09 -0400
Message-ID: <20050912145609.28120.67621.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:00:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjo-0000SG-03
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVILO4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVILO4b
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:31 -0400
Received: from citi.umich.edu ([141.211.133.111]:16396 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751300AbVILO4K (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:10 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id A30AF1BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:09 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8395>

Clean-up:  Hide some external references to "active_cache" and "active_nr"
by simplifying the calling sequence of write_cache().

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 apply.c          |    3 +--
 cache.h          |    2 +-
 checkout-index.c |    3 +--
 read-cache.c     |   41 +++++++++++++++++++++++++++--------------
 read-tree.c      |    3 +--
 update-index.c   |    3 +--
 6 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -1440,8 +1440,7 @@ static int apply_patch(int fd)
 		write_out_results(list, skipped_patch);
 
 	if (write_index) {
-		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_index_file(&cache_file))
+		if (write_cache(newfd) || commit_index_file(&cache_file))
 			die("Unable to write new cachefile");
 	}
 
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -157,7 +157,7 @@ extern char *prefix_path(const char *pre
 
 /* Initialize and use the cache information */
 extern int read_cache(void);
-extern int write_cache(int newfd, struct cache_entry **cache, int entries);
+extern int write_cache(int newfd);
 extern int cache_name_pos(const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
diff --git a/checkout-index.c b/checkout-index.c
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -138,8 +138,7 @@ int main(int argc, char **argv)
 	}
 
 	if (0 <= newfd &&
-	    (write_cache(newfd, active_cache, active_nr) ||
-	     commit_index_file(&cache_file)))
+	    (write_cache(newfd) || commit_index_file(&cache_file)))
 		die("Unable to write new cachefile");
 	return 0;
 }
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -470,30 +470,43 @@ static int ce_flush(SHA_CTX *context, in
 	return 0;
 }
 
-int write_cache(int newfd, struct cache_entry **cache, int entries)
+static int fd, removed = 0;
+static SHA_CTX c;
+
+static int count_removed(struct cache_cursor *cc, struct cache_entry *ce)
+{
+	if (ce->ce_mode == 0)
+		removed++;
+	next_cc(cc);
+	return 0;
+}
+
+static int write_one_cache_entry(struct cache_cursor *cc, struct cache_entry *ce)
+{
+	if (ce->ce_mode != 0)
+		if (ce_write(&c, fd, ce, ce_size(ce)) < 0)
+			return -1;
+	next_cc(cc);
+	return 0;
+}
+
+int write_cache(int newfd)
 {
-	SHA_CTX c;
 	struct cache_header hdr;
-	int i, removed;
 
-	for (i = removed = 0; i < entries; i++)
-		if (!cache[i]->ce_mode)
-			removed++;
+	walk_cache(count_removed);
 
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
 	hdr.hdr_version = htonl(2);
-	hdr.hdr_entries = htonl(entries - removed);
+	hdr.hdr_entries = htonl(active_nr - removed);
 
 	SHA1_Init(&c);
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
-	for (i = 0; i < entries; i++) {
-		struct cache_entry *ce = cache[i];
-		if (!ce->ce_mode)
-			continue;
-		if (ce_write(&c, newfd, ce, ce_size(ce)) < 0)
-			return -1;
-	}
+	fd = newfd;
+	if (walk_cache(write_one_cache_entry))
+		return -1;
+
 	return ce_flush(&c, newfd);
 }
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -670,8 +670,7 @@ int main(int argc, char **argv)
 	}
 
 	unpack_trees(fn);
-	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_index_file(&cache_file))
+	if (write_cache(newfd) || commit_index_file(&cache_file))
 		die("unable to write new index file");
 	return 0;
 }
diff --git a/update-index.c b/update-index.c
--- a/update-index.c
+++ b/update-index.c
@@ -393,8 +393,7 @@ int main(int argc, char **argv)
 		if (add_file_to_cache(path))
 			die("Unable to add %s to database; maybe you want to use --add option?", path);
 	}
-	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_index_file(&cache_file))
+	if (write_cache(newfd) || commit_index_file(&cache_file))
 		die("Unable to write new cachefile");
 
 	return has_errors ? 1 : 0;
