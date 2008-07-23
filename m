From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 9/9] builtin-mailinfo.c: use parse_options()
Date: Wed, 23 Jul 2008 23:42:12 +0200
Message-ID: <1216849332-26813-10-git-send-email-barra_cuda@katamail.com>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 23:37:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm1d-00026o-3c
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842AbYGWVgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754933AbYGWVgE
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:36:04 -0400
Received: from smtp.katamail.com ([62.149.157.154]:37090 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755004AbYGWVf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:35:58 -0400
Received: (qmail 11651 invoked by uid 89); 23 Jul 2008 21:35:49 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.10)
  by smtp2-pc with SMTP; 23 Jul 2008 21:35:48 -0000
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89780>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-mailinfo.c |   39 +++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index f974b9d..f1ed269 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -6,6 +6,7 @@
 #include "builtin.h"
 #include "utf8.h"
 #include "strbuf.h"
+#include "parse-options.h"
 
 static FILE *cmitmsg, *patchfile, *fin, *fout;
 
@@ -905,8 +906,10 @@ static int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
 	return 0;
 }
 
-static const char mailinfo_usage[] =
-	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] msg patch <mail >info";
+static const char * const mailinfo_usage[] = {
+	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] msg patch <mail >info",
+	NULL
+};
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
@@ -920,22 +923,22 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	def_charset = (git_commit_encoding ? git_commit_encoding : "utf-8");
 	metainfo_charset = def_charset;
 
-	while (1 < argc && argv[1][0] == '-') {
-		if (!strcmp(argv[1], "-k"))
-			keep_subject = 1;
-		else if (!strcmp(argv[1], "-u"))
-			metainfo_charset = def_charset;
-		else if (!strcmp(argv[1], "-n"))
-			metainfo_charset = NULL;
-		else if (!prefixcmp(argv[1], "--encoding="))
-			metainfo_charset = argv[1] + 11;
-		else
-			usage(mailinfo_usage);
-		argc--; argv++;
-	}
+	const struct option options[] = {
+		OPT_BOOLEAN('k', NULL, &keep_subject,
+			    "keep subject, don't clean it up"),
+		OPT_SET_PTR('u', NULL, &metainfo_charset,
+			    "re-code in UTF-8", (intptr_t)def_charset),
+		OPT_SET_PTR('n', NULL, &metainfo_charset,
+			    "disable re-coding", (intptr_t)NULL),
+		OPT_STRING(0, "encoding", &metainfo_charset,
+			   "encoding", "override default encoding"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, options, mailinfo_usage, 0);
 
-	if (argc != 3)
-		usage(mailinfo_usage);
+	if (argc != 2)
+		usage_with_options(mailinfo_usage, options);
 
-	return !!mailinfo(stdin, stdout, keep_subject, metainfo_charset, argv[1], argv[2]);
+	return !!mailinfo(stdin, stdout, keep_subject, metainfo_charset, argv[0], argv[1]);
 }
-- 
1.5.6.3
