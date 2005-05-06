From: Kay Sievers <kay.sievers@vrfy.org>
Subject: [PATCH] fix compare symlink against readlink not data
Date: Fri, 6 May 2005 15:45:01 +0200
Message-ID: <20050506134501.GA11430@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 15:40:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU32k-0007zm-Lm
	for gcvg-git@gmane.org; Fri, 06 May 2005 15:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVEFNpi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 09:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVEFNph
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 09:45:37 -0400
Received: from soundwarez.org ([217.160.171.123]:23241 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261187AbVEFNpF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 09:45:05 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 1399D2E96B; Fri,  6 May 2005 15:45:02 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Fix update-cache to compare the blob of a symlink against the link-target
and not the file it points to. Also ignore all permissions applied to
links.
Thanks to Greg for recognizing this while he added our list of symlinks
back to the udev repository.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---

--- a/diff-files.c
+++ b/diff-files.c
@@ -111,7 +111,7 @@ int main(int argc, char **argv)
 			continue;
 		}
  
-		if (stat(ce->name, &st) < 0) {
+		if (lstat(ce->name, &st) < 0) {
 			if (errno != ENOENT) {
 				perror(ce->name);
 				continue;
--- a/read-cache.c
+++ b/read-cache.c
@@ -16,6 +16,9 @@ int cache_match_stat(struct cache_entry 
 	switch (ntohl(ce->ce_mode) & S_IFMT) {
 	case S_IFREG:
 		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
+		/* We consider only the owner x bit to be relevant for "mode changes" */
+		if (0100 & (ntohl(ce->ce_mode) ^ st->st_mode))
+			changed |= MODE_CHANGED;
 		break;
 	case S_IFLNK:
 		changed |= !S_ISLNK(st->st_mode) ? TYPE_CHANGED : 0;
@@ -43,9 +46,6 @@ int cache_match_stat(struct cache_entry 
 	if (ce->ce_uid != htonl(st->st_uid) ||
 	    ce->ce_gid != htonl(st->st_gid))
 		changed |= OWNER_CHANGED;
-	/* We consider only the owner x bit to be relevant for "mode changes" */
-	if (0100 & (ntohl(ce->ce_mode) ^ st->st_mode))
-		changed |= MODE_CHANGED;
 	if (ce->ce_dev != htonl(st->st_dev) ||
 	    ce->ce_ino != htonl(st->st_ino))
 		changed |= INODE_CHANGED;
--- a/update-cache.c
+++ b/update-cache.c
@@ -64,7 +64,7 @@ static int add_file_to_cache_1(char *pat
 	struct stat st;
 	int fd;
 	unsigned int len;
-	char target[1024];
+	char *target;
 
 	if (lstat(path, &st) < 0) {
 		if (errno == ENOENT || errno == ENOTDIR) {
@@ -90,11 +90,14 @@ static int add_file_to_cache_1(char *pat
 			return -1;
 		break;
 	case S_IFLNK:
-		len = readlink(path, target, sizeof(target));
-		if (len == -1 || len+1 > sizeof(target))
+		target = xmalloc(st.st_size+1);
+		if (readlink(path, target, st.st_size+1) != st.st_size) {
+			free(target);
 			return -1;
-		if (write_sha1_file(target, len, "blob", ce->sha1))
+		}
+		if (write_sha1_file(target, st.st_size, "blob", ce->sha1))
 			return -1;
+		free(target);
 		break;
 	default:
 		return -1;
@@ -163,6 +166,32 @@ static int compare_data(struct cache_ent
 	return match;
 }
 
+static int compare_link(struct cache_entry *ce, unsigned long expected_size)
+{
+	int match = -1;
+	char *target;
+	void *buffer;
+	unsigned long size;
+	char type[10];
+	int len;
+	target = xmalloc(expected_size);
+	len = readlink(ce->name, target, expected_size);
+	if (len != expected_size ) {
+		free(target);
+		return -1;
+	}
+	buffer = read_sha1_file(ce->sha1, type, &size);
+	if (!buffer) {
+		free(target);
+		return -1;
+	}
+	if (size == expected_size)
+		match = memcmp(buffer, target, size);
+	free(buffer);
+	free(target);
+	return match;
+}
+
 /*
  * "refresh" does not calculate a new sha1 file or bring the
  * cache up-to-date for mode/content changes. But what it
@@ -194,8 +223,18 @@ static struct cache_entry *refresh_entry
 	if (changed & (MODE_CHANGED | TYPE_CHANGED))
 		return ERR_PTR(-EINVAL);
 
-	if (compare_data(ce, st.st_size))
+	switch (st.st_mode & S_IFMT) {
+	case S_IFREG:
+		if (compare_data(ce, st.st_size))
+			return ERR_PTR(-EINVAL);
+		break;
+	case S_IFLNK:
+		if (compare_link(ce, st.st_size))
+			return ERR_PTR(-EINVAL);
+		break;
+	default:
 		return ERR_PTR(-EINVAL);
+	}
 
 	cache_changed = 1;
 	size = ce_size(ce);

