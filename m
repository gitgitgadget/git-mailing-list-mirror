From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [REPLACEMENT PATCH 2/2] Add "--early-output" log flag for interactive
 GUI use
Date: Sat, 3 Nov 2007 11:11:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org> 
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org> 
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org> 
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 19:12:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoNUF-0007gv-G6
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 19:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbXKCSMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 14:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbXKCSMb
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 14:12:31 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42567 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753788AbXKCSMa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Nov 2007 14:12:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA3IBB2H011474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Nov 2007 11:11:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA3IBA64028160;
	Sat, 3 Nov 2007 11:11:10 -0700
In-Reply-To: <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
X-Spam-Status: No, hits=-5.932 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_44,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63296>


This adds support for "--early-output[=n]" as a flag to the "git log"
family of commands.  This allows GUI programs to state that they want to
get some output early, in order to be able to show at least something
quickly, even if the full output may take longer to generate.

If no count is specified, a default count of a hundred commits will be
used, although the actual numbr of commits output may be smaller
depending on how many commits were actually found in the first tenth of
a second (or if *everything* was found before that, in which case no
early output will be provided, and only the final list is made
available).

When the full list is generated, there will be a "Final output:" string
prepended to it, regardless of whether any early commits were shown or
not, so that the consumer can always know the difference between early
output and the final list.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This replaces my 2/2 patch from yesterday, but still relies on the 
topo-sorting cleanups in 1/2 (which are really totally independent, and 
probably could go in regardless of any of this series).

Instead of having a generic replay mechanism, this one just does *one* 
replay, and discards even that if it can generate all the commits really 
quickly.

The timeout right now is set to a pretty aggressive one-tenth-of-a- 
second, and realistically that could/should probably be longer, but making 
it short makes sure that we actually trigger this in normal use, so I 
think this is the right approach for the initial implementation.

Try it out, with

	git log --early-output=2

and look at what happens: if it cannot generate all the commits in the 
first 0.1 seconds, it will take what it *could* generate, sort it 
topologically (you can add "--date-order" if you want), and show the first 
two commits.

When it then generates the rest, it will add a "Final output:" line, and 
then re-generate it all.

The intent is for a GUI front-end to be able to use the first one-hundred 
or so commits to populate the commit log, and show the window, and not 
have to worry about the fact that the rest of the data (how-ever many 
hundred thousand commits there are) may take much more time to arrive.

So not only is this patch pretty straightforward in itself, I think usage 
should be pretty straightforward too.

 builtin-log.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 revision.c    |   22 ++++++++++++++++++
 revision.h    |    4 +++
 3 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index e8b982d..707add2 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -77,11 +77,78 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	}
 }
 
+static void log_show_early(struct rev_info *revs, struct commit_list *list)
+{
+	int i = revs->early_output;
+
+	sort_in_topological_order(&list, revs->lifo);
+	while (list && i) {
+		struct commit *commit = list->item;
+		log_tree_commit(revs, commit);
+		list = list->next;
+		i--;
+	}
+}
+
+static void early_output(int signal)
+{
+	show_early_output = log_show_early;
+}
+
+static void setup_early_output(struct rev_info *rev)
+{
+	struct sigaction sa;
+	struct itimerval v;
+
+	/*
+	 * Set up the signal handler, minimally intrusively:
+	 * we only set a single volatile integer word (not
+	 * using sigatomic_t - trying to avoid unnecessary
+	 * system dependencies and headers), and using
+	 * SA_RESTART.
+	 */
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = early_output;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGALRM, &sa, NULL);
+
+	/*
+	 * If we can get the whole output in less than a
+	 * tenth of a second, don't even bother doing the
+	 * early-output thing..
+	 *
+	 * This is a one-time-only trigger.
+	 */
+	memset(&v, 0, sizeof(v));
+	v.it_value.tv_sec = 0;
+	v.it_value.tv_usec = 100000;
+	setitimer(ITIMER_REAL, &v, NULL);
+}
+
+static void finish_early_output(struct rev_info *rev)
+{
+	signal(SIGALRM, SIG_IGN);
+	if (rev->shown_one) {
+		rev->shown_one = 0;
+		if (rev->commit_format != CMIT_FMT_ONELINE)
+			putchar(rev->diffopt.line_termination);
+	}
+	printf("Final output:\n");
+}
+
 static int cmd_log_walk(struct rev_info *rev)
 {
 	struct commit *commit;
 
+	if (rev->early_output)
+		setup_early_output(rev);
+
 	prepare_revision_walk(rev);
+
+	if (rev->early_output)
+		finish_early_output(rev);
+
 	while ((commit = get_revision(rev)) != NULL) {
 		log_tree_commit(rev, commit);
 		if (!rev->reflog_info) {
diff --git a/revision.c b/revision.c
index e85b4af..26610bb 100644
--- a/revision.c
+++ b/revision.c
@@ -10,6 +10,8 @@
 #include "reflog-walk.h"
 #include "patch-ids.h"
 
+volatile show_early_output_fn_t show_early_output;
+
 static char *path_name(struct name_path *path, const char *name)
 {
 	struct name_path *p;
@@ -533,6 +535,7 @@ static int limit_list(struct rev_info *revs)
 		struct commit_list *entry = list;
 		struct commit *commit = list->item;
 		struct object *obj = &commit->object;
+		show_early_output_fn_t show;
 
 		list = list->next;
 		free(entry);
@@ -550,6 +553,13 @@ static int limit_list(struct rev_info *revs)
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
 			continue;
 		p = &commit_list_insert(commit, p)->next;
+
+		show = show_early_output;
+		if (!show)
+			continue;
+
+		show(revs, newlist);
+		show_early_output = NULL;
 	}
 	if (revs->cherry_pick)
 		cherry_pick_list(newlist, revs);
@@ -991,6 +1001,18 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->topo_order = 1;
 				continue;
 			}
+			if (!prefixcmp(arg, "--early-output")) {
+				int count = 100;
+				switch (arg[14]) {
+				case '=':
+					count = atoi(arg+15);
+					/* Fallthrough */
+				case 0:
+					revs->topo_order = 1;
+					revs->early_output = count;
+					continue;
+				}
+			}
 			if (!strcmp(arg, "--parents")) {
 				revs->parents = 1;
 				continue;
diff --git a/revision.h b/revision.h
index 1f64576..d8a5a50 100644
--- a/revision.h
+++ b/revision.h
@@ -30,6 +30,8 @@ struct rev_info {
 	void *prune_data;
 	prune_fn_t *prune_fn;
 
+	unsigned int early_output;
+
 	/* Traversal flags */
 	unsigned int	dense:1,
 			no_merges:1,
@@ -105,6 +107,8 @@ struct rev_info {
 #define REV_TREE_DIFFERENT	2
 
 /* revision.c */
+typedef void (*show_early_output_fn_t)(struct rev_info *, struct commit_list *);
+volatile show_early_output_fn_t show_early_output;
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
 extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
