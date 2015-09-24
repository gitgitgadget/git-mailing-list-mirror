From: Jeff King <peff@peff.net>
Subject: [PATCH 22/68] entry.c: convert strcpy to xsnprintf
Date: Thu, 24 Sep 2015 17:06:53 -0400
Message-ID: <20150924210653.GS30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:07:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDjM-0001Ak-Of
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbbIXVG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:06:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:35952 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752655AbbIXVG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:06:56 -0400
Received: (qmail 11929 invoked by uid 102); 24 Sep 2015 21:06:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:06:55 -0500
Received: (qmail 29135 invoked by uid 107); 24 Sep 2015 21:07:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:06:53 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278581>

This particular conversion is non-obvious, because nobody
has passed our function the length of the destination
buffer. However, the interface to checkout_entry specifies
that the buffer must be at least TEMPORARY_FILENAME_LENGTH
bytes long, so we can check that (meaning the existing code
was not buggy, but merely worrisome to somebody reading it).

Signed-off-by: Jeff King <peff@peff.net>
---
 entry.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 1eda8e9..582c400 100644
--- a/entry.c
+++ b/entry.c
@@ -96,8 +96,8 @@ static int open_output_fd(char *path, const struct cache_entry *ce, int to_tempf
 {
 	int symlink = (ce->ce_mode & S_IFMT) != S_IFREG;
 	if (to_tempfile) {
-		strcpy(path, symlink
-		       ? ".merge_link_XXXXXX" : ".merge_file_XXXXXX");
+		xsnprintf(path, TEMPORARY_FILENAME_LENGTH, "%s",
+			  symlink ? ".merge_link_XXXXXX" : ".merge_file_XXXXXX");
 		return mkstemp(path);
 	} else {
 		return create_file(path, !symlink ? ce->ce_mode : 0666);
-- 
2.6.0.rc3.454.g204ad51
