From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/9] git stat: show traditional status headers and trailers
 as well
Date: Sat, 15 Aug 2009 15:39:53 -0700
Message-ID: <1250375997-10657-6-git-send-email-gitster@pobox.com>
References: <1250375997-10657-1-git-send-email-gitster@pobox.com>
 <1250375997-10657-2-git-send-email-gitster@pobox.com>
 <1250375997-10657-3-git-send-email-gitster@pobox.com>
 <1250375997-10657-4-git-send-email-gitster@pobox.com>
 <1250375997-10657-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 00:40:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McRvc-0003is-JB
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 00:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbZHOWkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 18:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbZHOWkL
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 18:40:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbZHOWkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 18:40:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D26C2AA89
	for <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9EB9C2AA88 for
 <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:10 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.227.g1d720
In-Reply-To: <1250375997-10657-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 976D2430-89EC-11DE-90A6-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126041>

Also honor -v to show the "diff --cached" output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Fix-up to 3/9; will be squashed in the final round to remove the trace
   of ill conceived wt_status_print_body() refactoring.

 builtin-commit.c |    8 +++++++-
 wt-status.c      |   27 +++++++++------------------
 wt-status.h      |    1 -
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 7120876..8db0365 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -352,6 +352,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn,
 		      struct wt_status *s)
 {
+	unsigned char sha1[20];
+
 	if (s->relative_paths)
 		s->prefix = prefix;
 
@@ -363,7 +365,9 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->index_file = index_file;
 	s->fp = fp;
 	s->nowarn = nowarn;
+	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
 
+	wt_status_collect(s);
 	wt_status_print(s);
 
 	return s->commitable;
@@ -903,6 +907,7 @@ int cmd_stat(int argc, const char **argv, const char *prefix)
 	struct wt_status s;
 	unsigned char sha1[20];
 	static struct option builtin_stat_options[] = {
+		OPT__VERBOSE(&verbose),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
 		  "mode",
 		  "show untracked files, optional modes: all, normal, no. (Default: all)",
@@ -922,13 +927,14 @@ int cmd_stat(int argc, const char **argv, const char *prefix)
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	wt_status_collect(&s);
 
+	s.verbose = verbose;
 	if (s.relative_paths)
 		s.prefix = prefix;
 	if (s.use_color == -1)
 		s.use_color = git_use_color_default;
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
-	wt_status_print_body(&s);
+	wt_status_print(&s);
 	return 0;
 }
 
diff --git a/wt-status.c b/wt-status.c
index c887a90..c55be53 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -531,25 +531,10 @@ static void wt_status_print_tracking(struct wt_status *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 }
 
-void wt_status_print_body(struct wt_status *s)
-{
-	wt_status_print_unmerged(s);
-	wt_status_print_updated(s);
-	wt_status_print_changed(s);
-	if (s->submodule_summary)
-		wt_status_print_submodule_summary(s);
-	if (s->show_untracked_files)
-		wt_status_print_untracked(s);
-	else if (s->commitable)
-		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
-}
-
 void wt_status_print(struct wt_status *s)
 {
-	unsigned char sha1[20];
 	const char *branch_color = color(WT_STATUS_HEADER, s);
 
-	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
 	if (s->branch) {
 		const char *on_what = "On branch ";
 		const char *branch_name = s->branch;
@@ -566,15 +551,21 @@ void wt_status_print(struct wt_status *s)
 			wt_status_print_tracking(s);
 	}
 
-	wt_status_collect(s);
-
 	if (s->is_initial) {
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "# Initial commit");
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 	}
 
-	wt_status_print_body(s);
+	wt_status_print_unmerged(s);
+	wt_status_print_updated(s);
+	wt_status_print_changed(s);
+	if (s->submodule_summary)
+		wt_status_print_submodule_summary(s);
+	if (s->show_untracked_files)
+		wt_status_print_untracked(s);
+	else if (s->commitable)
+		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
 
 	if (s->verbose)
 		wt_status_print_verbose(s);
diff --git a/wt-status.h b/wt-status.h
index ab52ce1..a0e7517 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -54,6 +54,5 @@ struct wt_status {
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
-void wt_status_print_body(struct wt_status *s);
 
 #endif /* STATUS_H */
-- 
1.6.4.224.g3be84
