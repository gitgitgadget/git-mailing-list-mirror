From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] run_diff_{files,index}(): update calling convention.
Date: Fri, 09 Feb 2007 18:51:40 -0800
Message-ID: <7vy7n6ohc3.fsf_-_@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
	<7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550702091235x74e44362gad5b9b6076a5ea53@mail.gmail.com>
	<Pine.LNX.4.64.0702091253120.8424@woody.linux-foundation.org>
	<7vmz3mq394.fsf@assigned-by-dhcp.cox.net>
	<7vejoyq330.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 03:51:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFiL8-00058a-CE
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 03:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbXBJCvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 21:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbXBJCvm
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 21:51:42 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41408 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbXBJCvl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 21:51:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210025140.NLWB1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Feb 2007 21:51:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Merf1W00p1kojtg0000000; Fri, 09 Feb 2007 21:51:40 -0500
In-Reply-To: <7vejoyq330.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 09 Feb 2007 16:16:35 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39205>

They used to open and read index themselves, but they now expect
their callers to do so.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * This is preparatoin for the next one...

 builtin-diff-files.c |    4 ++++
 builtin-diff-index.c |    4 ++++
 builtin-diff.c       |    8 ++++++++
 diff-lib.c           |   10 +---------
 wt-status.c          |   12 ++++++++++--
 5 files changed, 27 insertions(+), 11 deletions(-)

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
index 2879c3d..e346511 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -191,12 +191,18 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
 		wt_status_print_trailer();
 }
 
+static void wt_read_cache(struct wt_status *s)
+{
+	discard_cache();
+	read_cache();
+}
+
 void wt_status_print_initial(struct wt_status *s)
 {
 	int i;
 	char buf[PATH_MAX];
 
-	read_cache();
+	wt_read_cache(s);
 	if (active_nr) {
 		s->commitable = 1;
 		wt_status_print_cached_header(NULL);
@@ -220,6 +226,7 @@ static void wt_status_print_updated(struct wt_status *s)
 	rev.diffopt.format_callback = wt_status_print_updated_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.diffopt.detect_rename = 1;
+	wt_read_cache(s);
 	run_diff_index(&rev, 1);
 }
 
@@ -231,6 +238,7 @@ static void wt_status_print_changed(struct wt_status *s)
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_print_changed_cb;
 	rev.diffopt.format_callback_data = s;
+	wt_read_cache(s);
 	run_diff_files(&rev, 0);
 }
 
@@ -287,6 +295,7 @@ static void wt_status_print_verbose(struct wt_status *s)
 	setup_revisions(0, NULL, &rev, s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename = 1;
+	wt_read_cache(s);
 	run_diff_index(&rev, 1);
 }
 
@@ -316,7 +325,6 @@ void wt_status_print(struct wt_status *s)
 	}
 	else {
 		wt_status_print_updated(s);
-		discard_cache();
 	}
 
 	wt_status_print_changed(s);
-- 
1.5.0.rc4.26.gcc46
