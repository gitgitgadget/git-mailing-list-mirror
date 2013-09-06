From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v5 2/6] wt-status: use argv_array API
Date: Fri,  6 Sep 2013 19:43:05 +0200
Message-ID: <1378489389-25802-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
 <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 06 19:43:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI04H-00016q-Ct
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961Ab3IFRnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:43:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44228 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab3IFRna (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:43:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r86HhKfw001274
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Sep 2013 19:43:20 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VI042-0000b7-C9; Fri, 06 Sep 2013 19:43:22 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VI042-0006jL-2d; Fri, 06 Sep 2013 19:43:22 +0200
X-Mailer: git-send-email 1.8.4.5.g8688bea
In-Reply-To: <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 06 Sep 2013 19:43:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r86HhKfw001274
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1379094204.01169@1yoZlRwbkh9s2qV1gp9D5w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234072>

No behavior change, but two slight code reorganization: argv_array_push
doesn't accept NULL strings, and duplicates its argument hence
summary_limit must be written to before being inserted into argv.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index cb24f1f..958a53c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -8,6 +8,7 @@
 #include "diffcore.h"
 #include "quote.h"
 #include "run-command.h"
+#include "argv-array.h"
 #include "remote.h"
 #include "refs.h"
 #include "submodule.h"
@@ -663,29 +664,30 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	char summary_limit[64];
 	char index[PATH_MAX];
 	const char *env[] = { NULL, NULL };
-	const char *argv[8];
-
-	env[0] =	index;
-	argv[0] =	"submodule";
-	argv[1] =	"summary";
-	argv[2] =	uncommitted ? "--files" : "--cached";
-	argv[3] =	"--for-status";
-	argv[4] =	"--summary-limit";
-	argv[5] =	summary_limit;
-	argv[6] =	uncommitted ? NULL : (s->amend ? "HEAD^" : "HEAD");
-	argv[7] =	NULL;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	sprintf(summary_limit, "%d", s->submodule_summary);
 	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", s->index_file);
 
+	env[0] = index;
+	argv_array_push(&argv, "submodule");
+	argv_array_push(&argv, "summary");
+	argv_array_push(&argv, uncommitted ? "--files" : "--cached");
+	argv_array_push(&argv, "--for-status");
+	argv_array_push(&argv, "--summary-limit");
+	argv_array_push(&argv, summary_limit);
+	if (!uncommitted)
+		argv_array_push(&argv, s->amend ? "HEAD^" : "HEAD");
+
 	memset(&sm_summary, 0, sizeof(sm_summary));
-	sm_summary.argv = argv;
+	sm_summary.argv = argv.argv;
 	sm_summary.env = env;
 	sm_summary.git_cmd = 1;
 	sm_summary.no_stdin = 1;
 	fflush(s->fp);
 	sm_summary.out = dup(fileno(s->fp));    /* run_command closes it */
 	run_command(&sm_summary);
+	argv_array_clear(&argv);
 }
 
 static void wt_status_print_other(struct wt_status *s,
-- 
1.8.4.5.g8688bea
