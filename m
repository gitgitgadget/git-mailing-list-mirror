From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: git and symlinks as tracked content
Date: Thu, 5 May 2005 00:35:32 +0200
Message-ID: <20050504223532.GA22967@vrfy.org>
References: <1115145234.21105.111.camel@localhost.localdomain> <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 00:30:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTSNC-0008Ju-DJ
	for gcvg-git@gmane.org; Thu, 05 May 2005 00:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVEDWgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 18:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVEDWgG
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 18:36:06 -0400
Received: from soundwarez.org ([217.160.171.123]:47301 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261935AbVEDWff (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 18:35:35 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 55CAC2CD33; Thu,  5 May 2005 00:35:32 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 03, 2005 at 12:02:33PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 3 May 2005, Kay Sievers wrote:
> >
> > Is there a sane model to make git aware of tracking symlinks in the
> > repository? In the bk udev tree we've had a test sysfs-tree with a lot
> > of symlinks in it.
> > 
> > Where can we store the link-target? In its own blob-object or directly
> > in the tree-object?
> 
> I'd suggest you create a blob object with the symlink name, and then in
> the tree you point to that blob, but with the S_IFLNK value in the mode
> field (0120000).
> 
> So you have
> 
>  - directories: S_IFDIR (0040000) point to "tree" objects for contents
>  - symlinks: S_IFLNK (0120000) point to "blob" objects
>  - executables: S_IFREG | 0755 (0100755) point to "blob" objects
>  - regular files: S_IFREG | 0644 (0100644) point to "blob" objects
> 
> which seems very sane and regular. 

Here is a first try, that is able to track symlinks. Please have a look
if something like this is acceptable, then I will finish it.

Thanks,
Kay

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

