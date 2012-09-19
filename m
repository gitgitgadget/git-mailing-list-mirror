From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v8 03/16] Add svndump_init_fd to allow reading dumps from arbitrary FDs
Date: Wed, 19 Sep 2012 17:21:17 +0200
Message-ID: <1348068090-31988-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1348068090-31988-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:22:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEM6u-0005ul-R9
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 17:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764Ab2ISPWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 11:22:31 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64575 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552Ab2ISPW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 11:22:29 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so596995bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TqoJOcJr+7Ysoigyyb/MtmOJcqHH8WFB8sHrqCNcorM=;
        b=bUfYOshTyhn3qlb3H4uGIX5oqnrDykAnzCJT5CV05Gx1XCrO9rKM3d0kXPqKJM1UqU
         q9UTU50pWp7CoH97p3e0/X8Bx1Dlv2FwLnYqh5BcGH/PBJObP5IisjqVCludxxwjG29F
         syqSqcNMJv+j+DYSDwztLkFehSBsElXVRbAKZA49lL0Zjng4nlQf5s0SMvQAaKB+Yt1U
         NBbdSM51mIF/miRl+Ew27hNEHCCZAXvqHA0MlAl9rGItRJcc8InbN6XIW0vIyCbbqbjL
         vGTq9x2/Z+5Cn9iYEwVqalgBpFs7wwYKqPGP9er9rFgmt7e8CXHBNaJpQ5eKFScnsJo6
         Yoag==
Received: by 10.204.152.13 with SMTP id e13mr1472375bkw.10.1348068148964;
        Wed, 19 Sep 2012 08:22:28 -0700 (PDT)
Received: from flobuntu.lan (91-115-94-56.adsl.highway.telekom.at. [91.115.94.56])
        by mx.google.com with ESMTPS id d13sm1570686bkw.12.2012.09.19.08.22.27
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 08:22:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348068090-31988-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205930>

The existing function only allows reading from a filename or from
stdin. Allow passing of a FD and an additional FD for the back report
pipe. This allows us to retrieve the name of the pipe in the caller.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
no diff

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
