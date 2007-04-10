From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Cygwin and git 1.5.1
Date: Tue, 10 Apr 2007 18:39:12 +0100
Message-ID: <461BCBC0.2000705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 03:11:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbKJS-0000lv-Up
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 19:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031267AbXDJRjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 13:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031281AbXDJRjX
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 13:39:23 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:2757 "EHLO
	anchor-post-32.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031267AbXDJRjW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2007 13:39:22 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-32.mail.demon.net with esmtp (Exim 4.42)
	id 1HbKJD-00016F-8F; Tue, 10 Apr 2007 17:39:15 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44157>

Hi Junio,

I recently upgraded to 1.5.1, via tarball as usual, without much problem.
The only problem being the "printf format warnings" issue, which prevents
me building with -Werror.

I have included, below, an updated version of my patch from the 1.5.0 series.
We agreed last time that this patch is not the correct solution to this
problem in general (but it works on cygwin!), so this is *not* intended
for submission. I just wanted to document the problem. As before, I don't
really have a solution; I suppose I will just have to carry this patch
forward with each release - no big deal.

Note that the patch has grown larger. This is due to the increased use of
uint32_t (in combination with printf/die/error etc).
I guess not many others use -Werror to build on cygwin! ;-)

All the best,

Ramsay Jones

--- >8 ---
 From b2610fc65e42cd6a9acadb20343bddee7c1e3cec Mon Sep 17 00:00:00 2001
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Mon, 9 Apr 2007 16:41:43 +0100
Subject: [PATCH] Fix some "printf format" warnings.


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
  builtin-ls-files.c       |    2 +-
  builtin-pack-objects.c   |   20 ++++++++++----------
  builtin-unpack-objects.c |    2 +-
  fetch-pack.c             |    2 +-
  index-pack.c             |    2 +-
  merge-index.c            |    2 +-
  pack-check.c             |    2 +-
  read-cache.c             |    2 +-
  receive-pack.c           |    2 +-
  sha1_file.c              |    6 +++---
  unpack-trees.c           |    2 +-
  11 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 4e1d5af..310952a 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -193,7 +193,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
  		putchar(line_terminator);
  	}
  	else {
-		printf("%s%06o %s %d\t",
+		printf("%s%06lo %s %d\t",
  		       tag,
  		       ntohl(ce->ce_mode),
  		       abbrev ? find_unique_abbrev(ce->sha1,abbrev)
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b5f9648..b40e617 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -532,7 +532,7 @@ static void write_pack_file(void)
  		f = sha1create("%s-%s.%s", base_name,
  			       sha1_to_hex(object_list_sha1), "pack");
  	if (do_progress)
-		fprintf(stderr, "Writing %u objects.\n", nr_result);
+		fprintf(stderr, "Writing %lu objects.\n", nr_result);

  	hdr.hdr_signature = htonl(PACK_SIGNATURE);
  	hdr.hdr_version = htonl(PACK_VERSION);
@@ -546,7 +546,7 @@ static void write_pack_file(void)
  		if (do_progress) {
  			unsigned percent = written * 100 / nr_result;
  			if (progress_update || percent != last_percent) {
-				fprintf(stderr, "%4u%% (%u/%u) done\r",
+				fprintf(stderr, "%4u%% (%lu/%lu) done\r",
  					percent, written, nr_result);
  				progress_update = 0;
  				last_percent = percent;
@@ -557,7 +557,7 @@ static void write_pack_file(void)
  		fputc('\n', stderr);
   done:
  	if (written != nr_result)
-		die("wrote %u objects while expecting %u", written, nr_result);
+		die("wrote %lu objects while expecting %lu", written, nr_result);
  	sha1close(f, pack_file_sha1, 1);
  }

@@ -716,7 +716,7 @@ static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclud

   already_added:
  	if (progress_update) {
-		fprintf(stderr, "Counting objects...%u\r", nr_objects);
+		fprintf(stderr, "Counting objects...%lu\r", nr_objects);
  		progress_update = 0;
  	}
  	if (exclude)
@@ -1286,7 +1286,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
  	array = xmalloc(array_size);
  	memset(array, 0, array_size);
  	if (progress)
-		fprintf(stderr, "Deltifying %u objects.\n", nr_result);
+		fprintf(stderr, "Deltifying %lu objects.\n", nr_result);

  	do {
  		struct object_entry *entry = list[--i];
@@ -1299,7 +1299,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
  		if (progress) {
  			unsigned percent = processed * 100 / nr_result;
  			if (percent != last_percent || progress_update) {
-				fprintf(stderr, "%4u%% (%u/%u) done\r",
+				fprintf(stderr, "%4u%% (%lu/%lu) done\r",
  					percent, processed, nr_result);
  				progress_update = 0;
  				last_percent = percent;
@@ -1383,7 +1383,7 @@ static int reuse_cached_pack(unsigned char *sha1)
  	}

  	if (progress)
-		fprintf(stderr, "Reusing %u objects pack %s\n", nr_objects,
+		fprintf(stderr, "Reusing %lu objects pack %s\n", nr_objects,
  			sha1_to_hex(sha1));

  	if (pack_to_stdout) {
@@ -1667,7 +1667,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
  	}

  	if (progress)
-		fprintf(stderr, "Done counting %u objects.\n", nr_objects);
+		fprintf(stderr, "Done counting %lu objects.\n", nr_objects);
  	sorted_by_sha = create_final_object_list();
  	if (non_empty && !nr_result)
  		return 0;
@@ -1680,7 +1680,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
  	}
  	SHA1_Final(object_list_sha1, &ctx);
  	if (progress && (nr_objects != nr_result))
-		fprintf(stderr, "Result has %u objects.\n", nr_result);
+		fprintf(stderr, "Result has %lu objects.\n", nr_result);

  	if (reuse_cached_pack(object_list_sha1))
  		;
@@ -1701,7 +1701,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
  		}
  	}
  	if (progress)
-		fprintf(stderr, "Total %u (delta %u), reused %u (delta %u)\n",
+		fprintf(stderr, "Total %lu (delta %lu), reused %lu (delta %lu)\n",
  			written, written_delta, reused, reused_delta);
  	return 0;
  }
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 3956c56..67783fe 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -324,7 +324,7 @@ static void unpack_all(void)
  	if (ntohl(hdr->hdr_signature) != PACK_SIGNATURE)
  		die("bad pack file");
  	if (!pack_version_ok(hdr->hdr_version))
-		die("unknown pack file version %d", ntohl(hdr->hdr_version));
+		die("unknown pack file version %ld", ntohl(hdr->hdr_version));
  	fprintf(stderr, "Unpacking %d objects\n", nr_objects);

  	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
diff --git a/fetch-pack.c b/fetch-pack.c
index 06f4aec..8cc9888 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -512,7 +512,7 @@ static int get_pack(int xd[2])

  		if (read_pack_header(fd[0], &header))
  			die("protocol error: bad pack header");
-		snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%u,%u",
+		snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%lu,%lu",
  			 ntohl(header.hdr_version), ntohl(header.hdr_entries));
  		if (ntohl(header.hdr_entries) < unpack_limit)
  			do_keep = 0;
diff --git a/index-pack.c b/index-pack.c
index 3c768fb..198e694 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -167,7 +167,7 @@ static void parse_pack_header(void)
  	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
  		die("pack signature mismatch");
  	if (!pack_version_ok(hdr->hdr_version))
-		die("pack version %d unsupported", ntohl(hdr->hdr_version));
+		die("pack version %ld unsupported", ntohl(hdr->hdr_version));

  	nr_objects = ntohl(hdr->hdr_entries);
  	use(sizeof(struct pack_header));
diff --git a/merge-index.c b/merge-index.c
index 5599fd3..4437355 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -48,7 +48,7 @@ static int merge_entry(int pos, const char *path)
  			break;
  		found++;
  		strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
-		sprintf(ownbuf[stage], "%o", ntohl(ce->ce_mode));
+		sprintf(ownbuf[stage], "%lo", ntohl(ce->ce_mode));
  		arguments[stage] = hexbuf[stage];
  		arguments[stage + 4] = ownbuf[stage];
  	} while (++pos < active_nr);
diff --git a/pack-check.c b/pack-check.c
index d988322..592a0ce 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -116,7 +116,7 @@ static void show_pack_info(struct packed_git *p)
  	for (i = 0; i < MAX_CHAIN; i++) {
  		if (!chain_histogram[i])
  			continue;
-		printf("chain length %s %d: %d object%s\n",
+		printf("chain length %s %ld: %ld object%s\n",
  		       i ? "=" : ">=",
  		       i ? i : MAX_CHAIN,
  		       chain_histogram[i],
diff --git a/read-cache.c b/read-cache.c
index 6339a27..9c274d9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -130,7 +130,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
  			changed |= TYPE_CHANGED;
  		break;
  	default:
-		die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
+		die("internal error: ce_mode is %lo", ntohl(ce->ce_mode));
  	}
  	if (ce->ce_mtime.sec != htonl(st->st_mtime))
  		changed |= MTIME_CHANGED;
diff --git a/receive-pack.c b/receive-pack.c
index 26aa26b..bdabdd9 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -352,7 +352,7 @@ static const char *unpack(void)
  	hdr_err = parse_pack_header(&hdr);
  	if (hdr_err)
  		return hdr_err;
-	snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%u,%u",
+	snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%lu,%lu",
  			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));

  	if (ntohl(hdr.hdr_entries) < unpack_limit) {
diff --git a/sha1_file.c b/sha1_file.c
index 9c26038..187a109 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -600,14 +600,14 @@ static int open_packed_git_1(struct packed_git *p)
  	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
  		return error("file %s is not a GIT packfile", p->pack_name);
  	if (!pack_version_ok(hdr.hdr_version))
-		return error("packfile %s is version %u and not supported"
+		return error("packfile %s is version %lu and not supported"
  			" (try upgrading GIT to a newer version)",
  			p->pack_name, ntohl(hdr.hdr_version));

  	/* Verify the pack matches its index. */
  	if (num_packed_objects(p) != ntohl(hdr.hdr_entries))
-		return error("packfile %s claims to have %u objects"
-			" while index size indicates %u objects",
+		return error("packfile %s claims to have %lu objects"
+			" while index size indicates %lu objects",
  			p->pack_name, ntohl(hdr.hdr_entries),
  			num_packed_objects(p));
  	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) == -1)
diff --git a/unpack-trees.c b/unpack-trees.c
index ee10eea..5063059 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -538,7 +538,7 @@ static void show_stage_entry(FILE *o,
  	if (!ce)
  		fprintf(o, "%s (missing)\n", label);
  	else
-		fprintf(o, "%s%06o %s %d\t%s\n",
+		fprintf(o, "%s%06lo %s %d\t%s\n",
  			label,
  			ntohl(ce->ce_mode),
  			sha1_to_hex(ce->sha1),
-- 
1.5.1
