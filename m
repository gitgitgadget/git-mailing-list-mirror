From: Jeff King <peff@peff.net>
Subject: [PATCH 19/21] diff_populate_gitlink: use a strbuf
Date: Fri, 19 Feb 2016 06:25:23 -0500
Message-ID: <20160219112523.GS9319@sigill.intra.peff.net>
References: <20160219111941.GA31906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 12:25:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWjBk-00066G-Kc
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 12:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427694AbcBSLZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 06:25:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:45307 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1427682AbcBSLZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 06:25:26 -0500
Received: (qmail 20715 invoked by uid 102); 19 Feb 2016 11:25:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:25:26 -0500
Received: (qmail 26822 invoked by uid 107); 19 Feb 2016 11:25:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:25:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 06:25:23 -0500
Content-Disposition: inline
In-Reply-To: <20160219111941.GA31906@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286702>

We allocate 100 bytes to hold the "Submodule commit ..."
text. This is enough, but it's not immediately obvious that
this is the case, and we have to repeat the magic 100 twice.

We could get away with xstrfmt here, but we want to know the
size, as well, so let's use a real strbuf. And while we're
here, we can clean up the logic around size_only. It
currently sets and clears the "data" field pointlessly, and
leaves the "should_free" flag on even after we have cleared
the data.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 27d14a7..a70ec6e 100644
--- a/diff.c
+++ b/diff.c
@@ -2704,21 +2704,21 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 
 static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
 {
-	int len;
-	char *data = xmalloc(100), *dirty = "";
+	struct strbuf buf = STRBUF_INIT;
+	char *dirty = "";
 
 	/* Are we looking at the work tree? */
 	if (s->dirty_submodule)
 		dirty = "-dirty";
 
-	len = snprintf(data, 100,
-		       "Subproject commit %s%s\n", sha1_to_hex(s->sha1), dirty);
-	s->data = data;
-	s->size = len;
-	s->should_free = 1;
+	strbuf_addf(&buf, "Subproject commit %s%s\n", sha1_to_hex(s->sha1), dirty);
+	s->size = buf.len;
 	if (size_only) {
 		s->data = NULL;
-		free(data);
+		strbuf_release(&buf);
+	} else {
+		s->data = strbuf_detach(&buf, NULL);
+		s->should_free = 1;
 	}
 	return 0;
 }
-- 
2.7.1.577.gfed91b8
