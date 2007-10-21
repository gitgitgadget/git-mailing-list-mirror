From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Correct some sizeof(size_t) != sizeof(unsigned long) typing errors
Date: Sun, 21 Oct 2007 01:25:37 -0400
Message-ID: <20071021052537.GB31927@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 07:26:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjTK3-0001p1-Ja
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 07:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbXJUFZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 01:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbXJUFZl
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 01:25:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33251 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbXJUFZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 01:25:40 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjTJi-0007C1-Ef
	for git@vger.kernel.org; Sun, 21 Oct 2007 01:25:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1753E20FBAE; Sun, 21 Oct 2007 01:25:37 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61878>

On at least one system I've used recently sizeof(size_t) == 4
and sizeof(unsigned long) == 8.  Trying to pass a pointer to an 8
byte value into strbuf_detach() causes problems as the function is
expecting an address for a 4 byte result location.  Writing only 4
bytes here will leave the other 4 bytes unitialized and may cause
problems when the caller evalutes the result.

I am introducing strbuf_detach_ul() as a variant that takes its
size as an unsigned long rather than as a size_t.  This approach is
shorter than fixing all of the callers to use their own temporary
size_t value for the call.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-apply.c   |    2 +-
 builtin-archive.c |    2 +-
 diff.c            |    4 ++--
 entry.c           |    2 +-
 strbuf.h          |    8 +++++++-
 test-delta.c      |    3 ++-
 6 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 05c6bc3..022f916 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1955,7 +1955,7 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 
 	if (apply_fragments(&buf, patch) < 0)
 		return -1; /* note with --reject this succeeds. */
-	patch->result = strbuf_detach(&buf, &patch->resultsize);
+	patch->result = strbuf_detach_ul(&buf, &patch->resultsize);
 
 	if (0 < patch->is_delete && patch->resultsize)
 		return error("removal patch leaves file contents");
diff --git a/builtin-archive.c b/builtin-archive.c
index 04385de..46d5de0 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -153,7 +153,7 @@ void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
 		convert_to_working_tree(path, buf.buf, buf.len, &buf);
 		convert_to_archive(path, buf.buf, buf.len, &buf, commit);
-		buffer = strbuf_detach(&buf, sizep);
+		buffer = strbuf_detach_ul(&buf, sizep);
 	}
 
 	return buffer;
diff --git a/diff.c b/diff.c
index 6648e01..6fd0c0a 100644
--- a/diff.c
+++ b/diff.c
@@ -1519,7 +1519,7 @@ static int populate_from_stdin(struct diff_filespec *s)
 				     strerror(errno));
 
 	s->should_munmap = 0;
-	s->data = strbuf_detach(&buf, &s->size);
+	s->data = strbuf_detach_ul(&buf, &s->size);
 	s->should_free = 1;
 	return 0;
 }
@@ -1611,7 +1611,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		if (convert_to_git(s->path, s->data, s->size, &buf)) {
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
-			s->data = strbuf_detach(&buf, &s->size);
+			s->data = strbuf_detach_ul(&buf, &s->size);
 			s->should_free = 1;
 		}
 	}
diff --git a/entry.c b/entry.c
index 98f5f6d..d36a0bb 100644
--- a/entry.c
+++ b/entry.c
@@ -120,7 +120,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		strbuf_init(&buf, 0);
 		if (convert_to_working_tree(ce->name, new, size, &buf)) {
 			free(new);
-			new = strbuf_detach(&buf, &size);
+			new = strbuf_detach_ul(&buf, &size);
 		}
 
 		if (to_tempfile) {
diff --git a/strbuf.h b/strbuf.h
index 9b9e861..d6d6bd0 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -52,7 +52,13 @@ struct strbuf {
 /*----- strbuf life cycle -----*/
 extern void strbuf_init(struct strbuf *, size_t);
 extern void strbuf_release(struct strbuf *);
-extern char *strbuf_detach(struct strbuf *, size_t *);
+extern char *strbuf_detach(struct strbuf *, unsigned long *);
+static inline char *strbuf_detach_ul(struct strbuf *a, unsigned long *n) {
+	size_t len;
+	char *res = strbuf_detach(a, &len);
+	*n = len;
+	return res;
+}
 extern void strbuf_attach(struct strbuf *, void *, size_t, size_t);
 static inline void strbuf_swap(struct strbuf *a, struct strbuf *b) {
 	struct strbuf tmp = *a;
diff --git a/test-delta.c b/test-delta.c
index 3d885ff..018e7dc 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -20,7 +20,8 @@ int main(int argc, char *argv[])
 	int fd;
 	struct stat st;
 	void *from_buf, *data_buf, *out_buf;
-	unsigned long from_size, data_size, out_size;
+	unsigned long from_size, data_size;
+	size_t out_size;
 
 	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
 		fprintf(stderr, "Usage: %s\n", usage_str);
-- 
1.5.3.4.1270.g2fe543
