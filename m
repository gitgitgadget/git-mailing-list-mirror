From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Add --dirstat-by-file diff option
Date: Fri, 5 Sep 2008 22:27:35 +0300
Message-ID: <20080905192735.GA12853@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 21:29:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbgz8-0002TI-3r
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 21:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbYIET1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 15:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbYIET1h
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 15:27:37 -0400
Received: from zakalwe.fi ([80.83.5.154]:58580 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbYIET1h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 15:27:37 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 4B1612BC68; Fri,  5 Sep 2008 22:27:35 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95035>

--dirstat-by-file is the same as --dirstat, but it counts
"impacted files" instead of "impacted lines" (lines that
are added or removed).

The patch also cleans --cumulative option handling.
DIFF_OPT_CUMULATIVE_DIRSTAT is used instead of
DIFF_FORMAT_CUMULATIVE.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
This version takes notice of comments from Junio C Hamano and Jeff King.

Changes to earlier version:

* use --dirstat-by-file instead of --filedirstat

* cleaner handling of --cumulative

 Documentation/diff-options.txt |    3 +++
 diff.c                         |   18 +++++++++++++-----
 diff.h                         |    3 ++-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 1759386..039452b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -66,6 +66,9 @@ endif::git-format-patch[]
 	the "--cumulative" flag, which adds up percentages recursively
 	even when they have been already reported for a sub-directory.
 
+--dirstat-by-file[=limit]::
+	Same as --dirstat, but counts changed files instead of lines.
+
 --summary::
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
diff --git a/diff.c b/diff.c
index 135dec4..9b8010d 100644
--- a/diff.c
+++ b/diff.c
@@ -1078,7 +1078,7 @@ static void show_dirstat(struct diff_options *options)
 	dir.alloc = 0;
 	dir.nr = 0;
 	dir.percent = options->dirstat_percent;
-	dir.cumulative = options->output_format & DIFF_FORMAT_CUMULATIVE;
+	dir.cumulative = DIFF_OPT_TST(options, CUMULATIVE_DIRSTAT);
 
 	changed = 0;
 	for (i = 0; i < q->nr; i++) {
@@ -1110,9 +1110,13 @@ static void show_dirstat(struct diff_options *options)
 		/*
 		 * Original minus copied is the removed material,
 		 * added is the new material.  They are both damages
-		 * made to the preimage.
+		 * made to the preimage. In --dirstat-by-file mode, count
+		 * damaged files, not damaged lines. This is done by
+		 * counting only a single damaged line per file.
 		 */
 		damage = (p->one->size - copied) + added;
+		if (DIFF_OPT_TST(options, DIRSTAT_BY_FILE) && damage > 0)
+			damage = 1;
 
 		ALLOC_GROW(dir.files, dir.nr + 1, dir.alloc);
 		dir.files[dir.nr].name = name;
@@ -2472,9 +2476,13 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
 	else if (opt_arg(arg, 'X', "dirstat", &options->dirstat_percent))
 		options->output_format |= DIFF_FORMAT_DIRSTAT;
-	else if (!strcmp(arg, "--cumulative"))
-		options->output_format |= DIFF_FORMAT_CUMULATIVE;
-	else if (!strcmp(arg, "--check"))
+	else if (opt_arg(arg, 0, "dirstat-by-file", &options->dirstat_percent)) {
+		options->output_format |= DIFF_FORMAT_DIRSTAT;
+		DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
+	} else if (!strcmp(arg, "--cumulative")) {
+		options->output_format |= DIFF_FORMAT_DIRSTAT;
+		DIFF_OPT_SET(options, CUMULATIVE_DIRSTAT);
+	} else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
 		options->output_format |= DIFF_FORMAT_SUMMARY;
diff --git a/diff.h b/diff.h
index 50fb5dd..102c38c 100644
--- a/diff.h
+++ b/diff.h
@@ -31,7 +31,6 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_FORMAT_PATCH	0x0010
 #define DIFF_FORMAT_SHORTSTAT	0x0020
 #define DIFF_FORMAT_DIRSTAT	0x0040
-#define DIFF_FORMAT_CUMULATIVE	0x0080
 
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
@@ -64,6 +63,8 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_CHECK_FAILED        (1 << 16)
 #define DIFF_OPT_RELATIVE_NAME       (1 << 17)
 #define DIFF_OPT_IGNORE_SUBMODULES   (1 << 18)
+#define DIFF_OPT_CUMULATIVE_DIRSTAT  (1 << 19)
+#define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
-- 
1.6.0.1
