From: Jeff King <peff@peff.net>
Subject: [PATCH 2/1 alt] peel_onion: do not assume length of x_type globals
Date: Tue, 3 Sep 2013 16:27:30 -0400
Message-ID: <20130903202729.GA26217@sigill.intra.peff.net>
References: <20130903202041.GA7463@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 22:27:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGxCL-0002H8-HV
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 22:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760798Ab3ICU1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 16:27:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:58144 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759990Ab3ICU1d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 16:27:33 -0400
Received: (qmail 26899 invoked by uid 102); 3 Sep 2013 20:27:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 15:27:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 16:27:30 -0400
Content-Disposition: inline
In-Reply-To: <20130903202041.GA7463@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233777>

When we are parsing "rev^{foo}", we check "foo" against the
various global type strings, like "commit_type",
"tree_type", etc. This is nicely abstracted, but then we
destroy the abstraction completely by using magic numbers
that must match the length of the type strings.

We could avoid these magic numbers by using skip_prefix. But
taking a step back, we can realize that using the
"commit_type" global is not really buying us anything. It is
not ever going to change from being "commit" without causing
severe breakage to existing uses. And even if it did change
for some crazy reason, we would want to evaluate its effects
on the "rev^{}" syntax, anyway.

Let's just switch these to using a custom string literal, as
we do for "rev^{object}". The resulting code is more robust
to changes in the type strings, and is more readable.

Signed-off-by: Jeff King <peff@peff.net>
---
If you _really_ wanted to abstract it, you could make commit_type a
macro and use string concatenation along with prefixcmp. But that is
going in the direction of less readable, I think. :)

This has probably consumed enough brain cycles for such a small and
probably unimportant cleanup. I'll let Junio pick from the 2 options (or
choose to do nothing at all) as he sees fit.

 sha1_name.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 6dc496d..2f6e5ab 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -677,13 +677,13 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 		return -1;
 
 	sp++; /* beginning of type name, or closing brace for empty */
-	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
+	if (!prefixcmp(sp, "commit}"))
 		expected_type = OBJ_COMMIT;
-	else if (!strncmp(tag_type, sp, 3) && sp[3] == '}')
+	else if (!prefixcmp(sp, "tag}"))
 		expected_type = OBJ_TAG;
-	else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
+	else if (!prefixcmp(sp, "tree}"))
 		expected_type = OBJ_TREE;
-	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
+	else if (!prefixcmp(sp, "blob}"))
 		expected_type = OBJ_BLOB;
 	else if (!prefixcmp(sp, "object}"))
 		expected_type = OBJ_ANY;
-- 
1.8.4.2.g87d4a77
