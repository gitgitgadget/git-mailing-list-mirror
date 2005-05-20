From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/3] delta creation
Date: Fri, 20 May 2005 17:00:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505201659190.4397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 23:03:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZEbr-00065B-ED
	for gcvg-git@gmane.org; Fri, 20 May 2005 23:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVETVBl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 17:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVETVBl
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 17:01:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37450 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261592AbVETVAi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 17:00:38 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGT002743ONQX@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 May 2005 17:00:24 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds the ability to actually create delta objects using a
new tool: git-mkdelta.  It uses an ordered list of potential objects
to deltafy against earlier objects in the list.  A cap on the depth of
delta references can be provided as well, otherwise the default is to
not have any limit.  A limit of 0 will also undeltafy any given object.

Also provided is the beginning of a script to deltafy an entire
repository.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: git/Makefile
===================================================================
--- git.orig/Makefile
+++ git/Makefile
@@ -19,7 +19,8 @@
 INSTALL=install
 
 SCRIPTS=git-apply-patch-script git-merge-one-file-script git-prune-script \
-	git-pull-script git-tag-script git-resolve-script git-whatchanged
+	git-pull-script git-tag-script git-resolve-script git-whatchanged \
+	git-deltafy-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
@@ -28,7 +29,7 @@
 	git-unpack-file git-export git-diff-cache git-convert-cache \
 	git-http-pull git-rpush git-rpull git-rev-list git-mktag \
 	git-diff-helper git-tar-tree git-local-pull git-write-blob \
-	git-get-tar-commit-id
+	git-get-tar-commit-id git-mkdelta
 
 all: $(PROG)
 
@@ -107,6 +108,7 @@
 git-diff-helper: diff-helper.c
 git-tar-tree: tar-tree.c
 git-write-blob: write-blob.c
+git-mkdelta: mkdelta.c
 
 git-http-pull: LIBS += -lcurl
 
Index: git/mkdelta.c
===================================================================
--- /dev/null
+++ git/mkdelta.c
@@ -0,0 +1,317 @@
+/*
+ * Deltafication of a GIT database.
+ *
+ * (C) 2005 Nicolas Pitre <nico@cam.org>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "cache.h"
+#include "delta.h"
+
+static int replace_object(char *buf, unsigned long size, unsigned char *sha1)
+{
+	char tmpfile[PATH_MAX];
+	int fd;
+
+	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX", get_object_directory());
+	fd = mkstemp(tmpfile);
+	if (fd < 0)
+		return error("%s: %s\n", tmpfile, strerror(errno));
+	if (write(fd, buf, size) != size) {
+		perror("unable to write file");
+		close(fd);
+		unlink(tmpfile);
+		return -1;
+	}
+	fchmod(fd, 0444);
+	close(fd);
+	if (rename(tmpfile, sha1_file_name(sha1))) {
+		perror("unable to replace original object");
+		unlink(tmpfile);
+		return -1;
+	}
+	return 0;
+}
+
+static void *create_object(char *buf, unsigned long len, char *hdr, int hdrlen,
+			   unsigned long *retsize)
+{
+	char *compressed;
+	unsigned long size;
+	z_stream stream;
+
+	/* Set it up */
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, Z_BEST_COMPRESSION);
+	size = deflateBound(&stream, len+hdrlen);
+	compressed = xmalloc(size);
+
+	/* Compress it */
+	stream.next_out = compressed;
+	stream.avail_out = size;
+
+	/* First header.. */
+	stream.next_in = hdr;
+	stream.avail_in = hdrlen;
+	while (deflate(&stream, 0) == Z_OK)
+		/* nothing */;
+
+	/* Then the data itself.. */
+	stream.next_in = buf;
+	stream.avail_in = len;
+	while (deflate(&stream, Z_FINISH) == Z_OK)
+		/* nothing */;
+	deflateEnd(&stream);
+	*retsize = stream.total_out;
+	return compressed;
+}
+
+static int restore_original_object(char *buf, unsigned long len,
+				   char *type, unsigned char *sha1)
+{
+	char hdr[50];
+	int hdrlen, ret;
+	void *compressed;
+	unsigned long size;
+
+	hdrlen = sprintf(hdr, "%s %lu", type, len)+1;
+	compressed = create_object(buf, len, hdr, hdrlen, &size);
+	ret = replace_object(compressed, size, sha1);
+	free(compressed);
+	return ret;
+}
+
+static void *create_delta_object(char *buf, unsigned long len,
+				 unsigned char *sha1_ref, unsigned long *size)
+{
+	char hdr[50];
+	int hdrlen;
+
+	/* Generate the header + sha1 of reference for delta */
+	hdrlen = sprintf(hdr, "delta %lu", len+20)+1;
+	memcpy(hdr + hdrlen, sha1_ref, 20);
+	hdrlen += 20;
+
+	return create_object(buf, len, hdr, hdrlen, size);
+}
+
+static unsigned long get_object_size(unsigned char *sha1)
+{
+	struct stat st;
+	if (stat(sha1_file_name(sha1), &st))
+		die("%s: %s", sha1_to_hex(sha1), strerror(errno));
+	return st.st_size;
+}
+
+static void *get_buffer(unsigned char *sha1, char *type, unsigned long *size)
+{
+	unsigned long mapsize;
+	void *map = map_sha1_file(sha1, &mapsize);
+	if (map) {
+		void *buffer = unpack_sha1_file(map, mapsize, type, size);
+		munmap(map, mapsize);
+		if (buffer)
+			return buffer;
+	}
+	error("unable to get object %s", sha1_to_hex(sha1));
+	return NULL;
+}
+
+static void *expand_delta(void *delta, unsigned long delta_size, char *type,
+			  unsigned long *size, unsigned int *depth, char *head)
+{
+	void *buf = NULL;
+	*depth++;
+	if (delta_size < 20) {
+		error("delta object is bad");
+		free(delta);
+	} else {
+		unsigned long ref_size;
+		void *ref = get_buffer(delta, type, &ref_size);
+		if (ref && !strcmp(type, "delta"))
+			ref = expand_delta(ref, ref_size, type, &ref_size,
+					   depth, head);
+		else
+			memcpy(head, delta, 20);
+		if (ref)
+			buf = patch_delta(ref, ref_size, delta+20,
+					  delta_size-20, size);
+		free(ref);
+		free(delta);
+	}
+	return buf;
+}
+
+static char *mkdelta_usage =
+"mkdelta [ --max-depth=N ] <reference_sha1> <target_sha1> [ <next_sha1> ... ]";
+
+int main(int argc, char **argv)
+{
+	unsigned char sha1_ref[20], sha1_trg[20], head_ref[20], head_trg[20];
+	char type_ref[20], type_trg[20];
+	void *buf_ref, *buf_trg, *buf_delta;
+	unsigned long size_ref, size_trg, size_orig, size_delta;
+	unsigned int depth_ref, depth_trg, depth_max = -1;
+	int i, verbose = 0;
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "-v")) {
+			verbose = 1;
+		} else if (!strcmp(argv[i], "-d") && i+1 < argc) {
+			depth_max = atoi(argv[++i]);
+		} else if (!strncmp(argv[i], "--max-depth=", 12)) {
+			depth_max = atoi(argv[i]+12);
+		} else
+			break;
+	}
+
+	if (i + (depth_max != 0) >= argc)
+		usage(mkdelta_usage);
+
+	if (get_sha1(argv[i], sha1_ref))
+		die("bad sha1 %s", argv[i]);
+	depth_ref = 0;
+	buf_ref = get_buffer(sha1_ref, type_ref, &size_ref);
+	if (buf_ref && !strcmp(type_ref, "delta"))
+		buf_ref = expand_delta(buf_ref, size_ref, type_ref,
+				       &size_ref, &depth_ref, head_ref);
+	else
+		memcpy(head_ref, sha1_ref, 20);
+	if (!buf_ref)
+		die("unable to obtain initial object %s", argv[i]);
+
+	if (depth_ref > depth_max) {
+		if (restore_original_object(buf_ref, size_ref, type_ref, sha1_ref))
+			die("unable to restore %s", argv[i]);
+		if (verbose)
+			printf("undelta %s (depth was %d)\n", argv[i], depth_ref);
+		depth_ref = 0;
+	}
+
+	/*
+	 * TODO: deltafication should be tried against any early object
+	 * in the object list and not only the previous object.
+	 */
+
+	while (++i < argc) {
+		if (get_sha1(argv[i], sha1_trg))
+			die("bad sha1 %s", argv[i]);
+		depth_trg = 0;
+		buf_trg = get_buffer(sha1_trg, type_trg, &size_trg);
+		if (buf_trg && !size_trg) {
+			if (verbose)
+				printf("skip    %s (object is empty)\n", argv[i]);
+			continue;
+		}
+		size_orig = size_trg;
+		if (buf_trg && !strcmp(type_trg, "delta")) {
+			if (!memcmp(buf_trg, sha1_ref, 20)) {
+				/* delta already in place */
+				depth_ref++;
+				memcpy(sha1_ref, sha1_trg, 20);
+				buf_ref = patch_delta(buf_ref, size_ref,
+						      buf_trg+20, size_trg-20,
+						      &size_ref);
+				if (!buf_ref)
+					die("unable to apply delta %s", argv[i]);
+				if (depth_ref > depth_max) {
+					if (restore_original_object(buf_ref, size_ref,
+								    type_ref, sha1_ref))
+						die("unable to restore %s", argv[i]);
+					if (verbose)
+						printf("undelta %s (depth was %d)\n", argv[i], depth_ref);
+					depth_ref = 0;
+					continue;
+				}
+				if (verbose)
+					printf("skip    %s (delta already in place)\n", argv[i]);
+				continue;
+			}
+			buf_trg = expand_delta(buf_trg, size_trg, type_trg,
+					       &size_trg, &depth_trg, head_trg);
+		} else
+			memcpy(head_trg, sha1_trg, 20);
+		if (!buf_trg)
+			die("unable to read target object %s", argv[i]);
+
+		if (depth_trg > depth_max) {
+			if (restore_original_object(buf_trg, size_trg, type_trg, sha1_trg))
+				die("unable to restore %s", argv[i]);
+			if (verbose)
+				printf("undelta %s (depth was %d)\n", argv[i], depth_trg);
+			depth_trg = 0;
+			size_orig = size_trg;
+		}
+
+		if (depth_max == 0)
+			goto skip;
+
+		if (strcmp(type_ref, type_trg))
+			die("type mismatch for object %s", argv[i]);
+
+		if (!size_ref) {
+			if (verbose)
+				printf("skip    %s (initial object is empty)\n", argv[i]);
+			goto skip;
+		}
+		
+		if (depth_ref + 1 > depth_max) {
+			if (verbose)
+				printf("skip    %s (exceeding max link depth)\n", argv[i]);
+			goto skip;
+		}
+
+		if (!memcmp(head_ref, sha1_trg, 20)) {
+			if (verbose)
+				printf("skip    %s (would create a loop)\n", argv[i]);
+			goto skip;
+		}
+
+		buf_delta = diff_delta(buf_ref, size_ref, buf_trg, size_trg, &size_delta);
+		if (!buf_delta)
+			die("out of memory");
+
+		/* no need to even try to compress if original
+		   uncompressed is already smaller */
+		if (size_delta+20 < size_orig) {
+			void *buf_obj;
+			unsigned long size_obj;
+			buf_obj = create_delta_object(buf_delta, size_delta,
+						      sha1_ref, &size_obj);
+			free(buf_delta);
+			size_orig = get_object_size(sha1_trg);
+			if (size_obj >= size_orig) {
+				free(buf_obj);
+				if (verbose)
+					printf("skip    %s (original is smaller)\n", argv[i]);
+				goto skip;
+			}
+			if (replace_object(buf_obj, size_obj, sha1_trg))
+				die("unable to write delta for %s", argv[i]);
+			free(buf_obj);
+			depth_ref++;
+			if (verbose)
+				printf("delta   %s (size=%ld.%02ld%%, depth=%d)\n",
+				       argv[i], size_obj*100 / size_orig,
+				       (size_obj*10000 / size_orig)%100,
+				       depth_ref);
+		} else {
+			free(buf_delta);
+			if (verbose)
+				printf("skip    %s (original is smaller)\n", argv[i]);
+			skip:
+			depth_ref = depth_trg;
+			memcpy(head_ref, head_trg, 20);
+		}
+
+		free(buf_ref);
+		buf_ref = buf_trg;
+		size_ref = size_trg;
+		memcpy(sha1_ref, sha1_trg, 20);
+	}
+
+	return 0;
+}
Index: git/git-deltafy-script
===================================================================
--- /dev/null
+++ git/git-deltafy-script
@@ -0,0 +1,39 @@
+#!/bin/bash
+
+# Script to deltafy an entire GIT repository based on the commit list.
+# The most recent version of a file is the reference and previous versions
+# are made delta against the best earlier version available. And so on for
+# successive versions going back in time.  This way the delta overhead is
+# pushed towards older version of any given file.
+#
+# NOTE: the "best earlier version" is not implemented in mkdelta yet
+#       and therefore only the next eariler version is used at this time.
+#
+# TODO: deltafy tree objects as well.
+#
+# The -d argument allows to provide a limit on the delta chain depth.
+# If 0 is passed then everything is undeltafied.
+
+set -e
+
+depth=
+[ "$1" == "-d" ] && depth="--max-depth=$2" && shift 2
+
+curr_file=""
+
+git-rev-list HEAD |
+git-diff-tree -r --stdin |
+sed -n '/^\*/ s/^.*->\(.\{41\}\)\(.*\)$/\2 \1/p' | sort | uniq |
+while read file sha1; do
+	if [ "$file" == "$curr_file" ]; then
+		list="$list $sha1"
+	else
+		if [ "$list" ]; then
+			echo "Processing $curr_file"
+			echo "$head $list" | xargs git-mkdelta $depth -v
+		fi
+		curr_file="$file"
+		list=""
+		head="$sha1"
+	fi
+done
