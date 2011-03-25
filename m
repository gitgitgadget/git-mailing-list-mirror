From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] merge: handle renames with replacement content
Date: Fri, 25 Mar 2011 12:06:47 -0400
Message-ID: <20110325160647.GB26635@sigill.intra.peff.net>
References: <20110325160013.GA25851@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:06:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q39XM-0004ey-Dx
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 17:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab1CYQGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 12:06:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41061
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753973Ab1CYQGu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 12:06:50 -0400
Received: (qmail 14876 invoked by uid 107); 25 Mar 2011 16:07:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 12:07:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 12:06:47 -0400
Content-Disposition: inline
In-Reply-To: <20110325160013.GA25851@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169994>

We generally think of a rename as removing one path entirely
and placing similar content at a new path. In other words,
after a rename, the original path is now empty. But that is
not necessarily the case with rewrite detection (which is
not currently possible to do for merge-recursive).

The current merge code blindly removes paths that are used
as rename sources; however, we should check to see if there
is useful content at that path.  There are basically two
interesting cases:

  1. One side renames a path, but also puts new content
     (or a symlink) at the same path. We want to detect the
     rename, and have changes from the other side applied to
     the rename destination. The new content at the original
     path should be left untouched.

     The current code just calls remove_file, but that
     ignores the concept that the renaming side may put
     something else useful there. We should detect this case
     and either remove (if no new content), or put the new
     content in place at the original path.

  2. Both sides renamed and installed new content at the
     original path. If they didn't rename to the same
     destination, it is a conflict, and we already mark it
     as such. But if it's the same destination, then it's
     not a conflict; the renamed content will be merged at
     the new destination.

     For the new content at the original path, we have to do
     a 3-way merge. The base must be the null sha1, because
     this "slot" for content didn't exist before (it was
     taken up by the content which got renamed away). So if
     only one side installed new content, that content
     automatically wins. If both sides did, and it is the
     same content, then that content is OK. But if the
     content is different, then we have a conflict and
     should do the usual conflict-markers thing.

This patch implements the semantics described above, which
lays the groundwork for turning on rewrite detection.

Signed-off-by: Jeff King <peff@peff.net>
---
I split this one out for easier review. The semantics I am
proposing are a superset of the current "remove" behavior (it's just
that without break detection on, you can't trigger the other cases). But
by putting this in before enabling break detection, you can test easily
that the new code isn't breaking any existing behavior.

 merge-recursive.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8e82a8b..16263b0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -706,6 +706,64 @@ static void update_file(struct merge_options *o,
 	update_file_flags(o, sha, mode, path, o->call_depth || clean, !o->call_depth);
 }
 
+static int update_or_remove(struct merge_options *o,
+			    const unsigned char *sha1, unsigned mode,
+			    const char *path, int update_wd)
+{
+	if (is_null_sha1(sha1))
+		return remove_file(o, 1, path, !update_wd);
+
+	update_file_flags(o, sha1, mode, path, 1, update_wd);
+	return 0;
+}
+
+static void merge_rename_source(struct merge_options *o,
+				       const char *path,
+				       struct stage_data *d)
+{
+	if (is_null_sha1(d->stages[2].sha)) {
+		/*
+		 * If both were real renames (not from a broken pair), we can
+		 * stop caring about the path. We don't touch the working
+		 * directory, though. The path must be gone in HEAD, so there
+		 * is no point (and anything we did delete would be an
+		 * untracked file).
+		 */
+		if (is_null_sha1(d->stages[3].sha)) {
+			remove_file(o, 1, path, 1);
+			return;
+		}
+
+		/*
+		 * If "ours" was a real rename, but the other side came
+		 * from a broken pair, then their version is the right
+		 * resolution (because we have no content, ours having been
+		 * renamed away, and they have new content).
+		 */
+		update_file_flags(o, d->stages[3].sha, d->stages[3].mode,
+				  path, 1, 1);
+		return;
+	}
+
+	/*
+	 * Now we have the opposite. "theirs" is a real rename, but ours
+	 * is from a broken pair. We resolve in favor of us, but we don't
+	 * need to touch the working directory.
+	 */
+	if (is_null_sha1(d->stages[3].sha)) {
+		update_file_flags(o, d->stages[2].sha, d->stages[2].mode,
+				  path, 1, 0);
+		return;
+	}
+
+	/*
+	 * Otherwise, both came from broken pairs. We need to do an actual
+	 * merge on the entries. We can just mark it as unprocessed and
+	 * the regular code will handle it.
+	 */
+	d->processed = 0;
+}
+
 /* Low level file merging, update and removal */
 
 struct merge_file_info {
@@ -1025,7 +1083,7 @@ static int process_renames(struct merge_options *o,
 							      ren1->dst_entry,
 							      ren2->dst_entry);
 			} else {
-				remove_file(o, 1, ren1_src, 1);
+				merge_rename_source(o, ren1_src, ren1->src_entry);
 				update_stages_and_entry(ren1_dst,
 							ren1->dst_entry,
 							ren1->pair->one,
@@ -1049,7 +1107,10 @@ static int process_renames(struct merge_options *o,
 			int renamed_stage = a_renames == renames1 ? 2 : 3;
 			int other_stage =   a_renames == renames1 ? 3 : 2;
 
-			remove_file(o, 1, ren1_src, o->call_depth || renamed_stage == 2);
+			update_or_remove(o,
+				ren1->src_entry->stages[renamed_stage].sha,
+				ren1->src_entry->stages[renamed_stage].mode,
+				ren1_src, renamed_stage == 3);
 
 			hashcpy(src_other.sha1, ren1->src_entry->stages[other_stage].sha);
 			src_other.mode = ren1->src_entry->stages[other_stage].mode;
-- 
1.7.4.41.g423da.dirty
