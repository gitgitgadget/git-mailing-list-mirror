Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BCEC1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754008AbdC1Tpr (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:45:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:53151 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752637AbdC1Tpq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:45:46 -0400
Received: (qmail 11718 invoked by uid 109); 28 Mar 2017 19:45:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:45:45 +0000
Received: (qmail 1083 invoked by uid 111); 28 Mar 2017 19:46:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:46:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:45:43 -0400
Date:   Tue, 28 Mar 2017 15:45:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/18] odb_mkstemp: write filename into strbuf
Message-ID: <20170328194543.6e7dhx35ttujm4vv@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The odb_mkstemp() function expects the caller to provide a
fixed buffer to write the resulting tempfile name into. But
it creates the template using snprintf without checking the
return value. This means we could silently truncate the
filename.

In practice, it's unlikely that the truncation would end in
the template-pattern that mkstemp needs to open the file. So
we'd probably end up failing either way, unless the path was
specially crafted.

The simplest fix would be to notice the truncation and die.
However, we can observe that most callers immediately
xstrdup() the result anyway. So instead, let's switch to
using a strbuf, which is easier for them (and isn't a big
deal for the other 2 callers, who can just strbuf_release
when they're done with it).

Note that many of the callers used static buffers, but this
was purely to avoid putting a large buffer on the stack. We
never passed the static buffers out of the function, so
there's no complicated memory handling we need to change.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c |  6 +++---
 cache.h              |  2 +-
 environment.c        | 16 ++++++++--------
 fast-import.c        |  9 +++++----
 pack-bitmap-write.c  | 12 +++++++-----
 pack-write.c         | 12 ++++++------
 6 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 49e7175d9..f4af2ab37 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -307,10 +307,10 @@ static const char *open_pack_file(const char *pack_name)
 	if (from_stdin) {
 		input_fd = 0;
 		if (!pack_name) {
-			static char tmp_file[PATH_MAX];
-			output_fd = odb_mkstemp(tmp_file, sizeof(tmp_file),
+			struct strbuf tmp_file = STRBUF_INIT;
+			output_fd = odb_mkstemp(&tmp_file,
 						"pack/tmp_pack_XXXXXX");
-			pack_name = xstrdup(tmp_file);
+			pack_name = strbuf_detach(&tmp_file, NULL);
 		} else {
 			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
 			if (output_fd < 0)
diff --git a/cache.h b/cache.h
index acad7078d..1c1889428 100644
--- a/cache.h
+++ b/cache.h
@@ -1678,7 +1678,7 @@ extern void pack_report(void);
  * usual "XXXXXX" trailer, and the resulting filename is written into the
  * "template" buffer. Returns the open descriptor.
  */
-extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
+extern int odb_mkstemp(struct strbuf *template, const char *pattern);
 
 /*
  * Generate the filename to be used for a pack file with checksum "sha1" and
diff --git a/environment.c b/environment.c
index 2fdba7622..88276790d 100644
--- a/environment.c
+++ b/environment.c
@@ -274,7 +274,7 @@ char *get_object_directory(void)
 	return git_object_dir;
 }
 
-int odb_mkstemp(char *template, size_t limit, const char *pattern)
+int odb_mkstemp(struct strbuf *template, const char *pattern)
 {
 	int fd;
 	/*
@@ -282,18 +282,18 @@ int odb_mkstemp(char *template, size_t limit, const char *pattern)
 	 * restrictive except to remove write permission.
 	 */
 	int mode = 0444;
-	snprintf(template, limit, "%s/%s",
-		 get_object_directory(), pattern);
-	fd = git_mkstemp_mode(template, mode);
+	strbuf_reset(template);
+	strbuf_addf(template, "%s/%s", get_object_directory(), pattern);
+	fd = git_mkstemp_mode(template->buf, mode);
 	if (0 <= fd)
 		return fd;
 
 	/* slow path */
 	/* some mkstemp implementations erase template on failure */
-	snprintf(template, limit, "%s/%s",
-		 get_object_directory(), pattern);
-	safe_create_leading_directories(template);
-	return xmkstemp_mode(template, mode);
+	strbuf_reset(template);
+	strbuf_addf(template, "%s/%s", get_object_directory(), pattern);
+	safe_create_leading_directories(template->buf);
+	return xmkstemp_mode(template->buf, mode);
 }
 
 int odb_pack_keep(const char *name)
diff --git a/fast-import.c b/fast-import.c
index 41a539f97..900b9626f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -890,14 +890,15 @@ static struct tree_content *dup_tree_content(struct tree_content *s)
 
 static void start_packfile(void)
 {
-	static char tmp_file[PATH_MAX];
+	struct strbuf tmp_file = STRBUF_INIT;
 	struct packed_git *p;
 	struct pack_header hdr;
 	int pack_fd;
 
-	pack_fd = odb_mkstemp(tmp_file, sizeof(tmp_file),
-			      "pack/tmp_pack_XXXXXX");
-	FLEX_ALLOC_STR(p, pack_name, tmp_file);
+	pack_fd = odb_mkstemp(&tmp_file, "pack/tmp_pack_XXXXXX");
+	FLEX_ALLOC_STR(p, pack_name, tmp_file.buf);
+	strbuf_release(&tmp_file);
+
 	p->pack_fd = pack_fd;
 	p->do_not_close = 1;
 	pack_file = sha1fd(pack_fd, p->pack_name);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 44492c346..e313f4f2b 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -508,16 +508,16 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 			  const char *filename,
 			  uint16_t options)
 {
-	static char tmp_file[PATH_MAX];
 	static uint16_t default_version = 1;
 	static uint16_t flags = BITMAP_OPT_FULL_DAG;
+	struct strbuf tmp_file = STRBUF_INIT;
 	struct sha1file *f;
 
 	struct bitmap_disk_header header;
 
-	int fd = odb_mkstemp(tmp_file, sizeof(tmp_file), "pack/tmp_bitmap_XXXXXX");
+	int fd = odb_mkstemp(&tmp_file, "pack/tmp_bitmap_XXXXXX");
 
-	f = sha1fd(fd, tmp_file);
+	f = sha1fd(fd, tmp_file.buf);
 
 	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
 	header.version = htons(default_version);
@@ -537,9 +537,11 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 
 	sha1close(f, NULL, CSUM_FSYNC);
 
-	if (adjust_shared_perm(tmp_file))
+	if (adjust_shared_perm(tmp_file.buf))
 		die_errno("unable to make temporary bitmap file readable");
 
-	if (rename(tmp_file, filename))
+	if (rename(tmp_file.buf, filename))
 		die_errno("unable to rename temporary bitmap file to '%s'", filename);
+
+	strbuf_release(&tmp_file);
 }
diff --git a/pack-write.c b/pack-write.c
index 19cb514ea..0c56ce98d 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -71,9 +71,9 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		f = sha1fd_check(index_name);
 	} else {
 		if (!index_name) {
-			static char tmp_file[PATH_MAX];
-			fd = odb_mkstemp(tmp_file, sizeof(tmp_file), "pack/tmp_idx_XXXXXX");
-			index_name = xstrdup(tmp_file);
+			struct strbuf tmp_file = STRBUF_INIT;
+			fd = odb_mkstemp(&tmp_file, "pack/tmp_idx_XXXXXX");
+			index_name = strbuf_detach(&tmp_file, NULL);
 		} else {
 			unlink(index_name);
 			fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
@@ -326,11 +326,11 @@ int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned
 
 struct sha1file *create_tmp_packfile(char **pack_tmp_name)
 {
-	char tmpname[PATH_MAX];
+	struct strbuf tmpname = STRBUF_INIT;
 	int fd;
 
-	fd = odb_mkstemp(tmpname, sizeof(tmpname), "pack/tmp_pack_XXXXXX");
-	*pack_tmp_name = xstrdup(tmpname);
+	fd = odb_mkstemp(&tmpname, "pack/tmp_pack_XXXXXX");
+	*pack_tmp_name = strbuf_detach(&tmpname, NULL);
 	return sha1fd(fd, *pack_tmp_name);
 }
 
-- 
2.12.2.845.g55fcf8b10

