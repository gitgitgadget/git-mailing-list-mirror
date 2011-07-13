From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 02/11] test-svn-fe: use parse-options
Date: Wed, 13 Jul 2011 18:21:04 +0600
Message-ID: <1310559673-5026-3-git-send-email-divanorama@gmail.com>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 14:20:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgyR1-0004Ap-AI
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab1GMMU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 08:20:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35552 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab1GMMUy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 08:20:54 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4787045bwd.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rLmWUFQSZ6KUxw3tNw6GMxtUGfuRafCiYz5IrpXjA2o=;
        b=r5X9VmUQunsBTLSXPvJ+p5EtmReUyUUssixNfoWDKsGiMYb7imCB8VAGPDI9+fOpo1
         RoiiiU9GSsuPBUzV4rBAlLncOp5LAO3+8osVTd3oKhX5raen/ZE8Guwbb7n3JFPkPB6l
         a9n+HSadOnjpr+cEdGPXZorAXe2gL8HKUvF34=
Received: by 10.204.40.136 with SMTP id k8mr555865bke.15.1310559654180;
        Wed, 13 Jul 2011 05:20:54 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id c8sm1653987bkc.15.2011.07.13.05.20.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 05:20:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177026>

There was custom options parsing. As more options arise it will
be easier to add and document new options with parse-options api.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 test-svn-fe.c |   42 ++++++++++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/test-svn-fe.c b/test-svn-fe.c
index 332a5f7..0aab245 100644
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
-		if (svndump_init(argv[1]))
+	argc = parse_options(argc, argv, NULL, test_svnfe_options,
+						test_svnfe_usage, 0);
+
+	if (d)
+		return apply_delta(argc, argv);
+
+	if (argc == 1) {
+		if (svndump_init(argv[0]))
 			return 1;
 		svndump_read(NULL);
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
