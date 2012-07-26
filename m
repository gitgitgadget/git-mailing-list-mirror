From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 03/16] Add svndump_init_fd to allow reading dumps from arbitrary FDs.
Date: Thu, 26 Jul 2012 09:32:24 +0200
Message-ID: <1343287957-22040-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:34:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIam-0004t5-Ua
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab2GZHe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:34:27 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab2GZHe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:26 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7vmSDQzkNv9mlb25Ylt+wksSOpuwd1DOqsmIkoQNw/M=;
        b=jQUCT222ygGEoCMtOLw21kNoL78JdWJNczkFWae93IaPH+nHT7P23hJVJ+DuFjKTGn
         /qmr7C7xc7meYAmh7hdgFsh5etY635WwP9Qjwj5vqrXl+SF7NKfprAzVH7Bl9E9aXvl+
         tboo0DA+5pvnSAPdiMN2UnbCDoCKHdCJN98nkC29CL+y2wWb7aqtVa/t/Cz2fmVimIaQ
         amkAoB//ZdkpuZ5tnaYjei2oc3n57YQlnG6PAUU2hajFml1oR6077iUVvEIqW0v4ALSL
         hDbeYN65pQtpxSXxgm6lyW0dCIR5MQ775H6vR7Xqb1PW8r2Mb7aqIy2/Zo/qekUExLQB
         3qnA==
Received: by 10.204.152.220 with SMTP id h28mr13224511bkw.30.1343288065044;
        Thu, 26 Jul 2012 00:34:25 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.23
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202234>

The existing function only allows reading from a filename or
from stdin. Allow passing of a FD and an additional FD for
the back report pipe. This allows us to retrieve the name of
the pipe in the caller.

Fixes the filename could be NULL bug.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 vcs-svn/svndump.c |   22 ++++++++++++++++++----
 vcs-svn/svndump.h |    1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 2b168ae..76b42b2 100644
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
+	if(buffer_fdinit(&input, in_fd))
+		return error("cannot open fd %d: %s", in_fd, strerror(errno));
+	init(back_fd);
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
