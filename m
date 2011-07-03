From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 5/8] test-svn-fe: use parse-options
Date: Sun,  3 Jul 2011 23:57:54 +0600
Message-ID: <1309715877-13814-6-git-send-email-divanorama@gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 19:57:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdQuu-00025S-D3
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 19:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431Ab1GCR4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jul 2011 13:56:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40345 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab1GCR4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 13:56:50 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so3614757bwd.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Xrm/jFuMR6Kc4XKJ1M/qhr60h0dRURDhZItK7HiyaS8=;
        b=lggStJG+ymi/r81V5fZNdKJrLoRoPbSPtF3G8UP9AI3E+jtmyKEi4/FlR1QxuHKohf
         mlp3P2/aojpKY7izjJK2MB1iRvVYaBq2iwGL8S1GM0t8w1C2MFUQf/TznrT0IMxGcD/r
         tE2emttdwdXYjo6ZfN99hsZ6MxlsAchw+knbE=
Received: by 10.204.9.197 with SMTP id m5mr5129839bkm.38.1309715809291;
        Sun, 03 Jul 2011 10:56:49 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id af13sm4841383bkc.19.2011.07.03.10.56.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 10:56:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176585>

There was custom options parsing. As more options arise it will
be easier to add and document new options with parse-options api.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 test-svn-fe.c |   42 ++++++++++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/test-svn-fe.c b/test-svn-fe.c
index 3ee5559..603d3fb 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -3,28 +3,38 @@
  */
 
 #include "git-compat-util.h"
+#include "parse-options.h"
 #include "vcs-svn/svndump.h"
 #include "vcs-svn/svndiff.h"
 #include "vcs-svn/sliding_window.h"
 #include "vcs-svn/line_buffer.h"
 
-static const char test_svnfe_usage[] =
-	"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
+static const char * const test_svnfe_usage[] = {
+	"test-svn-fe (<dumpfile> | -d <preimage> <delta> <len>)",
+	NULL
+};
 
-static int apply_delta(int argc, char *argv[])
+static int d;
+
+static struct option test_svnfe_options[] = {
+	OPT_SET_INT('d', NULL, &d, "test apply_delta", 1),
+	OPT_END()
+};
+
+static int apply_delta(int argc, const char *argv[])
 {
 	struct line_buffer preimage = LINE_BUFFER_INIT;
 	struct line_buffer delta = LINE_BUFFER_INIT;
 	struct sliding_view preimage_view = SLIDING_VIEW_INIT(&preimage, -1);
 
-	if (argc != 5)
-		usage(test_svnfe_usage);
+	if (argc != 3)
+		usage_with_options(test_svnfe_usage, test_svnfe_options);
 
-	if (buffer_init(&preimage, argv[2]))
+	if (buffer_init(&preimage, argv[0]))
 		die_errno("cannot open preimage");
-	if (buffer_init(&delta, argv[3]))
+	if (buffer_init(&delta, argv[1]))
 		die_errno("cannot open delta");
-	if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
+	if (svndiff0_apply(&delta, (off_t) strtoull(argv[2], NULL, 0),
 					&preimage_view, stdout))
 		return 1;
 	if (buffer_deinit(&preimage))
@@ -37,10 +47,16 @@ static int apply_delta(int argc, char *argv[])
 	return 0;
 }
 
-int main(int argc, char *argv[])
+int main(int argc, const char *argv[])
 {
-	if (argc == 2) {
-		if (svndump_init(argv[1], NULL))
+	argc = parse_options(argc, argv, NULL, test_svnfe_options,
+						test_svnfe_usage, 0);
+
+	if (d)
+		return apply_delta(argc, argv);
+
+	if (argc == 1) {
+		if (svndump_init(argv[0], NULL))
 			return 1;
 		svndump_read();
 		svndump_deinit();
@@ -48,7 +64,5 @@ int main(int argc, char *argv[])
 		return 0;
 	}
 
-	if (argc >= 2 && !strcmp(argv[1], "-d"))
-		return apply_delta(argc, argv);
-	usage(test_svnfe_usage);
+	usage_with_options(test_svnfe_usage, test_svnfe_options);
 }
-- 
1.7.3.4
