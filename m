From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 8/8] vcs-svn: allow to disable 'progress' lines
Date: Sun,  3 Jul 2011 23:57:57 +0600
Message-ID: <1309715877-13814-9-git-send-email-divanorama@gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 19:57:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdQuv-00025S-Gk
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 19:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658Ab1GCR5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jul 2011 13:57:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62342 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab1GCR4z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 13:56:55 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so3614734bwd.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SDzfYZ3ORXcHXCkRWvC/nT2DOlbH2evL4yQ7yCHepys=;
        b=xJGtCmFw6/CdRqv71gS7XtVRSH/gKHNJZRIB90dmpqQFU8bgIXb97Hl9KuDxuAPfKf
         T7yvMTF6sk4xC5lOzEKS43mACvsdrnzeCC48uAd/MSZ9eLYeGLyrIJyxh60amZTv0vp0
         SA2EhKUkqlYUHZMsntmTcLkoku+uNtj2MIdEM=
Received: by 10.204.48.88 with SMTP id q24mr1524878bkf.31.1309715814745;
        Sun, 03 Jul 2011 10:56:54 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id af13sm4841383bkc.19.2011.07.03.10.56.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 10:56:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176584>

vcs-svn/ writes a progress line after each processed revision. It
is too noisy for big imports. That's a stress for a terminal and
any other output can be lost or scrolled away among these lines.

For now just add a switch to turn progress lines off:
$ svn-fe --no-progress ...

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/svn-fe.c   |    6 +++++-
 contrib/svn-fe/svn-fe.txt |    3 +++
 test-svn-fe.c             |    2 +-
 vcs-svn/fast_export.c     |    7 +++++--
 vcs-svn/fast_export.h     |    2 +-
 vcs-svn/svndump.c         |    4 ++--
 vcs-svn/svndump.h         |    2 +-
 7 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 32755b1..792ffad 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -15,8 +15,12 @@ static const char * const svn_fe_usage[] = {
 static const char *url;
 static const char *ref = "refs/heads/master";
 static int backflow_fd = 3;
+static int progress = 1;
 
 static struct option svn_fe_options[] = {
+	OPT_BIT(0, "progress", &progress,
+		"write a progress line after each commit",
+		1),
 	OPT_STRING(0, "git-svn-id-url", &url, "url",
 		"append git-svn metadata line to commit messages"),
 	OPT_STRING(0, "ref", &ref, "dst_ref",
@@ -38,7 +42,7 @@ int main(int argc, const char **argv)
 		url = argv[0];
 	} else if (argc)
 		usage_with_options(svn_fe_usage, svn_fe_options);
-	if (svndump_init(NULL, url, ref, backflow_fd))
+	if (svndump_init(NULL, url, ref, backflow_fd, progress))
 		return 1;
 	svndump_read();
 	svndump_deinit();
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index a7ad368..f1a459e 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -39,6 +39,9 @@ OPTIONS
 	Integer number of file descriptor from which
 	responses to 'ls' and 'cat-blob' requests will come.
 	Default is fd=3.
+--[no-]progress::
+	Write 'progress' lines to fast-import stream. These
+	can be displayed by fast-import.
 
 INPUT FORMAT
 ------------
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 7885eb1..e4bfda0 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -62,7 +62,7 @@ int main(int argc, const char *argv[])
 		return apply_delta(argc, argv);
 
 	if (argc == 1) {
-		if (svndump_init(argv[0], NULL, ref, backflow_fd))
+		if (svndump_init(argv[0], NULL, ref, backflow_fd, 1))
 			return 1;
 		svndump_read();
 		svndump_deinit();
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index cfb0f2b..a8b8603 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -19,6 +19,7 @@ static uint32_t first_commit_done;
 static struct line_buffer postimage = LINE_BUFFER_INIT;
 static struct line_buffer report_buffer = LINE_BUFFER_INIT;
 static struct strbuf ref_name = STRBUF_INIT;
+static int print_progress;
 
 /* NEEDSWORK: move to fast_export_init() */
 static int init_postimage(void)
@@ -30,9 +31,10 @@ static int init_postimage(void)
 	return buffer_tmpfile_init(&postimage);
 }
 
-void fast_export_init(int fd, const char *dst_ref)
+void fast_export_init(int fd, const char *dst_ref, int progress)
 {
 	first_commit_done = 0;
+	print_progress = progress;
 	strbuf_reset(&ref_name);
 	strbuf_addstr(&ref_name, dst_ref);
 	if (buffer_fdinit(&report_buffer, fd))
@@ -112,7 +114,8 @@ void fast_export_begin_commit(uint32_t revision, const char *author,
 
 void fast_export_end_commit(uint32_t revision)
 {
-	printf("progress Imported commit %"PRIu32".\n\n", revision);
+	if (print_progress)
+		printf("progress Imported commit %"PRIu32".\n\n", revision);
 }
 
 static void ls_from_rev(uint32_t rev, const char *path)
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index d7eb7cc..7cab7b3 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -4,7 +4,7 @@
 struct strbuf;
 struct line_buffer;
 
-void fast_export_init(int fd, const char *dst_ref);
+void fast_export_init(int fd, const char *dst_ref, int progress);
 void fast_export_deinit(void);
 void fast_export_reset(void);
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index c52faf1..5e3a44d 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -452,11 +452,11 @@ void svndump_read(void)
 		end_revision();
 }
 
-int svndump_init(const char *filename, const char *url, const char *dst_ref, int report_fileno)
+int svndump_init(const char *filename, const char *url, const char *dst_ref, int report_fileno, int progress)
 {
 	if (buffer_init(&input, filename))
 		return error("cannot open %s: %s", filename, strerror(errno));
-	fast_export_init(report_fileno, dst_ref);
+	fast_export_init(report_fileno, dst_ref, progress);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
 	strbuf_init(&rev_ctx.log, 4096);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index 85c82c5..becea11 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -1,7 +1,7 @@
 #ifndef SVNDUMP_H_
 #define SVNDUMP_H_
 
-int svndump_init(const char *filename, const char *url, const char *dst_ref, int report_fileno);
+int svndump_init(const char *filename, const char *url, const char *dst_ref, int report_fileno, int progress);
 void svndump_read(void);
 void svndump_deinit(void);
 void svndump_reset(void);
-- 
1.7.3.4
