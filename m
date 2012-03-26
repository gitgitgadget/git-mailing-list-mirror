From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 3/4] grep: move code to print hunk markers after heading
Date: Sun, 25 Mar 2012 22:41:44 -0400
Message-ID: <1332729705-9283-4-git-send-email-lodatom@gmail.com>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 04:42:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBztG-0000YB-23
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 04:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358Ab2CZCme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 22:42:34 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:34124 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756205Ab2CZCmB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 22:42:01 -0400
Received: by mail-qa0-f53.google.com with SMTP id c11so1895985qad.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 19:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WphW9TuxYK/aZQiHM/R8TS4jk+Hyt9SC9ZdkX7/HQ5Q=;
        b=w7Ho81IopqB1zBDjwzwuJCPeBgRuLSLqIQTiVsyMklH8+I080GmBMfX92BrjLfUbHd
         /aMtmrWR4rdaj0tZnqtLWsG93sFwxu8cVx9B1dRgENQHQZWRZUk1Kk6k3uCoZhVOBeOS
         T/jBy+917Myr/8Q2ZqjetL0UTJXLIk1xBhiLTXRvLI1b6jNso7KnK+w+RUE1AolWdWbY
         rIALMdIWhNybJYChxfKVFMNAH+i8ZgZUmXzCo2QllPg56jdU32jXy6Tgm4iF98hM8fiF
         bEsYEcU6vm1daNshJA8NMrG1suPvPLMrIj+iDN60yZSYwYKciNLsAM47ca6JIofT7/38
         JYyg==
Received: by 10.229.136.77 with SMTP id q13mr7568001qct.154.1332729720937;
        Sun, 25 Mar 2012 19:42:00 -0700 (PDT)
Received: from mark.hsd1.dc.comcast.net. (c-76-21-213-235.hsd1.dc.comcast.net. [76.21.213.235])
        by mx.google.com with ESMTPS id fq1sm27711867qab.10.2012.03.25.19.41.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Mar 2012 19:42:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.4
In-Reply-To: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193890>

This commit does not have any effect on the output of the program.
The purpose is to distinguish in the code between two kinds of hunk
separators: those that occur before the heading and those that occur
after.  This step is necessary for the next commit, which will modify
only the latter tyep of hunk separators.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 grep.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/grep.c b/grep.c
index 190139c..14e0480 100644
--- a/grep.c
+++ b/grep.c
@@ -739,25 +739,26 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 {
 	int rest = eol - bol;
 	char *line_color = NULL;
+	int show_hunk = (opt->pre_context || opt->post_context ||
+			 opt->funcbody);
 
-	if (opt->file_break && opt->last_shown == 0) {
-		if (opt->show_hunk_mark)
-			opt->output(opt, "\n", 1);
-	} else if (opt->pre_context || opt->post_context || opt->funcbody) {
-		if (opt->last_shown == 0) {
-			if (opt->show_hunk_mark) {
-				output_color(opt, "--", 2, opt->color_sep);
-				opt->output(opt, "\n", 1);
-			}
-		} else if (lno > opt->last_shown + 1) {
+	if (opt->show_hunk_mark && opt->last_shown == 0 &&
+	    (opt->file_break || (opt->heading && show_hunk))) {
+		if (opt->heading && !opt->file_break)
 			output_color(opt, "--", 2, opt->color_sep);
-			opt->output(opt, "\n", 1);
-		}
+		opt->output(opt, "\n", 1);
+		show_hunk = 0;
 	}
 	if (opt->heading && opt->last_shown == 0) {
 		output_color(opt, name, strlen(name), opt->color_filename);
 		opt->output(opt, "\n", 1);
 	}
+	if (show_hunk &&
+	    ((opt->last_shown == 0 && opt->show_hunk_mark) ||
+	     (opt->last_shown != 0 && lno > opt->last_shown + 1))) {
+		output_color(opt, "--", 2, opt->color_sep);
+		opt->output(opt, "\n", 1);
+	}
 	opt->last_shown = lno;
 
 	if (!opt->heading && opt->pathname) {
-- 
1.7.9.2
