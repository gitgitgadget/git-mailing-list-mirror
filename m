From: Nate Case <ncase@xes-inc.com>
Subject: [PATCH] format-patch: Respect --quiet option
Date: Wed, 18 Mar 2009 12:00:45 -0500
Message-ID: <1237395645-22085-1-git-send-email-ncase@xes-inc.com>
Cc: Nate Case <ncase@xes-inc.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 18 18:48:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljzs2-0004IR-RG
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759058AbZCRRqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 13:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759140AbZCRRqg
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:46:36 -0400
Received: from xes-mad.com ([216.165.139.214]:39679 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759108AbZCRRqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 13:46:35 -0400
X-Greylist: delayed 2739 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2009 13:46:31 EDT
Received: from localhost.localdomain (natec.xes-mad.com [10.52.0.27])
	by xes-mad.com (8.13.8/8.13.8) with ESMTP id n2IH0jB7027155;
	Wed, 18 Mar 2009 12:00:47 -0500
X-Mailer: git-send-email 1.6.0.2
X-Virus-Scanned: ClamAV 0.94.2/9127/Tue Mar 17 23:30:26 2009 on mail.xes-mad.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=no version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mail.xes-mad.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113636>

Hide the patch filename output from 'git format-patch' when --quiet
is used.  The man pages suggested that this should have already worked.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 builtin-log.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 8684fcd..8af55d2 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -573,7 +573,7 @@ static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 static int outdir_offset;
 
-static int reopen_stdout(const char *oneline, int nr, int total)
+static int reopen_stdout(const char *oneline, int nr, struct rev_info *rev)
 {
 	char filename[PATH_MAX];
 	int len = 0;
@@ -598,7 +598,9 @@ static int reopen_stdout(const char *oneline, int nr, int total)
 		strcpy(filename + len, fmt_patch_suffix);
 	}
 
-	fprintf(realstdout, "%s\n", filename + outdir_offset);
+	if (!DIFF_OPT_TST(&rev->diffopt, QUIET))
+		fprintf(realstdout, "%s\n", filename + outdir_offset);
+
 	if (freopen(filename, "w", stdout) == NULL)
 		return error("Cannot open patch file %s",filename);
 
@@ -687,7 +689,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		die("Cover letter needs email format");
 
 	if (!use_stdout && reopen_stdout(numbered_files ?
-				NULL : "cover-letter", 0, rev->total))
+				NULL : "cover-letter", 0, rev))
 		return;
 
 	head_sha1 = sha1_to_hex(head->object.sha1);
@@ -1106,7 +1108,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 		if (!use_stdout && reopen_stdout(numbered_files ? NULL :
 				get_oneline_for_filename(commit, keep_subject),
-				rev.nr, rev.total))
+				rev.nr, &rev))
 			die("Failed to create output files");
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
-- 
1.6.0.2
