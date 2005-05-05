From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: git and symlinks as tracked content
Date: Thu, 5 May 2005 14:38:25 +0200
Message-ID: <20050505123825.GA30156@vrfy.org>
References: <1115145234.21105.111.camel@localhost.localdomain> <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org> <20050504223532.GA22967@vrfy.org> <7vwtqemvjt.fsf@assigned-by-dhcp.cox.net> <20050505012051.GA26201@vrfy.org> <7vy8aul8rs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 14:33:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTfWU-0007EY-Ab
	for gcvg-git@gmane.org; Thu, 05 May 2005 14:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVEEMip (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 08:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVEEMip
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 08:38:45 -0400
Received: from soundwarez.org ([217.160.171.123]:50085 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262080AbVEEMi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 08:38:28 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id A94AA2CF4B; Thu,  5 May 2005 14:38:25 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy8aul8rs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Allow to store and track symlink in the repository. A symlink is stored
the same way as a regular file, only with the appropriate mode bits set.
The symlink target is therefore stored in a blob object.
This will hopefully make our udev repository fully functional. :)

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---

On Wed, May 04, 2005 at 07:13:43PM -0700, Junio C Hamano wrote:
> >>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:

> I did not know if you are going to take CE_ type suggestion so 
> I left it as it was.
> 
> There are more.  "grep 'S_I[SF]' *.[ch] */*.[ch]" would tell us
> most if not all.  We probably would want to have CE_ISLNK() and
> friends, parallel to S_ISLNK() and friends if we go this route.

Hmm, how about this?

Thanks,
Kay

--- a/cache.h
+++ b/cache.h
@@ -87,7 +87,14 @@ struct cache_entry {
 #define ce_stage(ce) ((CE_STAGEMASK & ntohs((ce)->ce_flags)) >> CE_STAGESHIFT)
 
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
-#define create_ce_mode(mode) htonl(S_IFREG | ce_permissions(mode))
+static inline unsigned int create_ce_mode(unsigned int mode)
+{
+	if (S_ISREG(mode))
+		return htonl(S_IFREG | ce_permissions(mode));
+	if (S_ISLNK(mode))
+		return htonl(S_IFLNK);
+	return htonl(mode);
+}
 
 #define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)
 
@@ -124,6 +131,7 @@ extern int index_fd(unsigned char *sha1,
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
@@ -72,23 +72,41 @@ static int write_entry(struct cache_entr
 	unsigned long size;
 	long wrote;
 	char type[20];
+	char target[1024];
 
 	new = read_sha1_file(ce->sha1, type, &size);
 	if (!new || strcmp(type, "blob")) {
 		return error("checkout-cache: unable to read sha1 file of %s (%s)",
 			path, sha1_to_hex(ce->sha1));
 	}
-	fd = create_file(path, ntohl(ce->ce_mode));
-	if (fd < 0) {
+	switch (ntohl(ce->ce_mode) & S_IFMT) {
+	case S_IFREG:
+		fd = create_file(path, ntohl(ce->ce_mode));
+		if (fd < 0) {
+			free(new);
+			return error("checkout-cache: unable to create file %s (%s)",
+				path, strerror(errno));
+		}
+		wrote = write(fd, new, size);
+		close(fd);
+		free(new);
+		if (wrote != size)
+			return error("checkout-cache: unable to write file %s", path);
+		break;
+	case S_IFLNK:
+		memcpy(target, new, size);
+		target[size] = '\0';
+		if (symlink(target, path)) {
+			free(new);
+			return error("checkout-cache: unable to create symlink %s (%s)",
+				path, strerror(errno));
+		}
+		free(new);
+		break;
+	default:
 		free(new);
-		return error("checkout-cache: unable to create %s (%s)",
-			path, strerror(errno));
+		return error("checkout-cache: unknown file mode for %s", path);
 	}
-	wrote = write(fd, new, size);
-	close(fd);
-	free(new);
-	if (wrote != size)
-		return error("checkout-cache: unable to write %s", path);
 	return 0;
 }
 
@@ -101,7 +119,7 @@ static int checkout_entry(struct cache_e
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
 
+	switch (ntohl(ce->ce_mode) & S_IFMT) {
+	case S_IFREG:
+		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
+		break;
+	case S_IFLNK:
+		changed |= !S_ISLNK(st->st_mode) ? TYPE_CHANGED : 0;
+		break;
+	default:
+		die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
+	}
 	if (ce->ce_mtime.sec != htonl(st->st_mtime))
 		changed |= MTIME_CHANGED;
 	if (ce->ce_ctime.sec != htonl(st->st_ctime))
--- a/update-cache.c
+++ b/update-cache.c
@@ -57,19 +57,16 @@ static int add_file_to_cache(char *path)
 	struct cache_entry *ce;
 	struct stat st;
 	int fd;
+	unsigned int len;
+	char target[1024];
 
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
@@ -78,10 +75,24 @@ static int add_file_to_cache(char *path)
 	fill_stat_cache_info(ce, &st);
 	ce->ce_mode = create_ce_mode(st.st_mode);
 	ce->ce_flags = htons(namelen);
-
-	if (index_fd(ce->sha1, fd, &st) < 0)
+	switch (st.st_mode & S_IFMT) {
+	case S_IFREG:
+		fd = open(path, O_RDONLY);
+		if (fd < 0)
+			return -1;
+		if (index_fd(ce->sha1, fd, &st) < 0)
+			return -1;
+		break;
+	case S_IFLNK:
+		len = readlink(path, target, sizeof(target));
+		if (len == -1 || len+1 > sizeof(target))
+			return -1;
+		if (write_sha1_file(target, len, "blob", ce->sha1))
+			return -1;
+		break;
+	default:
 		return -1;
-
+	}
 	return add_cache_entry(ce, allow_add);
 }
 
@@ -137,7 +148,7 @@ static struct cache_entry *refresh_entry
 	struct cache_entry *updated;
 	int changed, size;
 
-	if (stat(ce->name, &st) < 0)
+	if (lstat(ce->name, &st) < 0)
 		return ERR_PTR(-errno);
 
 	changed = cache_match_stat(ce, &st);
@@ -145,10 +156,10 @@ static struct cache_entry *refresh_entry
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

