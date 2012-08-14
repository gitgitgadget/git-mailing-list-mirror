From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v3 03/16] Add svndump_init_fd to allow reading dumps from arbitrary FDs.
Date: Tue, 14 Aug 2012 21:13:05 +0200
Message-ID: <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:17:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Mc3-00035l-0r
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab2HNTRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:17:03 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44490 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740Ab2HNTRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:17:01 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so265503bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3qTDq8SCqf1nnsQm7gS3Om2jkuB0Lde+Bm7l6/5bDdw=;
        b=0WAjSfbAN93AwhjaZRorQNi5/b2BfrLQhdX6GHeMp4q012/GWMEWZxrBF1Yn3KDtSM
         ubxyWn4kJHWK+RsLE9dUBRBb1BgQHA5mCf03Nc7Np6Hin+At43aIvuivssFndfS9GCjj
         Belaex/s7JzsunSOjtz7D4GBOSYskwDdh6feZREX1pWgL23YHhguAsNSCRO3nyE/a46H
         jhOMSV79AjLTz3ilNuJE2hQRU2z0uvvmwm3lvylVh2QD5g83iiU7oeOnb+1e+yAwg+zE
         CYtfwt6geMDDgeq6YGbT9aW0CSqwBD4j9v71CGQ2zkkqjFcT7j4xg86Fugh0HG0nt5jF
         qfkQ==
Received: by 10.204.154.141 with SMTP id o13mr6687454bkw.72.1344971820386;
        Tue, 14 Aug 2012 12:17:00 -0700 (PDT)
Received: from localhost.localdomain (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id fu8sm1681583bkc.5.2012.08.14.12.16.55
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 12:16:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203427>

The existing function only allows reading from a filename or
from stdin. Allow passing of a FD and an additional FD for
the back report pipe. This allows us to retrieve the name of
the pipe in the caller.

Fixes the filename could be NULL bug.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
- dup input file descriptor, because buffer_deinit closes the fd.
 vcs-svn/svndump.c |   22 ++++++++++++++++++----
 vcs-svn/svndump.h |    1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 2b168ae..d81a078 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -468,11 +468,9 @@ void svndump_read(const char *url)
 		end_revision();
 }
 
-int svndump_init(const char *filename)
+static void init(int report_fd)
 {
-	if (buffer_init(&input, filename))
-		return error("cannot open %s: %s", filename, strerror(errno));
-	fast_export_init(REPORT_FILENO);
+	fast_export_init(report_fd);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
 	strbuf_init(&rev_ctx.log, 4096);
@@ -482,6 +480,22 @@ int svndump_init(const char *filename)
 	reset_dump_ctx(NULL);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
+	return;
+}
+
+int svndump_init(const char *filename)
+{
+	if (buffer_init(&input, filename))
+		return error("cannot open %s: %s", filename ? filename : "NULL", strerror(errno));
+	init(REPORT_FILENO);
+	return 0;
+}
+
+int svndump_init_fd(int in_fd, int back_fd)
+{
+	if(buffer_fdinit(&input, xdup(in_fd)))
+		return error("cannot open fd %d: %s", in_fd, strerror(errno));
+	init(xdup(back_fd));
 	return 0;
 }
 
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index df9ceb0..acb5b47 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -2,6 +2,7 @@
 #define SVNDUMP_H_
 
 int svndump_init(const char *filename);
+int svndump_init_fd(int in_fd, int back_fd);
 void svndump_read(const char *url);
 void svndump_deinit(void);
 void svndump_reset(void);
-- 
1.7.9.5
