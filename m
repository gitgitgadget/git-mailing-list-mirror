From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 03/16] Add svndump_init_fd to allow reading dumps from arbitrary FDs.
Date: Mon, 30 Jul 2012 16:31:10 +0200
Message-ID: <1343658683-10713-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 16:40:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svr8m-0008J8-Ac
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab2G3OjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:39:19 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39226 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723Ab2G3OjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:39:16 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2859087bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7vmSDQzkNv9mlb25Ylt+wksSOpuwd1DOqsmIkoQNw/M=;
        b=Zce3oNRo+8hxzORSlV2iiwZRs90kKKeCy1DlZ/yFh4ah+HovLORWBe064kAX0A8NDf
         2q95bMQynJoDS3NaT8+VBo0OAyPWmxOqU7T36ifvwwPZy8/+iuy9fCMUvUdsQ6RbesXq
         cpeI2TPnm0sZlAmZnuN+84OeBzqvh49eWgBud4pN/9wNA2UnhzY/XdQri3cyhlt7tEsX
         wBDwuxNUGgZJn/PgNzPuejpIaSprPCidUyI027FY3CYjhS1bx1zbuWheDOt+FNxnsr6Y
         NSo1px3THHVYUcHm8ev37JqLzqKTZXazaNUvLY4u8tuFd8blfYa59UgovlVugFSFWGur
         CGDQ==
Received: by 10.204.156.17 with SMTP id u17mr4091826bkw.52.1343659155889;
        Mon, 30 Jul 2012 07:39:15 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm3945866bkc.5.2012.07.30.07.39.13
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 07:39:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202559>

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
