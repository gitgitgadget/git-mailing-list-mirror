From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Obey NO_C99_FORMAT in fast-import.c.
Date: Mon, 19 Feb 2007 16:27:09 -0800
Message-ID: <17825.1171931229@lotus.CS.Berkeley.EDU>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJIrd-00074b-RD
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965715AbXBTA1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965709AbXBTA1N
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:27:13 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:33715 "EHLO
	lotus.CS.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965707AbXBTA1K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:27:10 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id l1K0R9c6017842
	for <git@vger.kernel.org>; Mon, 19 Feb 2007 16:27:09 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id l1K0R9a3017839
	for <git@vger.kernel.org>; Mon, 19 Feb 2007 16:27:09 -0800 (PST)
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.0.92
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40174>

Define UM_FMT and UM10_FMT and use in place of %ju and %10ju,
respectively.  Both format as unsigned long long, so this
assumes the compiler supports long long.

Signed-off-by: Jason Riedy <jason@acm.org>
---
   If there's need, I could add a NO_LONGLONG.

 fast-import.c |   37 +++++++++++++++++++++++--------------
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 404d911..ad32300 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -133,6 +133,15 @@ Format of STDIN stream:
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
 
+#if !defined(NO_C99_FORMAT)
+#define UM_FMT "%ju"
+#define UM10_FMT "%10ju"
+#else
+/* Assumes unsigned long long exists. */
+#define UM_FMT "%llu"
+#define UM10_FMT "%10llu"
+#endif
+
 struct object_entry
 {
 	struct object_entry *next;
@@ -475,7 +484,7 @@ static struct object_entry *find_mark(uintmax_t idnum)
 			oe = s->data.marked[idnum];
 	}
 	if (!oe)
-		die("mark :%ju not declared", orig_idnum);
+		die("mark :" UM_FMT " not declared", orig_idnum);
 	return oe;
 }
 
@@ -1361,7 +1370,7 @@ static void dump_marks_helper(FILE *f,
 	} else {
 		for (k = 0; k < 1024; k++) {
 			if (m->data.marked[k])
-				fprintf(f, ":%ju %s\n", base + k,
+				fprintf(f, ":" UM_FMT " %s\n", base + k,
 					sha1_to_hex(m->data.marked[k]->sha1));
 		}
 	}
@@ -1687,7 +1696,7 @@ static void cmd_from(struct branch *b)
 		unsigned long size;
 		char *buf;
 		if (oe->type != OBJ_COMMIT)
-			die("Mark :%ju not a commit", idnum);
+			die("Mark :" UM_FMT " not a commit", idnum);
 		hashcpy(b->sha1, oe->sha1);
 		buf = gfi_unpack_entry(oe, &size);
 		if (!buf || size < 46)
@@ -1740,7 +1749,7 @@ static struct hash_list *cmd_merge(unsigned int *count)
 			uintmax_t idnum = strtoumax(from + 1, NULL, 10);
 			struct object_entry *oe = find_mark(idnum);
 			if (oe->type != OBJ_COMMIT)
-				die("Mark :%ju not a commit", idnum);
+				die("Mark :" UM_FMT " not a commit", idnum);
 			hashcpy(n->sha1, oe->sha1);
 		} else if (get_sha1(from, n->sha1))
 			die("Invalid ref name or SHA1 expression: %s", from);
@@ -1884,7 +1893,7 @@ static void cmd_new_tag(void)
 		from_mark = strtoumax(from + 1, NULL, 10);
 		oe = find_mark(from_mark);
 		if (oe->type != OBJ_COMMIT)
-			die("Mark :%ju not a commit", from_mark);
+			die("Mark :" UM_FMT " not a commit", from_mark);
 		hashcpy(sha1, oe->sha1);
 	} else if (!get_sha1(from, sha1)) {
 		unsigned long size;
@@ -2059,18 +2068,18 @@ int main(int argc, const char **argv)
 
 		fprintf(stderr, "%s statistics:\n", argv[0]);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
-		fprintf(stderr, "Alloc'd objects: %10ju\n", alloc_count);
-		fprintf(stderr, "Total objects:   %10ju (%10ju duplicates                  )\n", total_count, duplicate_count);
-		fprintf(stderr, "      blobs  :   %10ju (%10ju duplicates %10ju deltas)\n", object_count_by_type[OBJ_BLOB], duplicate_count_by_type[OBJ_BLOB], delta_count_by_type[OBJ_BLOB]);
-		fprintf(stderr, "      trees  :   %10ju (%10ju duplicates %10ju deltas)\n", object_count_by_type[OBJ_TREE], duplicate_count_by_type[OBJ_TREE], delta_count_by_type[OBJ_TREE]);
-		fprintf(stderr, "      commits:   %10ju (%10ju duplicates %10ju deltas)\n", object_count_by_type[OBJ_COMMIT], duplicate_count_by_type[OBJ_COMMIT], delta_count_by_type[OBJ_COMMIT]);
-		fprintf(stderr, "      tags   :   %10ju (%10ju duplicates %10ju deltas)\n", object_count_by_type[OBJ_TAG], duplicate_count_by_type[OBJ_TAG], delta_count_by_type[OBJ_TAG]);
+		fprintf(stderr, "Alloc'd objects: " UM10_FMT "\n", alloc_count);
+		fprintf(stderr, "Total objects:   " UM10_FMT " (" UM10_FMT " duplicates                  )\n", total_count, duplicate_count);
+		fprintf(stderr, "      blobs  :   " UM10_FMT " (" UM10_FMT " duplicates " UM10_FMT " deltas)\n", object_count_by_type[OBJ_BLOB], duplicate_count_by_type[OBJ_BLOB], delta_count_by_type[OBJ_BLOB]);
+		fprintf(stderr, "      trees  :   " UM10_FMT " (" UM10_FMT " duplicates " UM10_FMT " deltas)\n", object_count_by_type[OBJ_TREE], duplicate_count_by_type[OBJ_TREE], delta_count_by_type[OBJ_TREE]);
+		fprintf(stderr, "      commits:   " UM10_FMT " (" UM10_FMT " duplicates " UM10_FMT " deltas)\n", object_count_by_type[OBJ_COMMIT], duplicate_count_by_type[OBJ_COMMIT], delta_count_by_type[OBJ_COMMIT]);
+		fprintf(stderr, "      tags   :   " UM10_FMT " (" UM10_FMT " duplicates " UM10_FMT " deltas)\n", object_count_by_type[OBJ_TAG], duplicate_count_by_type[OBJ_TAG], delta_count_by_type[OBJ_TAG]);
 		fprintf(stderr, "Total branches:  %10lu (%10lu loads     )\n", branch_count, branch_load_count);
-		fprintf(stderr, "      marks:     %10ju (%10ju unique    )\n", (((uintmax_t)1) << marks->shift) * 1024, marks_set_count);
+		fprintf(stderr, "      marks:     " UM10_FMT " (" UM10_FMT " unique    )\n", (((uintmax_t)1) << marks->shift) * 1024, marks_set_count);
 		fprintf(stderr, "      atoms:     %10u\n", atom_cnt);
-		fprintf(stderr, "Memory total:    %10ju KiB\n", (total_allocd + alloc_count*sizeof(struct object_entry))/1024);
+		fprintf(stderr, "Memory total:    " UM10_FMT " KiB\n", (total_allocd + alloc_count*sizeof(struct object_entry))/1024);
 		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)(total_allocd/1024));
-		fprintf(stderr, "     objects:    %10ju KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
+		fprintf(stderr, "     objects:    " UM10_FMT " KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
 		pack_report();
 		fprintf(stderr, "---------------------------------------------------------------------\n");
-- 
1.5.0.rc1.g6f729
