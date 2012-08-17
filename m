From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v4 03/16] Add svndump_init_fd to allow reading dumps from arbitrary FDs.
Date: Fri, 17 Aug 2012 22:25:44 +0200
Message-ID: <1345235157-702-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:27:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T8H-0005Xc-K2
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758885Ab2HQU0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:26:51 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47144 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758858Ab2HQU0r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:26:47 -0400
Received: by wgbdr13 with SMTP id dr13so3663355wgb.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dZxE5l2lOxqBwnSLROg/pJOn8Ryvu/1p+Vhm0K57qkM=;
        b=I7b79FkvL6EY8jfoJ/RKEvka/96fi12Am1iU8Wr5w3M/uawNQHTOkpBoFhk/w3BZ4g
         2k88ZLhXrBjotAdVM83ZVklf7JCb2NkmhowGQjeEFjwem1Z00sIf8IiCd2Gl/MXDpK5p
         1l+Kfa68jeYnnLwXtZRkpGFjGs0nKS/F71WP2HSMK157PpodRZHCVzjt0VaXzBm2OsWT
         22mUlgt/onta1tQXtK/pbjUQBgY6juR1vUsyhIu4ktxmdwG5fGajGS/mx6E3sbLG9siG
         SBjuHnWKi1RaA+8K+5/8I2NbpDCzl+qTkyHRvqvpcrT3Q08H57jvRDvldri1tJoJMLYh
         oUxw==
Received: by 10.180.79.229 with SMTP id m5mr7758375wix.13.1345235206340;
        Fri, 17 Aug 2012 13:26:46 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id k2sm17372232wiz.7.2012.08.17.13.26.44
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:26:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345235157-702-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203645>

The existing function only allows reading from a filename or
from stdin. Allow passing of a FD and an additional FD for
the back report pipe. This allows us to retrieve the name of
the pipe in the caller.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
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
