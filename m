From: Jeff King <peff@peff.net>
Subject: [PATCH v2 10/25] prune-packed: use for_each_loose_file_in_objdir
Date: Wed, 15 Oct 2014 18:40:53 -0400
Message-ID: <20141015224053.GJ25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:41:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXFc-0007oh-23
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbaJOWk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:40:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:58963 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750721AbaJOWk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:40:56 -0400
Received: (qmail 2406 invoked by uid 102); 15 Oct 2014 22:40:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:40:56 -0500
Received: (qmail 28044 invoked by uid 107); 15 Oct 2014 22:40:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:40:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:40:53 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This saves us from manually traversing the directory
structure ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/prune-packed.c | 69 +++++++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 46 deletions(-)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index d430731..f24a2c2 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -10,65 +10,42 @@ static const char * const prune_packed_usage[] = {
 
 static struct progress *progress;
 
-static void prune_dir(int i, DIR *dir, struct strbuf *pathname, int opts)
+static int prune_subdir(int nr, const char *path, void *data)
 {
-	struct dirent *de;
-	char hex[40];
-	int top_len = pathname->len;
+	int *opts = data;
+	display_progress(progress, nr + 1);
+	if (!(*opts & PRUNE_PACKED_DRY_RUN))
+		rmdir(path);
+	return 0;
+}
+
+static int prune_object(const unsigned char *sha1, const char *path,
+			 void *data)
+{
+	int *opts = data;
 
-	sprintf(hex, "%02x", i);
-	while ((de = readdir(dir)) != NULL) {
-		unsigned char sha1[20];
-		if (strlen(de->d_name) != 38)
-			continue;
-		memcpy(hex + 2, de->d_name, 38);
-		if (get_sha1_hex(hex, sha1))
-			continue;
-		if (!has_sha1_pack(sha1))
-			continue;
+	if (!has_sha1_pack(sha1))
+		return 0;
 
-		strbuf_add(pathname, de->d_name, 38);
-		if (opts & PRUNE_PACKED_DRY_RUN)
-			printf("rm -f %s\n", pathname->buf);
-		else
-			unlink_or_warn(pathname->buf);
-		display_progress(progress, i + 1);
-		strbuf_setlen(pathname, top_len);
-	}
+	if (*opts & PRUNE_PACKED_DRY_RUN)
+		printf("rm -f %s\n", path);
+	else
+		unlink_or_warn(path);
+	return 0;
 }
 
 void prune_packed_objects(int opts)
 {
-	int i;
-	const char *dir = get_object_directory();
-	struct strbuf pathname = STRBUF_INIT;
-	int top_len;
-
-	strbuf_addstr(&pathname, dir);
 	if (opts & PRUNE_PACKED_VERBOSE)
 		progress = start_progress_delay(_("Removing duplicate objects"),
 			256, 95, 2);
 
-	if (pathname.len && pathname.buf[pathname.len - 1] != '/')
-		strbuf_addch(&pathname, '/');
-
-	top_len = pathname.len;
-	for (i = 0; i < 256; i++) {
-		DIR *d;
+	for_each_loose_file_in_objdir(get_object_directory(),
+				      prune_object, NULL, prune_subdir, &opts);
 
-		display_progress(progress, i + 1);
-		strbuf_setlen(&pathname, top_len);
-		strbuf_addf(&pathname, "%02x/", i);
-		d = opendir(pathname.buf);
-		if (!d)
-			continue;
-		prune_dir(i, d, &pathname, opts);
-		closedir(d);
-		strbuf_setlen(&pathname, top_len + 2);
-		rmdir(pathname.buf);
-	}
+	/* Ensure we show 100% before finishing progress */
+	display_progress(progress, 256);
 	stop_progress(&progress);
-	strbuf_release(&pathname);
 }
 
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
-- 
2.1.2.596.g7379948
