From: Pierre Habouzit <madcoder@debian.org>
Subject: [PROPER PATCH 1/1] Make read_patch_file work on a strbuf.
Date: Thu, 27 Sep 2007 13:33:19 +0200
Message-ID: <20070927114016.08CCB8C4A@madism.org>
References: <20070927112204.GE10289@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 13:40:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IarjE-0002VI-Ui
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 13:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbXI0LkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 07:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbXI0LkS
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 07:40:18 -0400
Received: from pan.madism.org ([88.191.52.104]:43617 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbXI0LkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 07:40:17 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 590642202A;
	Thu, 27 Sep 2007 13:40:16 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 08CCB8C4A; Thu, 27 Sep 2007 13:40:16 +0200 (CEST)
In-Reply-To: <20070927112204.GE10289@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59287>

So that we don't need to use strbuf_detach.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

Sorry, in the hurry I sent a wrong patch before, this one works :)

 builtin-apply.c |   27 +++++++++++----------------
 1 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 833b142..1f0a672 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -178,12 +178,9 @@ static void say_patch_name(FILE *output, const char *pre, struct patch *patch, c
 #define CHUNKSIZE (8192)
 #define SLOP (16)
 
-static void *read_patch_file(int fd, size_t *sizep)
+static void read_patch_file(struct strbuf *sb, int fd)
 {
-	struct strbuf buf;
-
-	strbuf_init(&buf, 0);
-	if (strbuf_read(&buf, fd, 0) < 0)
+	if (strbuf_read(sb, fd, 0) < 0)
 		die("git-apply: read returned %s", strerror(errno));
 
 	/*
@@ -191,9 +188,8 @@ static void *read_patch_file(int fd, size_t *sizep)
 	 * so that we can do speculative "memcmp" etc, and
 	 * see to it that it is NUL-filled.
 	 */
-	strbuf_grow(&buf, SLOP);
-	memset(buf.buf + buf.len, 0, SLOP);
-	return strbuf_detach(&buf, sizep);
+	strbuf_grow(sb, SLOP);
+	memset(sb->buf + sb->len, 0, SLOP);
 }
 
 static unsigned long linelen(const char *buffer, unsigned long size)
@@ -2648,22 +2644,22 @@ static void prefix_patches(struct patch *p)
 
 static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 {
-	unsigned long offset, size;
-	char *buffer = read_patch_file(fd, &size);
+	size_t offset;
+	struct strbuf buf;
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 
+	strbuf_init(&buf, 0);
 	patch_input_file = filename;
-	if (!buffer)
-		return -1;
+	read_patch_file(&buf, fd);
 	offset = 0;
-	while (size > 0) {
+	while (offset < buf.len) {
 		struct patch *patch;
 		int nr;
 
 		patch = xcalloc(1, sizeof(*patch));
 		patch->inaccurate_eof = inaccurate_eof;
-		nr = parse_chunk(buffer + offset, size, patch);
+		nr = parse_chunk(buf.buf + offset, buf.len, patch);
 		if (nr < 0)
 			break;
 		if (apply_in_reverse)
@@ -2681,7 +2677,6 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 			skipped_patch++;
 		}
 		offset += nr;
-		size -= nr;
 	}
 
 	if (whitespace_error && (new_whitespace == error_on_whitespace))
@@ -2716,7 +2711,7 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 	if (summary)
 		summary_patch_list(list);
 
-	free(buffer);
+	strbuf_release(&buf);
 	return 0;
 }
 
-- 
1.5.3.2.1102.gefa87-dirty
