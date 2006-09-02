From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sat, 02 Sep 2006 03:09:32 -0700
Message-ID: <7vodty1swz.fsf@assigned-by-dhcp.cox.net>
References: <20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
	<Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
	<7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
	<20060902045246.GB25146@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 12:09:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJSRe-0005oI-14
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 12:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWIBKJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 06:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWIBKJb
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 06:09:31 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:6059 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750971AbWIBKJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 06:09:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902100930.NKZY20060.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 Sep 2006 06:09:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HN9Q1V00S1kojtg0000000
	Sat, 02 Sep 2006 06:09:25 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060902045246.GB25146@spearce.org> (Shawn Pearce's message of
	"Sat, 2 Sep 2006 00:52:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26326>

Shawn Pearce <spearce@spearce.org> writes:

> I think the better thing to do here is to not repack objects which
> are already contained in very large packs.  Just leave them be.

I've been thinking about updating rev-list so that repack
can be used to organize packs into zero or more "archive packs"
and one "active pack".

repack without -a essentially boils down to:

	rev-list --objects --all --unpacked |
        pack-objects $new_pack

which picks up all live loose objects and create a new pack.

If rev-list had an extention that lets you say

	rev-list --objects --all --unpacked=$active_pack |
	pack-objects $new_pack

instead, to mean "all live loose objects but pretend as if
objects that are in this pack are also unpacked", then the
newly created pack would be perfect for updating $active_pack
by replacing it.

Perhaps something like this.

-- >8 --

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 1d3729a..73c5982 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -62,7 +62,7 @@ static void count_objects(DIR *d, char *
 		hex[40] = 0;
 		if (get_sha1_hex(hex, sha1))
 			die("internal error");
-		if (has_sha1_pack(sha1))
+		if (has_sha1_pack(sha1, NULL))
 			(*packed_loose)++;
 	}
 }
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index d3dd94d..960db49 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -19,7 +19,7 @@ static void prune_dir(int i, DIR *dir, c
 		memcpy(hex+2, de->d_name, 38);
 		if (get_sha1_hex(hex, sha1))
 			continue;
-		if (!has_sha1_pack(sha1))
+		if (!has_sha1_pack(sha1, NULL))
 			continue;
 		memcpy(pathname + len, de->d_name, 38);
 		if (dryrun)
diff --git a/cache.h b/cache.h
index 7257c4c..b50a823 100644
--- a/cache.h
+++ b/cache.h
@@ -259,7 +259,7 @@ extern int write_sha1_from_fd(const unsi
 extern int write_sha1_to_fd(int fd, const unsigned char *sha1);
 extern int move_temp_to_file(const char *tmpfile, const char *filename);
 
-extern int has_sha1_pack(const unsigned char *sha1);
+extern int has_sha1_pack(const unsigned char *sha1, const char *ignore);
 extern int has_sha1_file(const unsigned char *sha1);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *);
 extern int legacy_loose_object(unsigned char *);
diff --git a/revision.c b/revision.c
index b588f74..fad3b24 100644
--- a/revision.c
+++ b/revision.c
@@ -416,7 +416,8 @@ static void limit_list(struct rev_info *
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
-		if (revs->unpacked && has_sha1_pack(obj->sha1))
+		if (revs->unpacked &&
+		    has_sha1_pack(obj->sha1, revs->ignore_packed))
 			obj->flags |= UNINTERESTING;
 		add_parents_to_list(revs, commit, &list);
 		if (obj->flags & UNINTERESTING) {
@@ -737,6 +738,12 @@ int setup_revisions(int argc, const char
 			}
 			if (!strcmp(arg, "--unpacked")) {
 				revs->unpacked = 1;
+				revs->ignore_packed = NULL;
+				continue;
+			}
+			if (!strncmp(arg, "--unpacked=", 11)) {
+				revs->unpacked = 1;
+				revs->ignore_packed = arg + 11;
 				continue;
 			}
 			if (!strcmp(arg, "-r")) {
@@ -1046,7 +1053,8 @@ struct commit *get_revision(struct rev_i
 		 */
 		if (!revs->limited) {
 			if ((revs->unpacked &&
-			     has_sha1_pack(commit->object.sha1)) ||
+			     has_sha1_pack(commit->object.sha1,
+					   revs->ignore_packed)) ||
 			    (revs->max_age != -1 &&
 			     (commit->date < revs->max_age)))
 				continue;
diff --git a/revision.h b/revision.h
index d289781..843aeea 100644
--- a/revision.h
+++ b/revision.h
@@ -57,6 +57,9 @@ struct rev_info {
 	unsigned int	shown_one:1,
 			abbrev_commit:1,
 			relative_date:1;
+
+	const char *ignore_packed;
+
 	unsigned int	abbrev;
 	enum cmit_fmt	commit_format;
 	struct log_info *loginfo;
diff --git a/sha1_file.c b/sha1_file.c
index 76f66e6..7031f65 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1189,12 +1189,15 @@ int find_pack_entry_one(const unsigned c
 	return 0;
 }
 
-static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
+static int find_pack_entry(const unsigned char *sha1,
+			   struct pack_entry *e, const char *ignore_packed)
 {
 	struct packed_git *p;
 	prepare_packed_git();
 
 	for (p = packed_git; p; p = p->next) {
+		if (ignore_packed && !strcmp(p->pack_name, ignore_packed))
+			continue;
 		if (find_pack_entry_one(sha1, e, p))
 			return 1;
 	}
@@ -1227,10 +1230,10 @@ int sha1_object_info(const unsigned char
 	if (!map) {
 		struct pack_entry e;
 
-		if (find_pack_entry(sha1, &e))
+		if (find_pack_entry(sha1, &e, NULL))
 			return packed_object_info(&e, type, sizep);
 		reprepare_packed_git();
-		if (find_pack_entry(sha1, &e))
+		if (find_pack_entry(sha1, &e, NULL))
 			return packed_object_info(&e, type, sizep);
 		return error("unable to find %s", sha1_to_hex(sha1));
 	}
@@ -1253,7 +1256,7 @@ static void *read_packed_sha1(const unsi
 {
 	struct pack_entry e;
 
-	if (!find_pack_entry(sha1, &e)) {
+	if (!find_pack_entry(sha1, &e, NULL)) {
 		error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 		return NULL;
 	}
@@ -1266,7 +1269,7 @@ void * read_sha1_file(const unsigned cha
 	void *map, *buf;
 	struct pack_entry e;
 
-	if (find_pack_entry(sha1, &e))
+	if (find_pack_entry(sha1, &e, NULL))
 		return read_packed_sha1(sha1, type, size);
 	map = map_sha1_file(sha1, &mapsize);
 	if (map) {
@@ -1275,7 +1278,7 @@ void * read_sha1_file(const unsigned cha
 		return buf;
 	}
 	reprepare_packed_git();
-	if (find_pack_entry(sha1, &e))
+	if (find_pack_entry(sha1, &e, NULL))
 		return read_packed_sha1(sha1, type, size);
 	return NULL;
 }
@@ -1707,10 +1710,10 @@ int has_pack_file(const unsigned char *s
 	return 1;
 }
 
-int has_sha1_pack(const unsigned char *sha1)
+int has_sha1_pack(const unsigned char *sha1, const char *ignore_packed)
 {
 	struct pack_entry e;
-	return find_pack_entry(sha1, &e);
+	return find_pack_entry(sha1, &e, ignore_packed);
 }
 
 int has_sha1_file(const unsigned char *sha1)
@@ -1718,7 +1721,7 @@ int has_sha1_file(const unsigned char *s
 	struct stat st;
 	struct pack_entry e;
 
-	if (find_pack_entry(sha1, &e))
+	if (find_pack_entry(sha1, &e, NULL))
 		return 1;
 	return find_sha1_file(sha1, &st) ? 1 : 0;
 }


-- 
VGER BF report: U 0.5
