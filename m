From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v6 03/16] Add svndump_init_fd to allow reading dumps from arbitrary FDs
Date: Wed, 22 Aug 2012 21:15:48 +0200
Message-ID: <1345662961-9587-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:16:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GQ8-0001Ql-0U
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033Ab2HVTQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:16:42 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53740 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965012Ab2HVTQf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:16:35 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so449687bkw.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 12:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=61bsyBjgvzC0LLn343FRLVlK2Jy+AdwBiZL3eIQ/M7g=;
        b=hyk7HNjp/FX8k6pWTgGEagqcTFVJHzhEKbzY/XzUu6CZZckNYTm+XtlDMdg9oUEqa/
         wHrtbGdfpG6D3byG5drsoVryXFKPzjQNiE6OZgTXlwanxyZ+9MoHek3zMy5RYVOy23WE
         Pf/qcatgyJ4OzFUHtYY7nyxtqMlrUP2l+/wyQA3SaKn5ujBQby1CnRyAJYCj9QemFv19
         8zJxjCGZ4PMiHfmbEJfG1sC11KQWMxmTFfMtFuAusyrOl71UmhmNdtch+/7ODjBqBOX9
         TIVGpyYq2y8HmS/VOxklT3+Y2ktc2G98VnErcIwTVoYktnoTd/8p56cgsu2i+2FG8dWs
         Cg9g==
Received: by 10.204.157.10 with SMTP id z10mr7107028bkw.63.1345662994598;
        Wed, 22 Aug 2012 12:16:34 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id ht18sm3346763bkc.16.2012.08.22.12.16.32
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 12:16:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345662961-9587-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204072>

The existing function only allows reading from a filename or from
stdin. Allow passing of a FD and an additional FD for the back report
pipe. This allows us to retrieve the name of the pipe in the caller.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
