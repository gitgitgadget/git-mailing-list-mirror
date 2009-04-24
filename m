From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 2/2] diff: color statistics (stat, shortstat, numstat)
Date: Sat, 25 Apr 2009 00:06:48 +0200
Message-ID: <1240610808-7285-2-git-send-email-markus.heidelberg@web.de>
References: <200904222313.50081.markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:08:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxTYv-000761-Mg
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 00:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbZDXWGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 18:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755559AbZDXWG3
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 18:06:29 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:59180 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754834AbZDXWG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 18:06:29 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 7D5CFFDA6E94;
	Sat, 25 Apr 2009 00:06:27 +0200 (CEST)
Received: from [89.59.109.160] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LxTXP-0008K9-00; Sat, 25 Apr 2009 00:06:27 +0200
X-Mailer: git-send-email 1.6.3.rc1.84.g1036b
In-Reply-To: <200904222313.50081.markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX195Hq0lVUkspWYfUIqz7yNZvR1gOOTZGymEH8ej
	BIoYzuJHUGzvVFckGMQMswZ3P5a9lg+9+1ld12rbmACdLk+5hF
	0VVAofNhRKGf4CDTYRCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117498>

stat/shortstat:
Color added and removed lines and the corresponding signs ('+' and '-')
in the summary.

numstat:
Color added and removed lines per file.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

    I didn't consider --summary and --name-status. Also in --stat it
    would be possible to color filenames in renames and copies and the
    mode in mode changes. Not sure if it would be nice or distracting.
    At least it wouldn't look so consistent, I think.

 diff.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index d581d4d..bc8377d 100644
--- a/diff.c
+++ b/diff.c
@@ -994,18 +994,24 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 		show_graph(options->file, '-', del, del_c, reset);
 		fprintf(options->file, "\n");
 	}
-	fprintf(options->file,
-	       " %d files changed, %d insertions(+), %d deletions(-)\n",
-	       total_files, adds, dels);
+	fprintf(options->file, " %d files changed, %s%d%s insertions(%s+%s), "
+						  "%s%d%s deletions(%s-%s)\n",
+				total_files, add_c, adds, reset, add_c, reset,
+					     del_c, dels, reset, del_c, reset);
 }
 
 static void show_shortstats(struct diffstat_t* data, struct diff_options *options)
 {
 	int i, adds = 0, dels = 0, total_files = data->nr;
+	const char *reset, *add_c, *del_c;
 
 	if (data->nr == 0)
 		return;
 
+	reset = diff_get_color_opt(options, DIFF_RESET);
+	add_c = diff_get_color_opt(options, DIFF_FILE_NEW);
+	del_c = diff_get_color_opt(options, DIFF_FILE_OLD);
+
 	for (i = 0; i < data->nr; i++) {
 		if (!data->files[i]->is_binary &&
 		    !data->files[i]->is_unmerged) {
@@ -1020,17 +1026,24 @@ static void show_shortstats(struct diffstat_t* data, struct diff_options *option
 			}
 		}
 	}
-	fprintf(options->file, " %d files changed, %d insertions(+), %d deletions(-)\n",
-	       total_files, adds, dels);
+	fprintf(options->file, " %d files changed, %s%d%s insertions(%s+%s), "
+						  "%s%d%s deletions(%s-%s)\n",
+				total_files, add_c, adds, reset, add_c, reset,
+					     del_c, dels, reset, del_c, reset);
 }
 
 static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 {
 	int i;
+	const char *reset, *add_c, *del_c;
 
 	if (data->nr == 0)
 		return;
 
+	reset = diff_get_color_opt(options, DIFF_RESET);
+	add_c = diff_get_color_opt(options, DIFF_FILE_NEW);
+	del_c = diff_get_color_opt(options, DIFF_FILE_OLD);
+
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 
@@ -1038,7 +1051,8 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 			fprintf(options->file, "-\t-\t");
 		else
 			fprintf(options->file,
-				"%d\t%d\t", file->added, file->deleted);
+				"%s%d%s\t%s%d%s\t", add_c, file->added, reset,
+						    del_c, file->deleted, reset);
 		if (options->line_termination) {
 			fill_print_name(file);
 			if (!file->is_renamed)
-- 
1.6.3.rc1.84.g1036b
