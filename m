From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git status' is not read-only fs friendly
Date: Fri, 09 Feb 2007 16:12:55 -0800
Message-ID: <7vmz3mq394.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
	<7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550702091235x74e44362gad5b9b6076a5ea53@mail.gmail.com>
	<Pine.LNX.4.64.0702091253120.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 01:13:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFfrR-00086B-As
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 01:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946780AbXBJAM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 19:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946782AbXBJAM6
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 19:12:58 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34970 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946780AbXBJAM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 19:12:57 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210001257.YESE22948.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Feb 2007 19:12:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id McCv1W00f1kojtg0000000; Fri, 09 Feb 2007 19:12:56 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39202>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 9 Feb 2007, Marco Costalba wrote:
>> 
>> If I modify qgit in running 'git runstatus' as a fallback in case 'git
>> status' exits with an error (without checking what kind of error
>> exactly) could be an acceptable path or could hide subtle
>> side-effects? I have no the knowledge to answer this by hand.
>
> It's probably better for you to just
>
>  - run "git update-index --refresh" and don't care about the exit value
>  - run "git runstatus" unconditionally
>
> which should basically get you something working.

We could do "git runstatus --refresh", which only updates the
index in-core.

The patch does two things.

 - it changes the calling convention of run_diff_files() and
   run_diff_index(); earlier, they read the index on their own,
   but now we expect the caller to have populated the index by
   calling read_cache().

 - it adds --refresh flag to git-runstatus, and before
   git-runstatus calls read_cache() to satisfy the updated
   calling convention of run_diff_files() and run_diff_index(),
   it refreshes the in-core copy of index.

---
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 5d4a5c5..3ee2605 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -47,5 +47,9 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	if (rev.pending.nr ||
 	    rev.min_age != -1 || rev.max_age != -1)
 		usage(diff_files_usage);
+	if (read_cache() < 0) {
+		perror("read_cache");
+		return -1;
+	}
 	return run_diff_files(&rev, silent);
 }
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 95a3db1..083599d 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -38,5 +38,9 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	if (rev.pending.nr != 1 ||
 	    rev.max_count != -1 || rev.min_age != -1 || rev.max_age != -1)
 		usage(diff_cache_usage);
+	if (read_cache() < 0) {
+		perror("read_cache");
+		return -1;
+	}
 	return run_diff_index(&rev, cached);
 }
diff --git a/builtin-diff.c b/builtin-diff.c
index a659020..12d11f0 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -56,6 +56,10 @@ static int builtin_diff_files(struct rev_info *revs,
 	if (revs->max_count < 0 &&
 	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
 		revs->combine_merges = revs->dense_combined_merges = 1;
+	if (read_cache() < 0) {
+		perror("read_cache");
+		return -1;
+	}
 	return run_diff_files(revs, silent);
 }
 
@@ -151,6 +155,10 @@ static int builtin_diff_index(struct rev_info *revs,
 	    revs->max_count != -1 || revs->min_age != -1 ||
 	    revs->max_age != -1)
 		usage(builtin_diff_usage);
+	if (read_cache() < 0) {
+		perror("read_cache");
+		return -1;
+	}
 	return run_diff_index(revs, cached);
 }
 
diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index 4b489b1..df66742 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -4,7 +4,7 @@
 extern int wt_status_use_color;
 
 static const char runstatus_usage[] =
-"git-runstatus [--color|--nocolor] [--amend] [--verbose] [--untracked]";
+"git-runstatus [--color|--nocolor] [--refresh] [--amend] [--verbose] [--untracked]";
 
 int cmd_runstatus(int argc, const char **argv, const char *prefix)
 {
@@ -17,6 +17,8 @@ int cmd_runstatus(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++) {
 		if (!strcmp(argv[i], "--color"))
 			wt_status_use_color = 1;
+		else if (!strcmp(argv[i], "--refresh"))
+			s.refresh = 1;
 		else if (!strcmp(argv[i], "--nocolor"))
 			wt_status_use_color = 0;
 		else if (!strcmp(argv[i], "--amend")) {
diff --git a/diff-lib.c b/diff-lib.c
index 91cd877..278ba79 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -20,11 +20,7 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
 
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
-	entries = read_cache();
-	if (entries < 0) {
-		perror("read_cache");
-		return -1;
-	}
+	entries = active_nr;
 	for (i = 0; i < entries; i++) {
 		struct stat st;
 		unsigned int oldmode, newmode;
@@ -354,10 +350,6 @@ int run_diff_index(struct rev_info *revs, int cached)
 	if (!revs->ignore_merges)
 		match_missing = 1;
 
-	if (read_cache() < 0) {
-		perror("read_cache");
-		return -1;
-	}
 	mark_merge_entries();
 
 	ent = revs->pending.objects[0].item;
diff --git a/wt-status.c b/wt-status.c
index 5567868..58186d6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -47,17 +47,10 @@ void wt_status_prepare(struct wt_status *s)
 	unsigned char sha1[20];
 	const char *head;
 
+	memset(s, 0, sizeof(*s));
 	head = resolve_ref("HEAD", sha1, 0, NULL);
 	s->branch = head ? xstrdup(head) : NULL;
-
 	s->reference = "HEAD";
-	s->amend = 0;
-	s->verbose = 0;
-	s->untracked = 0;
-
-	s->commitable = 0;
-	s->workdir_dirty = 0;
-	s->workdir_untracked = 0;
 }
 
 static void wt_status_print_cached_header(const char *reference)
@@ -198,12 +191,22 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
 		wt_status_print_trailer();
 }
 
+static void wt_read_cache(struct wt_status *s)
+{
+	discard_cache();
+	read_cache();
+	if (s->refresh)
+		refresh_cache(0);
+}
+
 void wt_status_print_initial(struct wt_status *s)
 {
 	int i;
 	char buf[PATH_MAX];
 
-	read_cache();
+	wt_read_cache(s);
+	if (s->refresh)
+		refresh_cache(REFRESH_QUIET);
 	if (active_nr) {
 		s->commitable = 1;
 		wt_status_print_cached_header(NULL);
@@ -227,6 +230,7 @@ static void wt_status_print_updated(struct wt_status *s)
 	rev.diffopt.format_callback = wt_status_print_updated_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.diffopt.detect_rename = 1;
+	wt_read_cache(s);
 	run_diff_index(&rev, 1);
 }
 
@@ -238,6 +242,7 @@ static void wt_status_print_changed(struct wt_status *s)
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_print_changed_cb;
 	rev.diffopt.format_callback_data = s;
+	wt_read_cache(s);
 	run_diff_files(&rev, 0);
 }
 
@@ -294,6 +299,7 @@ static void wt_status_print_verbose(struct wt_status *s)
 	setup_revisions(0, NULL, &rev, s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename = 1;
+	wt_read_cache(s);
 	run_diff_index(&rev, 1);
 }
 
@@ -323,7 +329,6 @@ void wt_status_print(struct wt_status *s)
 	}
 	else {
 		wt_status_print_updated(s);
-		discard_cache();
 	}
 
 	wt_status_print_changed(s);
diff --git a/wt-status.h b/wt-status.h
index cfea4ae..680a0ca 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -15,6 +15,7 @@ struct wt_status {
 	int verbose;
 	int amend;
 	int untracked;
+	int refresh;
 	/* These are computed during processing of the individual sections */
 	int commitable;
 	int workdir_dirty;
