From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 03/16] Add svndump_init_fd to allow reading dumps from arbitrary FDs
Date: Mon, 20 Aug 2012 23:52:09 +0200
Message-ID: <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:53:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ZuY-0008Es-1U
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858Ab2HTVxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:13 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:60643 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743Ab2HTVxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:09 -0400
Received: by wibhq12 with SMTP id hq12so3844314wib.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=61bsyBjgvzC0LLn343FRLVlK2Jy+AdwBiZL3eIQ/M7g=;
        b=eLHajgNyDwbniG3OhFs+7COZIjx/SaRW/kQPUm5Xy6lwEFK7Vv9o6TkhkaVrAfHQ6u
         29sg/W1tu2E8mMdtyWR+03FKhoAKGN2t6JWgKFmJVk3UtMKP7+fHwTmItJJeuS2Lyl0D
         mIcfcc4B0zJyzGOZdBHyDt2t0wUrxYdKu4XC23h9cyxX7T36Sizwx9DOTeNu5hgs/SR4
         htDsjaA4vwNnlMfLSe7X8SB8aHpzGhxTWEST9IBOmEF3NE1JKyzCCYwmpRdf3fNfzyKE
         M+T8pBjz4uQG/SY+hR/uEgGh8md120Qi25PrfktOnOpAtR6zrL0fOBvNMt65kOMK5nMa
         ebjQ==
Received: by 10.180.78.135 with SMTP id b7mr32168332wix.11.1345499588007;
        Mon, 20 Aug 2012 14:53:08 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.06
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203881>

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
