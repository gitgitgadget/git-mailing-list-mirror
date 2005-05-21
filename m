From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH 3/3] - Convert git-checkout-cache to argp
Date: Sat, 21 May 2005 17:39:31 -0400 (EDT)
Message-ID: <2669.10.10.10.24.1116711571.squirrel@linux1>
References: <2242.10.10.10.24.1116700408.squirrel@linux1>
    <428FA5C3.6010900@pobox.com>
    <7v7jhsgtlg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050521173931_15087"
Cc: "Jeff Garzik" <jgarzik@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 23:39:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZbg2-0003LR-Dr
	for gcvg-git@gmane.org; Sat, 21 May 2005 23:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVEUVjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 17:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVEUVjp
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 17:39:45 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:54214 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261631AbVEUVjc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 17:39:32 -0400
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050521213931.FHT11606.simmts5-srv.bellnexxia.net@linux1>;
          Sat, 21 May 2005 17:39:31 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4LLdUru023544;
	Sat, 21 May 2005 17:39:30 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sat, 21 May 2005 17:39:31 -0400 (EDT)
In-Reply-To: <7v7jhsgtlg.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

------=_20050521173931_15087
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Sat, May 21, 2005 5:24 pm, Junio C Hamano said:
>>>>>> "JG" == Jeff Garzik <jgarzik@pobox.com> writes:
>
> JG> Sean wrote:
>>> Use argp to process command line arguments for git-checkout-cache.
>>> Also,
>>> fix things up so that the order of options on the command line no
>>> longer
>>> matters.  To this end, the "-f" (--force) switch only applies to the
>>> individual files given on the command line.   A new forcing version of
>>> the
>>> "-a" (--all) switch is added as "-A" (--forceall).
>
> JG> I agree with Junio -- this patch breaks stuff.
>
> Yes, and that is exactly why I wanted to see the documentation
> changes first before the code.
>

Okay.  Attached no longer tries to maintain the feature of unforced -a in
combination with forced file list.  So:


Use argp to process command line arguments for git-checkout-cache.  Also,
fix things up so that the order of options on the command line no longer
matters.  To this end, the "-f" (--force) option always affects the -a
(--all) option no matter where it appears on the command line.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>


 Documentation/git-checkout-cache.txt |   16 ++--
 checkout-cache.c                     |  120
++++++++++++++++-------------------
 2 files changed, 64 insertions(+), 72 deletions(-)


------=_20050521173931_15087
Content-Type: text/plain; name="argp-checkout-cache-v4.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="argp-checkout-cache-v4.patch"

Index: Documentation/git-checkout-cache.txt
===================================================================
--- 3abc6a8ee0f27eaba8d0a7d091413eb390447386/Documentation/git-checkout-cache.txt  (mode:100644)
+++ uncommitted/Documentation/git-checkout-cache.txt  (mode:100644)
@@ -24,7 +24,7 @@
 	the cache file.
 
 -q::
-	be quiet if files exist or are not in the cache
+	be quiet if files exist or are not in the cache.
 
 -f::
 	forces overwrite of existing files
@@ -44,17 +44,15 @@
 --::
 	Do not interpret any more arguments as options.
 
-Note that the order of the flags matters:
+Example:
 
-     git-checkout-cache -a -f file.c
+     git-checkout-cache -a
 
-will first check out all files listed in the cache (but not overwrite
-any old ones), and then force-checkout `file.c` a second time (ie that
-one *will* overwrite any old contents with the same filename).
+Will check out all files listed in the cache.
 
-Also, just doing "git-checkout-cache" does nothing. You probably meant
+Just doing "git-checkout-cache" does nothing. You probably meant
 "git-checkout-cache -a". And if you want to force it, you want
-"git-checkout-cache -f -a".
+"git-checkout-cache -a -f".
 
 Intuitiveness is not the goal here. Repeatability is. The reason for
 the "no arguments means no work" thing is that from scripts you are
@@ -68,7 +66,7 @@
 
 To update and refresh only the files already checked out:
 
-        git-checkout-cache -n -f -a && git-update-cache --ignore-missing --refresh
+        git-checkout-cache -n -a -f && git-update-cache --ignore-missing --refresh
 
 Oh, and the "--" is just a good idea when you know the rest will be
 filenames. Just so that you wouldn't have a filename of "-a" causing
Index: checkout-cache.c
===================================================================
--- 3abc6a8ee0f27eaba8d0a7d091413eb390447386/checkout-cache.c  (mode:100644)
+++ uncommitted/checkout-cache.c  (mode:100644)
@@ -3,18 +3,14 @@
  *
  * Copyright (C) 2005 Linus Torvalds
  *
- * Careful: order of argument flags does matter. For example,
+ *	git-checkout-cache -a
  *
- *	git-checkout-cache -a -f file.c
+ * Will check out all files listed in the cache, but not
+ * overwrite any existing files. 
  *
- * Will first check out all files listed in the cache (but not
- * overwrite any old ones), and then force-checkout "file.c" a
- * second time (ie that one _will_ overwrite any old contents
- * with the same filename).
- *
- * Also, just doing "git-checkout-cache" does nothing. You probably
- * meant "git-checkout-cache -a". And if you want to force it, you
- * want "git-checkout-cache -f -a".
+ * Just doing "git-checkout-cache" does nothing. You probably
+ * meant "git-checkout-cache -a". And if you want to force it,
+ * you want "git-checkout-cache -f -a".
  *
  * Intuitiveness is not the goal here. Repeatability is. The
  * reason for the "no arguments means no work" thing is that
@@ -35,8 +31,11 @@
 #include <sys/types.h>
 #include <dirent.h>
 #include "cache.h"
+#include <argp.h>
+const char *argp_program_version = VERSION;
 
-static int force = 0, quiet = 0, not_new = 0, refresh_cache = 0;
+static int force = 0, quiet = 0, not_new = 0, refresh_cache = 0, all = 0;
+static const char *base_opt = "";
 
 static void create_directories(const char *path)
 {
@@ -226,68 +225,63 @@
 	return 0;
 }
 
+static const char doc[] = "Populate working tree with files from cache";
+
+static struct argp_option options[] = {
+ {"prefix", 1, "base", 0, "Prepend base to each file before checkout"},
+ {"all", 'a', 0, 0, "Checkout entire cache"},
+ {"force", 'f', 0, 0, "Allow checkout to overwrite existing files"},
+ {"quiet", 'q', 0, 0, "Suppress warnings"},
+ {"not-new", 'n', 0, 0, "Checkout existing files only"},
+ {"update", 'u', 0, 0, "Update cache with new stat info"},
+ { }
+};
+
+static error_t parse_opt (int key, char *arg, struct argp_state *state)
+{
+        switch (key) {
+        case 'a':		all = 1; break;
+        case 'q':		quiet = 1; break;
+        case 'n':		not_new = 1; break;
+        case 'f':		force = 1; break;
+        case   1:		base_opt = arg; break;
+        case 'u':		refresh_cache = 1; break;
+        default:		return ARGP_ERR_UNKNOWN;
+        }
+        return 0;
+}
+
+static const struct argp argp = { options, parse_opt, "[FILES...]", doc };
+
 int main(int argc, char **argv)
 {
-	int i, force_filename = 0;
-	const char *base_dir = "";
 	struct cache_file cache_file;
-	int newfd = -1;
+	int i, idx, newfd = -1;
 
 	if (read_cache() < 0) {
 		die("invalid cache");
 	}
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!force_filename) {
-			if (!strcmp(arg, "-a")) {
-				checkout_all(base_dir);
-				continue;
-			}
-			if (!strcmp(arg, "--")) {
-				force_filename = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-f")) {
-				force = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-q")) {
-				quiet = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-n")) {
-				not_new = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-u")) {
-				refresh_cache = 1;
-				if (newfd < 0)
-					newfd = hold_index_file_for_update
-						(&cache_file,
-						 get_index_file());
-				if (newfd < 0)
-					die("cannot open index.lock file.");
-				continue;
-			}
-			if (!memcmp(arg, "--prefix=", 9)) {
-				base_dir = arg+9;
-				continue;
-			}
-		}
-		if (base_dir[0]) {
-			/* when --prefix is specified we do not
-			 * want to update cache.
-			 */
-			if (refresh_cache) {
-				close(newfd); newfd = -1;
-				rollback_index_file(&cache_file);
-			}
-			refresh_cache = 0;
-		}
-		checkout_file(arg, base_dir);
+	error_t rc = argp_parse(&argp, argc, argv, 0, &idx, NULL);
+	if (rc) {
+		fprintf(stderr, "argument failed: %s\n", strerror(rc));
+		return 1;
 	}
 
+	if (refresh_cache) {
+		if (base_opt[0])
+			die("cannot update cache when --prefix option is used");
+		newfd = hold_index_file_for_update(&cache_file, get_index_file());
+		if (newfd < 0)
+			die("cannot open index.lock file.");
+	}
+
+	if (all)
+		checkout_all(base_opt); 
+
+	for (i = idx; i < argc; i++) 
+		checkout_file(argv[i], base_opt);
+
 	if (0 <= newfd &&
 	    (write_cache(newfd, active_cache, active_nr) ||
 	     commit_index_file(&cache_file)))
------=_20050521173931_15087--


