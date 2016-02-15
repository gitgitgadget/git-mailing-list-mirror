From: Jeff King <peff@peff.net>
Subject: [PATCH 10/18] fast-import: simplify allocation in start_packfile
Date: Mon, 15 Feb 2016 16:54:16 -0500
Message-ID: <20160215215415.GJ10287@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 22:54:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVR66-0002fu-H9
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbcBOVyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:54:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:42498 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752608AbcBOVyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:54:18 -0500
Received: (qmail 2613 invoked by uid 102); 15 Feb 2016 21:54:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:54:18 -0500
Received: (qmail 12521 invoked by uid 107); 15 Feb 2016 21:54:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:54:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:54:16 -0500
Content-Disposition: inline
In-Reply-To: <20160215214516.GA4015@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286265>

This function allocates a packed_git flex-array, and adds a
mysterious 2 bytes to the length of the pack_name field. One
is for the trailing NUL, but the other has no purpose. This
is probably cargo-culted from add_packed_git, which gets the
".idx" path and needs to allocate enough space to hold the
matching ".pack" (though since 48bcc1c, we calculate the
size there differently).

This site, however, is using the raw path of a tempfile, and
does not need the extra byte. We can just replace the
allocation with FLEX_ALLOC_STR, which handles the allocation
and the NUL for us.

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3053bb8..9fc7093 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -865,15 +865,12 @@ static void start_packfile(void)
 {
 	static char tmp_file[PATH_MAX];
 	struct packed_git *p;
-	int namelen;
 	struct pack_header hdr;
 	int pack_fd;
 
 	pack_fd = odb_mkstemp(tmp_file, sizeof(tmp_file),
 			      "pack/tmp_pack_XXXXXX");
-	namelen = strlen(tmp_file) + 2;
-	p = xcalloc(1, sizeof(*p) + namelen);
-	xsnprintf(p->pack_name, namelen, "%s", tmp_file);
+	FLEX_ALLOC_STR(p, pack_name, tmp_file);
 	p->pack_fd = pack_fd;
 	p->do_not_close = 1;
 	pack_file = sha1fd(pack_fd, p->pack_name);
-- 
2.7.1.572.gf718037
