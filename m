From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: git and symlinks as tracked content
Date: Thu, 5 May 2005 03:20:51 +0200
Message-ID: <20050505012051.GA26201@vrfy.org>
References: <1115145234.21105.111.camel@localhost.localdomain> <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org> <20050504223532.GA22967@vrfy.org> <7vwtqemvjt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 03:15:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTUx1-000085-7U
	for gcvg-git@gmane.org; Thu, 05 May 2005 03:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVEEBVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 21:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVEEBVP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 21:21:15 -0400
Received: from soundwarez.org ([217.160.171.123]:8659 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261446AbVEEBUy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 21:20:54 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 667482CEEE; Thu,  5 May 2005 03:20:51 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtqemvjt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Allow to store and track symlink in the repository. A symlink is stored
the same way as a regular file, but with the appropriate mode bits set.
The symlink target is stored in its own blob object. This will hopefully
make our udev repository fully functional. :)

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---

On Wed, May 04, 2005 at 04:16:22PM -0700, Junio C Hamano wrote:
> It seems to follow the original suggestion by Linus and looks
> good.  Some comments:
>
>  * It continues to assume that S_IFREG, S_IFDIR and S_IFLNK have
>    the same bit pattern everywhere.  In the same spirit as we
>    store mode bits in network byte order, it may be a good time
>    to introduce something like this:
...

>  * read-cache.c:cache_match_stat() needs to know about the
>    object type.  It was allowed to assume that anything thrown
>    at it was a file, but not anymore.  How about something like
>    this:

Both included and updated.

>   * (this is just a minor nit).  Since you have st here,
>     st.st_size can be used to see how big a buffer you need to
>     prepare for readlink() here:

Sounds nice, but is this reliable? I just remember some exotic filesystems
to reported bogus values here.

>   * Probably diff.c needs to be made aware of this change.

You already did this. :) Very nice.

Thanks,
Kay

--- a/cache.h
+++ b/cache.h
@@ -86,8 +86,19 @@ struct cache_entry {
 #define ce_size(ce) cache_entry_size(ce_namelen(ce))
 #define ce_stage(ce) ((CE_STAGEMASK & ntohs((ce)->ce_flags)) >> CE_STAGESHIFT)
 
+#define CE_IFREG  0100000
+#define CE_IFDIR  0040000
+#define CE_IFLNK  0120000
+#define CE_IFMASK 0770000
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
-#define create_ce_mode(mode) htonl(S_IFREG | ce_permissions(mode))
+static inline unsigned int create_ce_mode(unsigned int mode)
+{
+	if (S_ISREG(mode))
+		return htonl(S_IFREG | ce_permissions(mode));
+	if (S_ISLNK(mode))
+		return htonl(CE_IFLNK);
+	return 0;
+}
 
 #define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)
 
@@ -124,6 +135,7 @@ extern int index_fd(unsigned char *sha1,
 #define MODE_CHANGED    0x0008
 #define INODE_CHANGED   0x0010
 #define DATA_CHANGED    0x0020
+#define TYPE_CHANGED    0x0040
 
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *sha1_file_name(const unsigned char *sha1);
--- a/check-files.c
+++ b/check-files.c
@@ -28,8 +28,8 @@ static void check_file(const char *path)
 		die("preparing to update existing file '%s' not in cache", path);
 	ce = active_cache[pos];
 
-	if (fstat(fd, &st) < 0)
-		die("fstat(%s): %s", path, strerror(errno));
+	if (lstat(path, &st) < 0)
+		die("lstat(%s): %s", path, strerror(errno));
 
 	changed = cache_match_stat(ce, &st);
 	if (changed)
--- a/checkout-cache.c
+++ b/checkout-cache.c
@@ -72,23 +72,37 @@ static int write_entry(struct cache_entr
 	unsigned long size;
 	long wrote;
 	char type[20];
+	unsigned int mode;
 
 	new = read_sha1_file(ce->sha1, type, &size);
 	if (!new || strcmp(type, "blob")) {
 		return error("checkout-cache: unable to read sha1 file of %s (%s)",
 			path, sha1_to_hex(ce->sha1));
 	}
-	fd = create_file(path, ntohl(ce->ce_mode));
-	if (fd < 0) {
+	mode = ntohl(ce->ce_mode);
+	if (S_ISLNK(mode)) {
+		char target[1024];
+		memcpy(target, new, size);
+		target[size] = '\0';
+		if (symlink(target, path)) {
+			free(new);
+			return error("checkout-cache: unable to create link %s (%s)",
+				path, strerror(errno));
+		}
+		free(new);
+	} else {
+		fd = create_file(path, mode);
+		if (fd < 0) {
+			free(new);
+			return error("checkout-cache: unable to create file %s (%s)",
+				path, strerror(errno));
+		}
+		wrote = write(fd, new, size);
+		close(fd);
 		free(new);
-		return error("checkout-cache: unable to create %s (%s)",
-			path, strerror(errno));
+		if (wrote != size)
+			return error("checkout-cache: unable to write %s", path);
 	}
-	wrote = write(fd, new, size);
-	close(fd);
-	free(new);
-	if (wrote != size)
-		return error("checkout-cache: unable to write %s", path);
 	return 0;
 }
 
@@ -101,7 +115,7 @@ static int checkout_entry(struct cache_e
 	memcpy(path, base_dir, len);
 	strcpy(path + len, ce->name);
 
-	if (!stat(path, &st)) {
+	if (!lstat(path, &st)) {
 		unsigned changed = cache_match_stat(ce, &st);
 		if (!changed)
 			return 0;
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -24,7 +24,7 @@ static int get_stat_data(struct cache_en
 		static unsigned char no_sha1[20];
 		int changed;
 		struct stat st;
-		if (stat(ce->name, &st) < 0)
+		if (lstat(ce->name, &st) < 0)
 			return -1;
 		changed = cache_match_stat(ce, &st);
 		if (changed) {
--- a/diff.c
+++ b/diff.c
@@ -165,7 +165,7 @@ static void prepare_temp_file(const char
 		}
 		strcpy(temp->hex, sha1_to_hex(null_sha1));
 		sprintf(temp->mode, "%06o",
-			S_IFREG |ce_permissions(st.st_mode));
+			S_IFREG | ce_permissions(st.st_mode));
 	}
 	else {
 		int fd;
--- a/ls-files.c
+++ b/ls-files.c
@@ -199,7 +199,7 @@ static void show_files(void)
 			struct stat st;
 			if (excluded(ce->name) != show_ignored)
 				continue;
-			if (!stat(ce->name, &st))
+			if (!lstat(ce->name, &st))
 				continue;
 			printf("%s%c", ce->name, line_terminator);
 		}
--- a/read-cache.c
+++ b/read-cache.c
@@ -13,6 +13,16 @@ int cache_match_stat(struct cache_entry 
 {
 	unsigned int changed = 0;
 
+	switch (ntohl(ce->ce_mode) & CE_IFMASK) {
+	case CE_IFREG:
+		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
+		break;
+	case CE_IFLNK:
+		changed |= !S_ISLNK(st->st_mode) ? TYPE_CHANGED : 0;
+		break;
+	default:
+		die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
+	}
 	if (ce->ce_mtime.sec != htonl(st->st_mtime))
 		changed |= MTIME_CHANGED;
 	if (ce->ce_ctime.sec != htonl(st->st_ctime))
--- a/tree.c
+++ b/tree.c
@@ -13,7 +13,10 @@ static int read_one_entry(unsigned char 
 
 	memset(ce, 0, size);
 
-	ce->ce_mode = create_ce_mode(mode);
+	if (mode & S_IFMT)
+		ce->ce_mode = htonl(mode);
+	else
+		ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = create_ce_flags(baselen + len, stage);
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
--- a/update-cache.c
+++ b/update-cache.c
@@ -58,30 +58,37 @@ static int add_file_to_cache(char *path)
 	struct stat st;
 	int fd;
 
-	fd = open(path, O_RDONLY);
-	if (fd < 0) {
+	if (lstat(path, &st) < 0) {
 		if (errno == ENOENT || errno == ENOTDIR) {
 			if (allow_remove)
 				return remove_file_from_cache(path);
 		}
 		return -1;
 	}
-	if (fstat(fd, &st) < 0) {
-		close(fd);
-		return -1;
-	}
 	namelen = strlen(path);
 	size = cache_entry_size(namelen);
 	ce = xmalloc(size);
 	memset(ce, 0, size);
 	memcpy(ce->name, path, namelen);
 	fill_stat_cache_info(ce, &st);
-	ce->ce_mode = create_ce_mode(st.st_mode);
+	if (S_ISREG(st.st_mode)) {
+		fd = open(path, O_RDONLY);
+		if (fd < 0)
+			return -1;
+		ce->ce_mode = create_ce_mode(st.st_mode);
+		if (index_fd(ce->sha1, fd, &st) < 0)
+			return -1;
+	} else if (S_ISLNK(st.st_mode)) {
+		unsigned int len;
+		char target[1024];
+		ce->ce_mode = htonl(S_IFLNK);
+		len = readlink(path, target, sizeof(target));
+		if (len == -1 || len+1 > sizeof(target))
+			return -1;
+		if (write_sha1_file(target, len, "blob", ce->sha1))
+			return -1;
+	}
 	ce->ce_flags = htons(namelen);
-
-	if (index_fd(ce->sha1, fd, &st) < 0)
-		return -1;
-
 	return add_cache_entry(ce, allow_add);
 }
 
@@ -137,7 +144,7 @@ static struct cache_entry *refresh_entry
 	struct cache_entry *updated;
 	int changed, size;
 
-	if (stat(ce->name, &st) < 0)
+	if (lstat(ce->name, &st) < 0)
 		return ERR_PTR(-errno);
 
 	changed = cache_match_stat(ce, &st);
@@ -145,10 +152,10 @@ static struct cache_entry *refresh_entry
 		return ce;
 
 	/*
-	 * If the mode has changed, there's no point in trying
+	 * If the mode or type has changed, there's no point in trying
 	 * to refresh the entry - it's not going to match
 	 */
-	if (changed & MODE_CHANGED)
+	if (changed & (MODE_CHANGED | TYPE_CHANGED))
 		return ERR_PTR(-EINVAL);
 
 	if (compare_data(ce, st.st_size))

