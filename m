From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] fast-import: clean up pack_data pointer in end_packfile
Date: Sat, 23 Aug 2014 01:27:41 -0400
Message-ID: <20140823052741.GC18075@peff.net>
References: <20140823052334.GA17813@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 07:27:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL3rf-0007Ko-Bh
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 07:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbaHWF1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 01:27:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:57245 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752152AbaHWF1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 01:27:43 -0400
Received: (qmail 13602 invoked by uid 102); 23 Aug 2014 05:27:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Aug 2014 00:27:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Aug 2014 01:27:41 -0400
Content-Disposition: inline
In-Reply-To: <20140823052334.GA17813@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255731>

We have a global pointer pack_data pointing to the current
pack we have open. Inside end_packfile we have two new
pointers, old_p and new_p. The latter points to pack_data,
and the former points to the new "installed" version of the
packfile we get when we hand the file off to the regular
sha1_file machinery. When then free old_p.

Presumably the extra old_p pointer was there so that we
could overwrite pack_data with new_p and still free old_p,
but we don't do that. We just leave pack_data pointing to
bogus memory, and don't overwrite it until we call
start_packfile again (if ever).

This can cause problems for our die routine, which calls
end_packfile to clean things up. If we die at the wrong
moment, we can end up looking at invalid memory in
pack_data left after the last end_packfile().

Instead, let's make sure we set pack_data to NULL after we
free it, and make calling endfile() again with a NULL
pack_data a noop (there is nothing to end).

We can further make things less confusing by dropping old_p
entirely, and moving new_p closer to its point of use.

Signed-off-by: Jeff King <peff@peff.net>
---
Noticed while running fast-import under valgrind to debug the next
commit. :)

 fast-import.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d73f58c..f25a4ae 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -946,10 +946,12 @@ static void unkeep_all_packs(void)
 
 static void end_packfile(void)
 {
-	struct packed_git *old_p = pack_data, *new_p;
+	if (!pack_data)
+		return;
 
 	clear_delta_base_cache();
 	if (object_count) {
+		struct packed_git *new_p;
 		unsigned char cur_pack_sha1[20];
 		char *idx_name;
 		int i;
@@ -991,10 +993,11 @@ static void end_packfile(void)
 		pack_id++;
 	}
 	else {
-		close(old_p->pack_fd);
-		unlink_or_warn(old_p->pack_name);
+		close(pack_data->pack_fd);
+		unlink_or_warn(pack_data->pack_name);
 	}
-	free(old_p);
+	free(pack_data);
+	pack_data = NULL;
 
 	/* We can't carry a delta across packfiles. */
 	strbuf_release(&last_blob.data);
-- 
2.1.0.346.ga0367b9
