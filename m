From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] git-pasky-0.7
Date: Sun, 24 Apr 2005 03:52:48 -0700
Message-ID: <7vzmvosayn.fsf@assigned-by-dhcp.cox.net>
References: <20050424005923.GA8859@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 12:49:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPefl-00066T-OK
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 12:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVDXKx7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 06:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVDXKx7
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 06:53:59 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:17054 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262306AbVDXKxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 06:53:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050424105249.YPNY16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 24 Apr 2005 06:52:49 -0400
To: Petr Baudis <pasky@ucw.cz>
Cc: git@vger.kernel.org
In-Reply-To: <20050424005923.GA8859@pasky.ji.cz> (Petr Baudis's message of
 "Sun, 24 Apr 2005 02:59:23 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I was reviewing the differences in C-part between what is in
git-pasky and Linus tree.  By the way, I finally decided to look
at the upper layer again, now you switched to dircache based
implementation.  It looks like a good start.  Anyway, this
message is about purely C part.

First some nitpicks and possible bugs.

 - The remove_file_from_cache() function in read-cache.c was
   fixed for quite some time ago in the Linus tree to let users
   resolve unmerged path by "update-cache --remove".  You do not
   seem to have this part (the diff is reversed) [*R1*].  If this is
   not a merge oversight I'd like to know why?

 - show-diff exiting non-zero when unmatched paths are specified
   does not make much sense.  diff traditionally exits non-zero
   when differences are found.  Are you using this exit status
   to see if entries on the command line are in the dircache?
   If so that is not show-diff's job but probably belongs to
   show-files [*R2*].

Comments, commends and requests.

 - The -t option you have in show-files sounds generally
   useful [*R3*].  Could you push this upstream?

 - There are many small changes that adds free() and close(fd)
   and from my cursory looking they all look reasonable fixes.
   If you are confident with these, could please also push them
   upstream?

Thanks.

[References]

*R1*

This hunk should be reverted from Pasky if there is no good reason.

--- git.linus/read-cache.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/read-cache.c	2005-04-24 00:49:00.000000000 -0700
@@ -99,9 +99,7 @@
 int remove_file_from_cache(char *path)
 {
 	int pos = cache_name_pos(path, strlen(path));
-	if (pos < 0)
-		pos = -pos-1;
-	while (pos < active_nr && !strcmp(active_cache[pos]->name, path))
+	if (pos >= 0)
 		remove_entry_at(pos);
 	return 0;
 }

*R2*

This hunk should be reverted from Pasky if there is no good reason.

--- git.linus/show-diff.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/show-diff.c	2005-04-24 00:49:00.000000000 -0700
@@ -126,6 +127,7 @@
 	int machine_readable = 0;
 	int reverse = 0;
 	int entries = read_cache();
+	int matched = 0;
 	int i;
 
 	while (1 < argc && argv[1][0] == '-') {
@@ -161,6 +163,7 @@
 		if (1 < argc &&
 		    ! matches_pathspec(ce, argv+1, argc-1))
 			continue;
+		matched++;
 
 		if (ce_stage(ce)) {
 			if (machine_readable)
@@ -192,10 +195,8 @@
 			continue;
 		if (!machine_readable)
 			printf("%s: %s\n", ce->name, sha1_to_hex(ce->sha1));
-		else {
-			printf("%s %s%c", sha1_to_hex(ce->sha1), ce->name, 0);
-			continue;
-		}
+		else
+			printf("M %s %s%c", sha1_to_hex(ce->sha1), ce->name, 0);
 		if (silent)
 			continue;
 
@@ -208,5 +209,8 @@
 					 reverse);
 		free(old);
 	}
+
+	if (1 < argc && !matched)
+		return 1;
 	return 0;
 }

*R3*

This should be pushed upstream.

--- git.linus/show-files.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/show-files.c	2005-04-24 00:49:00.000000000 -0700
@@ -17,6 +17,11 @@
 static int show_unmerged = 0;
 static int line_terminator = '\n';
 
+static const char *tag_cached = "";
+static const char *tag_unmerged = "";
+static const char *tag_removed = "";
+static const char *tag_other = "";
+
 static const char **dir;
 static int nr_dir;
 static int dir_alloc;
@@ -107,7 +112,7 @@
 	}
 	if (show_others) {
 		for (i = 0; i < nr_dir; i++)
-			printf("%s%c", dir[i], line_terminator);
+			printf("%s%s%c", tag_other, dir[i], line_terminator);
 	}
 	if (show_cached | show_stage) {
 		for (i = 0; i < active_nr; i++) {
@@ -115,10 +120,13 @@
 			if (show_unmerged && !ce_stage(ce))
 				continue;
 			if (!show_stage)
-				printf("%s%c", ce->name, line_terminator);
+				printf("%s%s%c",
+				       ce_stage(ce) ? tag_unmerged : tag_cached,
+				       ce->name, line_terminator);
 			else
 				printf(/* "%06o %s %d %10d %s%c", */
-				       "%06o %s %d %s%c",
+				       "%s %06o %s %d %s%c",
+				       ce_stage(ce) ? tag_unmerged : tag_cached,
 				       ntohl(ce->ce_mode),
 				       sha1_to_hex(ce->sha1),
 				       ce_stage(ce),
@@ -132,7 +140,7 @@
 			struct stat st;
 			if (!stat(ce->name, &st))
 				continue;
-			printf("%s%c", ce->name, line_terminator);
+			printf("%s%s%c", tag_removed, ce->name, line_terminator);
 		}
 	}
 	if (show_ignored) {
@@ -151,6 +159,13 @@
 			line_terminator = 0;
 			continue;
 		}
+		if (!strcmp(arg, "-t")) {
+			tag_cached = "H ";
+			tag_unmerged = "M ";
+			tag_removed = "R ";
+			tag_other = "? ";
+			continue;
+		}
 
 		if (!strcmp(arg, "--cached")) {
 			show_cached = 1;
@@ -179,7 +194,7 @@
 			continue;
 		}
 
-		usage("show-files [-z] (--[cached|deleted|others|ignored|stage])*");
+		usage("show-files [-z] [-t] (--[cached|deleted|others|ignored|stage])*");
 	}
 
 	/* With no flags, we default to showing the cached files */


*R4*

These leak fixes look reasonable from cursory looking.  If you
are confident, please push them upstream.

--- git.linus/checkout-cache.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/checkout-cache.c	2005-04-24 00:49:00.000000000 -0700
@@ -48,6 +48,7 @@
 		buf[len] = 0;
 		mkdir(buf, 0755);
 	}
+	free(buf);
 }
 
 static int create_file(const char *path, unsigned int mode)
@@ -75,6 +76,8 @@
 
 	new = read_sha1_file(ce->sha1, type, &size);
 	if (!new || strcmp(type, "blob")) {
+		if (new)
+			free(new);
 		return error("checkout-cache: unable to read sha1 file of %s (%s)",
 			path, sha1_to_hex(ce->sha1));
 	}


--- git.linus/ls-tree.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/ls-tree.c	2005-04-24 00:49:00.000000000 -0700
@@ -77,6 +77,7 @@
 	if (!buffer)
 		die("unable to read sha1 file");
 	list_recursive(buffer, "tree", size, NULL);
+	free(buffer);
 	return 0;
 }
 

--- git.linus/read-tree.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/read-tree.c	2005-04-24 00:49:00.000000000 -0700
@@ -11,11 +11,14 @@
 {
 	void *buffer;
 	unsigned long size;
+	int ret;
 
 	buffer = read_tree_with_tree_or_commit_sha1(sha1, &size, 0);
 	if (!buffer)
 		return -1;
-	return read_tree(buffer, size, stage);
+	ret = read_tree(buffer, size, stage);
+	free(buffer);
+	return ret;
 }
 
 static char *lockfile_name;


--- git.linus/rev-tree.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/rev-tree.c	2005-04-24 00:49:00.000000000 -0700
@@ -56,10 +56,10 @@
 	struct commit_list *parents;
 	struct commit *obj = lookup_commit(sha1);
 
-	if (obj->object.parsed)
+	if (obj && obj->object.parsed)
 		return;
-
-	parse_commit(obj);
+	if (!obj || parse_commit(obj))
+		die("unable to parse commit (%s)", sha1_to_hex(sha1));
 	
 	parents = obj->parents;
 	while (parents) {


--- git.linus/show-diff.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/show-diff.c	2005-04-24 00:49:00.000000000 -0700
@@ -100,6 +100,7 @@
 		return;
 	}
 	show_differences("/dev/null", ce->name, old, size, reverse);
+	free(old);
 }
 
 static const char *show_diff_usage = "show-diff [-q] [-s] [-z] [paths...]";


* These all look genuine leak fixes.  If applicable to Linus tree please
  push them upstream.

--- git.linus/checkout-cache.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/checkout-cache.c	2005-04-24 00:49:00.000000000 -0700
@@ -48,6 +48,7 @@
 		buf[len] = 0;
 		mkdir(buf, 0755);
 	}
+	free(buf);
 }
 
 static int create_file(const char *path, unsigned int mode)
@@ -75,6 +76,8 @@
 
 	new = read_sha1_file(ce->sha1, type, &size);
 	if (!new || strcmp(type, "blob")) {
+		if (new)
+			free(new);
 		return error("checkout-cache: unable to read sha1 file of %s (%s)",
 			path, sha1_to_hex(ce->sha1));
 	}


--- git.linus/ls-tree.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/ls-tree.c	2005-04-24 00:49:00.000000000 -0700
@@ -77,6 +77,7 @@
 	if (!buffer)
 		die("unable to read sha1 file");
 	list_recursive(buffer, "tree", size, NULL);
+	free(buffer);
 	return 0;
 }
 
--- git.linus/read-tree.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/read-tree.c	2005-04-24 00:49:00.000000000 -0700
@@ -11,11 +11,14 @@
 {
 	void *buffer;
 	unsigned long size;
+	int ret;
 
 	buffer = read_tree_with_tree_or_commit_sha1(sha1, &size, 0);
 	if (!buffer)
 		return -1;
-	return read_tree(buffer, size, stage);
+	ret = read_tree(buffer, size, stage);
+	free(buffer);
+	return ret;
 }
 
 static char *lockfile_name;

--- git.linus/rev-tree.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/rev-tree.c	2005-04-24 00:49:00.000000000 -0700
@@ -56,10 +56,10 @@
 	struct commit_list *parents;
 	struct commit *obj = lookup_commit(sha1);
 
-	if (obj->object.parsed)
+	if (obj && obj->object.parsed)
 		return;
-
-	parse_commit(obj);
+	if (!obj || parse_commit(obj))
+		die("unable to parse commit (%s)", sha1_to_hex(sha1));
 	
 	parents = obj->parents;
 	while (parents) {

--- git.linus/sha1_file.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/sha1_file.c	2005-04-24 00:49:00.000000000 -0700
@@ -278,6 +278,7 @@
 
 	if (write(fd, compressed, size) != size)
 		die("unable to write file");
+	free(compressed);
 	close(fd);
 		
 	return 0;
@@ -295,8 +296,10 @@
 	if (fd < 0)
 		return -1;
 
-	if (fstat(fd, &st) < 0 || size != st.st_size)
+	if (fstat(fd, &st) < 0 || size != st.st_size) {
+		close(fd);
 		return -1;
+	}
 
 	map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);


--- git.linus/show-diff.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/show-diff.c	2005-04-24 00:49:00.000000000 -0700
@@ -100,6 +100,7 @@
 		return;
 	}
 	show_differences("/dev/null", ce->name, old, size, reverse);
+	free(old);
 }
 
 static const char *show_diff_usage = "show-diff [-q] [-s] [-z] [paths...]";


--- git.linus/update-cache.c	2005-04-24 00:05:02.000000000 -0700
+++ git.pasky/update-cache.c	2005-04-24 00:49:00.000000000 -0700
@@ -104,6 +104,11 @@
 		close(fd);
 		return -1;
 	}
+	if (S_ISDIR(st.st_mode)) {
+		fprintf(stderr, "'%s' is a directory, ignoring\n", path);
+		close(fd);
+		return 0;
+	}
 	namelen = strlen(path);
 	size = cache_entry_size(namelen);
 	ce = malloc(size);
@@ -113,10 +118,15 @@
 	ce->ce_mode = create_ce_mode(st.st_mode);
 	ce->ce_flags = htons(namelen);
 
-	if (index_fd(ce->sha1, fd, &st) < 0)
+	if (index_fd(ce->sha1, fd, &st) < 0) {
+		free(ce);
 		return -1;
-
-	return add_cache_entry(ce, allow_add);
+	}
+	if (add_cache_entry(ce, allow_add)) {
+		free(ce);
+		return -1;
+	}
+	return 0;
 }
 
 static int match_data(int fd, void *buffer, unsigned long size)
@@ -141,7 +151,7 @@
 	if (fd >= 0) {
 		void *buffer;
 		unsigned long size;
-		char type[10];
+		char type[20];
 
 		buffer = read_sha1_file(ce->sha1, type, &size);
 		if (buffer) {
@@ -216,6 +226,9 @@
 			printf("%s: needs update\n", ce->name);
 			continue;
 		}
+		/* You can NOT just free active_cache[i] here, since it
+		 * might not be necessarily malloc()ed but can also come
+		 * from mmap(). */
 		active_cache[i] = new;
 	}
 }

