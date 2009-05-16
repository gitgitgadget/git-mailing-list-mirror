From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] builtin-log: Add options to --coverletter
Date: Fri, 15 May 2009 17:46:36 -0700
Message-ID: <1242434796.4070.2.camel@Joe-Laptop.home>
References: <1242349041.646.8.camel@Joe-Laptop.home>
	 <7v63g2tewu.fsf@alter.siamese.dyndns.org>
	 <1242418762.3373.90.camel@Joe-Laptop.home>
	 <7vljoyrq4z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 02:47:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M583U-0008B2-NF
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 02:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbZEPAqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 20:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755118AbZEPAqs
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 20:46:48 -0400
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:2522 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbZEPAqr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 20:46:47 -0400
Received: from [192.168.1.158] ([192.168.1.158])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id RAA13711;
	Fri, 15 May 2009 17:46:19 -0700
In-Reply-To: <7vljoyrq4z.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119308>

Perhaps this?

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/git-format-patch.txt     |   13 +++++++++++++
 builtin-log.c                          |   22 ++++++++++++++++++----
 contrib/completion/git-completion.bash |    1 +
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6f1fc80..f6b34ff 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -20,6 +20,8 @@ SYNOPSIS
 		   [--subject-prefix=Subject-Prefix]
 		   [--cc=<email>]
 		   [--cover-letter]
+		   [--cover-letter-wrap=width[,indent1[,indent2]]]
+		   [--no-cover-letter-wrap]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
 
@@ -168,6 +170,17 @@ if that is not set.
 	containing the shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--cover-letter-wrap=<width>[,<indent1>[,<indent2>]]]::
+	Linewrap the cover-letter shortlog output by wrapping each line at
+	`width`.  The first line of each entry is indented by `indent1`
+	spaces, and the second and subsequent lines are indented by
+	`indent2` spaces.
+	`width`, `indent1`, and `indent2` default to 72, 2 and 4 respectively.
+
+--no-cover-letter-wrap::
+	Do not linewrap the cover-letter shortlog output.
+	indent is fixed at 6.
+
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
diff --git a/builtin-log.c b/builtin-log.c
index 5eaec5d..271cbc1 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -460,6 +460,11 @@ static void add_header(const char *value)
 static int thread = 0;
 static int do_signoff = 0;
 
+static int cover_letter_wrap = 1;
+static int cover_letter_wrappos = 72;
+static int cover_letter_indent1 = 2;
+static int cover_letter_indent2 = 4;
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
+	log.wrap_lines = cover_letter_wrap;
+	log.wrap = cover_letter_wrappos;
+	log.in1 = cover_letter_indent1;
+	log.in2 = cover_letter_indent2;
 	for (i = 0; i < nr; i++)
 		shortlog_add_commit(&log, list[i]);
 
@@ -868,6 +873,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			fmt_patch_suffix = argv[i] + 9;
 		else if (!strcmp(argv[i], "--cover-letter"))
 			cover_letter = 1;
+		else if (!strcmp(argv[i], "--no-cover-letter-wrap"))
+			cover_letter_wrap = 0;
+		else if (!prefixcmp(argv[i], "--cover-letter-wrap=")) {
+			if (sscanf(argv[i] + 20, "%d,%d,%d",
+				   &cover_letter_wrappos,
+				   &cover_letter_indent1,
+				   &cover_letter_indent2) <= 0)
+				die("Need options for --cover-letter-wrap=");
+			}
 		else if (!strcmp(argv[i], "--no-binary"))
 			no_binary_diff = 1;
 		else if (!prefixcmp(argv[i], "--add-header="))
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ad26b7c..2f5c42b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -969,6 +969,7 @@ _git_format_patch ()
 			--full-index --binary
 			--not --all
 			--cover-letter
+			--no-cover-letter-wrap --cover-letter-wrap=
 			--no-prefix --src-prefix= --dst-prefix=
 			--inline --suffix= --ignore-if-in-upstream
 			--subject-prefix=
-- 
1.6.3.1.9.g95405b.dirty
