From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 12/15] revision.c: add BOTTOM flag for commits
Date: Thu, 16 May 2013 18:32:38 +0300
Message-ID: <1368718361-27859-13-git-send-email-kevin@bracey.fi>
References: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 17:33:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0BR-0003uH-E7
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab3EPPd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:33:26 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:35875 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752775Ab3EPPdP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:33:15 -0400
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 3EFDE10540ED
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:14 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:14 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:33:11 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18173713347787985130
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224577>

When performing edge-based operations on the revision graph, it can be
useful to be able to identify the INTERESTING graph's connection(s) to
the bottom commit(s) specified by the user.

Conceptually when the user specifies "A..B" (== B ^A), they are asking
for the history from A to B. The first connection from A onto the
INTERESTING graph is part of that history, and should be considered. If
we consider only INTERESTING nodes and their connections, then we're
really only considering the history from A's immediate descendants to B.

This patch does not change behaviour, but adds a new BOTTOM flag to
indicate the bottom commits specified by the user, ready to be used by
following patches.

We immediately use the BOTTOM flag to return collect_bottom_commits() to
its original approach of examining the pending commit list rather than
the command line. This will ensure alignment of the definition of
"bottom" with future patches.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 revision.c | 34 ++++++++++++++++------------------
 revision.h |  3 ++-
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/revision.c b/revision.c
index 4f7446c..6607dab 100644
--- a/revision.c
+++ b/revision.c
@@ -909,16 +909,12 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
  * to filter the result of "A..B" further to the ones that can actually
  * reach A.
  */
-static struct commit_list *collect_bottom_commits(struct rev_info *revs)
+static struct commit_list *collect_bottom_commits(struct commit_list *list)
 {
-	struct commit_list *bottom = NULL;
-	int i;
-	for (i = 0; i < revs->cmdline.nr; i++) {
-		struct rev_cmdline_entry *elem = &revs->cmdline.rev[i];
-		if ((elem->flags & UNINTERESTING) &&
-		    elem->item->type == OBJ_COMMIT)
-			commit_list_insert((struct commit *)elem->item, &bottom);
-	}
+	struct commit_list *elem, *bottom = NULL;
+	for (elem = list; elem; elem = elem->next)
+		if (elem->item->object.flags & BOTTOM)
+			commit_list_insert(elem->item, &bottom);
 	return bottom;
 }
 
@@ -949,7 +945,7 @@ static int limit_list(struct rev_info *revs)
 	struct commit_list *bottom = NULL;
 
 	if (revs->ancestry_path) {
-		bottom = collect_bottom_commits(revs);
+		bottom = collect_bottom_commits(list);
 		if (!bottom)
 			die("--ancestry-path given but there are no bottom commits");
 	}
@@ -1121,7 +1117,7 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags)
 	const char *arg = arg_;
 
 	if (*arg == '^') {
-		flags ^= UNINTERESTING;
+		flags ^= UNINTERESTING | BOTTOM;
 		arg++;
 	}
 	if (get_sha1_committish(arg, sha1))
@@ -1213,8 +1209,8 @@ static void prepare_show_merge(struct rev_info *revs)
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
 	bases = get_merge_bases(head, other, 1);
-	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING);
-	add_pending_commit_list(revs, bases, UNINTERESTING);
+	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
+	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
 	free_commit_list(bases);
 	head->object.flags |= SYMMETRIC_LEFT;
 
@@ -1250,13 +1246,15 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	int cant_be_filename = revarg_opt & REVARG_CANNOT_BE_FILENAME;
 	unsigned get_sha1_flags = 0;
 
+	flags = flags & UNINTERESTING ? flags | BOTTOM : flags & ~BOTTOM;
+
 	dotdot = strstr(arg, "..");
 	if (dotdot) {
 		unsigned char from_sha1[20];
 		const char *next = dotdot + 2;
 		const char *this = arg;
 		int symmetric = *next == '.';
-		unsigned int flags_exclude = flags ^ UNINTERESTING;
+		unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
 		static const char head_by_default[] = "HEAD";
 		unsigned int a_flags;
 
@@ -1332,13 +1330,13 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	dotdot = strstr(arg, "^!");
 	if (dotdot && !dotdot[2]) {
 		*dotdot = 0;
-		if (!add_parents_only(revs, arg, flags ^ UNINTERESTING))
+		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM)))
 			*dotdot = '^';
 	}
 
 	local_flags = 0;
 	if (*arg == '^') {
-		local_flags = UNINTERESTING;
+		local_flags = UNINTERESTING | BOTTOM;
 		arg++;
 	}
 
@@ -1815,7 +1813,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
 	} else if (!strcmp(arg, "--bisect")) {
 		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
-		handle_refs(submodule, revs, *flags ^ UNINTERESTING, for_each_good_bisect_ref);
+		handle_refs(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
 		revs->bisect = 1;
 	} else if (!strcmp(arg, "--tags")) {
 		handle_refs(submodule, revs, *flags, for_each_tag_ref_submodule);
@@ -1841,7 +1839,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else if (!strcmp(arg, "--reflog")) {
 		handle_reflog(revs, *flags);
 	} else if (!strcmp(arg, "--not")) {
-		*flags ^= UNINTERESTING;
+		*flags ^= UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
 		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
 	} else if (!prefixcmp(arg, "--no-walk=")) {
diff --git a/revision.h b/revision.h
index 7d5763b..1e2c95c 100644
--- a/revision.h
+++ b/revision.h
@@ -15,7 +15,8 @@
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
 #define PATCHSAME	(1u<<9)
-#define ALL_REV_FLAGS	((1u<<10)-1)
+#define BOTTOM		(1u<<10)
+#define ALL_REV_FLAGS	((1u<<11)-1)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
-- 
1.8.3.rc0.28.g4b02ef5
