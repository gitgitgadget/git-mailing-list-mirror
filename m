From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add --no-reuse-delta, --window, and --depth options to
Date: Tue, 08 May 2007 11:30:31 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705081005400.24220@xanadu.home>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 08 17:49:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlRwW-0000Iz-4P
	for gcvg-git@gmane.org; Tue, 08 May 2007 17:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966039AbXEHPp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 11:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968095AbXEHPcr
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 11:32:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31818 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966433AbXEHPag (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 11:30:36 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHQ002GTB2V5P60@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2007 11:30:31 -0400 (EDT)
In-reply-to: <11786309073709-git-send-email-tytso@mit.edu>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46590>

On Tue, 8 May 2007, Theodore Ts'o wrote:

> OK, here's a patch to implement pack.depth (with the default tweaked
> to 50 --- is that too high?),

This is most likely to affect runtime performances, but some benchmarks 
would be needed to find out how much.

Having both pack.depth and pack.window as config options (with current 
defaults of 10) would certainly be a good thing.  Tweaking those 
defaults should probably be investigated separately.

> followed by a simplified and reworked
> patch to git-gc that only implements --no-reuse-delta.
> 
> I don't imagine that most users will want to use that feature most of
> the time, hence the long option name, but occasionally, it might be
> useful.  Yes, the user could just run "git-repack -a -d -f -l" after
> running git-gc, but then the "git-repack -a -d -l" in git-gc is just a
> wasted disk i/o.

In which case, it is git-gc that needs to get a bit smarter.  Maybe 
something like this:

----- >*
Avoid running git-repack from git-gc if there is evidently nothing to 
repack.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index ff90ebd..8d79764 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -67,13 +67,40 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 	}
 }
 
-int cmd_count_objects(int ac, const char **av, const char *prefix)
+static void count_loose_objects(int verbose,
+				unsigned long *loose,
+				unsigned long *loose_size,
+				unsigned long *packed_loose,
+				unsigned long *garbage)
 {
-	int i;
-	int verbose = 0;
 	const char *objdir = get_object_directory();
-	int len = strlen(objdir);
+	int i, len = strlen(objdir);
 	char *path = xmalloc(len + 50);
+	memcpy(path, objdir, len);
+	if (len && objdir[len-1] != '/')
+		path[len++] = '/';
+	for (i = 0; i < 256; i++) {
+		DIR *d;
+		sprintf(path + len, "%02x", i);
+		d = opendir(path);
+		if (!d)
+			continue;
+		count_objects(d, path, len, verbose,
+			      loose, loose_size, packed_loose, garbage);
+		closedir(d);
+	}
+}
+
+unsigned long num_loose_objects(void)
+{
+	unsigned long loose = 0, packed_loose = 0, garbage = 0, loose_size = 0;
+	count_loose_objects(0, &loose, &loose_size, &packed_loose, &garbage);
+	return loose;
+}
+
+int cmd_count_objects(int ac, const char **av, const char *prefix)
+{
+	int i, verbose = 0;
 	unsigned long loose = 0, packed = 0, packed_loose = 0, garbage = 0;
 	unsigned long loose_size = 0;
 
@@ -90,19 +117,8 @@ int cmd_count_objects(int ac, const char **av, const char *prefix)
 	/* we do not take arguments other than flags for now */
 	if (i < ac)
 		usage(count_objects_usage);
-	memcpy(path, objdir, len);
-	if (len && objdir[len-1] != '/')
-		path[len++] = '/';
-	for (i = 0; i < 256; i++) {
-		DIR *d;
-		sprintf(path + len, "%02x", i);
-		d = opendir(path);
-		if (!d)
-			continue;
-		count_objects(d, path, len, verbose,
-			      &loose, &loose_size, &packed_loose, &garbage);
-		closedir(d);
-	}
+
+	count_loose_objects(verbose, &loose, &loose_size, &packed_loose, &garbage);
 	if (verbose) {
 		struct packed_git *p;
 		unsigned long num_pack = 0;
diff --git a/builtin-gc.c b/builtin-gc.c
index 3b1f8c2..b9b3c05 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -40,7 +40,7 @@ static int gc_config(const char *var, const char *value)
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int prune = 0;
+	int prune = 0, do_repack = 0;
 
 	git_config(gc_config);
 
@@ -65,7 +65,20 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (run_command_v_opt(argv_reflog, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_reflog[0]);
 
-	if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
+	if (num_loose_objects() > 0) {
+		do_repack = 1;
+	} else {
+		struct packed_git *p;
+		unsigned long num_pack = 0;
+		if (!packed_git)
+			prepare_packed_git();
+		for (p = packed_git; p; p = p->next)
+			if (p->pack_local)
+				num_pack++;
+		if (num_pack > 1)
+			do_repack = 1;
+	}
+	if (do_repack && run_command_v_opt(argv_repack, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_repack[0]);
 
 	if (prune && run_command_v_opt(argv_prune, RUN_GIT_CMD))
diff --git a/cache.h b/cache.h
index 8e76152..3a140f1 100644
--- a/cache.h
+++ b/cache.h
@@ -359,6 +359,8 @@ extern int legacy_loose_object(unsigned char *);
 extern int has_pack_file(const unsigned char *sha1);
 extern int has_pack_index(const unsigned char *sha1);
 
+extern unsigned long num_loose_objects(void);
+
 extern signed char hexval_table[256];
 static inline unsigned int hexval(unsigned int c)
 {
