From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v3 10/9] revision.c: treat A...B merge bases as if manually specified
Date: Mon,  6 May 2013 19:51:36 +0300
Message-ID: <1367859096-25909-1-git-send-email-kevin@bracey.fi>
References: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 06 21:19:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQwp-0002FN-IC
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab3EFTTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:19:35 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:38240 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755789Ab3EFTTe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:19:34 -0400
X-Greylist: delayed 4201 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2013 15:19:34 EDT
Received: from mail630.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 40F38FF9FC1
	for <git@vger.kernel.org>; Mon,  6 May 2013 18:51:53 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 6 May 2013 18:51:53 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 6 May 2013 18:51:51 +0200
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 16115849792537989342
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrieegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrieegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223495>

The documentation assures users that "A...B" is defined as 'r1 r2 --not
$(git merge-base --all r1 r2)'. This isn't in fact quite true, because
the calculated merge bases are not sent to add_rev_cmdline().

Previously, the effect was pretty minor - all that I can think of is
that "git rev-list --ancestry-path A B ^AB_base" works, but "git
rev-list --ancestry-path A...B" fails with a "no bottom commits" error.

But now that all history walking cares about bottom commits, this
failure to note the merge bases as bottoms can lead to worse results for
"A...B" compared to "A B ^AB_base".

So ensure that the calculated merge bases are sent to add_rev_cmdline(),
flagged as 'REV_CMD_MERGE_BASE'.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 revision.c                   | 9 +++++++--
 revision.h                   | 2 ++
 t/t6111-rev-list-treesame.sh | 4 ++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 99a3432..aad16a6 100644
--- a/revision.c
+++ b/revision.c
@@ -1305,12 +1305,16 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 
 static void add_pending_commit_list(struct rev_info *revs,
                                     struct commit_list *commit_list,
+                                    int whence,
                                     unsigned int flags)
 {
 	while (commit_list) {
 		struct object *object = &commit_list->item->object;
+		const char *sha1 = sha1_to_hex(object->sha1);
 		object->flags |= flags;
-		add_pending_object(revs, object, sha1_to_hex(object->sha1));
+		if (whence != REV_CMD_NONE)
+			add_rev_cmdline(revs, object, sha1, whence, flags);
+		add_pending_object(revs, object, sha1);
 		commit_list = commit_list->next;
 	}
 }
@@ -1332,7 +1336,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
 	bases = get_merge_bases(head, other, 1);
-	add_pending_commit_list(revs, bases, UNINTERESTING);
+	add_pending_commit_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING);
 	free_commit_list(bases);
 	head->object.flags |= SYMMETRIC_LEFT;
 
@@ -1420,6 +1424,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 			if (symmetric) {
 				exclude = get_merge_bases(a, b, 1);
 				add_pending_commit_list(revs, exclude,
+							REV_CMD_MERGE_BASE,
 							flags_exclude);
 				free_commit_list(exclude);
 				a_flags = flags | SYMMETRIC_LEFT;
diff --git a/revision.h b/revision.h
index 765630a..b2ac5a3 100644
--- a/revision.h
+++ b/revision.h
@@ -32,10 +32,12 @@ struct rev_cmdline_info {
 		struct object *item;
 		const char *name;
 		enum {
+			REV_CMD_NONE,
 			REV_CMD_REF,
 			REV_CMD_PARENTS_ONLY,
 			REV_CMD_LEFT,
 			REV_CMD_RIGHT,
+			REV_CMD_MERGE_BASE,
 			REV_CMD_REV
 		} whence;
 		unsigned flags;
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 689d357..ded0b1a 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -161,6 +161,10 @@ check_result 'F' B..F --ancestry-path --simplify-merges -- file
 check_result 'F D' B..F --first-parent
 check_result 'F' B..F --first-parent -- file
 
+# E...F should be equivalent to E F ^B, and be able to drop D as above.
+check_result 'F' E F ^B -- file
+check_result 'F' E...F -- file
+
 # Any sort of full history of C..F should show D, as it's the connection to C,
 # and it differs from it.
 check_result 'F D B' C..F
-- 
1.8.3.rc0.28.g4b02ef5
