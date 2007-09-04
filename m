From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Simplify strbuf uses in fast-import.c using the proper functions.
Date: Tue,  4 Sep 2007 16:01:13 +0200
Message-ID: <11889144743483-git-send-email-madcoder@debian.org>
References: <20070904115317.GA3381@artemis.corp>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 16:01:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISYy1-0005lj-Uw
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbXIDOBU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbXIDOBT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:01:19 -0400
Received: from pan.madism.org ([88.191.52.104]:40918 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603AbXIDOBT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:01:19 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 141721DE34;
	Tue,  4 Sep 2007 16:01:15 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4CF9F2D42C1; Tue,  4 Sep 2007 16:01:14 +0200 (CEST)
X-Mailer: git-send-email 1.5.3
In-Reply-To: <20070904115317.GA3381@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57571>

  This is just cleaner way to deal with strbufs, using its API rather than
reinventing it in the module (e.g. strbuf_append_string is just the plain
strbuf_addstr function, and it was used to perform what strbuf_addch does
anyways).
---
 archive-tar.c |   65 ++++++++++++++-------------------------------------------
 1 files changed, 16 insertions(+), 49 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index a0763c5..c84d7c0 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -78,19 +78,6 @@ static void write_trailer(void)
 	}
 }
 
-static void strbuf_append_string(struct strbuf *sb, const char *s)
-{
-	int slen = strlen(s);
-	int total = sb->len + slen;
-	if (total + 1 > sb->alloc) {
-		sb->buf = xrealloc(sb->buf, total + 1);
-		sb->alloc = total + 1;
-	}
-	memcpy(sb->buf + sb->len, s, slen);
-	sb->len = total;
-	sb->buf[total] = '\0';
-}
-
 /*
  * pax extended header records have the format "%u %s=%s\n".  %u contains
  * the size of the whole string (including the %u), the first %s is the
@@ -100,26 +87,17 @@ static void strbuf_append_string(struct strbuf *sb, const char *s)
 static void strbuf_append_ext_header(struct strbuf *sb, const char *keyword,
                                      const char *value, unsigned int valuelen)
 {
-	char *p;
-	int len, total, tmp;
+	int len, tmp;
 
 	/* "%u %s=%s\n" */
 	len = 1 + 1 + strlen(keyword) + 1 + valuelen + 1;
 	for (tmp = len; tmp > 9; tmp /= 10)
 		len++;
 
-	total = sb->len + len;
-	if (total > sb->alloc) {
-		sb->buf = xrealloc(sb->buf, total);
-		sb->alloc = total;
-	}
-
-	p = sb->buf;
-	p += sprintf(p, "%u %s=", len, keyword);
-	memcpy(p, value, valuelen);
-	p += valuelen;
-	*p = '\n';
-	sb->len = total;
+	strbuf_grow(sb, len);
+	strbuf_addf(sb, "%u %s=", len, keyword);
+	strbuf_add(sb, value, valuelen);
+	strbuf_addch(sb, '\n');
 }
 
 static unsigned int ustar_header_chksum(const struct ustar_header *header)
@@ -153,8 +131,7 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 	struct strbuf ext_header;
 
 	memset(&header, 0, sizeof(header));
-	ext_header.buf = NULL;
-	ext_header.len = ext_header.alloc = 0;
+	strbuf_init(&ext_header);
 
 	if (!sha1) {
 		*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
@@ -225,8 +202,8 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 
 	if (ext_header.len > 0) {
 		write_entry(sha1, NULL, 0, ext_header.buf, ext_header.len);
-		free(ext_header.buf);
 	}
+	strbuf_release(&ext_header);
 	write_blocked(&header, sizeof(header));
 	if (S_ISREG(mode) && buffer && size > 0)
 		write_blocked(buffer, size);
@@ -235,11 +212,11 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 static void write_global_extended_header(const unsigned char *sha1)
 {
 	struct strbuf ext_header;
-	ext_header.buf = NULL;
-	ext_header.len = ext_header.alloc = 0;
+
+	strbuf_init(&ext_header);
 	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 40);
 	write_entry(NULL, NULL, 0, ext_header.buf, ext_header.len);
-	free(ext_header.buf);
+	strbuf_release(&ext_header);
 }
 
 static int git_tar_config(const char *var, const char *value)
@@ -260,28 +237,18 @@ static int write_tar_entry(const unsigned char *sha1,
                            const char *base, int baselen,
                            const char *filename, unsigned mode, int stage)
 {
-	static struct strbuf path;
+	static struct strbuf path = STRBUF_INIT;
 	int filenamelen = strlen(filename);
 	void *buffer;
 	enum object_type type;
 	unsigned long size;
 
-	if (!path.alloc) {
-		path.buf = xmalloc(PATH_MAX);
-		path.alloc = PATH_MAX;
-		path.len = path.eof = 0;
-	}
-	if (path.alloc < baselen + filenamelen + 1) {
-		free(path.buf);
-		path.buf = xmalloc(baselen + filenamelen + 1);
-		path.alloc = baselen + filenamelen + 1;
-	}
-	memcpy(path.buf, base, baselen);
-	memcpy(path.buf + baselen, filename, filenamelen);
-	path.len = baselen + filenamelen;
-	path.buf[path.len] = '\0';
+	strbuf_grow(&path, MAX(PATH_MAX, baselen + filenamelen + 1));
+	strbuf_reset(&path);
+	strbuf_add(&path, base, baselen);
+	strbuf_add(&path, filename, filenamelen);
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-		strbuf_append_string(&path, "/");
+		strbuf_addch(&path, '/');
 		buffer = NULL;
 		size = 0;
 	} else {
-- 
1.5.3
