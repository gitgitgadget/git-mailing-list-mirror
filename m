From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] add a diff-files command (revised and cleaned up)
Date: Thu, 28 Apr 2005 13:35:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504281327520.14033@localhost.localdomain>
References: <Pine.LNX.4.62.0504272239420.14033@localhost.localdomain>
 <Pine.LNX.4.58.0504280950340.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 19:32:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRCrj-0006w3-TY
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 19:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVD1RhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 13:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVD1RhN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 13:37:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:294 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262186AbVD1Rfq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 13:35:46 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFO00AJ53IZQ2@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Apr 2005 13:35:23 -0400 (EDT)
In-reply-to: <Pine.LNX.4.58.0504280950340.18901@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Apr 2005, Linus Torvalds wrote:

> HOWEVER, there clearly is a separate problem, which is what "show-files"  
> currently does very badly (and not at all in some cases), which is the 
> "ok, what about the _other_ files?"

Right.  And that's the problem I'm trying to solve.

What about this patch then?

=====

Give show-files the ability to process exclusion pattern.

This can be used with the famous dontdiff file as follows to find out 
about uncommitted files just like dontdiff is used with the diff 
command:

    show-files --others --exclude-from=dontdiff

and the exclude list can be reversed with the --ignore switch.

Signed-off-by: Nicolas Pitre <nico@cam.org>

--- a/show-files.c
+++ b/show-files.c
@@ -6,6 +6,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include <dirent.h>
+#include <fnmatch.h>
 
 #include "cache.h"
 
@@ -17,6 +18,70 @@ static int show_stage = 0;
 static int show_unmerged = 0;
 static int line_terminator = '\n';
 
+static int nr_excludes;
+static const char **excludes;
+static int excludes_alloc;
+
+static void add_exclude(const char *string)
+{
+	if (nr_excludes == excludes_alloc) {
+		excludes_alloc = alloc_nr(excludes_alloc);
+		excludes = realloc(excludes, excludes_alloc*sizeof(char *));
+	}
+	excludes[nr_excludes++] = string;
+}
+
+static void add_excludes_from_file(const char *fname)
+{
+	int fd, i;
+	long size;
+	char *buf, *entry;
+
+	fd = open(fname, O_RDONLY);
+	if (fd < 0)
+		goto err;
+	size = lseek(fd, 0, SEEK_END);
+	if (size < 0)
+		goto err;
+	lseek(fd, 0, SEEK_SET);
+	if (size == 0) {
+		close(fd);
+		return;
+	}
+	buf = xmalloc(size);
+	if (read(fd, buf, size) != size)
+		goto err;
+	close(fd);
+
+	entry = buf;
+	for (i = 0; i < size; i++) {
+		if (buf[i] == '\n') {
+			if (entry != buf + i) {
+				buf[i] = 0;
+				add_exclude(entry);
+			}
+			entry = buf + i + 1;
+		}
+	}
+	return;
+
+err:	perror(fname);
+	exit(1);
+}
+
+static int excluded(const char *pathname)
+{
+	int i;
+	if (nr_excludes) {
+		const char *basename = strrchr(pathname, '/');
+		basename = (basename) ? basename+1 : pathname;
+		for (i = 0; i < nr_excludes; i++)
+			if (fnmatch(excludes[i], basename, 0) == 0)
+				return 1;
+	}
+	return 0;
+}
+
 static const char **dir;
 static int nr_dir;
 static int dir_alloc;
@@ -59,6 +124,8 @@ static void read_directory(const char *p
 
 			if (de->d_name[0] == '.')
 				continue;
+			if (excluded(de->d_name) != show_ignored)
+				continue;
 			len = strlen(de->d_name);
 			memcpy(fullname + baselen, de->d_name, len+1);
 
@@ -101,17 +168,17 @@ static void show_files(void)
 	int i;
 
 	/* For cached/deleted files we don't need to even do the readdir */
-	if (show_others | show_ignored) {
+	if (show_others) {
 		read_directory(".", "", 0);
 		qsort(dir, nr_dir, sizeof(char *), cmp_name);
-	}
-	if (show_others) {
 		for (i = 0; i < nr_dir; i++)
 			printf("%s%c", dir[i], line_terminator);
 	}
 	if (show_cached | show_stage) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
+			if (excluded(ce->name) != show_ignored)
+				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
 			if (!show_stage)
@@ -130,14 +197,13 @@ static void show_files(void)
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
 			struct stat st;
+			if (excluded(ce->name) != show_ignored)
+				continue;
 			if (!stat(ce->name, &st))
 				continue;
 			printf("%s%c", ce->name, line_terminator);
 		}
 	}
-	if (show_ignored) {
-		/* We don't have any "ignore" list yet */
-	}
 }
 
 int main(int argc, char **argv)
@@ -179,11 +245,34 @@ int main(int argc, char **argv)
 			continue;
 		}
 
-		usage("show-files [-z] (--[cached|deleted|others|ignored|stage])*");
+		if (!strcmp(arg, "-x") && i+1 < argc) {
+			add_exclude(argv[++i]);
+			continue;
+		}
+		if (!strncmp(arg, "--exclude=", 10)) {
+			add_exclude(arg+10);
+			continue;
+		}
+		if (!strcmp(arg, "-X") && i+1 < argc) {
+			add_excludes_from_file(argv[++i]);
+			continue;
+		}
+		if (!strncmp(arg, "--exclude-from=", 15)) {
+			add_excludes_from_file(arg+15);
+			continue;
+		}
+
+		usage("show-files [-z] (--[cached|deleted|others|stage])* "
+		      "[ --ignored [--exclude=<pattern>] [--exclude-from=<file>) ]");
+	}
+
+	if (show_ignored && !nr_excludes) {
+		fprintf(stderr, "%s: --ignored needs some exclude pattern\n", argv[0]);
+		exit(1);
 	}
 
 	/* With no flags, we default to showing the cached files */
-	if (!(show_stage | show_deleted | show_others | show_ignored | show_unmerged))
+	if (!(show_stage | show_deleted | show_others | show_unmerged))
 		show_cached = 1;
 
 	read_cache();
