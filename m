From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH] add new options to git format-patch: --cover-subject and --cover-blurb
Date: Fri,  5 Feb 2010 16:39:33 -0500
Message-ID: <1265405973-5670-1-git-send-email-larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 22:39:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVtv-0003Mc-02
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933862Ab0BEVjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 16:39:36 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:53278 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933814Ab0BEVjf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 16:39:35 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id BA35782217D; Fri,  5 Feb 2010 16:39:34 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139097>

This is useful because if you're preparing a patch series with a cover letter
you can easily put together one line to format and email the whole thing to
yourself.  You check to make sure everything is right, and then just change the
recipient address and run it again.

git send-email --to my@mydomain.org  master..HEAD --cover-letter \
    --cover-subject "this is my patch series" --cover-blurb "$(cat blurb.txt)"

check the results in my inbox

git send-email --to git@vger.kernel.org  master..HEAD --cover-letter \
    --cover-subject "this is my patch series" --cover-blurb "$(cat blurb.txt)"

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 Documentation/git-format-patch.txt |    8 ++++++++
 builtin-log.c                      |   15 +++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 9674f9d..522c56f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -176,6 +176,14 @@ will want to ensure that threading is disabled for `git send-email`.
 	containing the shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--cover-subject=<subject>
+	Instead of using *** SUBJECT HERE ***, specify the subject line of the
+	cover letter.
+
+--cover-blurb=<blurb>
+	Instead of using *** BLURB HERE ***, specify a blurb for the body of the
+	cover letter.
+
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
diff --git a/builtin-log.c b/builtin-log.c
index 8d16832..e7ae37e 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -452,6 +452,8 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 
 /* format-patch */
 
+static const char *cover_subject = "*** SUBJECT HERE ***";
+static const char *cover_blurb = "*** BLURB HERE ***";
 static const char *fmt_patch_suffix = ".patch";
 static int numbered = 0;
 static int auto_number = 1;
@@ -647,7 +649,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 {
 	const char *committer;
 	const char *subject_start = NULL;
-	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
 	const char *msg;
 	const char *extra_headers = rev->extra_headers;
 	struct shortlog log;
@@ -695,12 +696,15 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		if (has_non_ascii(list[i]->buffer))
 			need_8bit_cte = 1;
 
-	msg = body;
 	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
 		     encoding);
+
+	msg = cover_subject;
 	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
 		      encoding, need_8bit_cte);
+	msg = cover_blurb;
 	pp_remainder(CMIT_FMT_EMAIL, &msg, &sb, 0);
+
 	printf("%s\n", sb.buf);
 
 	strbuf_release(&sb);
@@ -913,6 +917,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    "print patches to standard out"),
 		OPT_BOOLEAN(0, "cover-letter", &cover_letter,
 			    "generate a cover letter"),
+		OPT_STRING(0, "cover-subject", &cover_subject, "subject",
+				   "use <subject> in the subject line of the cover letter"),
+		OPT_STRING(0, "cover-blurb", &cover_blurb, "blurb",
+				   "use <blurb> in the body of the cover letter"),
 		OPT_BOOLEAN(0, "numbered-files", &numbered_files,
 			    "use simple number sequence for output file names"),
 		OPT_STRING(0, "suffix", &fmt_patch_suffix, "sfx",
@@ -1048,6 +1056,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
 		die("--check does not make sense");
 
+	if (strchr(cover_subject, '\n'))
+		die("--cover-subject can not contain newlines");
+
 	if (!use_patch_format &&
 		(!rev.diffopt.output_format ||
 		 rev.diffopt.output_format == DIFF_FORMAT_PATCH))
-- 
1.7.0.rc1.33.g07cf0f.dirty
