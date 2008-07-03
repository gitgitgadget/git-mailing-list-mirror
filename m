From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH/RFC] Fix some warnings (on cygwin) to allow -Werror
Date: Thu, 03 Jul 2008 16:52:09 +0100
Message-ID: <486CF5A9.5060104@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 19:50:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KESwd-0008AG-HV
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 19:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbYGCRsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 13:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbYGCRsf
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 13:48:35 -0400
Received: from anchor-post-37.mail.demon.net ([194.217.242.87]:55854 "EHLO
	anchor-post-37.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753218AbYGCRsd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 13:48:33 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-37.mail.demon.net with esmtp (Exim 4.68)
	id 1KESv0-0003HC-PQ; Thu, 03 Jul 2008 17:48:32 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87298>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Despite the subject line, this should be useful on any system for
which uint32_t is defined to be unsigned long rather than
unsigned int. (and where the return type of htonl() is similarly
defined).

Note that this was built on the v1.5.6 tarball, so will probably
not apply cleanly to the git repo! (hey, it's been more than a
few days). Hence, the RFC in the subject line. (is there a better
TLA for "so old it won't apply" ;-)

Also, note that git-compat-compat-util.h contains an #ifdef'ed
definition of PRIuMAX despite an unconditional #include of
inttypes.h; this seems a bit odd.  This seems to imply a system
with a pre-standard header file, missing the PRIuMAX #define.
If so, then similar definitions for PRIu32 and PRIx32 may need
to be added.

ATB,
Ramsay

 builtin-fast-export.c    |    4 ++--
 builtin-fetch-pack.c     |    3 ++-
 builtin-pack-objects.c   |   15 ++++++++++-----
 builtin-unpack-objects.c |    3 ++-
 index-pack.c             |    6 ++++--
 pack-check.c             |    4 ++--
 receive-pack.c           |    3 ++-
 sha1_file.c              |   12 ++++++------
 show-index.c             |    3 ++-
 9 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index d0a462f..3500ff0 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -102,7 +102,7 @@ static void handle_object(const unsigned char *sha1)
 
 	mark_object(object);
 
-	printf("blob\nmark :%d\ndata %lu\n", last_idnum, size);
+	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
 		die ("Could not write blob %s", sha1_to_hex(sha1));
 	printf("\n");
@@ -190,7 +190,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 		reencoded = reencode_string(message, "UTF-8", encoding);
 	if (!commit->parents)
 		printf("reset %s\n", (const char*)commit->util);
-	printf("commit %s\nmark :%d\n%.*s\n%.*s\ndata %u\n%s",
+	printf("commit %s\nmark :%"PRIu32"\n%.*s\n%.*s\ndata %u\n%s",
 	       (const char *)commit->util, last_idnum,
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer,
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index de1e8d1..e094e2d 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -519,7 +519,8 @@ static int get_pack(int xd[2], char **pack_lockfile)
 
 		if (read_pack_header(demux.out, &header))
 			die("protocol error: bad pack header");
-		snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%u,%u",
+		snprintf(hdr_arg, sizeof(hdr_arg),
+			 "--pack_header=%"PRIu32",%"PRIu32,
 			 ntohl(header.hdr_version), ntohl(header.hdr_entries));
 		if (ntohl(header.hdr_entries) < unpack_limit)
 			do_keep = 0;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 447d492..5e97355 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -590,7 +590,8 @@ static void write_pack_file(void)
 	free(written_list);
 	stop_progress(&progress_state);
 	if (written != nr_result)
-		die("wrote %u objects while expecting %u", written, nr_result);
+		die("wrote %"PRIu32" objects while expecting %"PRIu32,
+			written, nr_result);
 	/*
 	 * We have scanned through [0 ... i).  Since we have written
 	 * the correct number of objects,  the remaining [i ... nr_objects)
@@ -602,7 +603,8 @@ static void write_pack_file(void)
 		j += !e->idx.offset && !e->preferred_base;
 	}
 	if (j)
-		die("wrote %u objects as expected but %u unwritten", written, j);
+		die("wrote %"PRIu32" objects as expected but %"PRIu32
+			" unwritten", written, j);
 }
 
 static int locate_object_entry_hash(const unsigned char *sha1)
@@ -1718,7 +1720,8 @@ static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, vo
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
-	uint32_t i, n, nr_deltas;
+	uint32_t i, nr_deltas;
+	unsigned n;
 
 	get_object_details();
 
@@ -1809,7 +1812,8 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "pack.indexversion")) {
 		pack_idx_default_version = git_config_int(k, v);
 		if (pack_idx_default_version > 2)
-			die("bad pack.indexversion=%d", pack_idx_default_version);
+			die("bad pack.indexversion=%"PRIu32,
+				pack_idx_default_version);
 		return 0;
 	}
 	if (!strcmp(k, "pack.packsizelimit")) {
@@ -2243,7 +2247,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		prepare_pack(window, depth);
 	write_pack_file();
 	if (progress)
-		fprintf(stderr, "Total %u (delta %u), reused %u (delta %u)\n",
+		fprintf(stderr, "Total %"PRIu32" (delta %"PRIu32"),"
+			" reused %"PRIu32" (delta %"PRIu32")\n",
 			written, written_delta, reused, reused_delta);
 	return 0;
 }
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 85043d1..a891866 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -471,7 +471,8 @@ static void unpack_all(void)
 	if (ntohl(hdr->hdr_signature) != PACK_SIGNATURE)
 		die("bad pack file");
 	if (!pack_version_ok(hdr->hdr_version))
-		die("unknown pack file version %d", ntohl(hdr->hdr_version));
+		die("unknown pack file version %"PRIu32,
+			ntohl(hdr->hdr_version));
 	use(sizeof(struct pack_header));
 
 	if (!quiet)
diff --git a/index-pack.c b/index-pack.c
index 5ac91ba..25db5db 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -190,7 +190,8 @@ static void parse_pack_header(void)
 	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
 		die("pack signature mismatch");
 	if (!pack_version_ok(hdr->hdr_version))
-		die("pack version %d unsupported", ntohl(hdr->hdr_version));
+		die("pack version %"PRIu32" unsupported",
+			ntohl(hdr->hdr_version));
 
 	nr_objects = ntohl(hdr->hdr_entries);
 	use(sizeof(struct pack_header));
@@ -771,7 +772,8 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "pack.indexversion")) {
 		pack_idx_default_version = git_config_int(k, v);
 		if (pack_idx_default_version > 2)
-			die("bad pack.indexversion=%d", pack_idx_default_version);
+			die("bad pack.indexversion=%"PRIu32,
+				pack_idx_default_version);
 		return 0;
 	}
 	return git_default_config(k, v, cb);
diff --git a/pack-check.c b/pack-check.c
index f489873..98a6d56 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -146,11 +146,11 @@ static void show_pack_info(struct packed_git *p)
 	for (i = 0; i <= MAX_CHAIN; i++) {
 		if (!chain_histogram[i])
 			continue;
-		printf("chain length = %d: %d object%s\n", i,
+		printf("chain length = %"PRIu32": %"PRIu32" object%s\n", i,
 		       chain_histogram[i], chain_histogram[i] > 1 ? "s" : "");
 	}
 	if (chain_histogram[0])
-		printf("chain length > %d: %d object%s\n", MAX_CHAIN,
+		printf("chain length > %d: %"PRIu32" object%s\n", MAX_CHAIN,
 		       chain_histogram[0], chain_histogram[0] > 1 ? "s" : "");
 }
 
diff --git a/receive-pack.c b/receive-pack.c
index b26f2e3..fa653b4 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -370,7 +370,8 @@ static const char *unpack(void)
 	hdr_err = parse_pack_header(&hdr);
 	if (hdr_err)
 		return hdr_err;
-	snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%u,%u",
+	snprintf(hdr_arg, sizeof(hdr_arg),
+			"--pack_header=%"PRIu32",%"PRIu32,
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
 
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
diff --git a/sha1_file.c b/sha1_file.c
index 191f814..7610c43 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -471,7 +471,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 		version = ntohl(hdr->idx_version);
 		if (version < 2 || version > 2) {
 			munmap(idx_map, idx_size);
-			return error("index file %s is version %d"
+			return error("index file %s is version %"PRIu32
 				     " and is not supported by this binary"
 				     " (try upgrading GIT to a newer version)",
 				     path, version);
@@ -682,14 +682,14 @@ static int open_packed_git_1(struct packed_git *p)
 	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
 		return error("file %s is not a GIT packfile", p->pack_name);
 	if (!pack_version_ok(hdr.hdr_version))
-		return error("packfile %s is version %u and not supported"
-			" (try upgrading GIT to a newer version)",
+		return error("packfile %s is version %"PRIu32" and not"
+			" supported (try upgrading GIT to a newer version)",
 			p->pack_name, ntohl(hdr.hdr_version));
 
 	/* Verify the pack matches its index. */
 	if (p->num_objects != ntohl(hdr.hdr_entries))
-		return error("packfile %s claims to have %u objects"
-			     " while index indicates %u objects",
+		return error("packfile %s claims to have %"PRIu32" objects"
+			     " while index indicates %"PRIu32" objects",
 			     p->pack_name, ntohl(hdr.hdr_entries),
 			     p->num_objects);
 	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) == -1)
@@ -1719,7 +1719,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	}
 
 	if (debug_lookup)
-		printf("%02x%02x%02x... lo %u hi %u nr %u\n",
+		printf("%02x%02x%02x... lo %u hi %u nr %"PRIu32"\n",
 		       sha1[0], sha1[1], sha1[2], lo, hi, p->num_objects);
 
 	if (use_lookup < 0)
diff --git a/show-index.c b/show-index.c
index 7253991..45bb535 100644
--- a/show-index.c
+++ b/show-index.c
@@ -68,7 +68,8 @@ int main(int argc, char **argv)
 						     ntohl(off64[1]);
 				off64_nr++;
 			}
-			printf("%" PRIuMAX " %s (%08x)\n", (uintmax_t) offset,
+			printf("%" PRIuMAX " %s (%08"PRIx32")\n",
+			       (uintmax_t) offset,
 			       sha1_to_hex(entries[i].sha1),
 			       ntohl(entries[i].crc));
 		}
-- 
1.5.6
