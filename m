From: Chris Mason <mason@suse.com>
Subject: [PATCH] packed delta git
Date: Tue, 17 May 2005 18:57:45 -0400
Message-ID: <200505171857.46370.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 18 01:08:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYBA3-0006ck-7O
	for gcvg-git@gmane.org; Wed, 18 May 2005 01:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVEQXHy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 19:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVEQXHy
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 19:07:54 -0400
Received: from cantor2.suse.de ([195.135.220.15]:54989 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261945AbVEQW5y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 18:57:54 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id D1AE810AAC;
	Wed, 18 May 2005 00:57:51 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 5F27D152A93; Wed, 18 May 2005 00:57:50 +0200 (CEST)
To: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
User-Agent: KMail/1.8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello everyone,

Here's a new version of my packed git patch, diffed on top of Nicolas' 
delta code (link below to that).  It doesn't change the core git commands
to create packed/delta files, that is done via a new git-pack command.  The
git-pack usage is very simple:

git-pack [<reference_sha1>:]<target_sha1> [ <next_sha1> ... ]

If you use the ref:target notation, it will create a delta between those 
two objects and relink the target into the resulting packed file.  If you
don't provide a reference sha1, the sha1 file is relinked into the packed file.

A script is provided (git-pack-changes-script) that walks the rev-list output 
and puts your whole repository into packed/delta form.  This is just
a starting point, it needs more knobs for forward/reverse deltas,
max depth etc.  The script does delta tree files and packs both trees and 
commits in with the blobs.

git-diff-tree -t was added so that it will show the sha1 of subtrees that
differ while it processes things.

There is no way to unpack a file yet, so please use these with caution.

I did tests against the current 2.6 git tree (ext3)

                                      vanilla              delta+pack
.git size                          191M                62M
checkout-cache (cold)     2m13s              38.9s
checkout-cache (hot)      8s  (2s user)      14.9s (11.46s user)

2.6.11 without any changesets:
                                      unpacked          packed
.git size                           91M                  55M

Because the 2.6 kernel repo has 2.6.11 floating around in there as a tree
with no commit, you have to do a few steps in order to pack things in. 

# step one, pack all the files in 2.6.11 together
git-ls-tree -r v2.6.11 | awk '{print $3}' | xargs git-pack

# step two, make packed deltas between trees for 2.6.11 and 2.6.12-rc2
# (git-pack-changes-script -t only works with trees, not commits/tags)
git-pack-changes-script -t c39ae07f393806ccf406ef966e9a15afc43cc36a 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 | xargs git-pack

# step three, use git-pack-changes to walk whole rev-list and pack/delta
# everything else
git-pack-changes-script | xargs git-pack

And finally, here's the patch.  It is on top of Nicolas' code, which you
can grab here:

http://marc.theaimsgroup.com/?l=git&m=111587004902021&w=2

Signed-off-by: Chris Mason <mason@suse.com>
--

diff -urN linus.delta/cache.h linus/cache.h
--- linus.delta/cache.h	2005-05-17 16:51:51.410686192 -0400
+++ linus/cache.h	2005-05-17 15:17:16.015477408 -0400
@@ -77,6 +77,16 @@
 	char name[0];
 };
 
+struct packed_item {
+	/* length of compressed data */
+	unsigned long len;
+	struct packed_item *next;
+	/* sha1 of uncompressed data */
+	char sha1[20];
+	/* compressed data */
+	char *data;
+};
+
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_STAGESHIFT 12
@@ -135,8 +145,10 @@
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
-extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
+extern void * unpack_sha1_file(const unsigned char *sha1, void *map, unsigned long mapsize, char *type, unsigned long *size, const unsigned char *recur_sha1, int *chain);
+extern void * raw_unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
+extern void * read_sha1_delta_ref(const unsigned char *sha1, char *type, unsigned long *size, const unsigned char *, int *chain);
 extern int write_sha1_file(char *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 
 extern int check_sha1_signature(unsigned char *sha1, void *buf, unsigned long size, const char *type);
@@ -152,6 +164,10 @@
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
+extern int pack_sha1_buffer(void *buf, unsigned long buf_len, char *type,
+                            unsigned char *returnsha1, unsigned char *refsha1, 
+			    struct packed_item **, int max_depth);
+int write_packed_list(struct packed_item *head);
 
 /* General helper functions */
 extern void usage(const char *err);
Files linus.delta/.cache.h.swp and linus/.cache.h.swp differ
diff -urN linus.delta/diff-tree.c linus/diff-tree.c
--- linus.delta/diff-tree.c	2005-05-17 16:51:51.413685736 -0400
+++ linus/diff-tree.c	2005-05-16 20:08:41.000000000 -0400
@@ -5,6 +5,7 @@
 static int silent = 0;
 static int verbose_header = 0;
 static int ignore_merges = 1;
+static int show_tree_diffs = 0;
 static int recursive = 0;
 static int read_stdin = 0;
 static int line_termination = '\n';
@@ -114,6 +115,7 @@
 	const unsigned char *sha1, *sha2;
 	int cmp, pathlen1, pathlen2;
 	char old_sha1_hex[50];
+	int retval = 0;
 
 	sha1 = extract(tree1, size1, &path1, &mode1);
 	sha2 = extract(tree2, size2, &path2, &mode2);
@@ -143,11 +145,11 @@
 	}
 
 	if (recursive && S_ISDIR(mode1)) {
-		int retval;
 		char *newbase = malloc_base(base, path1, pathlen1);
 		retval = diff_tree_sha1(sha1, sha2, newbase);
 		free(newbase);
-		return retval;
+		if (!show_tree_diffs)
+			return retval;
 	}
 
 	if (header) {
@@ -155,7 +157,7 @@
 		header = NULL;
 	}
 	if (silent)
-		return 0;
+		return retval;
 
 	if (generate_patch) {
 		if (!S_ISDIR(mode1))
@@ -168,7 +170,7 @@
 		       old_sha1_hex, sha1_to_hex(sha2), base, path1,
 		       line_termination);
 	}
-	return 0;
+	return retval;
 }
 
 static int interesting(void *tree, unsigned long size, const char *base)
@@ -387,7 +389,7 @@
 }
 
 static char *diff_tree_usage =
-"diff-tree [-p] [-r] [-z] [--stdin] [-m] [-s] [-v] <tree sha1> <tree sha1>";
+"diff-tree [-p] [-r] [-z] [--stdin] [-m] [-s] [-v] [-t] <tree sha1> <tree sha1>";
 
 int main(int argc, char **argv)
 {
@@ -428,6 +430,10 @@
 			silent = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-t")) {
+			show_tree_diffs = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-v")) {
 			verbose_header = 1;
 			header_prefix = "diff-tree ";
diff -urN linus.delta/git-pack-changes-script linus/git-pack-changes-script
--- linus.delta/git-pack-changes-script	1969-12-31 19:00:00.000000000 -0500
+++ linus/git-pack-changes-script	2005-05-17 16:57:44.768967568 -0400
@@ -0,0 +1,161 @@
+#!/usr/bin/perl
+#
+# script to search through the rev-list output and generate delta history
+# you can specify either a start and stop commit or two trees to search.
+# with no command line args it searches the entire revision history.
+# output is suitable for piping to xargs git-pack
+
+use strict;
+
+my $ret;
+my $i;
+my @wanted = ();
+my $argc = scalar(@ARGV);
+my $commit;
+my $stop;
+my %delta = ();
+
+sub add_delta($$) {
+    my ($ref, $target) = @_;
+    if (defined($delta{$target})) {
+        return;
+    }
+    if ($target eq $delta{$ref}) {
+	print $ref;
+	return 1;
+    }
+    $delta{$target} = $ref;
+    print "$ref:$target\n";
+
+}
+sub print_usage() {
+    print STDERR "usage: pack-changes [-c commit] [-s stop commit] [-t tree1 tree2]\n";
+    exit(1);
+}
+
+sub find_tree($) {
+    my ($commit) = @_;
+    open(CM, "git-cat-file commit $commit|") || die "git-cat-file failed";
+    while(<CM>) {
+        chomp;
+	my @words = split;
+	if ($words[0] eq "tree") {
+	    return $words[1];
+	} elsif ($words[0] ne "parent") {
+	    last;
+	}
+    }
+    close(CM);
+    if ($? && ($ret = $? >> 8)) {
+        die "cat-file $commit failed with $ret";
+    }
+    return undef;
+}
+
+sub test_diff($$) {
+    my ($a, $b) = @_;
+    open(DT, "git-diff-tree -r -t $a $b|") || die "diff-tree failed";
+    while(<DT>) {
+        chomp;
+	my @words = split;
+	my $sha1 = $words[2];
+	my $change = $words[0];
+	if ($change =~ m/^\*/) {
+	    @words = split("->", $sha1);
+	    add_delta($words[0], $words[1]);
+	} elsif ($change =~ m/^\-/) {
+	    next;
+	} else {
+	    print "$sha1\n";
+	}
+    }
+    close(DT);
+    if ($? && ($ret = $? >> 8)) {
+	die "git-diff-tree failed with $ret";
+    }
+    return 0;
+}
+
+for ($i = 0 ; $i < $argc ; $i++)  {
+    if ($ARGV[$i] eq "-c") {
+    	if ($i == $argc - 1) {
+	    print_usage();
+	}
+	$commit = $ARGV[++$i];
+    } elsif ($ARGV[$i] eq "-s") {
+    	if ($i == $argc - 1) {
+	    print_usage();
+	}
+	$stop = $ARGV[++$i];
+    } elsif ($ARGV[$i] eq "-t") {
+        if ($argc != 3 || $i != 0) {
+	    print_usage();
+	}
+	if (test_diff($ARGV[1], $ARGV[2])) {
+	    die "test_diff failed\n";
+	}
+	add_delta($ARGV[1], $ARGV[2]);
+	exit(0);
+    }
+}
+
+if (!defined($commit)) {
+    $commit = `commit-id`;
+    if ($?) {
+    	print STDERR "commit-id failed, try using -c to specify a commit\n";
+	exit(1);
+    }
+    chomp $commit;
+}
+
+open(RL, "git-rev-list $commit|") || die "rev-list failed";
+while(<RL>) {
+    chomp;
+    my $cur = $_;
+    my $cur_tree;
+    my $parent_tree;
+    my $parent_commit = undef;
+    open(PARENT, "git-cat-file commit $cur|") || die "cat-file failed";
+    while(<PARENT>) {
+        chomp;
+	my @words = split;
+	if ($words[0] eq "tree") {
+	    $cur_tree = $words[1];
+	    next;
+	} elsif ($words[0] ne "parent") {
+	    last;
+	}
+	$parent_commit = $words[1];
+	my $next = <PARENT>;
+	# ignore merge sets for now
+	if ($next =~ m/^parent/) {
+	    last;
+	}
+	if (test_diff($words[1], $cur)) {
+	    die "test_diff failed\n";
+	}
+	$parent_tree = find_tree($words[1]);
+	if (!defined($parent_tree)) {
+	    die "failed to find tree for $words[1]\n";
+	}
+	add_delta($parent_tree, $cur_tree);
+	print "$cur\n";
+	last;
+    }
+    close(PARENT);
+    if (!defined($parent_commit)) {
+        print STDERR "parentless commit $cur\n";
+    }
+    if ($? && ($ret = $? >> 8)) {
+        die "cat-file failed with $ret";
+    }
+    if ($cur eq $stop) {
+        last;
+    }
+}
+close(RL);
+
+if ($? && ($ret = $? >> 8)) {
+    die "rev-list failed with $ret";
+}
+
diff -urN linus.delta/Makefile linus/Makefile
--- linus.delta/Makefile	2005-05-17 16:52:56.698760896 -0400
+++ linus/Makefile	2005-05-17 16:50:48.335275112 -0400
@@ -22,7 +22,7 @@
 	git-unpack-file git-export git-diff-cache git-convert-cache \
 	git-http-pull git-rpush git-rpull git-rev-list git-mktag \
 	git-diff-tree-helper git-tar-tree git-local-pull git-write-blob \
-	git-mkdelta
+	git-mkdelta git-pack
 
 all: $(PROG)
 
diff -urN linus.delta/mkdelta.c linus/mkdelta.c
--- linus.delta/mkdelta.c	2005-05-17 16:52:56.700760592 -0400
+++ linus/mkdelta.c	2005-05-16 17:21:37.000000000 -0400
@@ -95,7 +95,7 @@
 	unsigned long mapsize;
 	void *map = map_sha1_file(sha1, &mapsize);
 	if (map) {
-		void *buffer = unpack_sha1_file(map, mapsize, type, size);
+		void *buffer = raw_unpack_sha1_file(map, mapsize, type, size);
 		munmap(map, mapsize);
 		if (buffer)
 			return buffer;
diff -urN linus.delta/object.c linus/object.c
--- linus.delta/object.c	2005-05-17 16:51:51.419684824 -0400
+++ linus/object.c	2005-05-17 15:16:52.291084064 -0400
@@ -107,7 +107,7 @@
 		struct object *obj;
 		char type[100];
 		unsigned long size;
-		void *buffer = unpack_sha1_file(map, mapsize, type, &size);
+		void *buffer = unpack_sha1_file(sha1, map, mapsize, type, &size, NULL, NULL);
 		munmap(map, mapsize);
 		if (!buffer)
 			return NULL;
diff -urN linus.delta/pack.c linus/pack.c
--- linus.delta/pack.c	1969-12-31 19:00:00.000000000 -0500
+++ linus/pack.c	2005-05-17 17:13:44.615048784 -0400
@@ -0,0 +1,122 @@
+/*
+ * pack and delta files in a GIT database
+ * (C) 2005 Chris Mason <mason@suse.com>
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "cache.h"
+#include "delta.h"
+
+static char *pack_usage = "pack [ --max-depth=N ] [<reference_sha1>:]<target_sha1> [ <next_sha1> ... ]";
+
+static int pack_sha1(unsigned char *sha1, unsigned char *refsha1, 
+		     struct packed_item **head, struct packed_item **tail, 
+		     unsigned long *packed_size, unsigned long *packed_nr, 
+		     int max_depth)
+{
+	struct packed_item *item;
+	char *buffer;
+	unsigned long size;
+	int ret;
+	char type[20];
+	unsigned char retsha1[20];
+
+	buffer = read_sha1_file(sha1, type, &size);
+	if (!buffer) {
+		fprintf(stderr, "failed to read %s\n", sha1_to_hex(sha1));
+		return -1;
+	}
+	ret = pack_sha1_buffer(buffer, size, type, retsha1, refsha1, &item, max_depth);
+	free(buffer);
+	if (memcmp(sha1, retsha1, 20)) {
+		fprintf(stderr, "retsha1 %s ", sha1_to_hex(retsha1));
+		fprintf(stderr, "sha1 %s\n", sha1_to_hex(sha1));
+		return -1;
+	}
+	if (memcmp(item->sha1, sha1, 20)) {
+		fprintf(stderr, "item sha1 %s ", sha1_to_hex(item->sha1));
+		fprintf(stderr, "sha1 %s\n", sha1_to_hex(sha1));
+		return -1;
+	}
+	if (ret)
+		return ret;
+	if (item) {
+		if (*tail)
+			(*tail)->next = item;
+		*tail = item;
+		if (!*head)
+			*head = item;
+		*packed_size += item->len;
+		(*packed_nr)++;
+		if (*packed_size > (512 * 1024) || *packed_nr > 1024) {
+			ret = write_packed_list(*head);
+			if (ret)
+				return ret;
+			*head = NULL;
+			*tail = NULL;
+			*packed_size = 0;
+			*packed_nr = 0;
+		}
+	}
+	return 0;
+}
+int main(int argc, char **argv)
+{
+	int i;
+	struct packed_item *head = NULL;
+	struct packed_item *tail = NULL;
+	unsigned long packed_size = 0;
+	unsigned long packed_nr = 0;
+	int verbose;
+	int depth_max = 16;
+	int ret;
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
+	if (i == argc)
+		usage(pack_usage);
+	while(i < argc) {
+		unsigned char sha1[20];
+		unsigned char refsha1[20];
+		unsigned char *target;
+		unsigned char *ref = NULL;
+		target = strchr(argv[i], ':');
+		if (target) {
+			*target = '\0';
+			target++;
+			ref = argv[i];
+		} else {
+			target = argv[i];
+		}
+		if (get_sha1_hex(target, sha1)) {
+			fprintf(stderr, "unable to parse sha1 %s\n", argv[i]);
+			exit(1);
+		}
+		if (ref) {
+			if (get_sha1_hex(ref, refsha1)) {
+				fprintf(stderr, "unable to parse sha1 %s\n", argv[i]);
+				exit(1);
+			}
+			ref = refsha1;
+		}
+		ret = pack_sha1(sha1, ref, &head, &tail, &packed_size, &packed_nr, depth_max);
+		if (ret) {
+			fprintf(stderr, "pack_sha1 failed! %d\n", ret);
+			exit(1);
+		}
+		i++;
+	}
+
+	if (head)
+		write_packed_list(head);
+	return 0;
+}
diff -urN linus.delta/sha1_file.c linus/sha1_file.c
--- linus.delta/sha1_file.c	2005-05-17 16:52:56.697761048 -0400
+++ linus/sha1_file.c	2005-05-17 18:16:54.004973952 -0400
@@ -180,39 +180,132 @@
 	return map;
 }
 
-void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size)
+/*
+ * looks through buf for the header entry corresponding to sha1.  returns
+ * 0 an entry is found and sets offset to the offset of the packed item
+ * in the file.  The offset is relative to the start of the packed items
+ * so you have to add in the length of the header before using it
+ * -1 is returned if the sha1 could not be found
+ */
+static int find_packed_header(const unsigned char *sha1, char *buf, unsigned long buf_len, unsigned long *offset)
+{
+	char *p;
+	p = buf;
+
+	*offset = 0;
+	while(p < buf + buf_len) {
+		unsigned long item_len;
+		unsigned char item_sha[20];
+		memcpy(item_sha, p, 20);
+		sscanf(p + 20, "%lu", &item_len);
+		p += 20 + strlen(p + 20) + 1;
+		if (memcmp(item_sha, sha1, 20) == 0)
+			return 0;
+		*offset += item_len;
+	}
+	return -1;
+}
+
+
+/*
+ * uncompresses a data segment without any extra delta/packed processing
+ */
+static void * _unpack_sha1_file(z_stream *stream, void *map, 
+                                unsigned long mapsize, char *type, 
+				unsigned long *size)
 {
 	int ret, bytes;
-	z_stream stream;
 	char buffer[8192];
 	char *buf;
 
 	/* Get the data stream */
-	memset(&stream, 0, sizeof(stream));
-	stream.next_in = map;
-	stream.avail_in = mapsize;
-	stream.next_out = buffer;
-	stream.avail_out = sizeof(buffer);
-
-	inflateInit(&stream);
-	ret = inflate(&stream, 0);
-	if (ret < Z_OK)
+	memset(stream, 0, sizeof(*stream));
+	stream->next_in = map;
+	stream->avail_in = mapsize;
+	stream->next_out = buffer;
+	stream->avail_out = sizeof(buffer);
+
+	inflateInit(stream);
+	ret = inflate(stream, 0);
+	if (ret < Z_OK) {
 		return NULL;
-	if (sscanf(buffer, "%10s %lu", type, size) != 2)
+	}
+	if (sscanf(buffer, "%10s %lu", type, size) != 2) {
 		return NULL;
-
+	}
 	bytes = strlen(buffer) + 1;
 	buf = xmalloc(*size);
 
-	memcpy(buf, buffer + bytes, stream.total_out - bytes);
-	bytes = stream.total_out - bytes;
+	memcpy(buf, buffer + bytes, stream->total_out - bytes);
+	bytes = stream->total_out - bytes;
 	if (bytes < *size && ret == Z_OK) {
-		stream.next_out = buf + bytes;
-		stream.avail_out = *size - bytes;
-		while (inflate(&stream, Z_FINISH) == Z_OK)
+		stream->next_out = buf + bytes;
+		stream->avail_out = *size - bytes;
+		while (inflate(stream, Z_FINISH) == Z_OK)
 			/* nothing */;
 	}
-	inflateEnd(&stream);
+	inflateEnd(stream);
+	return buf;
+}
+
+void * raw_unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size)
+{
+	z_stream stream;
+	return _unpack_sha1_file(&stream, map, mapsize, type, size);
+}
+
+void * unpack_sha1_file(const unsigned char *sha1, void *map, 
+			unsigned long mapsize, char *type, unsigned long *size, 
+			const unsigned char *recur_sha1,
+			int *chain)
+{
+	z_stream stream;
+	char *buf;
+	unsigned long offset;
+	unsigned long header_len;
+	buf = _unpack_sha1_file(&stream, map, mapsize, type, size);
+	if (!buf)
+		return buf;
+	if (!strcmp(type, "delta")) {
+		char *delta_ref;
+		unsigned long delta_size;
+		char *newbuf;
+		unsigned long newsize;
+		if (recur_sha1 && memcmp(buf, recur_sha1, 20) == 0) {
+			free(buf);
+			return NULL;
+		}
+		if (chain)
+			*chain += 1;
+		delta_ref = read_sha1_delta_ref(buf, type, &delta_size, recur_sha1, chain);
+		if (!delta_ref) {
+			fprintf(stderr, "failed to read delta %s\n", sha1_to_hex(buf));
+			free(buf);
+			return NULL;
+		}
+		newbuf = patch_delta(delta_ref, delta_size, buf+20, *size-20, &newsize);
+		if (!newbuf) {
+			fprintf(stderr, "patch_delta failed %s %lu\n", sha1_to_hex(buf), delta_size);
+		}
+		free(buf);
+		free(delta_ref);
+		*size = newsize;
+		return newbuf;
+
+	} else if (!strcmp(type, "packed")) {
+		if (!sha1) {
+			free(buf);
+			return NULL;
+		}
+		header_len = *size;
+		if (find_packed_header(sha1, buf, header_len, &offset)) {
+			free(buf);
+			return NULL;
+		}
+		offset += stream.total_in;
+		free(buf);
+		buf = unpack_sha1_file(sha1, map+offset, mapsize-offset, type, size, recur_sha1, chain);
+	}
 	return buf;
 }
 
@@ -223,21 +316,26 @@
 
 	map = map_sha1_file(sha1, &mapsize);
 	if (map) {
-		buf = unpack_sha1_file(map, mapsize, type, size);
+		buf = unpack_sha1_file(sha1, map, mapsize, type, size, NULL, NULL);
+		munmap(map, mapsize);
+		return buf;
+	}
+	return NULL;
+}
+
+/*
+ * the same as read_sha1_file except chain is used to count the length
+ * of any delta chains hit while unpacking
+ */
+void * read_sha1_delta_ref(const unsigned char *sha1, char *type, unsigned long *size, const unsigned char *recur_sha1, int *chain)
+{
+	unsigned long mapsize;
+	void *map, *buf;
+
+	map = map_sha1_file(sha1, &mapsize);
+	if (map) {
+		buf = unpack_sha1_file(sha1, map, mapsize, type, size, recur_sha1, chain);
 		munmap(map, mapsize);
-		if (buf && !strcmp(type, "delta")) {
-			void *ref = NULL, *delta = buf;
-			unsigned long ref_size, delta_size = *size;
-			buf = NULL;
-			if (delta_size > 20)
-				ref = read_sha1_file(delta, type, &ref_size);
-			if (ref)
-				buf = patch_delta(ref, ref_size,
-						  delta+20, delta_size-20, 
-						  size);
-			free(delta);
-			free(ref);
-		}
 		return buf;
 	}
 	return NULL;
@@ -482,3 +580,322 @@
 		munmap(buf, size);
 	return ret;
 }
+
+static void *compress_buffer(void *buf, unsigned long buf_len, char *metadata, 
+                             int metadata_size, unsigned long *compsize)
+{
+	char *compressed;
+	z_stream stream;
+	unsigned long size;
+
+	/* Set it up */
+	memset(&stream, 0, sizeof(stream));
+	size = deflateBound(&stream, buf_len + metadata_size);
+	compressed = xmalloc(size);
+
+	/*
+	 * ASCII size + nul byte
+	 */	
+	stream.next_in = metadata;
+	stream.avail_in = metadata_size;
+	stream.next_out = compressed;
+	stream.avail_out = size;
+	deflateInit(&stream, Z_BEST_COMPRESSION);
+	while (deflate(&stream, 0) == Z_OK)
+		/* nothing */;
+
+	stream.next_in = buf;
+	stream.avail_in = buf_len;
+	/* Compress it */
+	while (deflate(&stream, Z_FINISH) == Z_OK)
+		/* nothing */;
+	deflateEnd(&stream);
+	size = stream.total_out;
+	*compsize = size;
+	return compressed;
+}
+
+/*
+ * generates a delta for buf against refsha1 and returns a compressed buffer
+ * with the results.  NULL is returned on error, or when the delta could
+ * not be done.  This might happen if the delta is larger then either the
+ * refsha1 or the buffer, or the delta chain is too long.
+ */
+void *delta_buffer(void *buf, unsigned long buf_len, char *metadata, 
+                   int metadata_size, unsigned long *compsize, 
+		   unsigned char *sha1, unsigned char *refsha1, int max_chain)
+{
+	char *compressed;
+	char *refbuffer = NULL;
+	char reftype[20];
+	unsigned long refsize = 0;
+	char *delta;
+	unsigned long delta_size;
+	char *lmetadata = xmalloc(220);
+	unsigned long lmetadata_size;
+	int chain_length = 0;
+
+	if (buf_len == 0)
+		return NULL;
+	refbuffer = read_sha1_delta_ref(refsha1, reftype, &refsize, sha1, &chain_length);
+
+	if (chain_length > max_chain) {
+		free(refbuffer);
+		return NULL;
+	}
+	/* note, we could just continue without the delta here */
+	if (!refbuffer) {
+		free(refbuffer);
+		return NULL;
+	}
+	delta = diff_delta(refbuffer, refsize, buf, buf_len, &delta_size);
+	free(refbuffer);
+	if (!delta)
+		return NULL;
+	if (delta_size > refsize || delta_size > buf_len) {
+		free(delta);
+		return NULL;
+	}
+	if (delta_size < 10) {
+		free(delta);
+		return NULL;
+	}
+	lmetadata_size = 1 + sprintf(lmetadata, "%s %lu","delta",delta_size+20);
+	memcpy(lmetadata + lmetadata_size, refsha1, 20);
+	lmetadata_size += 20;
+	compressed = compress_buffer(delta, delta_size, lmetadata, lmetadata_size, compsize);
+	free(lmetadata);
+	free(delta);
+	return compressed;
+}
+
+/*
+ * returns a newly malloc'd packed item with a compressed buffer for buf.  
+ * If refsha1 is non-null, attempts a delta against it.  The sha1 of buf 
+ * is returned via returnsha1.
+ */
+int pack_sha1_buffer(void *buf, unsigned long buf_len, char *type,
+		     unsigned char *returnsha1,
+		     unsigned char *refsha1,
+		     struct packed_item **packed_item, int max_depth)
+{
+	unsigned char sha1[20];
+	SHA_CTX c;
+	char *compressed = NULL;
+	unsigned long size;
+	struct packed_item *item;
+	char *metadata = xmalloc(200);
+	int metadata_size;
+
+	*packed_item = NULL;
+
+	metadata_size = 1 + sprintf(metadata, "%s %lu", type, buf_len);
+
+	/* Sha1.. */
+	SHA1_Init(&c);
+	SHA1_Update(&c, metadata, metadata_size);
+	SHA1_Update(&c, buf, buf_len);
+	SHA1_Final(sha1, &c);
+
+	if (returnsha1)
+		memcpy(returnsha1, sha1, 20);
+
+	if (refsha1)
+		compressed = delta_buffer(buf, buf_len, metadata, 
+		                          metadata_size, &size, sha1, 
+					  refsha1, max_depth);
+	if (!compressed)
+		compressed = compress_buffer(buf, buf_len, metadata, 
+		                             metadata_size, &size);
+	free(metadata);
+	if (!compressed)
+		return -1;
+
+	item = xmalloc(sizeof(struct packed_item));
+	memcpy(item->sha1, sha1, 20);
+	item->len = size;
+	item->next = NULL;
+	item->data = compressed;
+	*packed_item = item;
+	return 0;
+}
+
+static char *create_packed_header(struct packed_item *head, unsigned long *size)
+{
+	char *metadata = NULL;
+	int metadata_size = 0;
+	*size = 0;
+	int entry_size = 0;
+
+	while(head) {
+		char *p;
+		metadata = realloc(metadata, metadata_size + 220);
+		if (!metadata)
+			return NULL;
+		p = metadata+metadata_size;
+		memcpy(p, head->sha1, 20);
+		p += 20;
+		entry_size = 1 + sprintf(p, "%lu", head->len);
+		metadata_size += entry_size + 20;
+		head = head->next;
+	}
+	*size = metadata_size;
+	return metadata;
+}
+
+#define WRITE_BUFFER_SIZE 8192
+static char write_buffer[WRITE_BUFFER_SIZE];
+static unsigned long write_buffer_len;
+
+static int c_write(int fd, void *data, unsigned int len)
+{
+	while (len) {
+		unsigned int buffered = write_buffer_len;
+		unsigned int partial = WRITE_BUFFER_SIZE - buffered;
+		if (partial > len)
+			partial = len;
+		memcpy(write_buffer + buffered, data, partial);
+		buffered += partial;
+		if (buffered == WRITE_BUFFER_SIZE) {
+			if (write(fd, write_buffer, WRITE_BUFFER_SIZE) != WRITE_BUFFER_SIZE)
+				return -1;
+			buffered = 0;
+		}
+		write_buffer_len = buffered;
+		len -= partial;
+		data += partial;
+ 	}
+ 	return 0;
+}
+
+static int c_flush(int fd)
+{
+	if (write_buffer_len) {
+		int left = write_buffer_len;
+		if (write(fd, write_buffer, left) != left)
+			return -1;
+		write_buffer_len = 0;
+	}
+	return 0;
+}
+
+/*
+ * creates a new packed file for all the items in head.  hard links are
+ * made from the sha1 of all the items back to the packd file, and then
+ * the packed file is unlinked.
+ */
+int write_packed_list(struct packed_item *head)
+{
+	unsigned char sha1[20];
+	SHA_CTX c;
+	char filename[PATH_MAX];
+	char *metadata = xmalloc(200);
+	char *header;
+	int metadata_size;
+	int fd;
+	int ret = 0;
+	unsigned long header_len;
+	struct packed_item *item;
+	char *compressed;
+	z_stream stream;
+	unsigned long size;
+
+	header = create_packed_header(head, &header_len);
+	metadata_size = 1+sprintf(metadata, "packed %lu", header_len);
+	/* 
+	 * the header contains the sha1 of each item, so we only sha1 the
+	 * header
+	 */ 
+	SHA1_Init(&c);
+	SHA1_Update(&c, metadata, metadata_size);
+	SHA1_Update(&c, header, header_len);
+	SHA1_Final(sha1, &c);
+
+	if (access(sha1_file_name(sha1), F_OK) == 0)
+		goto out_nofile;
+
+	snprintf(filename, sizeof(filename), "%s/obj_XXXXXX", get_object_directory());
+	fd = mkstemp(filename);
+	if (fd < 0) {
+		ret = -errno;
+		goto out_nofile;
+	}
+
+       /* compress just the header info */
+        memset(&stream, 0, sizeof(stream));
+        deflateInit(&stream, Z_BEST_COMPRESSION);
+	size = deflateBound(&stream, header_len + metadata_size);
+        compressed = xmalloc(size);
+
+        stream.next_in = metadata;
+        stream.avail_in = metadata_size;
+        stream.next_out = compressed;
+        stream.avail_out = size;
+        while (deflate(&stream, 0) == Z_OK)
+                /* nothing */;
+        stream.next_in = header;
+        stream.avail_in = header_len;
+        while (deflate(&stream, Z_FINISH) == Z_OK)
+                /* nothing */;
+        deflateEnd(&stream);
+        size = stream.total_out;
+
+	c_write(fd, compressed, size);
+	free(compressed);
+
+	item = head;
+	while(item) {
+		if (c_write(fd, item->data, item->len)) {
+			ret = -EIO;
+			goto out;
+		}
+		item = item->next;
+	}
+	if (c_flush(fd)) {
+		ret = -EIO;
+		goto out;
+	}
+	item = head;
+	while(item) {
+		char *item_file;
+		char item_tmp[PATH_MAX];
+		struct packed_item *next = item->next;
+		int name_iter = 0;
+		item_file = sha1_file_name(item->sha1);
+		while(1) {
+			/* ugly stuff.  We want to atomically replace any old objects
+			 * with the same sha1, making sure they don't get deleted
+			 * if any step along the way fails
+			 */
+			snprintf(item_tmp, sizeof(item_tmp), "%s/obj_%d", get_object_directory(), name_iter);
+			if (link(filename, item_tmp)) {
+				if (errno != EEXIST) {
+					ret = -errno;
+					goto out;
+				}
+			} else {
+				/* link success */
+				if (rename(item_tmp, item_file)) {
+					ret = -errno;
+					goto out;
+				}
+				break;
+			}
+			if (name_iter++ > 1000) {
+				ret = -1;
+				goto out;
+			}
+		}
+		free(item->data);
+		free(item);
+		item = next;
+	}
+out:
+	unlink(filename);
+	fchmod(fd, 0444);
+	close(fd);
+out_nofile:
+	free(header);
+	free(metadata);
+	return ret;
+}
