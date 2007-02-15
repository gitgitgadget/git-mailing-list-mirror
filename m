From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Dissociating a repository from its alternates
Date: Wed, 14 Feb 2007 23:51:13 -0800
Message-ID: <7vabzfhn9q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 08:51:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHbOr-0007iF-Jl
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 08:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbXBOHvQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 02:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbXBOHvP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 02:51:15 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50445 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964925AbXBOHvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 02:51:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070215075114.XXWU22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Feb 2007 02:51:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PjrD1W00G1kojtg0000000; Thu, 15 Feb 2007 02:51:14 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39799>

People often start out with "clone -l -s" (or --reference) and
later wish to dissociate the repository from its alternates.
The new option -A to "git repack" lets you do so.

What it does:

 - git-pack-objects gets a new option --ignore-alternate-pack.
   The command used in git-repack is told to pack only unpacked
   objects in general, but also is told to pretend objects in
   packs in the local repository are unpacked (this is necessary
   to keep historical huge packs marked with .keep files without
   repacking).  This new option tells it to also pretend that
   objects from packs in alternate repositories are unpacked, to
   make them subject to packing.

 - code to parse revision traversal options gets an additional
   bit, ignore_alternate_pack.

 - has_sha1_pack() function gets an additional argument for that
   bit.  Existing callers pass 0 to it (they continue to behave
   as before).

 - git-repack obviously understands the new -A option.  When it
   is given, it passes --ignore-alternate-pack option to
   git-pack-objects to include objects from borrowed packs in
   the result, and $GIT_OBJECT_DIRECTORY/info/alternates file is
   removed at the end.

The patch was tested very lightly, and I haven't verified the
interactions between various options git-repack takes, and
options it passes to git-pack-objects (especially, I think
interaction with --local and --incremental might be dubious).

Because a bug in git-repack has real risk of corrupting
repository in a bad way, somebody else needs to double check
this patch, if we were to do this.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 builtin-count-objects.c |    2 +-
 builtin-pack-objects.c  |    1 +
 builtin-prune-packed.c  |    2 +-
 cache.h                 |    2 +-
 diff.c                  |    2 +-
 git-repack.sh           |   30 ++++++++++++++++++++++--------
 revision.c              |   12 +++++++++---
 revision.h              |    1 +
 sha1_file.c             |   16 +++++++++-------
 9 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index f5b22bb..10c8860 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -62,7 +62,7 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 		hex[40] = 0;
 		if (get_sha1_hex(hex, sha1))
 			die("internal error");
-		if (has_sha1_pack(sha1, NULL))
+		if (has_sha1_pack(sha1, NULL, 0))
 			(*packed_loose)++;
 	}
 }
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 3824ee3..0f5d72c 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1623,6 +1623,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp("--unpacked", arg) ||
 		    !strncmp("--unpacked=", arg, 11) ||
+		    !strcmp("--ignore-alternate-pack", arg) ||
 		    !strcmp("--reflog", arg) ||
 		    !strcmp("--all", arg)) {
 			use_internal_rev_list = 1;
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 9777300..eb55c58 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -20,7 +20,7 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 		memcpy(hex+2, de->d_name, 38);
 		if (get_sha1_hex(hex, sha1))
 			continue;
-		if (!has_sha1_pack(sha1, NULL))
+		if (!has_sha1_pack(sha1, NULL, 0))
 			continue;
 		memcpy(pathname + len, de->d_name, 38);
 		if (opts & DRY_RUN)
diff --git a/cache.h b/cache.h
index c62b0b0..0c24318 100644
--- a/cache.h
+++ b/cache.h
@@ -266,7 +266,7 @@ extern int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 extern int write_sha1_to_fd(int fd, const unsigned char *sha1);
 extern int move_temp_to_file(const char *tmpfile, const char *filename);
 
-extern int has_sha1_pack(const unsigned char *sha1, const char **ignore);
+extern int has_sha1_pack(const unsigned char *sha1, const char **ignore, int ignore_alternates);
 extern int has_sha1_file(const unsigned char *sha1);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *);
 extern int legacy_loose_object(unsigned char *);
diff --git a/diff.c b/diff.c
index 12c8b2b..ee46960 100644
--- a/diff.c
+++ b/diff.c
@@ -1254,7 +1254,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * objects however would tend to be slower as they need
 	 * to be individually opened and inflated.
 	 */
-	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1, NULL))
+	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1, NULL, 0))
 		return 0;
 
 	len = strlen(name);
diff --git a/git-repack.sh b/git-repack.sh
index ddfa8b4..774286e 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -3,17 +3,18 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
-USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]'
+USAGE='[-a] [-A] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
-no_update_info= all_into_one= remove_redundant=
+no_update_info= all_into_one= remove_redundant= nuke_alternates=
 local= quiet= no_reuse_delta= extra=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
 	-n)	no_update_info=t ;;
 	-a)	all_into_one=t ;;
+	-A)	nuke_alternates=t ;;
 	-d)	remove_redundant=t ;;
 	-q)	quiet=-q ;;
 	-f)	no_reuse_delta=--no-reuse-delta ;;
@@ -28,8 +29,7 @@ done
 # Later we will default repack.UseDeltaBaseOffset to true
 default_dbo=false
 
-case "`git config --bool repack.usedeltabaseoffset ||
-       echo $default_dbo`" in
+case "`git config --bool repack.usedeltabaseoffset || echo $default_dbo`" in
 true)
 	extra="$extra --delta-base-offset" ;;
 esac
@@ -40,11 +40,14 @@ rm -f "$PACKTMP"-*
 trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
 
 # There will be more repacking strategies to come...
-case ",$all_into_one," in
-,,)
+case ",$all_into_one,$nuke_alternates," in
+,,,)
 	args='--unpacked --incremental'
 	;;
-,t,)
+,,t,)
+	args='--incremental --ignore-alternate-pack'
+	;;
+,t,*)
 	if [ -d "$PACKDIR" ]; then
 		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
 			| sed -e 's/^\.\///' -e 's/\.pack$//'`
@@ -57,7 +60,12 @@ case ",$all_into_one," in
 			fi
 		done
 	fi
-	[ -z "$args" ] && args='--unpacked --incremental'
+	case "$nuke_alternates" in
+	'')
+		[ -z "$args" ] && args='--unpacked --incremental' ;;
+	t)
+		args="$args --ignore-alternate-pack" ;;
+	esac
 	;;
 esac
 
@@ -113,6 +121,12 @@ then
 	git-prune-packed $quiet
 fi
 
+case "$nuke_alternates" in
+t)
+	rm -f "$GIT_OBJECT_DIRECTORY/info/alternates"
+	;;
+esac
+
 case "$no_update_info" in
 t) : ;;
 *) git-update-server-info ;;
diff --git a/revision.c b/revision.c
index 5b1794b..b9e33c3 100644
--- a/revision.c
+++ b/revision.c
@@ -949,6 +949,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				add_ignore_packed(revs, arg+11);
 				continue;
 			}
+			if (!strcmp(arg, "--ignore-alternate-pack")) {
+				revs->ignore_alternate_pack = 1;
+				continue;
+			}
 			if (!strcmp(arg, "-r")) {
 				revs->diff = 1;
 				revs->diffopt.recursive = 1;
@@ -1240,9 +1244,11 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		if (commit->object.flags & SHOWN)
 			continue;
 
-		if (revs->unpacked && has_sha1_pack(commit->object.sha1,
-						    revs->ignore_packed))
-		    continue;
+		if ((revs->unpacked || revs->ignore_alternate_pack) &&
+		    has_sha1_pack(commit->object.sha1,
+				  revs->ignore_packed,
+				  revs->ignore_alternate_pack))
+			continue;
 
 		/* We want to show boundary commits only when their
 		 * children are shown.  When path-limiter is in effect,
diff --git a/revision.h b/revision.h
index 5fec184..ca6affd 100644
--- a/revision.h
+++ b/revision.h
@@ -40,6 +40,7 @@ struct rev_info {
 			edge_hint:1,
 			limited:1,
 			unpacked:1, /* see also ignore_packed below */
+			ignore_alternate_pack:1,
 			boundary:1,
 			left_right:1,
 			parents:1,
diff --git a/sha1_file.c b/sha1_file.c
index b83f59f..2d8c0f2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1403,7 +1403,7 @@ static int matches_pack_name(struct packed_git *p, const char *ig)
 	return 1;
 }
 
-static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
+static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed, int ignore_alternates)
 {
 	struct packed_git *p;
 	unsigned long offset;
@@ -1419,6 +1419,8 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, cons
 			if (*ig)
 				continue;
 		}
+		if (ignore_alternates && !p->pack_local)
+			continue;
 		offset = find_pack_entry_one(sha1, p);
 		if (offset) {
 			/*
@@ -1485,9 +1487,9 @@ int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep
 {
 	struct pack_entry e;
 
-	if (!find_pack_entry(sha1, &e, NULL)) {
+	if (!find_pack_entry(sha1, &e, NULL, 0)) {
 		reprepare_packed_git();
-		if (!find_pack_entry(sha1, &e, NULL))
+		if (!find_pack_entry(sha1, &e, NULL, 0))
 			return sha1_loose_object_info(sha1, type, sizep);
 	}
 	return packed_object_info(e.p, e.offset, type, sizep);
@@ -1497,7 +1499,7 @@ static void *read_packed_sha1(const unsigned char *sha1, char *type, unsigned lo
 {
 	struct pack_entry e;
 
-	if (!find_pack_entry(sha1, &e, NULL))
+	if (!find_pack_entry(sha1, &e, NULL, 0))
 		return NULL;
 	else
 		return unpack_entry(e.p, e.offset, type, size);
@@ -2004,10 +2006,10 @@ int has_pack_file(const unsigned char *sha1)
 	return 1;
 }
 
-int has_sha1_pack(const unsigned char *sha1, const char **ignore_packed)
+int has_sha1_pack(const unsigned char *sha1, const char **ignore_packed, int ignore_alternates)
 {
 	struct pack_entry e;
-	return find_pack_entry(sha1, &e, ignore_packed);
+	return find_pack_entry(sha1, &e, ignore_packed, ignore_alternates);
 }
 
 int has_sha1_file(const unsigned char *sha1)
@@ -2015,7 +2017,7 @@ int has_sha1_file(const unsigned char *sha1)
 	struct stat st;
 	struct pack_entry e;
 
-	if (find_pack_entry(sha1, &e, NULL))
+	if (find_pack_entry(sha1, &e, NULL, 0))
 		return 1;
 	return find_sha1_file(sha1, &st) ? 1 : 0;
 }
