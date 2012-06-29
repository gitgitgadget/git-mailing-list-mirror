From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 3/4 v2] Add svndump_init_fd to allow reading dumps from arbitrary FDs.
Date: Fri, 29 Jun 2012 09:59:23 +0200
Message-ID: <1790879.5n53DiMT9G@flobuntu>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1374057.qfvOg1c6C6@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 10:01:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkW8f-0002YR-QA
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 10:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab2F2IBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 04:01:09 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50678 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab2F2IBH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 04:01:07 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so2723356bkc.19
        for <git@vger.kernel.org>; Fri, 29 Jun 2012 01:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=jVL1kk2/AepgxiK4EpfQYTbPd73fOhpvTv6D3lrevYc=;
        b=oXxOR0kTS0hMNYfyTLSupaXITGtTVPL2zYin3gDwCPj9UuLbLcmq9b3OlJ+kiDtd9I
         PFp/DQoaZ0A/FBzljWp5S0YNDkFjSbF6M/ZJGg7eEbTuFS0GgW68NyDrW3PCivAv9cyM
         v2DVnNAGavLEfTCokrxzL7ydj2z2c7h7PPkok51qWBdtKWSBVuIymXK04j1eSFSy2axl
         kDLwH+tkPCuoB1RvXaK4q8yKLZs5USMX3ekdJqHhsnJbOg2z1koMQUS85WcF9n+1YBTc
         3Y2iLfV0zliDHdd6tmaDMw7T3SWIRVn00i+YexQTeYsCuwsazCSlYJVnangmWww/DbiJ
         kajg==
Received: by 10.205.133.6 with SMTP id hw6mr190785bkc.93.1340956866568;
        Fri, 29 Jun 2012 01:01:06 -0700 (PDT)
Received: from flobuntu.localnet (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id fu14sm1825747bkc.13.2012.06.29.01.01.04
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jun 2012 01:01:05 -0700 (PDT)
User-Agent: KMail/4.8.3 (Linux/3.2.0-26-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <1374057.qfvOg1c6C6@flobuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200806>

The existing function only allowed reading from a filename or
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
index 0899790..eb76bf8 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -465,11 +465,9 @@ void svndump_read(const char *url)
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
