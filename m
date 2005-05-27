From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] mkdelta enhancements (take 2)
Date: Fri, 27 May 2005 15:29:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505271511450.16151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 21:34:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbkaR-0005BA-Lz
	for gcvg-git@gmane.org; Fri, 27 May 2005 21:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVE0TeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 15:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVE0Tb0
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 15:31:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41100 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261969AbVE0T3B
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 15:29:01 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IH50075AY4CYI@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 27 May 2005 15:29:01 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Although it was described as such, git-mkdelta didn't really attempt to
find the best delta against any previous object in the list but was only
able to create a delta against the preceeding object.  This patch 
reworks the code to fix that limitation and hopefully makes it a bit
clearer than before.

This means that

        git-mkdelta sha1 sha2 sha3 sha4 sha5 sha6

will now create a sha2 delta against sha1, a sha3 delta against either
sha2 or sha1 and keep the best one, a sha4 delta against either sha3,
sha2 or sha1, etc.  The --max-behind argument limits that search for the
best delta to the specified number of previous objects in the list.  If
no limit is specified it is unlimited (note: it might run out of 
memory with long object lists).

Also added a -q (quiet) switch so it is possible to have 3 levels of
output: -q for nothing, -v for verbose, and if none of -q nor -v is
specified then only actual changes on the object database are shown.

Finally the git-deltafy-script has been updated accordingly, and some 
bugs fixed (thanks to Stephen C. Tweedie for spotting them).

This version has been toroughly tested and I think it might be ready
for public consumption.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/git-deltafy-script b/git-deltafy-script
old mode 100644
new mode 100755
--- a/git-deltafy-script
+++ b/git-deltafy-script
@@ -1,40 +1,67 @@
 #!/bin/bash
 
-# Script to deltafy an entire GIT repository based on the commit list.
+# Example script to deltafy an entire GIT repository based on the commit list.
 # The most recent version of a file is the reference and previous versions
 # are made delta against the best earlier version available. And so on for
-# successive versions going back in time.  This way the delta overhead is
-# pushed towards older version of any given file.
-#
-# NOTE: the "best earlier version" is not implemented in mkdelta yet
-#       and therefore only the next eariler version is used at this time.
-#
-# TODO: deltafy tree objects as well.
+# successive versions going back in time.  This way the increasing delta
+# overhead is pushed towards older versions of any given file.
 #
 # The -d argument allows to provide a limit on the delta chain depth.
-# If 0 is passed then everything is undeltafied.
+# If 0 is passed then everything is undeltafied.  Limiting the delta
+# depth is meaningful for subsequent access performance to old revisions.
+# A value of 16 might be a good compromize between performance and good
+# space saving.  Current default is unbounded.
+#
+# The --max-behind=30 argument is passed to git-mkdelta so to keep
+# combinations and memory usage bounded a bit.  If you have lots of memory
+# and CPU power you may remove it (or set to 0) to let git-mkdelta find the
+# best delta match regardless of the number of revisions for a given file.
+# You can also make the value smaller to make it faster and less
+# memory hungry.  A value of 5 ought to still give pretty good results.
+# When set to 0 or ommitted then look behind is unbounded.  Note that
+# git-mkdelta might die with a segmentation fault in that case if it
+# runs out of memory.  Note that the GIT repository will still be consistent
+# even if git-mkdelta dies unexpectedly.
 
 set -e
 
 depth=
 [ "$1" == "-d" ] && depth="--max-depth=$2" && shift 2
 
+function process_list() {
+	if [ "$list" ]; then
+		echo "Processing $curr_file"
+		echo "$head $list" | xargs git-mkdelta $depth --max-behind=30 -v
+	fi
+}
+
 curr_file=""
 
 git-rev-list HEAD |
-git-diff-tree -r --stdin |
-awk '/^:/ { if ($5 == "M" || $5 == "N") print $4, $6 }' |
+git-diff-tree -r -t --stdin |
+awk '/^:/ { if ($5 == "M" || $5 == "N") print $4, $6;
+            if ($5 == "M") print $3, $6 }' |
 LC_ALL=C sort -s -k 2 | uniq |
 while read sha1 file; do
 	if [ "$file" == "$curr_file" ]; then
 		list="$list $sha1"
 	else
-		if [ "$list" ]; then
-			echo "Processing $curr_file"
-			echo "$head $list" | xargs git-mkdelta $depth -v
-		fi
+		process_list
 		curr_file="$file"
 		list=""
 		head="$sha1"
 	fi
 done
+process_list
+
+curr_file="root directory"
+head=""
+list="$(
+	git-rev-list HEAD |
+	while read commit; do
+		git-cat-file commit $commit |
+		sed -n 's/tree //p;Q'
+	done
+	)"
+process_list
+
diff --git a/mkdelta.c b/mkdelta.c
--- a/mkdelta.c
+++ b/mkdelta.c
@@ -98,21 +98,16 @@ static void *create_delta_object(char *b
 	return create_object(buf, len, hdr, hdrlen, size);
 }
 
-static unsigned long get_object_size(unsigned char *sha1)
-{
-	struct stat st;
-	if (stat(sha1_file_name(sha1), &st))
-		die("%s: %s", sha1_to_hex(sha1), strerror(errno));
-	return st.st_size;
-}
-
-static void *get_buffer(unsigned char *sha1, char *type, unsigned long *size)
+static void *get_buffer(unsigned char *sha1, char *type,
+			unsigned long *size, unsigned long *compsize)
 {
 	unsigned long mapsize;
 	void *map = map_sha1_file(sha1, &mapsize);
 	if (map) {
 		void *buffer = unpack_sha1_file(map, mapsize, type, size);
 		munmap(map, mapsize);
+		if (compsize)
+			*compsize = mapsize;
 		if (buffer)
 			return buffer;
 	}
@@ -120,198 +115,246 @@ static void *get_buffer(unsigned char *s
 	return NULL;
 }
 
-static void *expand_delta(void *delta, unsigned long delta_size, char *type,
-			  unsigned long *size, unsigned int *depth, char *head)
+static void *expand_delta(void *delta, unsigned long *size, char *type,
+			  unsigned int *depth, unsigned char **links)
 {
 	void *buf = NULL;
-	*depth++;
-	if (delta_size < 20) {
+	unsigned int level = (*depth)++;
+	if (*size < 20) {
 		error("delta object is bad");
 		free(delta);
 	} else {
 		unsigned long ref_size;
-		void *ref = get_buffer(delta, type, &ref_size);
+		void *ref = get_buffer(delta, type, &ref_size, NULL);
 		if (ref && !strcmp(type, "delta"))
-			ref = expand_delta(ref, ref_size, type, &ref_size,
-					   depth, head);
-		else
-			memcpy(head, delta, 20);
-		if (ref)
-			buf = patch_delta(ref, ref_size, delta+20,
-					  delta_size-20, size);
-		free(ref);
+			ref = expand_delta(ref, &ref_size, type, depth, links);
+		else if (ref)
+{
+			*links = xmalloc(*depth * 20);
+}
+		if (ref) {
+			buf = patch_delta(ref, ref_size, delta+20, *size-20, size);
+			free(ref);
+			if (buf)
+				memcpy(*links + level*20, delta, 20);
+			else
+				free(*links);
+		}
 		free(delta);
 	}
 	return buf;
 }
 
 static char *mkdelta_usage =
-"mkdelta [ --max-depth=N ] <reference_sha1> <target_sha1> [ <next_sha1> ... ]";
+"mkdelta [--max-depth=N] [--max-behind=N] <reference_sha1> <target_sha1> [<next_sha1> ...]";
 
+struct delta {
+	unsigned char sha1[20];		/* object sha1 */
+	unsigned long size;		/* object size */
+	void *buf;			/* object content */
+	unsigned char *links;		/* delta reference links */
+	unsigned int depth;		/* delta depth */
+};
+	
 int main(int argc, char **argv)
 {
-	unsigned char sha1_ref[20], sha1_trg[20], head_ref[20], head_trg[20];
-	char type_ref[20], type_trg[20];
-	void *buf_ref, *buf_trg, *buf_delta;
-	unsigned long size_ref, size_trg, size_orig, size_delta;
-	unsigned int depth_ref, depth_trg, depth_max = -1;
-	int i, verbose = 0;
+	struct delta *ref, trg;
+	char ref_type[20], trg_type[20], *skip_reason;
+	void *best_buf;
+	unsigned long best_size, orig_size, orig_compsize;
+	unsigned int r, orig_ref, best_ref, nb_refs, next_ref, max_refs = 0;
+	unsigned int i, duplicate, skip_lvl, verbose = 0, quiet = 0;
+	unsigned int max_depth = -1;
 
 	for (i = 1; i < argc; i++) {
 		if (!strcmp(argv[i], "-v")) {
 			verbose = 1;
+			quiet = 0;
+		} else if (!strcmp(argv[i], "-q")) {
+			quiet = 1;
+			verbose = 0;
 		} else if (!strcmp(argv[i], "-d") && i+1 < argc) {
-			depth_max = atoi(argv[++i]);
+			max_depth = atoi(argv[++i]);
 		} else if (!strncmp(argv[i], "--max-depth=", 12)) {
-			depth_max = atoi(argv[i]+12);
+			max_depth = atoi(argv[i]+12);
+		} else if (!strcmp(argv[i], "-b") && i+1 < argc) {
+			max_refs = atoi(argv[++i]);
+		} else if (!strncmp(argv[i], "--max-behind=", 13)) {
+			max_refs = atoi(argv[i]+13);
 		} else
 			break;
 	}
 
-	if (i + (depth_max != 0) >= argc)
+	if (i + (max_depth != 0) >= argc)
 		usage(mkdelta_usage);
 
-	if (get_sha1(argv[i], sha1_ref))
-		die("bad sha1 %s", argv[i]);
-	depth_ref = 0;
-	buf_ref = get_buffer(sha1_ref, type_ref, &size_ref);
-	if (buf_ref && !strcmp(type_ref, "delta"))
-		buf_ref = expand_delta(buf_ref, size_ref, type_ref,
-				       &size_ref, &depth_ref, head_ref);
-	else
-		memcpy(head_ref, sha1_ref, 20);
-	if (!buf_ref)
-		die("unable to obtain initial object %s", argv[i]);
-
-	if (depth_ref > depth_max) {
-		if (restore_original_object(buf_ref, size_ref, type_ref, sha1_ref))
-			die("unable to restore %s", argv[i]);
-		if (verbose)
-			printf("undelta %s (depth was %d)\n", argv[i], depth_ref);
-		depth_ref = 0;
-	}
-
-	/*
-	 * TODO: deltafication should be tried against any early object
-	 * in the object list and not only the previous object.
-	 */
+	if (!max_refs || max_refs > argc - i)
+		max_refs = argc - i;
+	ref = xmalloc(max_refs * sizeof(*ref));
+	for (r = 0; r < max_refs; r++)
+		ref[r].buf = ref[r].links = NULL;
+	next_ref = nb_refs = 0;
 
-	while (++i < argc) {
-		if (get_sha1(argv[i], sha1_trg))
+	do {
+		if (get_sha1(argv[i], trg.sha1))
 			die("bad sha1 %s", argv[i]);
-		depth_trg = 0;
-		buf_trg = get_buffer(sha1_trg, type_trg, &size_trg);
-		if (buf_trg && !size_trg) {
+		trg.buf = get_buffer(trg.sha1, trg_type, &trg.size, &orig_compsize);
+		if (trg.buf && !trg.size) {
 			if (verbose)
 				printf("skip    %s (object is empty)\n", argv[i]);
 			continue;
 		}
-		size_orig = size_trg;
-		if (buf_trg && !strcmp(type_trg, "delta")) {
-			if (!memcmp(buf_trg, sha1_ref, 20)) {
-				/* delta already in place */
-				depth_ref++;
-				memcpy(sha1_ref, sha1_trg, 20);
-				buf_ref = patch_delta(buf_ref, size_ref,
-						      buf_trg+20, size_trg-20,
-						      &size_ref);
-				if (!buf_ref)
-					die("unable to apply delta %s", argv[i]);
-				if (depth_ref > depth_max) {
-					if (restore_original_object(buf_ref, size_ref,
-								    type_ref, sha1_ref))
-						die("unable to restore %s", argv[i]);
-					if (verbose)
-						printf("undelta %s (depth was %d)\n", argv[i], depth_ref);
-					depth_ref = 0;
-					continue;
-				}
-				if (verbose)
-					printf("skip    %s (delta already in place)\n", argv[i]);
-				continue;
+		orig_size = trg.size;
+		orig_ref = -1;
+		trg.depth = 0;
+		trg.links = NULL;
+		if (trg.buf && !strcmp(trg_type, "delta")) {
+			for (r = 0; r < nb_refs; r++)
+				if (!memcmp(trg.buf, ref[r].sha1, 20))
+					break;
+			if (r < nb_refs) {
+				/* no need to reload the reference object */
+				trg.depth = ref[r].depth + 1;
+				trg.links = xmalloc(trg.depth*20);
+				memcpy(trg.links, trg.buf, 20);
+				memcpy(trg.links+20, ref[r].links, ref[r].depth*20);
+				trg.buf = patch_delta(ref[r].buf, ref[r].size,
+						      trg.buf+20, trg.size-20,
+						      &trg.size);
+				strcpy(trg_type, ref_type);
+				orig_ref = r;
+			} else {
+				trg.buf = expand_delta(trg.buf, &trg.size, trg_type,
+						       &trg.depth, &trg.links);
 			}
-			buf_trg = expand_delta(buf_trg, size_trg, type_trg,
-					       &size_trg, &depth_trg, head_trg);
-		} else
-			memcpy(head_trg, sha1_trg, 20);
-		if (!buf_trg)
-			die("unable to read target object %s", argv[i]);
-
-		if (depth_trg > depth_max) {
-			if (restore_original_object(buf_trg, size_trg, type_trg, sha1_trg))
-				die("unable to restore %s", argv[i]);
-			if (verbose)
-				printf("undelta %s (depth was %d)\n", argv[i], depth_trg);
-			depth_trg = 0;
-			size_orig = size_trg;
 		}
+		if (!trg.buf)
+			die("unable to read target object %s", argv[i]);
 
-		if (depth_max == 0)
-			goto skip;
-
-		if (strcmp(type_ref, type_trg))
+		if (!nb_refs) {
+			strcpy(ref_type, trg_type);
+		} else if (max_depth && strcmp(ref_type, trg_type)) {
 			die("type mismatch for object %s", argv[i]);
-
-		if (!size_ref) {
-			if (verbose)
-				printf("skip    %s (initial object is empty)\n", argv[i]);
-			goto skip;
-		}
-		
-		if (depth_ref + 1 > depth_max) {
-			if (verbose)
-				printf("skip    %s (exceeding max link depth)\n", argv[i]);
-			goto skip;
 		}
 
-		if (!memcmp(head_ref, sha1_trg, 20)) {
-			if (verbose)
-				printf("skip    %s (would create a loop)\n", argv[i]);
-			goto skip;
+		duplicate = 0;
+		best_buf = NULL;
+		best_size = -1;
+		best_ref = -1;
+		skip_lvl = 0;
+		skip_reason = NULL;
+		for (r = 0; max_depth && r < nb_refs; r++) {
+			void *delta_buf, *comp_buf;
+			unsigned long delta_size, comp_size;
+			unsigned int l;
+
+			duplicate = !memcmp(trg.sha1, ref[r].sha1, 20);
+			if (duplicate) {
+				skip_reason = "already seen";
+				break;
+			}
+			if (ref[r].depth >= max_depth) {
+				if (skip_lvl < 1) {
+					skip_reason = "exceeding max link depth";
+					skip_lvl = 1;
+				}
+				continue;
+			}
+			for (l = 0; l < ref[r].depth; l++)
+				if (!memcmp(trg.sha1, ref[r].links + l*20, 20))
+					break;
+			if (l != ref[r].depth) {
+				if (skip_lvl < 2) {
+					skip_reason = "would create a loop";
+					skip_lvl = 2;
+				}
+				continue;
+			}
+			if (trg.depth < max_depth && r == orig_ref) {
+				if (skip_lvl < 3) {
+					skip_reason = "delta already in place";
+					skip_lvl = 3;
+				}
+				continue;
+			}
+			delta_buf = diff_delta(ref[r].buf, ref[r].size,
+					       trg.buf, trg.size, &delta_size);
+			if (!delta_buf)
+				die("out of memory");
+			if (trg.depth < max_depth &&
+			    delta_size+20 >= orig_size) {
+				/* no need to even try to compress if original
+				   object is smaller than this delta */
+				free(delta_buf);
+				if (skip_lvl < 4) {
+					skip_reason = "no size reduction";
+					skip_lvl = 4;
+				}
+				continue;
+			}
+			comp_buf = create_delta_object(delta_buf, delta_size,
+						       ref[r].sha1, &comp_size);
+			if (!comp_buf)
+				die("out of memory");
+			free(delta_buf);
+			if (trg.depth < max_depth &&
+			    comp_size >= orig_compsize) {
+				free(comp_buf);
+				if (skip_lvl < 5) {
+					skip_reason = "no size reduction";
+					skip_lvl = 5;
+				}
+				continue;
+			}
+			if ((comp_size < best_size) ||
+			    (comp_size == best_size &&
+			     ref[r].depth < ref[best_ref].depth)) {
+				free(best_buf);
+				best_buf = comp_buf;
+				best_size = comp_size;
+				best_ref = r;
+			}
 		}
 
-		buf_delta = diff_delta(buf_ref, size_ref, buf_trg, size_trg, &size_delta);
-		if (!buf_delta)
-			die("out of memory");
-
-		/* no need to even try to compress if original
-		   uncompressed is already smaller */
-		if (size_delta+20 < size_orig) {
-			void *buf_obj;
-			unsigned long size_obj;
-			buf_obj = create_delta_object(buf_delta, size_delta,
-						      sha1_ref, &size_obj);
-			free(buf_delta);
-			size_orig = get_object_size(sha1_trg);
-			if (size_obj >= size_orig) {
-				free(buf_obj);
-				if (verbose)
-					printf("skip    %s (original is smaller)\n", argv[i]);
-				goto skip;
-			}
-			if (replace_object(buf_obj, size_obj, sha1_trg))
+		if (best_buf) {
+			if (replace_object(best_buf, best_size, trg.sha1))
 				die("unable to write delta for %s", argv[i]);
-			free(buf_obj);
-			depth_ref++;
-			if (verbose)
-				printf("delta   %s (size=%ld.%02ld%%, depth=%d)\n",
-				       argv[i], size_obj*100 / size_orig,
-				       (size_obj*10000 / size_orig)%100,
-				       depth_ref);
-		} else {
-			free(buf_delta);
-			if (verbose)
-				printf("skip    %s (original is smaller)\n", argv[i]);
-			skip:
-			depth_ref = depth_trg;
-			memcpy(head_ref, head_trg, 20);
+			free(best_buf);
+			free(trg.links);
+			trg.depth = ref[best_ref].depth + 1;
+			trg.links = xmalloc(trg.depth*20);
+			memcpy(trg.links, ref[best_ref].sha1, 20);
+			memcpy(trg.links+20, ref[best_ref].links, ref[best_ref].depth*20);
+			if (!quiet)
+				printf("delta   %s (size=%ld.%02ld%% depth=%d dist=%d)\n",
+				       argv[i], best_size*100 / orig_compsize,
+				       (best_size*10000 / orig_compsize)%100,
+				       trg.depth,
+				       (next_ref - best_ref + max_refs)
+				       % (max_refs + 1) + 1);
+		} else if (trg.depth > max_depth) {
+			if (restore_original_object(trg.buf, trg.size, trg_type, trg.sha1))
+				die("unable to restore %s", argv[i]);
+			if (!quiet)
+				printf("undelta %s (depth was %d)\n",
+				       argv[i], trg.depth);
+			trg.depth = 0;
+			free(trg.links);
+			trg.links = NULL;
+		} else if (skip_reason && verbose) {
+			printf("skip    %s (%s)\n", argv[i], skip_reason);
 		}
 
-		free(buf_ref);
-		buf_ref = buf_trg;
-		size_ref = size_trg;
-		memcpy(sha1_ref, sha1_trg, 20);
-	}
+		if (!duplicate) {
+			free(ref[next_ref].buf);
+			free(ref[next_ref].links);
+			ref[next_ref] = trg;
+			if (++next_ref > nb_refs)
+				nb_refs = next_ref;
+			if (next_ref == max_refs)
+				next_ref = 0;
+		}
+	} while (++i < argc);
 
 	return 0;
 }
