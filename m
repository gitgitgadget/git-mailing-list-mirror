From: Jeff King <peff@peff.net>
Subject: [PATCH] fast-import: avoid running end_packfile recursively
Date: Mon, 9 Feb 2015 20:07:19 -0500
Message-ID: <20150210010719.GA31823@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 02:07:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKzIU-0007tn-Rb
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 02:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933063AbbBJBHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 20:07:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:47090 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756110AbbBJBHW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 20:07:22 -0500
Received: (qmail 15255 invoked by uid 102); 10 Feb 2015 01:07:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Feb 2015 19:07:21 -0600
Received: (qmail 3129 invoked by uid 107); 10 Feb 2015 01:07:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Feb 2015 20:07:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Feb 2015 20:07:19 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263622>

When an import has finished, we run end_packfile() to
finalize the data and move the packfile into place. If this
process fails, we call die() and end up in our die_nicely()
handler.  Which unfortunately includes running end_packfile
to save any progress we made. We enter the function again,
and start operating on the pack_data struct while it is in
an inconsistent state, leading to a segfault.

One way to trigger this is to simply start two identical
fast-imports at the same time. They will both create the
same packfiles, which will then try to create identically
named ".keep" files. One will win the race, and the other
will die(), and end up with the segfault.

Since 3c078b9, we already reset the pack_data pointer to
NULL at the end of end_packfile. That covers the case of us
calling die() right after end_packfile, before we have
reinitialized the pack_data pointer. This new problem is
quite similar, except that we are worried about calling
die() _during_ end_packfile, not right after. Ideally we
would simply set pack_data to NULL as soon as we enter the
function, and operate on a copy of the pointer.

Unfortunately, it is not so easy. pack_data is a global, and
end_packfile calls into other functions which operate on the
global directly. We would have to teach each of these to
take an argument, and there is no guarantee that we would
catch all of the spots.

Instead, we can simply use a static flag to avoid
recursively entering the function. This is a little less
elegant, but it's short and fool-proof.

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index d0bd285..aac2c24 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -947,9 +947,12 @@ static void unkeep_all_packs(void)
 
 static void end_packfile(void)
 {
-	if (!pack_data)
+	static int running;
+
+	if (running || !pack_data)
 		return;
 
+	running = 1;
 	clear_delta_base_cache();
 	if (object_count) {
 		struct packed_git *new_p;
@@ -999,6 +1002,7 @@ static void end_packfile(void)
 	}
 	free(pack_data);
 	pack_data = NULL;
+	running = 0;
 
 	/* We can't carry a delta across packfiles. */
 	strbuf_release(&last_blob.data);
-- 
2.3.0.rc1.287.g761fd19
