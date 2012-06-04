From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 3/4] Add svndump_init_fd to allow reading dumps from arbitrary FDs.
Date: Mon,  4 Jun 2012 19:20:54 +0200
Message-ID: <1338830455-3091-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 19:21:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbayJ-0003FD-6O
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab2FDRV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:21:29 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42845 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab2FDRV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:21:27 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so3818518bkc.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+QkcbyVTIWCrzAisMD/ZMYRs5n7Ep2cbDqGl6cwd+Bk=;
        b=ZcMCU3dsAxpWgpTCCiyVc7XOWfYELg0O0piAehe+qxIpk+cjlvnWuOs8hA4jpIFc2n
         bQvQ+jqEYE7t6hBNIUiPB1HKQs0HxHcm3vqRPx9t211NoAUKRI3pPek7HMiF6HyXuc/r
         cLIxgDWeh6XaQ9rQyc7qtuPU0pPkzo1fESutdyvosKCKylncwAl+1wMSYAbxx6lny1BQ
         /uPDzXVB4j7vHXzq3QVDVTuTy7+JjeNL442AmecbjEclEANxPmNli/MkkF7cLbhVBISF
         ywNjdpvomvSoRRzO8gj/kbhkgS8j4O2VF0WEbIWKF8MSzod+WYqm1Y34/GBU9pE71Z+M
         chgw==
Received: by 10.204.157.23 with SMTP id z23mr7498968bkw.71.1338830486813;
        Mon, 04 Jun 2012 10:21:26 -0700 (PDT)
Received: from flobuntu.lan (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id m2sm11224637bkm.2.2012.06.04.10.21.25
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 10:21:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1338830455-3091-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199156>

The existing function only allowed reading from a filename or
from stdin.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 vcs-svn/svndump.c |   20 +++++++++++++++++---
 vcs-svn/svndump.h |    1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 0899790..2f0089f 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -465,10 +465,8 @@ void svndump_read(const char *url)
 		end_revision();
 }
 
-int svndump_init(const char *filename)
+static void init()
 {
-	if (buffer_init(&input, filename))
-		return error("cannot open %s: %s", filename, strerror(errno));
 	fast_export_init(REPORT_FILENO);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
@@ -479,6 +477,22 @@ int svndump_init(const char *filename)
 	reset_dump_ctx(NULL);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
+	return;
+}
+
+int svndump_init(const char *filename)
+{
+	if (buffer_init(&input, filename))
+		return error("cannot open %s: %s", filename, strerror(errno));
+	init();
+	return 0;
+}
+
+int svndump_init_fd(int in_fd)
+{
+	if(buffer_fdinit(&input, in_fd))
+		return error("cannot open fd %d: %s", in_fd, strerror(errno));
+	init();
 	return 0;
 }
 
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index df9ceb0..24e7beb 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -2,6 +2,7 @@
 #define SVNDUMP_H_
 
 int svndump_init(const char *filename);
+int svndump_init_fd(int in_fd);
 void svndump_read(const char *url);
 void svndump_deinit(void);
 void svndump_reset(void);
-- 
1.7.9.5
