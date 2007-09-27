From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/1] Make read_patch_file work on a strbuf.
Date: Thu, 27 Sep 2007 13:33:19 +0200
Message-ID: <20070927113347.5C4AE8D5A@madism.org>
References: <20070927112204.GE10289@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 13:34:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iarcz-0008Qh-CZ
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 13:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbXI0Ldu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 07:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbXI0Ldu
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 07:33:50 -0400
Received: from pan.madism.org ([88.191.52.104]:43666 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbXI0Ldt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 07:33:49 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id DA84322052;
	Thu, 27 Sep 2007 13:33:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5C4AE8D5A; Thu, 27 Sep 2007 13:33:47 +0200 (CEST)
In-Reply-To: <20070927112204.GE10289@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59285>

So that we don't need to use strbuf_detach.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-apply.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 833b142..b0c6e60 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -178,7 +178,7 @@ static void say_patch_name(FILE *output, const char *pre, struct patch *patch, c
 #define CHUNKSIZE (8192)
 #define SLOP (16)
 
-static void *read_patch_file(int fd, size_t *sizep)
+static void read_patch_file(struct strbuf *sb, int fd)
 {
 	struct strbuf buf;
 
@@ -193,7 +193,6 @@ static void *read_patch_file(int fd, size_t *sizep)
 	 */
 	strbuf_grow(&buf, SLOP);
 	memset(buf.buf + buf.len, 0, SLOP);
-	return strbuf_detach(&buf, sizep);
 }
 
 static unsigned long linelen(const char *buffer, unsigned long size)
@@ -2648,22 +2647,22 @@ static void prefix_patches(struct patch *p)
 
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
@@ -2681,7 +2680,6 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 			skipped_patch++;
 		}
 		offset += nr;
-		size -= nr;
 	}
 
 	if (whitespace_error && (new_whitespace == error_on_whitespace))
@@ -2716,7 +2714,7 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 	if (summary)
 		summary_patch_list(list);
 
-	free(buffer);
+	strbuf_release(&buf);
 	return 0;
 }
 
-- 
1.5.3.2.1101.g89e60-dirty
