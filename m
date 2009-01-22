From: Lars Hjemli <hjemli@gmail.com>
Subject: [RFC/PATCH v3 2/3] sha1_file: prepare for adding alternates on demand
Date: Thu, 22 Jan 2009 22:17:50 +0100
Message-ID: <1232659071-14401-3-git-send-email-hjemli@gmail.com>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>
 <1232659071-14401-2-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 22:20:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ6y3-000087-AO
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 22:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbZAVVSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 16:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbZAVVSO
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 16:18:14 -0500
Received: from mail46.e.nsc.no ([193.213.115.46]:54184 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758083AbZAVVSG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 16:18:06 -0500
Received: from localhost.localdomain (ti0025a380-2706.bb.online.no [83.108.109.152])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id n0MLHvZm012659;
	Thu, 22 Jan 2009 22:17:58 +0100 (MET)
X-Mailer: git-send-email 1.6.1.150.g5e733b
In-Reply-To: <1232659071-14401-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106786>

The new function add_alt_odb() can be used to add alternate object
databases dynamically (i.e. after parsing of objects/info/alternates).
It will be used by git-archive to implement inclusion of submodules
by adding submodule object databases during tree traversal.

To make the function usable from call-sites which doesn't require the
add_alt_odb() to succeed, it takes a 'quiet' parameter which is passed
on to the underlying alt-odb-related functions.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 cache.h     |    1 +
 sha1_file.c |   40 +++++++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index 8e1af26..ccfad5f 100644
--- a/cache.h
+++ b/cache.h
@@ -724,6 +724,7 @@ extern struct alternate_object_database {
 	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
+extern int add_alt_odb(char *path, int quiet);
 extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern void foreach_alt_odb(alt_odb_fn, void*);
diff --git a/sha1_file.c b/sha1_file.c
index f08493f..8b5540d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -235,7 +235,7 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 struct alternate_object_database *alt_odb_list;
 static struct alternate_object_database **alt_odb_tail;
 
-static void read_info_alternates(const char * alternates, int depth);
+static void read_info_alternates(const char * alternates, int depth, int quiet);
 
 /*
  * Prepare alternate object database registry.
@@ -252,7 +252,8 @@ static void read_info_alternates(const char * alternates, int depth);
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static int link_alt_odb_entry(const char * entry, int len, const char * relative_base, int depth)
+static int link_alt_odb_entry(const char * entry, int len,
+			      const char * relative_base, int depth, int quiet)
 {
 	const char *objdir = get_object_directory();
 	struct alternate_object_database *ent;
@@ -285,9 +286,10 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(ent->base)) {
-		error("object directory %s does not exist; "
-		      "check .git/objects/info/alternates.",
-		      ent->base);
+		if (!quiet)
+			error("object directory %s does not exist; "
+			      "check .git/objects/info/alternates.",
+			      ent->base);
 		free(ent);
 		return -1;
 	}
@@ -312,7 +314,7 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 	ent->next = NULL;
 
 	/* recursively add alternates */
-	read_info_alternates(ent->base, depth + 1);
+	read_info_alternates(ent->base, depth + 1, quiet);
 
 	ent->base[pfxlen] = '/';
 
@@ -320,7 +322,8 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 }
 
 static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
-				 const char *relative_base, int depth)
+				 const char *relative_base, int depth,
+				 int quiet)
 {
 	const char *cp, *last;
 
@@ -343,11 +346,12 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 			cp++;
 		if (last != cp) {
 			if (!is_absolute_path(last) && depth) {
+				if (!quiet)
 				error("%s: ignoring relative alternate object store %s",
 						relative_base, last);
 			} else {
 				link_alt_odb_entry(last, cp - last,
-						relative_base, depth);
+						relative_base, depth, quiet);
 			}
 		}
 		while (cp < ep && *cp == sep)
@@ -356,7 +360,8 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 	}
 }
 
-static void read_info_alternates(const char * relative_base, int depth)
+static void read_info_alternates(const char * relative_base, int depth,
+				 int quiet)
 {
 	char *map;
 	size_t mapsz;
@@ -380,7 +385,8 @@ static void read_info_alternates(const char * relative_base, int depth)
 	map = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	link_alt_odb_entries(map, map + mapsz, '\n', relative_base, depth);
+	link_alt_odb_entries(map, map + mapsz, '\n', relative_base, depth,
+			     quiet);
 
 	munmap(map, mapsz);
 }
@@ -394,7 +400,7 @@ void add_to_alternates_file(const char *reference)
 	if (commit_lock_file(lock))
 		die("could not close alternates file");
 	if (alt_odb_tail)
-		link_alt_odb_entries(alt, alt + strlen(alt), '\n', NULL, 0);
+		link_alt_odb_entries(alt, alt + strlen(alt), '\n', NULL, 0, 0);
 }
 
 void foreach_alt_odb(alt_odb_fn fn, void *cb)
@@ -418,9 +424,9 @@ void prepare_alt_odb(void)
 	if (!alt) alt = "";
 
 	alt_odb_tail = &alt_odb_list;
-	link_alt_odb_entries(alt, alt + strlen(alt), PATH_SEP, NULL, 0);
+	link_alt_odb_entries(alt, alt + strlen(alt), PATH_SEP, NULL, 0, 0);
 
-	read_info_alternates(get_object_directory(), 0);
+	read_info_alternates(get_object_directory(), 0, 0);
 }
 
 static int has_loose_object_local(const unsigned char *sha1)
@@ -2573,3 +2579,11 @@ int read_pack_header(int fd, struct pack_header *header)
 		return PH_ERROR_PROTOCOL;
 	return 0;
 }
+
+int add_alt_odb(char *path, int quiet)
+{
+	int err = link_alt_odb_entry(path, strlen(path), NULL, 0, quiet);
+	if (!err)
+		prepare_packed_git_one(path, 0);
+	return err;
+}
-- 
1.6.1.150.g5e733b
