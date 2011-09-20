From: Alexey Shumkin <zapped@mail.ru>
Subject: [PATCH] format-patch: cover letter does not respect i18n.commitencoding
Date: Tue, 20 Sep 2011 12:26:17 +0400
Message-ID: <1316507177-6403-1-git-send-email-zapped@mail.ru>
Cc: Alexey Shumkin <zapped@mail.ru>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 10:26:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5vez-0007za-G5
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 10:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169Ab1ITI02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 04:26:28 -0400
Received: from smtp17.mail.ru ([94.100.176.154]:51304 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028Ab1ITI00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 04:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Sender:Message-Id:Date:Subject:Cc:To:From; bh=kb7ETk8lywD/HrpEUhP1JmbqWFgkknVpryWmZcBuq8g=;
	b=jxLxmQsA0d4VwSPF+oanKCPpgdGsXqATzmPM9o/zhIJ85nrD12pfK9vNyXAT0rR0ExLKQ5sw+CzYCKiq78lSAhDseyGILSI+V8Tkv9aesPT8PWN26DaXB3YNyJjgZ3Ym;
Received: from [91.77.19.104] (port=35126 helo=zappedws)
	by smtp17.mail.ru with asmtp 
	id 1R5vep-0002TF-00; Tue, 20 Sep 2011 12:26:23 +0400
Received: from Alex by zappedws with local (Exim 4.76)
	(envelope-from <zapped@mail.ru>)
	id 1R5vem-0001fx-4b; Tue, 20 Sep 2011 12:26:20 +0400
X-Mailer: git-send-email 1.7.6.3.4.gf71f
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181742>

When we write a cover letter it is naturally enough to suppose
that we use the same encoding as we do commits in. So make
"format-patch --cover-letter" to use i18n.commitencoding setting
in "Content-Type" header of a cover letter instead of hard-coded "UTF-8".
Especially as cover letter contains shortlog and diffstat of patches
which can contain author names and file names in i18n.commitencoding.

Signed-off-by: Alexey Shumkin <zapped@mail.ru>
---
 builtin/log.c |    4 ++--
 log-tree.c    |   10 ++++++----
 log-tree.h    |    3 ++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5c2af59..6a4050c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -769,7 +769,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
 	int i;
-	const char *encoding = "UTF-8";
+	const char *encoding =  get_commit_output_encoding();
 	struct diff_options opts;
 	int need_8bit_cte = 0;
 	struct commit *commit = NULL;
@@ -806,7 +806,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	}
 
 	log_write_email_headers(rev, head, &pp.subject, &pp.after_subject,
-				&need_8bit_cte);
+				&need_8bit_cte, get_commit_output_encoding());
 
 	for (i = 0; !need_8bit_cte && i < nr; i++)
 		if (has_non_ascii(list[i]->buffer))
diff --git a/log-tree.c b/log-tree.c
index 39913d7..403aede 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -284,7 +284,8 @@ void get_patch_filename(struct commit *commit, int nr, const char *suffix,
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **subject_p,
 			     const char **extra_headers_p,
-			     int *need_8bit_cte_p)
+			     int *need_8bit_cte_p,
+			     const char *encoding)
 {
 	const char *subject = NULL;
 	const char *extra_headers = opt->extra_headers;
@@ -340,11 +341,12 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 "format.\n"
 			 "--%s%s\n"
 			 "Content-Type: text/plain; "
-			 "charset=UTF-8; format=fixed\n"
+			 "charset=%s; format=fixed\n"
 			 "Content-Transfer-Encoding: 8bit\n\n",
 			 extra_headers ? extra_headers : "",
 			 mime_boundary_leader, opt->mime_boundary,
-			 mime_boundary_leader, opt->mime_boundary);
+			 mime_boundary_leader, opt->mime_boundary,
+			 encoding);
 		extra_headers = subject_buffer;
 
 		get_patch_filename(opt->numbered_files ? NULL : commit, opt->nr,
@@ -433,7 +435,7 @@ void show_log(struct rev_info *opt)
 
 	if (opt->commit_format == CMIT_FMT_EMAIL) {
 		log_write_email_headers(opt, commit, &ctx.subject, &extra_headers,
-					&ctx.need_8bit_cte);
+					&ctx.need_8bit_cte, get_commit_output_encoding());
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), stdout);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
diff --git a/log-tree.h b/log-tree.h
index 5c4cf7c..ce0acf7 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -17,7 +17,8 @@ void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **subject_p,
 			     const char **extra_headers_p,
-			     int *need_8bit_cte_p);
+			     int *need_8bit_cte_p,
+			     const char *encoding);
 void load_ref_decorations(int flags);
 
 #define FORMAT_PATCH_NAME_MAX 64
-- 
1.7.6.3.4.gf71f
