From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/4] Add a 'source' decorator for commits
Date: Mon, 3 Nov 2008 11:33:53 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811031132520.3419@nehalem.linux-foundation.org>
References: <200811031439.12111.brian.foster@innova-card.com> <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:36:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx5Dr-0000t1-Ml
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 20:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbYKCTfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 14:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440AbYKCTfE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 14:35:04 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56081 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754253AbYKCTfD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 14:35:03 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3JXsCV022097
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Nov 2008 11:33:55 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3JXrqt023045;
	Mon, 3 Nov 2008 11:33:53 -0800
In-Reply-To: <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.94 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99982>



From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2008 12:51:59 -0700

We already support decorating commits by tags or branches that point to
them, but especially when we are looking at multiple branches together,
we sometimes want to see _how_ we reached a particular commit.

We can abuse the '->util' field in the commit to keep track of that as
we walk the commit lists, and get a reasonably useful view into which
branch or tag first reaches that commit.

Of course, if the commit is reachable through multiple sources (which is
common), our particular choice of "first" reachable is entirely random
and depends on the particular path we happened to follow.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is strictly unrelated to the rest, but as mentioned, it touches the 
same areas, and I'm too lazy to split it out. I had it in my tree. It 
won't hurt.

 builtin-log.c      |    2 ++
 builtin-rev-list.c |    2 +-
 log-tree.c         |    8 +++++---
 log-tree.h         |    2 +-
 revision.c         |    4 ++++
 revision.h         |    1 +
 6 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index a0944f7..176cbce 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -56,6 +56,8 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		if (!strcmp(arg, "--decorate")) {
 			load_ref_decorations();
 			decorate = 1;
+		} else if (!strcmp(arg, "--source")) {
+			rev->show_source = 1;
 		} else
 			die("unrecognized argument: %s", arg);
 	}
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 06cdeb7..857742a 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -100,7 +100,7 @@ static void show_commit(struct commit *commit)
 			children = children->next;
 		}
 	}
-	show_decorations(commit);
+	show_decorations(&revs, commit);
 	if (revs.commit_format == CMIT_FMT_ONELINE)
 		putchar(' ');
 	else
diff --git a/log-tree.c b/log-tree.c
index cec3c06..cf7947b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -52,11 +52,13 @@ static void show_parents(struct commit *commit, int abbrev)
 	}
 }
 
-void show_decorations(struct commit *commit)
+void show_decorations(struct rev_info *opt, struct commit *commit)
 {
 	const char *prefix;
 	struct name_decoration *decoration;
 
+	if (opt->show_source && commit->util)
+		printf(" %s", (char *) commit->util);
 	decoration = lookup_decoration(&name_decoration, &commit->object);
 	if (!decoration)
 		return;
@@ -279,7 +281,7 @@ void show_log(struct rev_info *opt)
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
-		show_decorations(commit);
+		show_decorations(opt, commit);
 		if (opt->graph && !graph_is_commit_finished(opt->graph)) {
 			putchar('\n');
 			graph_show_remainder(opt->graph);
@@ -352,7 +354,7 @@ void show_log(struct rev_info *opt)
 			printf(" (from %s)",
 			       diff_unique_abbrev(parent->object.sha1,
 						  abbrev_commit));
-		show_decorations(commit);
+		show_decorations(opt, commit);
 		printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
 		if (opt->commit_format == CMIT_FMT_ONELINE) {
 			putchar(' ');
diff --git a/log-tree.h b/log-tree.h
index 3c8127b..f2a9008 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -12,7 +12,7 @@ int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 int log_tree_opt_parse(struct rev_info *, const char **, int);
 void show_log(struct rev_info *opt);
-void show_decorations(struct commit *commit);
+void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, const char *name,
 			     const char **subject_p,
 			     const char **extra_headers_p,
diff --git a/revision.c b/revision.c
index 2f646de..d45f05a 100644
--- a/revision.c
+++ b/revision.c
@@ -199,6 +199,8 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 			mark_parents_uninteresting(commit);
 			revs->limited = 1;
 		}
+		if (revs->show_source && !commit->util)
+			commit->util = (void *) name;
 		return commit;
 	}
 
@@ -484,6 +486,8 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 
 		if (parse_commit(p) < 0)
 			return -1;
+		if (revs->show_source && !p->util)
+			p->util = commit->util;
 		p->object.flags |= left_flag;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= SEEN;
diff --git a/revision.h b/revision.h
index 2fdb2dd..51a4863 100644
--- a/revision.h
+++ b/revision.h
@@ -53,6 +53,7 @@ struct rev_info {
 			left_right:1,
 			rewrite_parents:1,
 			print_parents:1,
+			show_source:1,
 			reverse:1,
 			reverse_output_stage:1,
 			cherry_pick:1,
-- 
1.6.0.3.616.gf1239d6.dirty
