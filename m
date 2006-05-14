From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Add "--summary" option to git diff.
Date: Sun, 14 May 2006 08:13:49 -0400
Message-ID: <BAYC1-PASMTP0770FC4238970CB812C192AEA20@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 14 14:19:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfFZA-0008CW-QG
	for gcvg-git@gmane.org; Sun, 14 May 2006 14:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWENMTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 08:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWENMTS
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 08:19:18 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:31962 "EHLO
	BAYC1-PASMTP07.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751413AbWENMTR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 08:19:17 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP07.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 14 May 2006 05:22:27 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 18D28644C28
	for <git@vger.kernel.org>; Sun, 14 May 2006 08:19:15 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060514081349.12efe660.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 14 May 2006 12:22:27.0500 (UTC) FILETIME=[103B0EC0:01C67751]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Remove the need to pipe git diff through git apply to
get the extended headers summary.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

---

e5d981eef0203c399d8b1890be94add525eee969
 Documentation/diff-options.txt |    4 ++
 diff.c                         |   88 ++++++++++++++++++++++++++++++++++++++++
 diff.h                         |    3 +
 3 files changed, 93 insertions(+), 2 deletions(-)

e5d981eef0203c399d8b1890be94add525eee969
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c183dc9..f523ec2 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -10,6 +10,10 @@
 --stat::
 	Generate a diffstat instead of a patch.
 
+--summary::
+	Output a condensed summary of extended header information
+	such as creations, renames and mode changes.
+
 --patch-with-stat::
 	Generate patch and prepend its diffstat.
 
diff --git a/diff.c b/diff.c
index 7a7b839..00b1044 100644
--- a/diff.c
+++ b/diff.c
@@ -1233,6 +1233,8 @@ int diff_opt_parse(struct diff_options *
 	}
 	else if (!strcmp(arg, "--stat"))
 		options->output_format = DIFF_FORMAT_DIFFSTAT;
+	else if (!strcmp(arg, "--summary"))
+		options->summary = 1;
 	else if (!strcmp(arg, "--patch-with-stat")) {
 		options->output_format = DIFF_FORMAT_PATCH;
 		options->with_stat = 1;
@@ -1703,6 +1705,85 @@ static void flush_one_pair(struct diff_f
 	}
 }
 
+static void show_file_mode_name(const char *newdelete, struct diff_filespec *fs)
+{
+	if (fs->mode)
+		printf(" %s mode %06o %s\n", newdelete, fs->mode, fs->path);
+	else
+		printf(" %s %s\n", newdelete, fs->path);
+}
+
+
+static void show_mode_change(struct diff_filepair *p, int show_name)
+{
+	if (p->one->mode && p->two->mode && p->one->mode != p->two->mode) {
+		if (show_name)
+			printf(" mode change %06o => %06o %s\n",
+			       p->one->mode, p->two->mode, p->two->path);
+		else
+			printf(" mode change %06o => %06o\n",
+			       p->one->mode, p->two->mode);
+	}
+}
+
+static void show_rename_copy(const char *renamecopy, struct diff_filepair *p)
+{
+	const char *old, *new;
+
+	/* Find common prefix */
+	old = p->one->path;
+	new = p->two->path;
+	while (1) {
+		const char *slash_old, *slash_new;
+		slash_old = strchr(old, '/');
+		slash_new = strchr(new, '/');
+		if (!slash_old ||
+		    !slash_new ||
+		    slash_old - old != slash_new - new ||
+		    memcmp(old, new, slash_new - new))
+			break;
+		old = slash_old + 1;
+		new = slash_new + 1;
+	}
+	/* p->one->path thru old is the common prefix, and old and new
+	 * through the end of names are renames
+	 */
+	if (old != p->one->path)
+		printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
+		       (int)(old - p->one->path), p->one->path,
+		       old, new, (int)(0.5 + p->score * 100.0/MAX_SCORE));
+	else
+		printf(" %s %s => %s (%d%%)\n", renamecopy,
+		       p->one->path, p->two->path,
+		       (int)(0.5 + p->score * 100.0/MAX_SCORE));
+	show_mode_change(p, 0);
+}
+
+static void diff_summary(struct diff_filepair *p)
+{
+	switch(p->status) {
+	case DIFF_STATUS_DELETED:
+		show_file_mode_name("delete", p->one);
+		break;
+	case DIFF_STATUS_ADDED:
+		show_file_mode_name("create", p->two);
+		break;
+	case DIFF_STATUS_COPIED:
+		show_rename_copy("copy", p);
+		break;
+	case DIFF_STATUS_RENAMED:
+		show_rename_copy("rename", p);
+		break;
+	default:
+		if (p->score) {
+			printf(" rewrite %s (%d%%)\n", p->two->path,
+				(int)(0.5 + p->score * 100.0/MAX_SCORE));
+			show_mode_change(p, 0);
+		} else	show_mode_change(p, 1);
+		break;
+	}
+}
+
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -1736,7 +1817,6 @@ void diff_flush(struct diff_options *opt
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		flush_one_pair(p, diff_output_format, options, diffstat);
-		diff_free_filepair(p);
 	}
 
 	if (diffstat) {
@@ -1744,6 +1824,12 @@ void diff_flush(struct diff_options *opt
 		free(diffstat);
 	}
 
+	for (i = 0; i < q->nr; i++) {
+		if (options->summary)
+			diff_summary(q->queue[i]);
+		diff_free_filepair(q->queue[i]);
+	}
+
 	free(q->queue);
 	q->queue = NULL;
 	q->nr = q->alloc = 0;
diff --git a/diff.h b/diff.h
index d052608..70077c6 100644
--- a/diff.h
+++ b/diff.h
@@ -31,7 +31,8 @@ struct diff_options {
 		 binary:1,
 		 full_index:1,
 		 silent_on_remove:1,
-		 find_copies_harder:1;
+		 find_copies_harder:1,
+		 summary:1;
 	int break_opt;
 	int detect_rename;
 	int line_termination;
-- 
1.3.2.gab2a
