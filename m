From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] Update fsck-cache (take 2)
Date: Tue, 28 Jun 2005 14:58:33 -0700
Message-ID: <7vhdfita7q.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
	<7vslz2x3vg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 23:57:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnO4q-0004kg-W4
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 23:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVF1WDi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 18:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVF1WCV
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 18:02:21 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42629 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261525AbVF1V6j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 17:58:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628215834.IBGV1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Jun 2005 17:58:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vslz2x3vg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 28 Jun 2005 01:49:39 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The fsck-cache complains if objects referred to by files in
.git/refs/ or objects stored in files under .git/objects/??/ are
not found as stand-alone SHA1 files (i.e. found in alternate
object pools GIT_ALTERNATE_OBJECT_DIRECTORIES or packed archives
stored under .git/objects/pack).

Although this is a good semantics to maintain consistency of a
single .git/objects directory as a self contained set of
objects, it sometimes is useful to consider it is OK as long as
these "outside" objects are available.

This commit introduces a new flag, --standalone, to
git-fsck-cache.  When it is not specified, connectivity checks
and .git/refs pointer checks are taught that it is OK when
expected objects do not exist under .git/objects/?? hierarchy
but are available from an packed archive or in an alternate
object pool.

Another new flag, --full, makes git-fsck-cache to check not only
the current GIT_OBJECT_DIRECTORY but also objects found in
alternate object pools and packed GIT archives.a

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** This completes "the other half" the fsck updates I did last
*** night was missing.  Please discard that one and use this
*** instead.

 Documentation/git-fsck-cache.txt |   18 +++++++++-
 fsck-cache.c                     |   71 ++++++++++++++++++++++++++++++++------
 2 files changed, 76 insertions(+), 13 deletions(-)

5cae1fa43bfeae6722d916aa764fa75d9ce1839a
diff --git a/Documentation/git-fsck-cache.txt b/Documentation/git-fsck-cache.txt
--- a/Documentation/git-fsck-cache.txt
+++ b/Documentation/git-fsck-cache.txt
@@ -9,7 +9,7 @@ git-fsck-cache - Verifies the connectivi
 
 SYNOPSIS
 --------
-'git-fsck-cache' [--tags] [--root] [--unreachable] [--cache] [<object>*]
+'git-fsck-cache' [--tags] [--root] [--unreachable] [--cache] [--standalone | --full] [<object>*]
 
 DESCRIPTION
 -----------
@@ -37,6 +37,22 @@ OPTIONS
 	Consider any object recorded in the cache also as a head node for
 	an unreachability trace.
 
+--standalone::
+	Limit checks to the contents of GIT_OBJECT_DIRECTORY
+	(.git/objects), making sure that it is consistent and
+	complete without referring to objects found in alternate
+	object pools listed in GIT_ALTERNATE_OBJECT_DIRECTORIES,
+	nor packed GIT archives found in .git/objects/pack;
+	cannot be used with --full.
+
+--full::
+	Check not just objects in GIT_OBJECT_DIRECTORY
+	(.git/objects), but also the ones found in alternate
+	object pools listed in GIT_ALTERNATE_OBJECT_DIRECTORIES,
+	and in packed GIT archives found in .git/objects/pack
+	and corresponding pack subdirectories in alternate
+	object pools; cannot be used with --standalone.
+
 It tests SHA1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
diff --git a/fsck-cache.c b/fsck-cache.c
--- a/fsck-cache.c
+++ b/fsck-cache.c
@@ -12,6 +12,8 @@
 static int show_root = 0;
 static int show_tags = 0;
 static int show_unreachable = 0;
+static int standalone = 0;
+static int check_full = 0;
 static int keep_cache_objects = 0; 
 static unsigned char head_sha1[20];
 
@@ -25,13 +27,17 @@ static void check_connectivity(void)
 		struct object_list *refs;
 
 		if (!obj->parsed) {
-			printf("missing %s %s\n",
-			       obj->type, sha1_to_hex(obj->sha1));
+			if (!standalone && has_sha1_file(obj->sha1))
+				; /* it is in pack */
+			else
+				printf("missing %s %s\n",
+				       obj->type, sha1_to_hex(obj->sha1));
 			continue;
 		}
 
 		for (refs = obj->refs; refs; refs = refs->next) {
-			if (refs->item->parsed)
+			if (refs->item->parsed ||
+			    (!standalone && has_sha1_file(refs->item->sha1)))
 				continue;
 			printf("broken link from %7s %s\n",
 			       obj->type, sha1_to_hex(obj->sha1));
@@ -315,8 +321,11 @@ static int read_sha1_reference(const cha
 		return -1;
 
 	obj = lookup_object(sha1);
-	if (!obj)
+	if (!obj) {
+		if (!standalone && has_sha1_file(sha1))
+			return 0; /* it is in pack */
 		return error("%s: invalid sha1 pointer %.40s", path, hexname);
+	}
 
 	obj->used = 1;
 	mark_reachable(obj, REACHABLE);
@@ -366,10 +375,20 @@ static void get_default_heads(void)
 		die("No default references");
 }
 
+static void fsck_object_dir(const char *path)
+{
+	int i;
+	for (i = 0; i < 256; i++) {
+		static char dir[4096];
+		sprintf(dir, "%s/%02x", path, i);
+		fsck_dir(i, dir);
+	}
+	fsck_sha1_list();
+}
+
 int main(int argc, char **argv)
 {
 	int i, heads;
-	char *sha1_dir;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -390,17 +409,45 @@ int main(int argc, char **argv)
 			keep_cache_objects = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--standalone")) {
+			standalone = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--full")) {
+			check_full = 1;
+			continue;
+		}
 		if (*arg == '-')
-			usage("git-fsck-cache [--tags] [[--unreachable] [--cache] <head-sha1>*]");
+			usage("git-fsck-cache [--tags] [[--unreachable] [--cache] [--standalone | --full] <head-sha1>*]");
 	}
 
-	sha1_dir = get_object_directory();
-	for (i = 0; i < 256; i++) {
-		static char dir[4096];
-		sprintf(dir, "%s/%02x", sha1_dir, i);
-		fsck_dir(i, dir);
+	if (standalone && check_full)
+		die("Only one of --standalone or --full can be used.");
+	if (standalone)
+		unsetenv("GIT_ALTERNATE_OBJECT_DIRECTORIES");
+
+	fsck_object_dir(get_object_directory());
+	if (check_full) {
+		int j;
+		struct packed_git *p;
+		prepare_alt_odb();
+		for (j = 0; alt_odb[j].base; j++) {
+			alt_odb[j].name[-1] = 0; /* was slash */
+			fsck_object_dir(alt_odb[j].base);
+			alt_odb[j].name[-1] = '/';
+		}
+		prepare_packed_git();
+		for (p = packed_git; p; p = p->next) {
+			int num = num_packed_objects(p);
+			for (i = 0; i < num; i++) {
+				unsigned char sha1[20];
+				nth_packed_object_sha1(p, i, sha1);
+				if (fsck_sha1(sha1) < 0)
+					fprintf(stderr, "bad sha1 entry '%s'\n", sha1_to_hex(sha1));
+
+			}
+		}
 	}
-	fsck_sha1_list();
 
 	heads = 0;
 	for (i = 1; i < argc; i++) {
------------
