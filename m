From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] builtin-rm.c: explain and clarify the "local change"
 logic
Date: Fri, 28 Nov 2008 19:51:58 -0800
Message-ID: <7vvdu72nq9.fsf@gitster.siamese.dyndns.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
 <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
 <20081128192033.GF23984@spearce.org>
 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
 <7vk5an4cba.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 29 04:58:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Gy6-0007Nw-H2
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 04:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbYK2DwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 22:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbYK2DwR
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 22:52:17 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbYK2DwR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 22:52:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A97D827A5;
	Fri, 28 Nov 2008 22:52:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3677C827A0; Fri,
 28 Nov 2008 22:52:00 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1C8F3F0E-BDC9-11DD-B43E-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101897>

Explain the logic to check local modification a bit more in the comment,
especially because the existing comment that talks about "git rm --cached"
was placed in a part that was not about "--cached" at all.

Also clarify "if .. else if .." structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is the first patch of a re-rolled sesries of the previous one, and
   again applies to the master plus the first commit from nd/narrow.

 builtin-rm.c |   53 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index b7126e3..3d03da0 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -31,7 +31,8 @@ static void add_list(const char *name)
 
 static int check_local_mod(unsigned char *head, int index_only)
 {
-	/* items in list are already sorted in the cache order,
+	/*
+	 * Items in list are already sorted in the cache order,
 	 * so we could do this a lot more efficiently by using
 	 * tree_desc based traversal if we wanted to, but I am
 	 * lazy, and who cares if removal of files is a tad
@@ -71,25 +72,55 @@ static int check_local_mod(unsigned char *head, int index_only)
 			 */
 			continue;
 		}
+
+		/*
+		 * "rm" of a path that has changes need to be treated
+		 * carefully not to allow losing local changes
+		 * accidentally.  A local change could be (1) file in
+		 * work tree is different since the index; and/or (2)
+		 * the user staged a content that is different from
+		 * the current commit in the index.
+		 *
+		 * In such a case, you would need to --force the
+		 * removal.  However, "rm --cached" (remove only from
+		 * the index) is safe if the index matches the file in
+		 * the work tree or the HEAD commit, as it means that
+		 * the content being removed is available elsewhere.
+		 */
+
+		/*
+		 * Is the index different from the file in the work tree?
+		 */
 		if (ce_match_stat(ce, &st, 0))
 			local_changes = 1;
+
+		/*
+		 * Is the index different from the HEAD commit?  By
+		 * definition, before the very initial commit,
+		 * anything staged in the index is treated by the same
+		 * way as changed from the HEAD.
+		 */
 		if (no_head
 		     || get_tree_entry(head, name, sha1, &mode)
 		     || ce->ce_mode != create_ce_mode(mode)
 		     || hashcmp(ce->sha1, sha1))
 			staged_changes = 1;
 
-		if (local_changes && staged_changes &&
-		    !(index_only && is_empty_blob_sha1(ce->sha1)))
-			errs = error("'%s' has staged content different "
-				     "from both the file and the HEAD\n"
-				     "(use -f to force removal)", name);
+		/*
+		 * If the index does not match the file in the work
+		 * tree and if it does not match the HEAD commit
+		 * either, (1) "git rm" without --cached definitely
+		 * will lose information; (2) "git rm --cached" will
+		 * lose information unless it is about removing an
+		 * "intent to add" entry.
+		 */
+		if (local_changes && staged_changes) {
+			if (!index_only || !is_empty_blob_sha1(ce->sha1))
+				errs = error("'%s' has staged content different "
+					     "from both the file and the HEAD\n"
+					     "(use -f to force removal)", name);
+		}
 		else if (!index_only) {
-			/* It's not dangerous to "git rm --cached" a
-			 * file if the index matches the file or the
-			 * HEAD, since it means the deleted content is
-			 * still available somewhere.
-			 */
 			if (staged_changes)
 				errs = error("'%s' has changes staged in the index\n"
 					     "(use --cached to keep the file, "
-- 
1.6.0.4.850.g6bd829
