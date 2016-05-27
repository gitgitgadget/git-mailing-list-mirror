From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Require 0 context lines in git-blame algorithm
Date: Fri, 27 May 2016 16:16:32 +0200
Message-ID: <1464358592-5409-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 16:30:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6ImA-0008DB-KK
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 16:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbcE0OaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 10:30:04 -0400
Received: from eggs.gnu.org ([208.118.235.92]:56474 "EHLO eggs.gnu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454AbcE0OaC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 10:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1b6Im0-0006pu-ED
	for git@vger.kernel.org; Fri, 27 May 2016 10:30:01 -0400
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on eggs.gnu.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_40,RP_MATCHES_RCVD
	autolearn=disabled version=3.3.2
Received: from fencepost.gnu.org ([2001:4830:134:3::e]:54618 helo=lola.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1b6Ilx-0006oy-0g; Fri, 27 May 2016 10:29:57 -0400
Received: by lola.localdomain (Postfix, from userid 1000)
	id 1584FE3E5A; Fri, 27 May 2016 16:16:41 +0200 (CEST)
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2001:4830:134:3::e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295758>

Previously, the core part of git blame -M required 1 context line.
There is no rationale to be found in the code (one guess would be that
the old blame algorithm was unable to deal with immediately adjacent
regions), and it causes artifacts like discussed in the thread
<URL:http://thread.gmane.org/gmane.comp.version-control.git/255289/>
---
 builtin/blame.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 21f42b0..a3f6874 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -134,7 +134,7 @@ struct progress_info {
 	int blamed_lines;
 };
 
-static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b, long ctxlen,
+static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
 		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
 {
 	xpparam_t xpp = {0};
@@ -142,7 +142,6 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b, long ctxlen,
 	xdemitcb_t ecb = {NULL};
 
 	xpp.flags = xdl_opts;
-	xecfg.ctxlen = ctxlen;
 	xecfg.hunk_func = hunk_func;
 	ecb.priv = cb_data;
 	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
@@ -980,7 +979,7 @@ static void pass_blame_to_parent(struct scoreboard *sb,
 	fill_origin_blob(&sb->revs->diffopt, target, &file_o);
 	num_get_patch++;
 
-	if (diff_hunks(&file_p, &file_o, 0, blame_chunk_cb, &d))
+	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d))
 		die("unable to generate diff (%s -> %s)",
 		    oid_to_hex(&parent->commit->object.oid),
 		    oid_to_hex(&target->commit->object.oid));
@@ -1129,7 +1128,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	 * file_p partially may match that image.
 	 */
 	memset(split, 0, sizeof(struct blame_entry [3]));
-	if (diff_hunks(file_p, &file_o, 1, handle_split_cb, &d))
+	if (diff_hunks(file_p, &file_o, handle_split_cb, &d))
 		die("unable to generate diff (%s)",
 		    oid_to_hex(&parent->commit->object.oid));
 	/* remainder, if any, all match the preimage */
-- 
2.7.4
