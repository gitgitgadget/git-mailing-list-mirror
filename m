From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Check for PRIuMAX rather than NO_C99_FORMAT in fast-import.c.
Date: Tue, 20 Feb 2007 17:34:56 -0800
Message-ID: <27484.1172021696@lotus.CS.Berkeley.EDU>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 02:35:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJgNr-0001kw-EA
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 02:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbXBUBe7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 20:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbXBUBe7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 20:34:59 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:33813 "EHLO
	lotus.CS.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbXBUBe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 20:34:58 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id l1L1Yvc6027490
	for <git@vger.kernel.org>; Tue, 20 Feb 2007 17:34:57 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id l1L1YvOJ027487
	for <git@vger.kernel.org>; Tue, 20 Feb 2007 17:34:57 -0800 (PST)
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.0.92
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40273>

Thanks to Simon 'corecode' Schubert <corecode@fs.ei.tum.de> for
the clean-up.  Defining the C99 standard PRIuMAX when necessary
replaces UM_FMT and the awkward UM10_FMT.  There are no direct
C99 translations for other uses of NO_C99_FORMAT in git, alas.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>
---
 fast-import.c |   37 ++++++++++++++++---------------------
 1 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 8720090..1ae125a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -133,13 +133,8 @@ Format of STDIN stream:
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
 
-#if !defined(NO_C99_FORMAT)
-#define UM_FMT "%ju"
-#define UM10_FMT "%10ju"
-#else
-/* Assumes unsigned long long exists. */
-#define UM_FMT "%llu"
-#define UM10_FMT "%10llu"
+#ifndef PRIuMAX
+#define PRIuMAX "llu"
 #endif
 
 struct object_entry
@@ -484,7 +479,7 @@ static struct object_entry *find_mark(uintmax_t idnum)
 			oe = s->data.marked[idnum];
 	}
 	if (!oe)
-		die("mark :" UM_FMT " not declared", orig_idnum);
+		die("mark :%" PRIuMAX " not declared", orig_idnum);
 	return oe;
 }
 
@@ -1370,7 +1365,7 @@ static void dump_marks_helper(FILE *f,
 	} else {
 		for (k = 0; k < 1024; k++) {
 			if (m->data.marked[k])
-				fprintf(f, ":" UM_FMT " %s\n", base + k,
+				fprintf(f, ":%" PRIuMAX " %s\n", base + k,
 					sha1_to_hex(m->data.marked[k]->sha1));
 		}
 	}
@@ -1696,7 +1691,7 @@ static void cmd_from(struct branch *b)
 		unsigned long size;
 		char *buf;
 		if (oe->type != OBJ_COMMIT)
-			die("Mark :" UM_FMT " not a commit", idnum);
+			die("Mark :%" PRIuMAX " not a commit", idnum);
 		hashcpy(b->sha1, oe->sha1);
 		buf = gfi_unpack_entry(oe, &size);
 		if (!buf || size < 46)
@@ -1749,7 +1744,7 @@ static struct hash_list *cmd_merge(unsigned int *count)
 			uintmax_t idnum = strtoumax(from + 1, NULL, 10);
 			struct object_entry *oe = find_mark(idnum);
 			if (oe->type != OBJ_COMMIT)
-				die("Mark :" UM_FMT " not a commit", idnum);
+				die("Mark :%" PRIuMAX " not a commit", idnum);
 			hashcpy(n->sha1, oe->sha1);
 		} else if (get_sha1(from, n->sha1))
 			die("Invalid ref name or SHA1 expression: %s", from);
@@ -1893,7 +1888,7 @@ static void cmd_new_tag(void)
 		from_mark = strtoumax(from + 1, NULL, 10);
 		oe = find_mark(from_mark);
 		if (oe->type != OBJ_COMMIT)
-			die("Mark :" UM_FMT " not a commit", from_mark);
+			die("Mark :%" PRIuMAX " not a commit", from_mark);
 		hashcpy(sha1, oe->sha1);
 	} else if (!get_sha1(from, sha1)) {
 		unsigned long size;
@@ -2068,18 +2063,18 @@ int main(int argc, const char **argv)
 
 		fprintf(stderr, "%s statistics:\n", argv[0]);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
-		fprintf(stderr, "Alloc'd objects: " UM10_FMT "\n", alloc_count);
-		fprintf(stderr, "Total objects:   " UM10_FMT " (" UM10_FMT " duplicates                  )\n", total_count, duplicate_count);
-		fprintf(stderr, "      blobs  :   " UM10_FMT " (" UM10_FMT " duplicates " UM10_FMT " deltas)\n", object_count_by_type[OBJ_BLOB], duplicate_count_by_type[OBJ_BLOB], delta_count_by_type[OBJ_BLOB]);
-		fprintf(stderr, "      trees  :   " UM10_FMT " (" UM10_FMT " duplicates " UM10_FMT " deltas)\n", object_count_by_type[OBJ_TREE], duplicate_count_by_type[OBJ_TREE], delta_count_by_type[OBJ_TREE]);
-		fprintf(stderr, "      commits:   " UM10_FMT " (" UM10_FMT " duplicates " UM10_FMT " deltas)\n", object_count_by_type[OBJ_COMMIT], duplicate_count_by_type[OBJ_COMMIT], delta_count_by_type[OBJ_COMMIT]);
-		fprintf(stderr, "      tags   :   " UM10_FMT " (" UM10_FMT " duplicates " UM10_FMT " deltas)\n", object_count_by_type[OBJ_TAG], duplicate_count_by_type[OBJ_TAG], delta_count_by_type[OBJ_TAG]);
+		fprintf(stderr, "Alloc'd objects: %10" PRIuMAX "\n", alloc_count);
+		fprintf(stderr, "Total objects:   %10" PRIuMAX " (%10" PRIuMAX " duplicates                  )\n", total_count, duplicate_count);
+		fprintf(stderr, "      blobs  :   %10" PRIuMAX " (%10" PRIuMAX " duplicates %10" PRIuMAX " deltas)\n", object_count_by_type[OBJ_BLOB], duplicate_count_by_type[OBJ_BLOB], delta_count_by_type[OBJ_BLOB]);
+		fprintf(stderr, "      trees  :   %10" PRIuMAX " (%10" PRIuMAX " duplicates %10" PRIuMAX " deltas)\n", object_count_by_type[OBJ_TREE], duplicate_count_by_type[OBJ_TREE], delta_count_by_type[OBJ_TREE]);
+		fprintf(stderr, "      commits:   %10" PRIuMAX " (%10" PRIuMAX " duplicates %10" PRIuMAX " deltas)\n", object_count_by_type[OBJ_COMMIT], duplicate_count_by_type[OBJ_COMMIT], delta_count_by_type[OBJ_COMMIT]);
+		fprintf(stderr, "      tags   :   %10" PRIuMAX " (%10" PRIuMAX " duplicates %10" PRIuMAX " deltas)\n", object_count_by_type[OBJ_TAG], duplicate_count_by_type[OBJ_TAG], delta_count_by_type[OBJ_TAG]);
 		fprintf(stderr, "Total branches:  %10lu (%10lu loads     )\n", branch_count, branch_load_count);
-		fprintf(stderr, "      marks:     " UM10_FMT " (" UM10_FMT " unique    )\n", (((uintmax_t)1) << marks->shift) * 1024, marks_set_count);
+		fprintf(stderr, "      marks:     %10" PRIuMAX " (%10" PRIuMAX " unique    )\n", (((uintmax_t)1) << marks->shift) * 1024, marks_set_count);
 		fprintf(stderr, "      atoms:     %10u\n", atom_cnt);
-		fprintf(stderr, "Memory total:    " UM10_FMT " KiB\n", (total_allocd + alloc_count*sizeof(struct object_entry))/1024);
+		fprintf(stderr, "Memory total:    %10" PRIuMAX " KiB\n", (total_allocd + alloc_count*sizeof(struct object_entry))/1024);
 		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)(total_allocd/1024));
-		fprintf(stderr, "     objects:    " UM10_FMT " KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
+		fprintf(stderr, "     objects:    %10" PRIuMAX " KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
 		pack_report();
 		fprintf(stderr, "---------------------------------------------------------------------\n");
-- 
1.5.0.1.4.gd41a
