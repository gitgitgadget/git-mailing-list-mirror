From: Michel Marti <mma@objectxp.com>
Subject: [PATCH] Allow git-runstatus to limit its scope to a set of files/directories.
Date: Sat, 27 Oct 2007 20:08:39 +0200
Message-ID: <1193508519-14140-1-git-send-email-mma@objectxp.com>
References: <ffofbm@ger.gmane.org>
Cc: Michel Marti <mma@objectxp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 20:20:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlqH1-0004Ci-OS
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 20:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbXJ0SU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 14:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbXJ0SU1
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 14:20:27 -0400
Received: from automatix.objectxp.com ([62.2.156.210]:56305 "EHLO
	automatix.objectxp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbXJ0SU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 14:20:26 -0400
X-Greylist: delayed 705 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Oct 2007 14:20:25 EDT
Received: from max.office.objectxp.com (max.office.objectxp.com [192.168.0.56])
	by automatix.objectxp.com (Postfix) with ESMTP id 9A8685801665;
	Sat, 27 Oct 2007 20:08:39 +0200 (CEST)
Received: by max.office.objectxp.com (Postfix, from userid 1000)
	id 91F2A628091; Sat, 27 Oct 2007 20:08:39 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.396.g767d-dirty
In-Reply-To: <ffofbm@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62506>

Signed-off-by: Michel Marti <mma@objectxp.com>
---
IMO, the next step should be to tweak git-status/git-commit: I suggest 
introducing a new option '--what-if' to 'git-commit' that behaves like current
'git-status [<path>...]' and in return stop 'git-status' from displaying 
'[<path>...]'  as "Changes to commit".

 Documentation/git-runstatus.txt |    6 +++++-
 builtin-runstatus.c             |    5 ++++-
 wt-status.c                     |   13 ++++++++++++-
 wt-status.h                     |    1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-runstatus.txt b/Documentation/git-runstatus.txt
index dee5d0d..ddf83ae 100644
--- a/Documentation/git-runstatus.txt
+++ b/Documentation/git-runstatus.txt
@@ -8,7 +8,7 @@ git-runstatus - A helper for git-status and git-commit
 
 SYNOPSIS
 --------
-'git-runstatus' [--color|--nocolor] [--amend] [--verbose] [--untracked]
+'git-runstatus' [--color|--nocolor] [--amend] [--verbose] [--untracked] [<path>...]
 
 
 DESCRIPTION
@@ -47,6 +47,10 @@ OPTIONS
 	option only its name and a trailing slash are displayed
 	for each untracked directory.
 
+<path>...::
+	The <path> parameters, when given, are used to limit
+	the status to the named path(s).
+
 
 OUTPUT
 ------
diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index 2db25c8..6acc92f 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -5,7 +5,7 @@
 extern int wt_status_use_color;
 
 static const char runstatus_usage[] =
-"git-runstatus [--color|--nocolor] [--amend] [--verbose] [--untracked]";
+"git-runstatus [--color|--nocolor] [--amend] [--verbose] [--untracked] [<path>...]";
 
 int cmd_runstatus(int argc, const char **argv, const char *prefix)
 {
@@ -16,6 +16,8 @@ int cmd_runstatus(int argc, const char **argv, const char *prefix)
 	wt_status_prepare(&s);
 
 	for (i = 1; i < argc; i++) {
+		if (argv[i][0] != '-')
+			break;
 		if (!strcmp(argv[i], "--color"))
 			wt_status_use_color = 1;
 		else if (!strcmp(argv[i], "--nocolor"))
@@ -32,6 +34,7 @@ int cmd_runstatus(int argc, const char **argv, const char *prefix)
 			usage(runstatus_usage);
 	}
 
+	s.pathspec = argc > i ? get_pathspec(prefix, argv+i) : NULL;
 	wt_status_print(&s);
 	return s.commitable ? 0 : 1;
 }
diff --git a/wt-status.c b/wt-status.c
index 10ce6ee..e40e0d2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -228,6 +228,7 @@ static void wt_status_print_updated(struct wt_status *s)
 	rev.diffopt.format_callback_data = s;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
+	rev.prune_data = s->pathspec;
 	wt_read_cache(s);
 	run_diff_index(&rev, 1);
 }
@@ -240,6 +241,7 @@ static void wt_status_print_changed(struct wt_status *s)
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_print_changed_cb;
 	rev.diffopt.format_callback_data = s;
+	rev.prune_data = s->pathspec;
 	wt_read_cache(s);
 	run_diff_files(&rev, 0);
 }
@@ -248,7 +250,8 @@ static void wt_status_print_untracked(struct wt_status *s)
 {
 	struct dir_struct dir;
 	const char *x;
-	int i;
+	int i, specs;
+	char *seen;
 	int shown_header = 0;
 
 	memset(&dir, 0, sizeof(dir));
@@ -264,11 +267,19 @@ static void wt_status_print_untracked(struct wt_status *s)
 	if (excludes_file && file_exists(excludes_file))
 		add_excludes_from_file(&dir, excludes_file);
 
+	for (specs = 0; s->pathspec && s->pathspec[specs];  specs++)
+		/* nothing */;
+	if (specs)
+		seen = xcalloc(specs, 1);
+
 	read_directory(&dir, ".", "", 0, NULL);
 	for(i = 0; i < dir.nr; i++) {
 		/* check for matching entry, which is unmerged; lifted from
 		 * builtin-ls-files:show_other_files */
 		struct dir_entry *ent = dir.entries[i];
+		if (specs &&
+		    !match_pathspec(s->pathspec, ent->name, ent->len, 0, seen))
+				continue;
 		int pos = cache_name_pos(ent->name, ent->len);
 		struct cache_entry *ce;
 		if (0 <= pos)
diff --git a/wt-status.h b/wt-status.h
index cfea4ae..1153e87 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -15,6 +15,7 @@ struct wt_status {
 	int verbose;
 	int amend;
 	int untracked;
+	const char **pathspec;
 	/* These are computed during processing of the individual sections */
 	int commitable;
 	int workdir_dirty;
-- 
1.5.3.4.316.g8a37e
