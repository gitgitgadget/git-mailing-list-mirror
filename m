From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Sat, 21 May 2005 17:09:02 -0400 (EDT)
Message-ID: <2572.10.10.10.24.1116709742.squirrel@linux1>
References: <4870.10.10.10.24.1116646732.squirrel@linux1>      
    <Pine.LNX.4.58.0505211245580.2206@ppc970.osdl.org>   
    <2475.10.10.10.24.1116708368.squirrel@linux1>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050521170902_94512"
Cc: "GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 23:08:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZbCd-0000mb-2R
	for gcvg-git@gmane.org; Sat, 21 May 2005 23:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVEUVJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 17:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVEUVJT
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 17:09:19 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:46067 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261604AbVEUVJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 17:09:03 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050521210902.SEKT1005.simmts12-srv.bellnexxia.net@linux1>;
          Sat, 21 May 2005 17:09:02 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4LL92ug023172;
	Sat, 21 May 2005 17:09:02 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sat, 21 May 2005 17:09:02 -0400 (EDT)
To: "Linus Torvalds" <torvalds@osdl.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
In-Reply-To: <2475.10.10.10.24.1116708368.squirrel@linux1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

------=_20050521170902_94512
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Sat, May 21, 2005 4:46 pm, Sean said:

> Right, fixed up in attached patch which basically punts with a
> description of   "Show unreachable objects", and leaves it to the
> documentation to do better.
Linus,

Try 2 at that attachment thingy, hopefully this one will make your mailer
happy.

Sean


------=_20050521170902_94512
Content-Type: text/plain; name="argp-fsck-cache-v4.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="argp-fsck-cache-v4.patch"

Index: Documentation/git-fsck-cache.txt
===================================================================
--- 85ec256656a7839ca7a2067792b828c9b63c8711/Documentation/git-fsck-cache.txt  (mode:100644)
+++ uncommitted/Documentation/git-fsck-cache.txt  (mode:100644)
@@ -9,7 +9,8 @@
 
 SYNOPSIS
 --------
-'git-fsck-cache' [--tags] [--root] [[--unreachable] [--cache] <object>\*]
+'git-fsck-cache' [--tags] [--root] [--delta-depth] 
+			[[--unreachable] [--cache] <object>\*]
 
 DESCRIPTION
 -----------
@@ -34,6 +35,9 @@
 	Consider any object recorded in the cache also as a head node for
 	an unreachability trace.
 
+--delta-depth::
+	Show length of longest delta chain.
+
 It tests SHA1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
Index: fsck-cache.c
===================================================================
--- 85ec256656a7839ca7a2067792b828c9b63c8711/fsck-cache.c  (mode:100644)
+++ uncommitted/fsck-cache.c  (mode:100644)
@@ -1,5 +1,7 @@
 #include <sys/types.h>
 #include <dirent.h>
+#include <argp.h>
+const char *argp_program_version = VERSION;
 
 #include "cache.h"
 #include "commit.h"
@@ -407,36 +409,42 @@
 	find_file_objects(git_dir, "refs");
 }
 
+static const char doc[] = "Perform repository consistency check";
+
+static struct argp_option options[] = {
+ {"unreachable", 'u', 0, 0, "Show unreachable objects"},
+ {"tags", 't', 0, 0, "Show revision tags"},
+ {"root", 'r', 0, 0, "Show root objects, ie. those without parents"},
+ {"delta-depth", 'd', 0, 0, "Show length of longest delta chain"},
+ {"cache", 'c', 0, 0, "Mark all objects referenced by cache as reachable"},
+ { }
+};
+
+static error_t parse_opt (int key, char *arg, struct argp_state *state)
+{
+        switch (key) {
+        case 'u':		show_unreachable = 1; break;
+        case 't':		show_tags = 1; break;
+        case 'r':		show_root = 1; break;
+        case 'd':		show_max_delta_depth = 1; break;
+        case 'c':		keep_cache_objects = 1; break;
+        default:		return ARGP_ERR_UNKNOWN;
+        }
+        return 0;
+}
+
+static const struct argp argp = { options, parse_opt, "[HEAD-SHA1...]", doc };
+
 int main(int argc, char **argv)
 {
 	int i, heads;
 	char *sha1_dir;
+	int idx;
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-
-		if (!strcmp(arg, "--unreachable")) {
-			show_unreachable = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--tags")) {
-			show_tags = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--root")) {
-			show_root = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--delta-depth")) {
-			show_max_delta_depth = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--cache")) {
-			keep_cache_objects = 1;
-			continue;
-		}
-		if (*arg == '-')
-			usage("git-fsck-cache [--tags] [[--unreachable] [--cache] <head-sha1>*]");
+	error_t rc = argp_parse(&argp, argc, argv, 0, &idx, NULL);
+	if (rc) {
+		fprintf(stderr, "argument failed: %s\n", strerror(rc));
+		return 1;
 	}
 
 	sha1_dir = get_object_directory();
@@ -450,7 +458,7 @@
 	expand_deltas();
 
 	heads = 0;
-	for (i = 1; i < argc; i++) {
+	for (i = idx; i < argc; i++) {
 		const char *arg = argv[i]; 
 
 		if (*arg == '-')
------=_20050521170902_94512--


