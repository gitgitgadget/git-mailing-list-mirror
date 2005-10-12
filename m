From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add '--create-index' to git-unpack-objects
Date: Wed, 12 Oct 2005 13:02:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510121301340.30679@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 12 13:05:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPeOO-0005Tx-Ip
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 13:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVJLLCk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 07:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVJLLCk
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 07:02:40 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:31210 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750825AbVJLLCk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 07:02:40 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AF33113EE13; Wed, 12 Oct 2005 13:02:36 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 909A4B4CCF; Wed, 12 Oct 2005 13:02:36 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 69772B4CCD; Wed, 12 Oct 2005 13:02:36 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2360C13EE77; Wed, 12 Oct 2005 13:02:36 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10017>

Add the option '--create-index' to git-unpack-objects, which makes it 
create an index file instead of expanding its contents. While at it, 
document the dry-run option '-n', and optionally take a pack file instead 
of stdin.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Is anyone interested in writing the index to stdout? It is easy to
	add this feature to sha1create...

 Documentation/git-unpack-objects.txt |   13 +++-
 t/t5300-pack-object.sh               |    5 ++
 unpack-objects.c                     |  108 +++++++++++++++++++++++++++++++---
 3 files changed, 114 insertions(+), 12 deletions(-)

applies-to: 6dfbbc44a77ad3300caed532814e7feb02ff794b
1bff150c89d2636c54fa45bf62e7b248ba2a7b8d
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index b716ba1..58120e4 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -8,14 +8,15 @@ git-unpack-objects - Unpack objects from
 
 SYNOPSIS
 --------
-'git-unpack-objects' [-q] <pack-file
+'git-unpack-objects' [-q] [-n] [--create-index index-file] [pack-file]
 
 
 DESCRIPTION
 -----------
-Reads a packed archive (.pack) from the standard input, and
+Reads a packed archive (.pack) from a file or stdin, and
 expands the objects contained in the pack into "one-file
-one-object" format in $GIT_OBJECT_DIRECTORY.
+one-object" format in $GIT_OBJECT_DIRECTORY, or alternatively,
+create an index for it.
 
 OPTIONS
 -------
@@ -23,6 +24,12 @@ OPTIONS
 	The command usually shows percentage progress.  This
 	flag suppresses it.
 
+-n::
+	Perform a dry run, i.e. do not write any files.
+
+--create-index <filename>::
+	Instead of unpacking the files, create an index for this
+	pack.
 
 Author
 ------
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index bb62336..593bfc2 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -79,6 +79,11 @@ test_expect_success \
      git-unpack-objects -n <test-2-${packname_2}.pack &&
      git-unpack-objects <test-2-${packname_2}.pack'
 
+test_expect_success \
+     'create-index from pack' \
+     'git-unpack-objects --create-index index <test-2-${packname_2}.pack &&
+     cmp test-2-${packname_2}.idx index'
+
 unset GIT_OBJECT_DIRECTORY
 cd $TRASH/.git2
 test_expect_success \
diff --git a/unpack-objects.c b/unpack-objects.c
index 8ae1a1c..b6dad74 100644
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -2,17 +2,29 @@
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
+#include "csum-file.h"
 
 #include <sys/time.h>
 
-static int dry_run, quiet;
-static const char unpack_usage[] = "git-unpack-objects [-q] < pack-file";
+static int dry_run, quiet, create_index;
+static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [--create-index filename] [pack-file]";
 
 /* We always read in 4kB chunks. */
+static int fd_in = 0;
 static unsigned char buffer[4096];
+static off_t buffer_offset;
 static unsigned long offset, len, eof;
 static SHA_CTX ctx;
 
+/* To recreate an index */
+static const char* index_filename;
+typedef struct {
+	unsigned int offset;
+	unsigned char sha1[20];
+} object_entry;
+static object_entry* objects;
+static unsigned char *current_sha1;
+
 /*
  * Make sure at least "min" bytes are available in the buffer, and
  * return the pointer to the buffer.
@@ -28,10 +40,11 @@ static void * fill(int min)
 	if (offset) {
 		SHA1_Update(&ctx, buffer, offset);
 		memcpy(buffer, buffer + offset, len);
+		buffer_offset += offset;
 		offset = 0;
 	}
 	do {
-		int ret = read(0, buffer + len, sizeof(buffer) - len);
+		int ret = read(fd_in, buffer + len, sizeof(buffer) - len);
 		if (ret <= 0) {
 			if (!ret)
 				die("early EOF");
@@ -83,6 +96,7 @@ struct delta_info {
 	unsigned char base_sha1[20];
 	unsigned long size;
 	void *delta;
+	unsigned char* sha1;
 	struct delta_info *next;
 };
 
@@ -95,6 +109,7 @@ static void add_delta_to_list(unsigned c
 	memcpy(info->base_sha1, base_sha1, 20);
 	info->size = size;
 	info->delta = delta;
+	info->sha1 = current_sha1;
 	info->next = delta_list;
 	delta_list = info;
 }
@@ -104,7 +119,15 @@ static void added_object(unsigned char *
 static void write_object(void *buf, unsigned long size, const char *type)
 {
 	unsigned char sha1[20];
-	if (write_sha1_file(buf, size, type, sha1) < 0)
+	if (create_index) {
+		char header[100];
+		SHA_CTX c;
+
+		SHA1_Init(&c);
+		SHA1_Update(&c, header, 1+sprintf(header, "%s %lu", type, size));
+		SHA1_Update(&c, buf, size);
+		SHA1_Final(current_sha1, &c);
+	} else if (write_sha1_file(buf, size, type, sha1) < 0)
 		die("failed to write object");
 	added_object(sha1, type, buf, size);
 }
@@ -136,6 +159,7 @@ static void added_object(unsigned char *
 		if (!memcmp(info->base_sha1, sha1, 20)) {
 			*p = info->next;
 			p = &delta_list;
+			current_sha1 = info->sha1;
 			resolve_delta(type, data, size, info->delta, info->size);
 			free(info);
 			continue;
@@ -156,8 +180,10 @@ static int unpack_non_delta_entry(enum o
 	case OBJ_TAG:    type = "tag"; break;
 	default: die("bad type %d", kind);
 	}
+
 	if (!dry_run)
 		write_object(buf, size, type);
+
 	free(buf);
 	return 0;
 }
@@ -174,7 +200,7 @@ static int unpack_delta_entry(unsigned l
 	use(20);
 
 	delta_data = get_data(delta_size);
-	if (dry_run) {
+	if (dry_run && !create_index) {
 		free(delta_data);
 		return 0;
 	}
@@ -239,6 +265,40 @@ static void unpack_one(unsigned nr, unsi
 	}
 }
 
+int compare_object_entries(const void* a, const void* b)
+{
+	const object_entry *first = a;
+	const object_entry *second = b;
+
+	return memcmp(first->sha1, second->sha1, 20);
+}
+
+void show_index(unsigned int nr_objects, char* pack_sha1)
+{
+	unsigned int n, i;
+	unsigned int top_index[256];
+	struct sha1file* index_file;
+	
+	/* sort by sha1 */
+	qsort(objects, nr_objects, sizeof(object_entry), compare_object_entries);
+
+	for (n = i = 0; i < 256; i++) {
+		while (n < nr_objects && objects[n].sha1[0] == i)
+			n++;
+		top_index[i] = htonl(n);
+	}
+	top_index[255] = nr_objects;
+
+	/* write to file */
+	index_file = sha1create(index_filename);
+	sha1write(index_file, top_index, sizeof(top_index));
+	sha1write(index_file, objects, sizeof(object_entry)*nr_objects);
+	sha1write(index_file, pack_sha1, 20);
+	sha1close(index_file, NULL, 1);
+
+	free(objects);
+}
+
 /*
  * We unpack from the end, older files first. Now, usually
  * there are deltas etc, so we'll not actually write the
@@ -251,17 +311,29 @@ static void unpack_all(void)
 	unsigned version = ntohl(hdr->hdr_version);
 	unsigned nr_objects = ntohl(hdr->hdr_entries);
 
+	if (create_index)
+		objects = xmalloc(sizeof(object_entry)*nr_objects);
+
 	if (ntohl(hdr->hdr_signature) != PACK_SIGNATURE)
 		die("bad pack file");
 	if (version != PACK_VERSION)
 		die("unable to handle pack file version %d", version);
-	fprintf(stderr, "Unpacking %d objects\n", nr_objects);
+	if (!quiet)
+		fprintf(stderr, "Unpacking %d objects\n", nr_objects);
 
 	use(sizeof(struct pack_header));
-	for (i = 0; i < nr_objects; i++)
+	for (i = 0; i < nr_objects; i++) {
+		if (create_index) {
+			objects[i].offset = htonl(buffer_offset+offset);
+			current_sha1 = (unsigned char*)&objects[i].sha1;
+		}
 		unpack_one(i+1, nr_objects);
+	}
 	if (delta_list)
 		die("unresolved deltas left after unpacking");
+
+	if (create_index)
+		show_index(nr_objects, fill(20));
 }
 
 int main(int argc, char **argv)
@@ -281,11 +353,22 @@ int main(int argc, char **argv)
 				quiet = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--create-index")) {
+				create_index = 1;
+				if (i >= argc-1)
+					usage(unpack_usage);
+				index_filename = argv[++i];
+				continue;
+			}
 			usage(unpack_usage);
 		}
 
-		/* We don't take any non-flag arguments now.. Maybe some day */
-		usage(unpack_usage);
+		if (i != argc-1)
+			usage(unpack_usage);
+
+		fd_in = open(argv[i], O_RDONLY);
+		if (fd_in < 0)
+			die("Could not open %s: %s\n", argv[i], strerror(errno));
 	}
 	SHA1_Init(&ctx);
 	unpack_all();
@@ -295,6 +378,9 @@ int main(int argc, char **argv)
 		die("final sha1 did not match");
 	use(20);
 
+	if (create_index)
+		return 0;
+
 	/* Write the last part of the buffer to stdout */
 	while (len) {
 		int ret = write(1, buffer + offset, len);
@@ -312,5 +398,9 @@ int main(int argc, char **argv)
 	/* All done */
 	if (!quiet)
 		fprintf(stderr, "\n");
+
+	if (fd_in)
+		close(fd_in);
+
 	return 0;
 }
---
0.99.8.GIT
