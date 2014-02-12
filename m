From: Jeff King <peff@peff.net>
Subject: [PATCH] tree-walk: be more specific about corrupt tree errors
Date: Wed, 12 Feb 2014 14:49:57 -0500
Message-ID: <20140212194956.GA3850@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 12 20:50:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDfoq-00081i-8N
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 20:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbaBLTt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 14:49:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:49358 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752013AbaBLTt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 14:49:59 -0500
Received: (qmail 637 invoked by uid 102); 12 Feb 2014 19:49:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Feb 2014 13:49:59 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Feb 2014 14:49:57 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242019>

When the tree-walker runs into an error, it just calls
die(), and the message is always "corrupt tree file".
However, we are actually covering several cases here; let's
give the user a hint about what happened.

Let's also avoid using the word "corrupt", which makes it
seem like the data bit-rotted on disk. Our sha1 check would
already have found that. These errors are ones of data that
is malformed in the first place.

Signed-off-by: Jeff King <peff@peff.net>
---
Michael and I have been looking off-list at some bogus trees (created by
a non-git.git implementation). git-fsck unhelpfully dies during the
tree-walk:

  $ git fsck
  Checking object directories: 100% (256/256), done.
  fatal: corrupt tree file

I think in the long run we want to either teach fsck to avoid the
regular tree-walker or to set a special "continue as much as you can"
flag. That will let us keep going to find more errors, do our usual fsck
error checks (which are more strict), and especially report on _which_
object was broken (we can't do that here because we are deep in the call
stack and may not even have a real object yet).

This patch at least gives us slightly more specific error messages (both
for fsck and for other commands). And it may provide a first step in
clarity if we follow the "continue as much as you can" path.

 tree-walk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 79dba1d..d53b084 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -28,11 +28,13 @@ static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned
 	unsigned int mode, len;
 
 	if (size < 24 || buf[size - 21])
-		die("corrupt tree file");
+		die("truncated tree file");
 
 	path = get_mode(buf, &mode);
-	if (!path || !*path)
-		die("corrupt tree file");
+	if (!path)
+		die("malformed mode in tree entry");
+	if (!*path)
+		die("empty filename in tree entry");
 	len = strlen(path) + 1;
 
 	/* Initialize the descriptor entry */
@@ -81,7 +83,7 @@ void update_tree_entry(struct tree_desc *desc)
 	unsigned long len = end - (const unsigned char *)buf;
 
 	if (size < len)
-		die("corrupt tree file");
+		die("truncated tree file");
 	buf = end;
 	size -= len;
 	desc->buffer = buf;
-- 
1.8.5.2.500.g8060133
