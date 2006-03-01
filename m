From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-log (internal): more options.
Date: Wed, 01 Mar 2006 04:24:39 -0800
Message-ID: <7vbqwqgxo8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602281126340.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602281251390.22647@g5.osdl.org>
	<7vr75nm8cl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602281504280.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 13:25:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEQNt-0003Ew-QB
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 13:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWCAMYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 07:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWCAMYq
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 07:24:46 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:49843 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932206AbWCAMYp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 07:24:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060301122251.PFNK20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 07:22:51 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16974>

This ports the following options from rev-list based git-log
implementation:

 * -<n>, -n<n>, and -n <n>.  I am still wondering if we want
    this natively supported by setup_revisions(), which already
    takes --max-count.  We may want to move them in the next
    round.  Also I am not sure if we can get away with not
    setting revs->limited when we set max-count.  The latest
    rev-list.c and revision.c in this series do not, so I left
    them as they are.

 * --pretty and --pretty=<fmt>.

 * --abbrev=<n> and --no-abbrev.

The previous commit already handles time-based limiters
(--since, --until and friends).  The remaining things that
rev-list based git-log happens to do are not useful in a pure
log-viewing purposes, and not ported:

 * --bisect (obviously).

 * --header.  I am actually in favor of doing the NUL
   terminated record format, but rev-list based one always
   passed --pretty, which defeated this option.  Maybe next
   round.

 * --parents.  I do not think of a reason a log viewer wants
   this.  The flag is primarily for feeding squashed history
   via pipe to downstream tools.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * comes on top of --since/--until patch which in turn comes on
   top of janitorial "remove merge-order" change.

 git.c      |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 rev-list.c |    5 ++--
 revision.h |    1 +
 3 files changed, 72 insertions(+), 4 deletions(-)

4e365d2558356cd091ebf57f689c477a86822d53
diff --git a/git.c b/git.c
index b0da6b1..bf68dac 100644
--- a/git.c
+++ b/git.c
@@ -256,12 +256,80 @@ static int cmd_log(int argc, char **argv
 	struct rev_info rev;
 	struct commit *commit;
 	char *buf = xmalloc(LOGSIZE);
+	static enum cmit_fmt commit_format = CMIT_FMT_DEFAULT;
+	int abbrev = DEFAULT_ABBREV;
+	int show_parents = 0;
+	const char *commit_prefix = "commit ";
 
 	argc = setup_revisions(argc, argv, &rev, "HEAD");
+	while (1 < argc) {
+		char *arg = argv[1];
+		/* accept -<digit>, like traditilnal "head" */
+		if ((*arg == '-') && isdigit(arg[1])) {
+			rev.max_count = atoi(arg + 1);
+		}
+		else if (!strcmp(arg, "-n")) {
+			if (argc < 2)
+				die("-n requires an argument");
+			rev.max_count = atoi(argv[2]);
+			argc--; argv++;
+		}
+		else if (!strncmp(arg,"-n",2)) {
+			rev.max_count = atoi(arg + 2);
+		}
+		else if (!strncmp(arg, "--pretty", 8)) {
+			commit_format = get_commit_format(arg + 8);
+			if (commit_format == CMIT_FMT_ONELINE)
+				commit_prefix = "";
+		}
+		else if (!strcmp(arg, "--parents")) {
+			show_parents = 1;
+		}
+		else if (!strcmp(arg, "--no-abbrev")) {
+			abbrev = 0;
+		}
+		else if (!strncmp(arg, "--abbrev=", 9)) {
+			abbrev = strtoul(arg + 9, NULL, 10);
+			if (abbrev && abbrev < MINIMUM_ABBREV)
+				abbrev = MINIMUM_ABBREV;
+			else if (40 < abbrev)
+				abbrev = 40;
+		}
+		else
+			die("unrecognized argument: %s", arg);
+		argc--; argv++;
+	}
+
 	prepare_revision_walk(&rev);
 	setup_pager();
 	while ((commit = get_revision(&rev)) != NULL) {
-		pretty_print_commit(CMIT_FMT_DEFAULT, commit, ~0, buf, LOGSIZE, 18);
+		printf("%s%s", commit_prefix,
+		       sha1_to_hex(commit->object.sha1));
+		if (show_parents) {
+			struct commit_list *parents = commit->parents;
+			while (parents) {
+				struct object *o = &(parents->item->object);
+				parents = parents->next;
+				if (o->flags & TMP_MARK)
+					continue;
+				printf(" %s", sha1_to_hex(o->sha1));
+				o->flags |= TMP_MARK;
+			}
+			/* TMP_MARK is a general purpose flag that can
+			 * be used locally, but the user should clean
+			 * things up after it is done with them.
+			 */
+			for (parents = commit->parents;
+			     parents;
+			     parents = parents->next)
+				parents->item->object.flags &= ~TMP_MARK;
+		}
+		if (commit_format == CMIT_FMT_ONELINE)
+			putchar(' ');
+		else
+			putchar('\n');
+		pretty_print_commit(commit_format, commit, ~0, buf,
+				    LOGSIZE, abbrev);
 		printf("%s\n", buf);
 	}
 	free(buf);
diff --git a/rev-list.c b/rev-list.c
index 6af8d86..8e4d83e 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -7,10 +7,9 @@
 #include "diff.h"
 #include "revision.h"
 
-/* bits #0-3 in revision.h */
+/* bits #0-4 in revision.h */
 
-#define COUNTED		(1u << 4)
-#define TMP_MARK	(1u << 5) /* for isolated cases; clean after use */
+#define COUNTED		(1u<<5)
 
 static const char rev_list_usage[] =
 "git-rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
diff --git a/revision.h b/revision.h
index 0043c16..31e8f61 100644
--- a/revision.h
+++ b/revision.h
@@ -5,6 +5,7 @@
 #define UNINTERESTING   (1u<<1)
 #define TREECHANGE	(1u<<2)
 #define SHOWN		(1u<<3)
+#define TMP_MARK	(1u<<4) /* for isolated cases; clean after use */
 
 struct rev_info {
 	/* Starting list */
-- 
1.2.3.g9425
