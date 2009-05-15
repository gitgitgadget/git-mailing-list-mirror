From: Joe Perches <joe@perches.com>
Subject: [RFC PATCH] builtin-log: Add options to --coverletter
Date: Thu, 14 May 2009 17:57:21 -0700
Message-ID: <1242349041.646.8.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 02:57:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4ljz-0007LZ-EH
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 02:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbZEOA5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 20:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbZEOA5X
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 20:57:23 -0400
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:1043 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbZEOA5W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 20:57:22 -0400
Received: from [192.168.1.158] ([192.168.1.158])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id RAA04427
	for <git@vger.kernel.org>; Thu, 14 May 2009 17:57:04 -0700
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119241>

Currently the coverletter options for wrapping long lines
in the shortlog are: on, wrap as position72, with fixed indents.

I think these defaults can produce poor looking output.

This patch allows these to be optionally specified on the
command line with --cover-letter[=wrap[,pos[,in1[,in2]]]]

I'm not sure this is the right approach though.

Suggestions?

diff --git a/builtin-log.c b/builtin-log.c
index 5eaec5d..de26c04 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -460,6 +460,11 @@ static void add_header(const char *value)
 static int thread = 0;
 static int do_signoff = 0;
 
+static int coverletter_wrap = 1;
+static int coverletter_wraplen = 72;
+static int coverletter_indent1 = 2;
+static int coverletter_indent2 = 4;
+
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
@@ -668,10 +673,10 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	strbuf_release(&sb);
 
 	shortlog_init(&log);
-	log.wrap_lines = 1;
-	log.wrap = 72;
-	log.in1 = 2;
-	log.in2 = 4;
+	log.wrap_lines = coverletter_wrap;
+	log.wrap = coverletter_wraplen;
+	log.in1 = coverletter_indent1;
+	log.in2 = coverletter_indent2;
 	for (i = 0; i < nr; i++)
 		shortlog_add_commit(&log, list[i]);
 
@@ -866,8 +871,17 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			rev.subject_prefix = argv[i] + 17;
 		} else if (!prefixcmp(argv[i], "--suffix="))
 			fmt_patch_suffix = argv[i] + 9;
-		else if (!strcmp(argv[i], "--cover-letter"))
+		else if (!prefixcmp(argv[i], "--cover-letter")) {
 			cover_letter = 1;
+			if (*(argv[i] + 14) == '=') {
+				if (sscanf(argv[i] + 15, "%d,%d,%d,%d",
+					   &coverletter_wrap,
+					   &coverletter_wraplen,
+					   &coverletter_indent1,
+					   &coverletter_indent2) <= 0)
+					die("Need options for --cover-letter=");
+			}
+		}
 		else if (!strcmp(argv[i], "--no-binary"))
 			no_binary_diff = 1;
 		else if (!prefixcmp(argv[i], "--add-header="))
