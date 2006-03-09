From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fsck-objects: Remove --standalone
Date: Thu, 09 Mar 2006 02:37:08 -0800
Message-ID: <7v4q277vl7.fsf@assigned-by-dhcp.cox.net>
References: <440F945C.2010401@brocade.com>
	<7v7j74fgsh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ming Lei <mlei@brocade.com>
X-From: git-owner@vger.kernel.org Thu Mar 09 11:37:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHIWL-0005LR-Uc
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 11:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWCIKhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 05:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWCIKhN
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 05:37:13 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:11652 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751809AbWCIKhL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 05:37:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309103553.OZXT3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 05:35:53 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17406>

The fsck-objects command (back then it was called fsck-cache)
used to complain if objects referred to by files in .git/refs/
or objects stored in files under .git/objects/??/ were not found
as stand-alone SHA1 files (i.e.  found in alternate object pools
or packed archives stored under .git/objects/pack).  Back then,
packs and alternates were new curiosity and having everything as
loose objects were the norm.

When we adjusted the behaviour of fsck-cache to consider objects
found in packs are OK, we introduced the --standalone flag as a
backward compatibility measure.

It still correctly checks if your repository is complete and
consists only of loose objects, so in that sense it is doing the
"right" thing, but checking that is pointless these days.  This
commit removes --standalone flag.

See also:

	23676d407c63a6f67f8ce3ff192199bda03e6a03
	8a498a05c3c6b2f53db669b24f36257ab213eb4c

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * The flag itself is harmless and it still is working as
   advertized and documented, but I think it outlived its
   usefulness.  I do not expect any objections against the
   removal but just in case...

 Documentation/git-fsck-objects.txt |   15 ++++-----------
 fsck-objects.c                     |   18 ++++--------------
 2 files changed, 8 insertions(+), 25 deletions(-)

8f9c5c27d9d5dfe0a5f26646e39ebc48df0eb25c
diff --git a/Documentation/git-fsck-objects.txt b/Documentation/git-fsck-objects.txt
index 387b435..93ce9dc 100644
--- a/Documentation/git-fsck-objects.txt
+++ b/Documentation/git-fsck-objects.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-fsck-objects' [--tags] [--root] [--unreachable] [--cache]
-		 [--standalone | --full] [--strict] [<object>*]
+		 [--full] [--strict] [<object>*]
 
 DESCRIPTION
 -----------
@@ -38,21 +38,14 @@ index file and all SHA1 references in .g
 	Consider any object recorded in the index also as a head node for
 	an unreachability trace.
 
---standalone::
-	Limit checks to the contents of GIT_OBJECT_DIRECTORY
-	($GIT_DIR/objects), making sure that it is consistent and
-	complete without referring to objects found in alternate
-	object pools listed in GIT_ALTERNATE_OBJECT_DIRECTORIES,
-	nor packed git archives found in $GIT_DIR/objects/pack;
-	cannot be used with --full.
-
 --full::
 	Check not just objects in GIT_OBJECT_DIRECTORY
 	($GIT_DIR/objects), but also the ones found in alternate
-	object pools listed in GIT_ALTERNATE_OBJECT_DIRECTORIES,
+	object pools listed in GIT_ALTERNATE_OBJECT_DIRECTORIES
+	or $GIT_DIR/objects/info/alternates,
 	and in packed git archives found in $GIT_DIR/objects/pack
 	and corresponding pack subdirectories in alternate
-	object pools; cannot be used with --standalone.
+	object pools.
 
 --strict::
 	Enable more strict checking, namely to catch a file mode
diff --git a/fsck-objects.c b/fsck-objects.c
index 4ddd676..9cc8572 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -14,7 +14,6 @@
 static int show_root = 0;
 static int show_tags = 0;
 static int show_unreachable = 0;
-static int standalone = 0;
 static int check_full = 0;
 static int check_strict = 0;
 static int keep_cache_objects = 0; 
@@ -68,7 +67,7 @@ static void check_connectivity(void)
 			continue;
 
 		if (!obj->parsed) {
-			if (!standalone && has_sha1_file(obj->sha1))
+			if (has_sha1_file(obj->sha1))
 				; /* it is in pack */
 			else
 				printf("missing %s %s\n",
@@ -82,7 +81,7 @@ static void check_connectivity(void)
 			for (j = 0; j < refs->count; j++) {
 				struct object *ref = refs->ref[j];
 				if (ref->parsed ||
-				    (!standalone && has_sha1_file(ref->sha1)))
+				    (has_sha1_file(ref->sha1)))
 					continue;
 				printf("broken link from %7s %s\n",
 				       obj->type, sha1_to_hex(obj->sha1));
@@ -390,7 +389,7 @@ static int fsck_handle_ref(const char *r
 
 	obj = lookup_object(sha1);
 	if (!obj) {
-		if (!standalone && has_sha1_file(sha1)) {
+		if (has_sha1_file(sha1)) {
 			default_refs++;
 			return 0; /* it is in a pack */
 		}
@@ -464,10 +463,6 @@ int main(int argc, char **argv)
 			keep_cache_objects = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--standalone")) {
-			standalone = 1;
-			continue;
-		}
 		if (!strcmp(arg, "--full")) {
 			check_full = 1;
 			continue;
@@ -477,14 +472,9 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (*arg == '-')
-			usage("git-fsck-objects [--tags] [--root] [[--unreachable] [--cache] [--standalone | --full] [--strict] <head-sha1>*]");
+			usage("git-fsck-objects [--tags] [--root] [[--unreachable] [--cache] [--full] [--strict] <head-sha1>*]");
 	}
 
-	if (standalone && check_full)
-		die("Only one of --standalone or --full can be used.");
-	if (standalone)
-		putenv("GIT_ALTERNATE_OBJECT_DIRECTORIES=");
-
 	fsck_head_link();
 	fsck_object_dir(get_object_directory());
 	if (check_full) {
-- 
1.2.4.g2acc
