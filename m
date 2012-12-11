From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 5/5] log: Add --use-mailmap option
Date: Tue, 11 Dec 2012 23:21:33 +0100
Message-ID: <1355264493-8298-6-git-send-email-apelisse@gmail.com>
References: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Rich Midwinter <rich.midwinter@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 23:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiYDn-0001al-OM
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 23:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031Ab2LKWWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 17:22:20 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36132 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193Ab2LKWWS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 17:22:18 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so2773356wib.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 14:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uxxAHhR6emsniqc7NyfA32No8uul1+BPyZkA2QPanLU=;
        b=bTuNjjsemKpLkZ9Xc5rTt8CeqdhWTZI3JnU5+QC55VJf6w5LPqVo3PzlvYj2cv3fBH
         Urni0totXKVMw3SuvvvqAL/7F4I0WWZArXsZQ5esOmKKQuHUMi2lUS8gVLdlB1egRlAy
         nB7uDA/0S9qqB/1lNtNn+yb8AKcpNxZvZKTaLdYw3jMc7x+FCsluZTZ9zb02Cxvu1i7O
         mCz2Eose9CMemN0o+cktQxicqPJG83AVEkaWjJ2frTe9oL9L8y0tjknWvI0+O88e+jjg
         70vtua1siNVH0uPa9OTYfqPTxZ9GTkbMg91+g8luKIA91XiUhw9OLRxvp1VRvsS2dFEr
         7xDA==
Received: by 10.194.76.99 with SMTP id j3mr3145847wjw.47.1355264537580;
        Tue, 11 Dec 2012 14:22:17 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id ec3sm610033wib.10.2012.12.11.14.22.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2012 14:22:17 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.5.g7e0651a
In-Reply-To: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211308>

Add the --use-mailmap option to log commands. It allows
to display names from mailmap file when displaying logs,
whatever the format used.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 builtin/log.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index e7b7db1..d2bd8ce 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -22,6 +22,7 @@
 #include "branch.h"
 #include "streaming.h"
 #include "version.h"
+#include "mailmap.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -94,11 +95,12 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	struct userformat_want w;
-	int quiet = 0, source = 0;
+	int quiet = 0, source = 0, mailmap = 0;
 
 	const struct option builtin_log_options[] = {
 		OPT_BOOLEAN(0, "quiet", &quiet, N_("suppress diff output")),
 		OPT_BOOLEAN(0, "source", &source, N_("show source")),
+		OPT_BOOLEAN(0, "use-mailmap", &mailmap, N_("Use mail map file")),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
 		  PARSE_OPT_OPTARG, decorate_callback},
 		OPT_END()
@@ -136,6 +138,11 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (source)
 		rev->show_source = 1;
 
+	if (mailmap) {
+		rev->mailmap = xcalloc(1, sizeof(struct string_list));
+		read_mailmap(rev->mailmap, NULL);
+	}
+
 	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
 		/*
 		 * "log --pretty=raw" is special; ignore UI oriented
-- 
1.8.1.rc1.5.g7e0651a
