From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] diff: add --no-diff-deleted to make -p more pleasant
Date: Sun, 29 Jan 2006 06:24:04 -0800
Message-ID: <20060129142403.GA15482@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 29 15:24:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3DTR-0003ao-3T
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 15:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWA2OYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 09:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWA2OYH
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 09:24:07 -0500
Received: from hand.yhbt.net ([66.150.188.102]:50643 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1751001AbWA2OYG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 09:24:06 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id 500442DC033
	for <git@vger.kernel.org>; Sun, 29 Jan 2006 06:24:04 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sun, 29 Jan 2006 06:24:04 -0800
To: git list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15221>

This is a feature I've stol^Wborrowed from svn that I find very
useful since I usually don't care to see what I've deleted.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 diff.c |    6 ++++++
 diff.h |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

0b426af15a7da4f430d9cca8c1ad057557d93627
diff --git a/diff.c b/diff.c
index f45d18c..6db3e19 100644
--- a/diff.c
+++ b/diff.c
@@ -769,6 +769,7 @@ void diff_setup(struct diff_options *opt
 {
 	memset(options, 0, sizeof(*options));
 	options->output_format = DIFF_FORMAT_RAW;
+	options->diff_deleted = 1;
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
@@ -849,6 +850,8 @@ int diff_opt_parse(struct diff_options *
 	}
 	else if (!strcmp(arg, "--find-copies-harder"))
 		options->find_copies_harder = 1;
+	else if (!strcmp(arg, "--no-diff-deleted"))
+		options->diff_deleted = 0;
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
 	else if (!strncmp(arg, "--abbrev=", 9)) {
@@ -1103,6 +1106,9 @@ int diff_unmodified_pair(struct diff_fil
 
 static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 {
+	if (!o->diff_deleted && (p->status == DIFF_STATUS_DELETED))
+		return;
+
 	if (diff_unmodified_pair(p))
 		return;
 
diff --git a/diff.h b/diff.h
index 9a0169c..4f320ac 100644
--- a/diff.h
+++ b/diff.h
@@ -39,6 +39,7 @@ struct diff_options {
 	int find_copies_harder;
 	int line_termination;
 	int output_format;
+	int diff_deleted;
 	int pickaxe_opts;
 	int rename_score;
 	int reverse_diff;
@@ -120,6 +121,8 @@ extern void diffcore_std_no_resolve(stru
 "  -C            detect copies.\n" \
 "  --find-copies-harder\n" \
 "                try unchanged files as candidate for copy detection.\n" \
+"  --no-diff-deleted\n" \
+"                do not print patch format for deleted files\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
 "  -S<string>    find filepair whose only one side contains the string.\n" \
-- 
1.1.5.gae18-dirty
