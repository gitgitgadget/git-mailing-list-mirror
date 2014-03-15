From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] pack-objects: show reused packfile objects in "Counting
 objects"
Date: Fri, 14 Mar 2014 22:26:58 -0400
Message-ID: <20140315022658.GB987@sigill.intra.peff.net>
References: <20140315022550.GA875@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 03:27:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOeJV-000655-MW
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 03:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbaCOC1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 22:27:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:39843 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754352AbaCOC1A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 22:27:00 -0400
Received: (qmail 4061 invoked by uid 102); 15 Mar 2014 02:27:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Mar 2014 21:27:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 22:26:58 -0400
Content-Disposition: inline
In-Reply-To: <20140315022550.GA875@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244136>

When we are sending a pack for push or fetch, we may reuse a
chunk of packfile without even parsing it. The progress
meter then looks like this:

  Reusing existing pack: 3440489, done.
  Counting objects: 3, done.

The first line shows that we are reusing a large chunk of
objects, and then we further count any objects not included
in the reused portion with an actual traversal.

These are all implementation details that the user does not
need to care about. Instead, we can show the reused objects
in the normal "counting..." progress meter (which will
simply go much faster than normal), and then continue to add
to it as we traverse.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 12aa94c..4ca3946 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1038,7 +1038,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 			    exclude, name && no_try_delta(name),
 			    index_pos, found_pack, found_offset);
 
-	display_progress(progress_state, to_pack.nr_objects);
+	display_progress(progress_state, nr_result);
 	return 1;
 }
 
@@ -1054,7 +1054,7 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 
 	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
 
-	display_progress(progress_state, to_pack.nr_objects);
+	display_progress(progress_state, nr_result);
 	return 1;
 }
 
@@ -2456,12 +2456,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 			&reuse_packfile_offset)) {
 		assert(reuse_packfile_objects);
 		nr_result += reuse_packfile_objects;
-
-		if (progress) {
-			fprintf(stderr, "Reusing existing pack: %d, done.\n",
-				reuse_packfile_objects);
-			fflush(stderr);
-		}
+		display_progress(progress_state, nr_result);
 	}
 
 	traverse_bitmap_commit_list(&add_object_entry_from_bitmap);
-- 
1.9.0.417.gc6bea4f
