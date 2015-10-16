From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH v2 2/4] stripspace: Use parse-options for command-line parsing
Date: Fri, 16 Oct 2015 17:16:43 +0200
Message-ID: <1445008605-16534-3-git-send-email-tklauser@distanz.ch>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 17:17:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn6ki-000388-Ox
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 17:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbbJPPQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 11:16:51 -0400
Received: from mail.zhinst.com ([212.126.164.98]:36622 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186AbbJPPQt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 11:16:49 -0400
Received: from ziws06.zhinst.com ([10.42.0.71])
	by mail.zhinst.com (Kerio Connect 8.5.2);
	Fri, 16 Oct 2015 17:16:45 +0200
X-Mailer: git-send-email 2.6.1.148.g7927db1
In-Reply-To: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279746>

Use parse-options to parse command-line options instead of a
hand-crafted implementation.

This is a preparatory patch to simplify the introduction of the
--count-lines option in a follow-up patch.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 builtin/stripspace.c | 56 ++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index f677093..ac1ab3d 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "parse-options.h"
 #include "strbuf.h"
 
 static void comment_lines(struct strbuf *buf)
@@ -12,41 +13,44 @@ static void comment_lines(struct strbuf *buf)
 	free(msg);
 }
 
-static const char *usage_msg = "\n"
-"  git stripspace [-s | --strip-comments] < input\n"
-"  git stripspace [-c | --comment-lines] < input";
+static const char * const stripspace_usage[] = {
+	N_("git stripspace [-s | --strip-comments] < input"),
+	N_("git stripspace [-c | --comment-lines] < input"),
+	NULL
+};
+
+enum stripspace_mode {
+	STRIP_DEFAULT = 0,
+	STRIP_COMMENTS,
+	COMMENT_LINES
+};
 
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int strip_comments = 0;
-	enum { INVAL = 0, STRIP_SPACE = 1, COMMENT_LINES = 2 } mode = STRIP_SPACE;
-
-	if (argc == 2) {
-		if (!strcmp(argv[1], "-s") ||
-		    !strcmp(argv[1], "--strip-comments")) {
-			strip_comments = 1;
-		} else if (!strcmp(argv[1], "-c") ||
-			   !strcmp(argv[1], "--comment-lines")) {
-			mode = COMMENT_LINES;
-		} else {
-			mode = INVAL;
-		}
-	} else if (argc > 1) {
-		mode = INVAL;
-	}
-
-	if (mode == INVAL)
-		usage(usage_msg);
-
-	if (strip_comments || mode == COMMENT_LINES)
+	enum stripspace_mode mode = STRIP_DEFAULT;
+
+	const struct option options[] = {
+		OPT_CMDMODE('s', "strip-comments", &mode,
+			    N_("skip and remove all lines starting with comment character"),
+			    STRIP_COMMENTS),
+		OPT_CMDMODE('c', "comment-lines", &mode,
+			    N_("prepend comment character and blank to each line"),
+			    COMMENT_LINES),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, stripspace_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES)
 		git_config(git_default_config, NULL);
 
 	if (strbuf_read(&buf, 0, 1024) < 0)
 		die_errno("could not read the input");
 
-	if (mode == STRIP_SPACE)
-		strbuf_stripspace(&buf, strip_comments);
+	if (mode == STRIP_DEFAULT || mode == STRIP_COMMENTS)
+		strbuf_stripspace(&buf, mode == STRIP_COMMENTS);
 	else
 		comment_lines(&buf);
 
-- 
2.6.1.148.g7927db1
