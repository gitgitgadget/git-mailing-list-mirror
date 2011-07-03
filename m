From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 1/8] vcs-svn: move url parameter from _read to _init
Date: Sun,  3 Jul 2011 23:57:50 +0600
Message-ID: <1309715877-13814-2-git-send-email-divanorama@gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 19:56:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdQuW-0001vs-Fy
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 19:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab1GCR4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jul 2011 13:56:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62342 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab1GCR4m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 13:56:42 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so3614734bwd.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 10:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/3RNMQKok7Yy4XwUgIHkvRyHuBIkxK4wQoq9r/7QKAw=;
        b=ZiMWb08ES/JkTf4ezKv1tJwatWzj2m6LzOgmSTCJzKfvoWa8b/KWUOP6wcCiEgqfGU
         A0wLrGyTIyY7Npband5MAI5ibl/+JwQdgB+vPcyvvexFEOAlGIvrfCVCBgJOTo2s5MYX
         KLfUsl6jbVn6goMYIIykq0iOBi/WJYk6C15+Y=
Received: by 10.204.40.136 with SMTP id k8mr5034265bke.15.1309715801625;
        Sun, 03 Jul 2011 10:56:41 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id af13sm4841383bkc.19.2011.07.03.10.56.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 10:56:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176577>

svndump_read takes a url parameter that is used in git-svn-id: lines
generation. Internally it is stored in dump_ctx which is initialized
in svndump_init with reset_dump_ctx and then is reinitialized again
in svndump_read.

Move url parameter to svndump_init so that reset_dump_ctx is done
once per dump and in the same place as other resets. More parameters
will arise and all will go to svndump_init to setup the module for
dumping.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/svn-fe.c |    4 ++--
 test-svn-fe.c           |    4 ++--
 vcs-svn/svndump.c       |    7 +++----
 vcs-svn/svndump.h       |    4 ++--
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 35db24f..11d7128 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -8,9 +8,9 @@
 
 int main(int argc, char **argv)
 {
-	if (svndump_init(NULL))
+	if (svndump_init(NULL, (argc > 1) ? argv[1] : NULL))
 		return 1;
-	svndump_read((argc > 1) ? argv[1] : NULL);
+	svndump_read();
 	svndump_deinit();
 	svndump_reset();
 	return 0;
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 332a5f7..3ee5559 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -40,9 +40,9 @@ static int apply_delta(int argc, char *argv[])
 int main(int argc, char *argv[])
 {
 	if (argc == 2) {
-		if (svndump_init(argv[1]))
+		if (svndump_init(argv[1], NULL))
 			return 1;
-		svndump_read(NULL);
+		svndump_read();
 		svndump_deinit();
 		svndump_reset();
 		return 0;
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index b1f4161..a88d392 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -313,14 +313,13 @@ static void end_revision(void)
 		fast_export_end_commit(rev_ctx.revision);
 }
 
-void svndump_read(const char *url)
+void svndump_read(void)
 {
 	char *val;
 	char *t;
 	uint32_t active_ctx = DUMP_CTX;
 	uint32_t len;
 
-	reset_dump_ctx(url);
 	while ((t = buffer_read_line(&input))) {
 		val = strchr(t, ':');
 		if (!val)
@@ -455,7 +454,7 @@ void svndump_read(const char *url)
 		end_revision();
 }
 
-int svndump_init(const char *filename)
+int svndump_init(const char *filename, const char *url)
 {
 	if (buffer_init(&input, filename))
 		return error("cannot open %s: %s", filename, strerror(errno));
@@ -466,7 +465,7 @@ int svndump_init(const char *filename)
 	strbuf_init(&rev_ctx.author, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(NULL);
+	reset_dump_ctx(url);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	return 0;
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index df9ceb0..1bcaab6 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -1,8 +1,8 @@
 #ifndef SVNDUMP_H_
 #define SVNDUMP_H_
 
-int svndump_init(const char *filename);
-void svndump_read(const char *url);
+int svndump_init(const char *filename, const char *url);
+void svndump_read(void);
 void svndump_deinit(void);
 void svndump_reset(void);
 
-- 
1.7.3.4
