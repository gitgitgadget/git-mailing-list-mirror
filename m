From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] git-blame --reverse
Date: Thu, 03 Apr 2008 02:19:24 -0700
Message-ID: <7vej9n1ejn.fsf@gitster.siamese.dyndns.org>
References: <7v4paj486a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 11:20:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhLcL-0000Hu-H4
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 11:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756880AbYDCJTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 05:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756830AbYDCJTh
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 05:19:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512AbYDCJTg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 05:19:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 119B1250D;
	Thu,  3 Apr 2008 05:19:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B6FF9250B; Thu,  3 Apr 2008 05:19:31 -0400 (EDT)
In-Reply-To: <7v4paj486a.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 03 Apr 2008 02:08:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78739>

This new option allows "git blame" to read an old version of the file, and
find up to which commit each line survived (i.e. their children rewrote
the line and removed the original from the contents).

The previous revision machinery update to decorate each commit with its
children was leading to this change.  When the --reverse option is given,
we read the old version and pass blame to the children of the current
suspect, instead of the usual order of starting from the latest and
passing blame to parents (hence, the earlier "scapegoat" rename).

The standard yardstick of "blame" in git.git history is still the file
"rev-list.c", which was refactored heavily during its existence.  For
example, output from:

  $ git blame -C -C -w --reverse 9de48752..master -- rev-list.c

begins like this:

6c41b801 builtin-rev-list.c (JC Hamano   2008-04-02  1) #include "cache...
6c41b801 builtin-rev-list.c (JC Hamano   2008-04-02  2) #include "commi...
6c41b801 builtin-rev-list.c (JC Hamano   2008-04-02  3) #include "tree....
6c41b801 builtin-rev-list.c (JC Hamano   2008-04-02  4) #include "blob....
213523f4 rev-list.c         (JC Hamano   2006-03-01  5) #include "epoch...
6c41b801 builtin-rev-list.c (JC Hamano   2008-04-02  6)
ab57c8dd rev-list.c         (JC Hamano   2006-02-24  7) #define SEEN
ab57c8dd rev-list.c         (JC Hamano   2006-02-24  8) #define INTERES...
213523f4 rev-list.c         (JC Hamano   2006-03-01  9) #define COUNTED...
7e21c29b rev-list.c         (LTorvalds   2005-07-06 10) #define SHOWN  ...
6c41b801 builtin-rev-list.c (JC Hamano   2008-04-02 11)
6c41b801 builtin-rev-list.c (JC Hamano   2008-04-02 12) static const ch...
b1349229 rev-list.c         (LTorvalds   2005-07-26 13)    "usage: git-...

This sample output reveals that the original first four lines survived up
to now but were moved to builtin-rev-list.c and inclusion of "epoch.h" was
removed after 213523f4, and the line was last seen in rev-list.c.

To be useful, this mode probably needs some more tweaking so that the
commit that removed the line (i.e. the children of the commits listed in
the above sample output) is shown instead, but then there is a little
matter of which child of a fork point to show.

For now, you can find the diff that rewrote the fifth line above by doing:

    $ git log --children 213523f4^..

to find its child, which is 1025fe5 (Merge branch 'lt/rev-list' into next,
2006-03-01), and then look at that child with:

    $ git show 1025fe5

Yes, it is a bit awkward, but it is a good start.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-blame.c |   81 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 65 insertions(+), 16 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index fbc441f..5c7546d 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -43,6 +43,7 @@ static int max_orig_digits;
 static int max_digits;
 static int max_score_digits;
 static int show_root;
+static int reverse;
 static int blank_boundary;
 static int incremental;
 static int cmd_is_annotate;
@@ -177,7 +178,7 @@ struct blame_entry {
 struct scoreboard {
 	/* the final commit (i.e. where we started digging from) */
 	struct commit *final;
-
+	struct rev_info *revs;
 	const char *path;
 
 	/*
@@ -1196,15 +1197,17 @@ static void pass_whole_blame(struct scoreboard *sb,
  * "parent" (and "porigin"), but what we mean is to find scapegoat to
  * exonerate ourselves.
  */
-static struct commit_list *first_scapegoat(struct commit *commit)
+static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit)
 {
-	return commit->parents;
+	if (!reverse)
+		return commit->parents;
+	return lookup_decoration(&revs->children, &commit->object);
 }
 
-static int num_scapegoats(struct commit *commit)
+static int num_scapegoats(struct rev_info *revs, struct commit *commit)
 {
 	int cnt;
-	struct commit_list *l = first_scapegoat(commit);
+	struct commit_list *l = first_scapegoat(revs, commit);
 	for (cnt = 0; l; l = l->next)
 		cnt++;
 	return cnt;
@@ -1214,13 +1217,14 @@ static int num_scapegoats(struct commit *commit)
 
 static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 {
+	struct rev_info *revs = sb->revs;
 	int i, pass, num_sg;
 	struct commit *commit = origin->commit;
 	struct commit_list *sg;
 	struct origin *sg_buf[MAXSG];
 	struct origin *porigin, **sg_origin = sg_buf;
 
-	num_sg = num_scapegoats(commit);
+	num_sg = num_scapegoats(revs, commit);
 	if (!num_sg)
 		goto finish;
 	else if (num_sg < ARRAY_SIZE(sg_buf))
@@ -1237,7 +1241,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 				       struct commit *, struct origin *);
 		find = pass ? find_rename : find_origin;
 
-		for (i = 0, sg = first_scapegoat(commit);
+		for (i = 0, sg = first_scapegoat(revs, commit);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct commit *p = sg->item;
@@ -1270,7 +1274,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	}
 
 	num_commits++;
-	for (i = 0, sg = first_scapegoat(commit);
+	for (i = 0, sg = first_scapegoat(revs, commit);
 	     i < num_sg && sg;
 	     sg = sg->next, i++) {
 		struct origin *porigin = sg_origin[i];
@@ -1284,7 +1288,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * Optionally find moves in parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_MOVE)
-		for (i = 0, sg = first_scapegoat(commit);
+		for (i = 0, sg = first_scapegoat(revs, commit);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct origin *porigin = sg_origin[i];
@@ -1298,7 +1302,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * Optionally find copies from parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_COPY)
-		for (i = 0, sg = first_scapegoat(commit);
+		for (i = 0, sg = first_scapegoat(revs, commit);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct origin *porigin = sg_origin[i];
@@ -1515,8 +1519,10 @@ static void found_guilty_entry(struct blame_entry *ent)
  * is still unknown, pick one blame_entry, and allow its current
  * suspect to pass blames to its parents.
  */
-static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
+static void assign_blame(struct scoreboard *sb, int opt)
 {
+	struct rev_info *revs = sb->revs;
+
 	while (1) {
 		struct blame_entry *ent;
 		struct commit *commit;
@@ -1537,8 +1543,9 @@ static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
 		commit = suspect->commit;
 		if (!commit->object.parsed)
 			parse_commit(commit);
-		if (!(commit->object.flags & UNINTERESTING) &&
-		    !(revs->max_age != -1 && commit->date < revs->max_age))
+		if (reverse ||
+		    (!(commit->object.flags & UNINTERESTING) &&
+		     !(revs->max_age != -1 && commit->date < revs->max_age)))
 			pass_blame(sb, suspect, opt);
 		else {
 			commit->object.flags |= UNINTERESTING;
@@ -2154,10 +2161,11 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	return commit;
 }
 
-static const char *prepare_final(struct scoreboard *sb, struct rev_info *revs)
+static const char *prepare_final(struct scoreboard *sb)
 {
 	int i;
 	const char *final_commit_name = NULL;
+	struct rev_info *revs = sb->revs;
 
 	/*
 	 * There must be one and only one positive commit in the
@@ -2181,6 +2189,36 @@ static const char *prepare_final(struct scoreboard *sb, struct rev_info *revs)
 	return final_commit_name;
 }
 
+static const char *prepare_initial(struct scoreboard *sb)
+{
+	int i;
+	const char *final_commit_name = NULL;
+	struct rev_info *revs = sb->revs;
+
+	/*
+	 * There must be one and only one negative commit, and it must be
+	 * the boundary.
+	 */
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object *obj = revs->pending.objects[i].item;
+		if (!(obj->flags & UNINTERESTING))
+			continue;
+		while (obj->type == OBJ_TAG)
+			obj = deref_tag(obj, NULL, 0);
+		if (obj->type != OBJ_COMMIT)
+			die("Non commit %s?", revs->pending.objects[i].name);
+		if (sb->final)
+			die("More than one commit to dig down to %s and %s?",
+			    revs->pending.objects[i].name,
+			    final_commit_name);
+		sb->final = (struct commit *) obj;
+		final_commit_name = revs->pending.objects[i].name;
+	}
+	if (!final_commit_name)
+		die("No commit to dig down to?");
+	return final_commit_name;
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -2213,6 +2251,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			blank_boundary = 1;
 		else if (!strcmp("--root", arg))
 			show_root = 1;
+		else if (!strcmp("--reverse", arg)) {
+			argv[unk++] = "--children";
+			reverse = 1;
+		}
 		else if (!strcmp(arg, "--show-stats"))
 			show_stats = 1;
 		else if (!strcmp("-c", arg))
@@ -2386,7 +2428,14 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	setup_revisions(unk, argv, &revs, NULL);
 	memset(&sb, 0, sizeof(sb));
 
-	final_commit_name = prepare_final(&sb, &revs);
+	sb.revs = &revs;
+	if (!reverse)
+		final_commit_name = prepare_final(&sb);
+	else if (contents_from)
+		die("--contents and --children do not blend well.");
+	else
+		final_commit_name = prepare_initial(&sb);
+
 	if (!sb.final) {
 		/*
 		 * "--not A B -- path" without anything positive;
@@ -2464,7 +2513,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (!incremental)
 		setup_pager();
 
-	assign_blame(&sb, &revs, opt);
+	assign_blame(&sb, opt);
 
 	if (incremental)
 		return 0;
-- 
1.5.5.rc3.139.g8b2cf
