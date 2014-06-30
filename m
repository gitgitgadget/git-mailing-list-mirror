From: Jeff King <peff@peff.net>
Subject: [PATCH 6/9] index-pack: use strip_suffix to avoid magic numbers
Date: Mon, 30 Jun 2014 12:59:10 -0400
Message-ID: <20140630165910.GF16637@sigill.intra.peff.net>
References: <20140630165526.GA15690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:59:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1evG-0001fk-7B
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 18:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741AbaF3Q7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 12:59:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:53665 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754658AbaF3Q7M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 12:59:12 -0400
Received: (qmail 7793 invoked by uid 102); 30 Jun 2014 16:59:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 11:59:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 12:59:10 -0400
Content-Disposition: inline
In-Reply-To: <20140630165526.GA15690@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252688>

We also switch to using strbufs, which lets us avoid the
potentially dangerous combination of a manual malloc
followed by a strcpy.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 46376b6..d4b77fd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1505,7 +1505,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	const char *curr_index;
 	const char *index_name = NULL, *pack_name = NULL;
 	const char *keep_name = NULL, *keep_msg = NULL;
-	char *index_name_buf = NULL, *keep_name_buf = NULL;
+	struct strbuf index_name_buf = STRBUF_INIT,
+		      keep_name_buf = STRBUF_INIT;
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
 	unsigned char pack_sha1[20];
@@ -1602,24 +1603,22 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (fix_thin_pack && !from_stdin)
 		die(_("--fix-thin cannot be used without --stdin"));
 	if (!index_name && pack_name) {
-		int len = strlen(pack_name);
-		if (!ends_with(pack_name, ".pack"))
+		size_t len;
+		if (!strip_suffix(pack_name, ".pack", &len))
 			die(_("packfile name '%s' does not end with '.pack'"),
 			    pack_name);
-		index_name_buf = xmalloc(len);
-		memcpy(index_name_buf, pack_name, len - 5);
-		strcpy(index_name_buf + len - 5, ".idx");
-		index_name = index_name_buf;
+		strbuf_add(&index_name_buf, pack_name, len);
+		strbuf_addstr(&index_name_buf, ".idx");
+		index_name = index_name_buf.buf;
 	}
 	if (keep_msg && !keep_name && pack_name) {
-		int len = strlen(pack_name);
-		if (!ends_with(pack_name, ".pack"))
+		size_t len;
+		if (!strip_suffix(pack_name, ".pack", &len))
 			die(_("packfile name '%s' does not end with '.pack'"),
 			    pack_name);
-		keep_name_buf = xmalloc(len);
-		memcpy(keep_name_buf, pack_name, len - 5);
-		strcpy(keep_name_buf + len - 5, ".keep");
-		keep_name = keep_name_buf;
+		strbuf_add(&keep_name_buf, pack_name, len);
+		strbuf_addstr(&keep_name_buf, ".idx");
+		keep_name = keep_name_buf.buf;
 	}
 	if (verify) {
 		if (!index_name)
@@ -1667,8 +1666,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	else
 		close(input_fd);
 	free(objects);
-	free(index_name_buf);
-	free(keep_name_buf);
+	strbuf_release(&index_name_buf);
+	strbuf_release(&keep_name_buf);
 	if (pack_name == NULL)
 		free((void *) curr_pack);
 	if (index_name == NULL)
-- 
2.0.0.566.gfe3e6b2
