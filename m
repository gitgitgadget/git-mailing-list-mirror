From: Jeff King <peff@peff.net>
Subject: [PATCH] unpack_entry: do not die when we fail to apply a delta
Date: Thu, 13 Jun 2013 19:26:08 -0400
Message-ID: <20130613232608.GA9844@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 01:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnGuL-0000CB-Hr
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 01:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758911Ab3FMX0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 19:26:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:50493 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758877Ab3FMX0M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 19:26:12 -0400
Received: (qmail 25218 invoked by uid 102); 13 Jun 2013 23:27:05 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Jun 2013 18:27:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jun 2013 19:26:08 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227783>

When we try to load an object from disk and fail, our
general strategy is to see if we can get it from somewhere
else (e.g., a loose object). That lets users fix corruption
problems by copying known-good versions of objects into the
object database.

We already handle the case where we were not able to read
the delta from disk. However, when we find that the delta we
read does not apply, we simply die.  This case is harder to
trigger, as corruption in the delta data itself would
trigger a crc error from zlib.  However, a corruption that
pointed us at the wrong delta base might cause it.

We can do the same "fail and try to find the object
elsewhere" trick instead of dying. This not only gives us a
chance to recover, but also puts us on code paths that will
alert the user to the problem (with the current message,
they do not even know which sha1 caused the problem).

Signed-off-by: Jeff King <peff@peff.net>
---
I needed this earlier today to recover from a corrupted packfile (I
fortunately had an older version of the repo in backups). Still tracking
down the exact nature of the corruption.

 sha1_file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5c08701..d458708 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2135,8 +2135,17 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		data = patch_delta(base, base_size,
 				   delta_data, delta_size,
 				   &size);
+
+		/*
+		 * We could not apply the delta; warn the user, but keep going.
+		 * Our failure will be noticed either in the next iteration of
+		 * the loop, or if this is the final delta, in the caller when
+		 * we return NULL. Those code paths will take care of making
+		 * a more explicit warning and retrying with another copy of
+		 * the object.
+		 */
 		if (!data)
-			die("failed to apply delta");
+			error("failed to apply delta");
 
 		free(delta_data);
 	}
-- 
1.8.3.rc2.14.g7eee6b3
