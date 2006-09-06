From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] revision.c: allow injecting revision parameters after setup_revisions().
Date: Tue, 05 Sep 2006 21:47:03 -0700
Message-ID: <7vd5a9a9fc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 06:47:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKpJj-0007lF-GF
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 06:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWIFErG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 00:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbWIFErF
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 00:47:05 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58791 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751052AbWIFErC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 00:47:02 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906044701.KZCR6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Wed, 6 Sep 2006 00:47:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Jsmu1V00f1kojtg0000000
	Wed, 06 Sep 2006 00:46:55 -0400
To: Andy Whitcroft <apw@shadowen.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26502>

setup_revisions() wants to get all the parameters at once and
then postprocesses the resulting revs structure after it is done
with them.  This code structure is a bit cumbersome to deal with
efficiently when we want to inject revision parameters from the
side (e.g. read from standard input).

Fortunately, the nature of this postprocessing is not affected by
revision parameters; they are affected only by flags.  So it is
Ok to do add_object() after the it returns.

This splits out the code that deals with the revision parameter
out of the main loop of setup_revisions(), so that we can later
call it from elsewhere after it returns.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 revision.c |  159 ++++++++++++++++++++++++++++++++----------------------------
 revision.h |    2 +
 2 files changed, 87 insertions(+), 74 deletions(-)

diff --git a/revision.c b/revision.c
index b588f74..db01682 100644
--- a/revision.c
+++ b/revision.c
@@ -592,6 +592,85 @@ static void prepare_show_merge(struct re
 	revs->prune_data = prune;
 }
 
+int handle_revision_arg(const char *arg, struct rev_info *revs,
+			int flags,
+			int cant_be_filename)
+{
+	char *dotdot;
+	struct object *object;
+	unsigned char sha1[20];
+	int local_flags;
+
+	dotdot = strstr(arg, "..");
+	if (dotdot) {
+		unsigned char from_sha1[20];
+		const char *next = dotdot + 2;
+		const char *this = arg;
+		int symmetric = *next == '.';
+		unsigned int flags_exclude = flags ^ UNINTERESTING;
+
+		*dotdot = 0;
+		next += symmetric;
+
+		if (!*next)
+			next = "HEAD";
+		if (dotdot == arg)
+			this = "HEAD";
+		if (!get_sha1(this, from_sha1) &&
+		    !get_sha1(next, sha1)) {
+			struct commit *a, *b;
+			struct commit_list *exclude;
+
+			a = lookup_commit_reference(from_sha1);
+			b = lookup_commit_reference(sha1);
+			if (!a || !b) {
+				die(symmetric ?
+				    "Invalid symmetric difference expression %s...%s" :
+				    "Invalid revision range %s..%s",
+				    arg, next);
+			}
+
+			if (!cant_be_filename) {
+				*dotdot = '.';
+				verify_non_filename(revs->prefix, arg);
+			}
+
+			if (symmetric) {
+				exclude = get_merge_bases(a, b, 1);
+				add_pending_commit_list(revs, exclude,
+							flags_exclude);
+				free_commit_list(exclude);
+				a->object.flags |= flags;
+			} else
+				a->object.flags |= flags_exclude;
+			b->object.flags |= flags;
+			add_pending_object(revs, &a->object, this);
+			add_pending_object(revs, &b->object, next);
+			return 0;
+		}
+		*dotdot = '.';
+	}
+	dotdot = strstr(arg, "^@");
+	if (dotdot && !dotdot[2]) {
+		*dotdot = 0;
+		if (add_parents_only(revs, arg, flags))
+			return 0;
+		*dotdot = '^';
+	}
+	local_flags = 0;
+	if (*arg == '^') {
+		local_flags = UNINTERESTING;
+		arg++;
+	}
+	if (get_sha1(arg, sha1))
+		return -1;
+	if (!cant_be_filename)
+		verify_non_filename(revs->prefix, arg);
+	object = get_reference(revs, arg, sha1, flags ^ local_flags);
+	add_pending_object(revs, object, arg);
+	return 0;
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -620,12 +699,7 @@ int setup_revisions(int argc, const char
 
 	flags = show_merge = 0;
 	for (i = 1; i < argc; i++) {
-		struct object *object;
 		const char *arg = argv[i];
-		unsigned char sha1[20];
-		char *dotdot;
-		int local_flags;
-
 		if (*arg == '-') {
 			int opts;
 			if (!strncmp(arg, "--max-count=", 12)) {
@@ -830,71 +904,10 @@ int setup_revisions(int argc, const char
 			left++;
 			continue;
 		}
-		dotdot = strstr(arg, "..");
-		if (dotdot) {
-			unsigned char from_sha1[20];
-			const char *next = dotdot + 2;
-			const char *this = arg;
-			int symmetric = *next == '.';
-			unsigned int flags_exclude = flags ^ UNINTERESTING;
-
-			*dotdot = 0;
-			next += symmetric;
-
-			if (!*next)
-				next = "HEAD";
-			if (dotdot == arg)
-				this = "HEAD";
-			if (!get_sha1(this, from_sha1) &&
-			    !get_sha1(next, sha1)) {
-				struct commit *a, *b;
-				struct commit_list *exclude;
-
-				a = lookup_commit_reference(from_sha1);
-				b = lookup_commit_reference(sha1);
-				if (!a || !b) {
-					die(symmetric ?
-					    "Invalid symmetric difference expression %s...%s" :
-					    "Invalid revision range %s..%s",
-					    arg, next);
-				}
-
-				if (!seen_dashdash) {
-					*dotdot = '.';
-					verify_non_filename(revs->prefix, arg);
-				}
-
-				if (symmetric) {
-					exclude = get_merge_bases(a, b, 1);
-					add_pending_commit_list(revs, exclude,
-					                        flags_exclude);
-					free_commit_list(exclude);
-					a->object.flags |= flags;
-				} else
-					a->object.flags |= flags_exclude;
-				b->object.flags |= flags;
-				add_pending_object(revs, &a->object, this);
-				add_pending_object(revs, &b->object, next);
-				continue;
-			}
-			*dotdot = '.';
-		}
-		dotdot = strstr(arg, "^@");
-		if (dotdot && !dotdot[2]) {
-			*dotdot = 0;
-			if (add_parents_only(revs, arg, flags))
-				continue;
-			*dotdot = '^';
-		}
-		local_flags = 0;
-		if (*arg == '^') {
-			local_flags = UNINTERESTING;
-			arg++;
-		}
-		if (get_sha1(arg, sha1)) {
-			int j;
 
-			if (seen_dashdash || local_flags)
+		if (handle_revision_arg(arg, revs, flags, seen_dashdash)) {
+			int j;
+			if (seen_dashdash || *arg == '^')
 				die("bad revision '%s'", arg);
 
 			/* If we didn't have a "--":
@@ -906,14 +919,12 @@ int setup_revisions(int argc, const char
 			for (j = i; j < argc; j++)
 				verify_filename(revs->prefix, argv[j]);
 
-			revs->prune_data = get_pathspec(revs->prefix, argv + i);
+			revs->prune_data = get_pathspec(revs->prefix,
+							argv + i);
 			break;
 		}
-		if (!seen_dashdash)
-			verify_non_filename(revs->prefix, arg);
-		object = get_reference(revs, arg, sha1, flags ^ local_flags);
-		add_pending_object(revs, object, arg);
 	}
+
 	if (show_merge)
 		prepare_show_merge(revs);
 	if (def && !revs->pending.nr) {
diff --git a/revision.h b/revision.h
index d289781..c1f71af 100644
--- a/revision.h
+++ b/revision.h
@@ -90,6 +90,8 @@ extern int rev_compare_tree(struct rev_i
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
 extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
+extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,int cant_be_filename);
+
 extern void prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
 
-- 
1.4.2.g980c3
