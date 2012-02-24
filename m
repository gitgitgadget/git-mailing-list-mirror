From: Jeff King <peff@peff.net>
Subject: [PATCHv2 2/3] teach dry-run convert_to_git not to require a src
 buffer
Date: Fri, 24 Feb 2012 17:05:03 -0500
Message-ID: <20120224220503.GB1809@sigill.intra.peff.net>
References: <20120224211913.GA30942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 23:05:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S13GL-0000Ps-Lg
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 23:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700Ab2BXWFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 17:05:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56110
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114Ab2BXWFG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 17:05:06 -0500
Received: (qmail 29885 invoked by uid 107); 24 Feb 2012 22:05:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 17:05:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 17:05:03 -0500
Content-Disposition: inline
In-Reply-To: <20120224211913.GA30942@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191492>

When we call convert_to_git in dry-run mode, it may still
want to look at the source buffer, because some CRLF
conversion modes depend on analyzing the source to determine
whether it is in fact convertible CRLF text.

However, the main motivation for convert_to_git's dry-run
mode is that we would decide which method to use to acquire
the blob's data (streaming versus in-core). Requiring this
source analysis creates a chicken-and-egg problem. We are
better off simply guessing that anything we can't analyze
will end up needing conversion.

This patch lets a caller specify a NULL src buffer when
using dry-run mode (and only dry-run mode). A non-zero
return value goes from "we would convert" to "we might
convert"; a zero return value remains "we would definitely
not convert".

Signed-off-by: Jeff King <peff@peff.net>
---
And this is the second half of v1's patch 1/2.

By splitting this off, I think it makes it much more obvious if we want
to re-visit the pessimism later (e.g., to optimistically assume that
missing src buffers should be assumed to be binary if they are large).

 convert.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 65fa9d5..aa7f72d 100644
--- a/convert.c
+++ b/convert.c
@@ -195,9 +195,17 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 	char *dst;
 
 	if (crlf_action == CRLF_BINARY ||
-	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE) || !len)
+	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE) ||
+	    (src && !len))
 		return 0;
 
+	/*
+	 * If we are doing a dry-run and have no source buffer, there is
+	 * nothing to analyze; we must assume we would convert.
+	 */
+	if (!buf && !src)
+		return 1;
+
 	gather_stats(src, len, &stats);
 
 	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_GUESS) {
@@ -532,7 +540,7 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 {
 	char *dst, *dollar;
 
-	if (!ident || !count_ident(src, len))
+	if (!ident || (src && !count_ident(src, len)))
 		return 0;
 
 	if (!buf)
-- 
1.7.9.11.gca600
