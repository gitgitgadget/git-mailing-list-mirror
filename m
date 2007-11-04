From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/2] Enhance --early-output format
Date: Sun, 4 Nov 2007 12:12:05 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
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
 <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
 <18221.14113.498416.396006@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 21:12:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iolpp-0003r7-OU
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 21:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbXKDUM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 15:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbXKDUM1
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 15:12:27 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44919 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751893AbXKDUM0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 15:12:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA4KC9SU024496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Nov 2007 12:12:10 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA4KC6MA017165;
	Sun, 4 Nov 2007 12:12:06 -0800
In-Reply-To: <alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63437>


This makes --early-output a bit more advanced, and actually makes it 
generate multiple "Final output:" headers as it updates things 
asynchronously. I realize that the "Final output:" line is now illogical, 
since it's not really final until it also says "done", but 

It now _always_ generates a "Final output:" header in front of any commit 
list, and that output header gives you a *guess* at the maximum number of 
commits available. However, it should be noted that the guess can be 
completely off: I do a reasonable job estimating it, but it is not meant 
to be exact. 

So what happens is that you may get output like this:

 - at 0.1 seconds:

	Final output: 2 incomplete
	.. 2 commits listed ..

 - half a second later:

	Final output: 33 incomplete
	.. 33 commits listed ..

 - another half a second after that:	

	Final output: 71 incomplete
	.. 71 commits listed ..

 - another half second later:

	Final output: 136 incomplete
	.. 100 commits listed: we hit the --early-output limit, and
	.. will only output 100 commits, and after this you'll not
	.. see an "incomplete" report any more since you got as much
	.. early output as you asked for!

 - .. and then finally:

	Final output: 73106 done
	.. all the commits ..

The above is a real-life scenario on my current kernel tree after having 
flushed all the caches.

Tested with the experimental gitk patch that Paul sent out, and by looking 
at the actual log output (and verifying that my commit count guesses 
actually match real life fairly well).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

On Sun, 4 Nov 2007, Linus Torvalds wrote:
> 
> I'm looking at it now, I'll have to think about this a bit more. It might 
> be trivial to fix, but this thing has real potential for being subtle.

It wasn't totally trivial, but it doesn't seem to be excessively subtle 
either. About half the patch is moving around some code to look at whether 
the commit is interesting or not and rewriting the parents, so that it can 
be shared with the revision walker.

 builtin-log.c |   88 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 revision.c    |   63 +++++++++++++++++++++++-----------------
 revision.h    |    8 +++++
 3 files changed, 119 insertions(+), 40 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 707add2..268a7af 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -77,17 +77,85 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	}
 }
 
+/*
+ * This gives a rough estimate for how many commits we
+ * will print out in the list.
+ */
+static int estimate_commit_count(struct rev_info *rev, struct commit_list *list)
+{
+	int n = 0;
+
+	while (list) {
+		struct commit *commit = list->item;
+		unsigned int flags = commit->object.flags;
+
+		list = list->next;
+		if (flags & UNINTERESTING)
+			continue;
+		if (rev->prune_fn && rev->dense && !(flags & TREECHANGE)) {
+			if (commit->parents && !commit->parents->next)
+				continue;
+		}
+		n++;
+	}
+	return n;
+}
+
+static void show_early_header(struct rev_info *rev, const char *stage, int nr)
+{
+	if (rev->shown_one) {
+		rev->shown_one = 0;
+		if (rev->commit_format != CMIT_FMT_ONELINE)
+			putchar(rev->diffopt.line_termination);
+	}
+	printf("Final output: %d %s\n", nr, stage);
+}
+
+struct itimerval early_output_timer;
+
 static void log_show_early(struct rev_info *revs, struct commit_list *list)
 {
 	int i = revs->early_output;
+	int show_header = 1;
 
 	sort_in_topological_order(&list, revs->lifo);
 	while (list && i) {
 		struct commit *commit = list->item;
-		log_tree_commit(revs, commit);
+		switch (simplify_commit(revs, commit)) {
+		case commit_show:
+			if (show_header) {
+				int n = estimate_commit_count(revs, list);
+				show_early_header(revs, "incomplete", n);
+				show_header = 0;
+			}
+			log_tree_commit(revs, commit);
+			i--;
+			break;
+		case commit_ignore:
+			break;
+		case commit_error:
+			return;
+		}
 		list = list->next;
-		i--;
 	}
+
+	/* Did we already get enough commits for the early output? */
+	if (!i)
+		return;
+
+	/*
+	 * ..if no, then repeat it twice a second until we
+	 * do.
+	 *
+	 * NOTE! We don't use "it_interval", because if the
+	 * reader isn't listening, we want our output to be
+	 * throttled by the writing, and not have the timer
+	 * trigger every second even if we're blocked on a
+	 * reader!
+	 */
+	early_output_timer.it_value.tv_sec = 0;
+	early_output_timer.it_value.tv_usec = 500000;
+	setitimer(ITIMER_REAL, &early_output_timer, NULL);
 }
 
 static void early_output(int signal)
@@ -98,7 +166,6 @@ static void early_output(int signal)
 static void setup_early_output(struct rev_info *rev)
 {
 	struct sigaction sa;
-	struct itimerval v;
 
 	/*
 	 * Set up the signal handler, minimally intrusively:
@@ -120,21 +187,16 @@ static void setup_early_output(struct rev_info *rev)
 	 *
 	 * This is a one-time-only trigger.
 	 */
-	memset(&v, 0, sizeof(v));
-	v.it_value.tv_sec = 0;
-	v.it_value.tv_usec = 100000;
-	setitimer(ITIMER_REAL, &v, NULL);
+	early_output_timer.it_value.tv_sec = 0;
+	early_output_timer.it_value.tv_usec = 100000;
+	setitimer(ITIMER_REAL, &early_output_timer, NULL);
 }
 
 static void finish_early_output(struct rev_info *rev)
 {
+	int n = estimate_commit_count(rev, rev->commits);
 	signal(SIGALRM, SIG_IGN);
-	if (rev->shown_one) {
-		rev->shown_one = 0;
-		if (rev->commit_format != CMIT_FMT_ONELINE)
-			putchar(rev->diffopt.line_termination);
-	}
-	printf("Final output:\n");
+	show_early_header(rev, "done", n);
 }
 
 static int cmd_log_walk(struct rev_info *rev)
diff --git a/revision.c b/revision.c
index 26610bb..5d6f208 100644
--- a/revision.c
+++ b/revision.c
@@ -1398,6 +1398,36 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 			   commit->buffer, strlen(commit->buffer));
 }
 
+enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
+{
+	if (commit->object.flags & SHOWN)
+		return commit_ignore;
+	if (revs->unpacked && has_sha1_pack(commit->object.sha1, revs->ignore_packed))
+		return commit_ignore;
+	if (commit->object.flags & UNINTERESTING)
+		return commit_ignore;
+	if (revs->min_age != -1 && (commit->date > revs->min_age))
+		return commit_ignore;
+	if (revs->no_merges && commit->parents && commit->parents->next)
+		return commit_ignore;
+	if (!commit_match(commit, revs))
+		return commit_ignore;
+	if (revs->prune_fn && revs->dense) {
+		/* Commit without changes? */
+		if (!(commit->object.flags & TREECHANGE)) {
+			/* drop merges unless we want parenthood */
+			if (!revs->parents)
+				return commit_ignore;
+			/* non-merge - always ignore it */
+			if (!commit->parents || !commit->parents->next)
+				return commit_ignore;
+		}
+		if (revs->parents && rewrite_parents(revs, commit) < 0)
+			return commit_error;
+	}
+	return commit_show;
+}
+
 static struct commit *get_revision_1(struct rev_info *revs)
 {
 	if (!revs->commits)
@@ -1425,36 +1455,15 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			if (add_parents_to_list(revs, commit, &revs->commits) < 0)
 				return NULL;
 		}
-		if (commit->object.flags & SHOWN)
-			continue;
-
-		if (revs->unpacked && has_sha1_pack(commit->object.sha1,
-						    revs->ignore_packed))
-		    continue;
 
-		if (commit->object.flags & UNINTERESTING)
-			continue;
-		if (revs->min_age != -1 && (commit->date > revs->min_age))
-			continue;
-		if (revs->no_merges &&
-		    commit->parents && commit->parents->next)
-			continue;
-		if (!commit_match(commit, revs))
+		switch (simplify_commit(revs, commit)) {
+		case commit_ignore:
 			continue;
-		if (revs->prune_fn && revs->dense) {
-			/* Commit without changes? */
-			if (!(commit->object.flags & TREECHANGE)) {
-				/* drop merges unless we want parenthood */
-				if (!revs->parents)
-					continue;
-				/* non-merge - always ignore it */
-				if (!commit->parents || !commit->parents->next)
-					continue;
-			}
-			if (revs->parents && rewrite_parents(revs, commit) < 0)
-				return NULL;
+		case commit_error:
+			return -1;
+		default:
+			return commit;
 		}
-		return commit;
 	} while (revs->commits);
 	return NULL;
 }
diff --git a/revision.h b/revision.h
index d8a5a50..2232247 100644
--- a/revision.h
+++ b/revision.h
@@ -133,4 +133,12 @@ extern void add_object(struct object *obj,
 
 extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
 
+enum commit_action {
+	commit_ignore,
+	commit_show,
+	commit_error
+};
+
+extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
+
 #endif
