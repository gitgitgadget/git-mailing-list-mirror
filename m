From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3 08/10] vcs-svn,svn-fe: allow to disable 'progress' lines
Date: Tue, 16 Aug 2011 15:54:53 +0600
Message-ID: <1313488495-2203-9-git-send-email-divanorama@gmail.com>
References: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 11:54:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGLi-00089W-KJ
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 11:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab1HPJyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 05:54:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61184 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab1HPJyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 05:54:09 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3585259bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 02:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1sIVm7by4nQk7zWQwlTmr5rFtcHpK/TYUrg275UqYdk=;
        b=OHRdcbUYTBvzzWKJt8OXjGgMAa0F2su4r24yJJgxoDEJOoGEkrTr7qUZoH4SitzGMs
         neTYS3PGCtkGDrDDo7LwIs8OTbtAcESiB75gBjtB2VXRYrgI1Kj3nntwsnucPC3zVoh5
         mXXlpuyz5IIWjGm96/NyRLKmgP4iTTp9JR5XU=
Received: by 10.204.233.65 with SMTP id jx1mr450348bkb.314.1313488449278;
        Tue, 16 Aug 2011 02:54:09 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zx9sm1841723bkb.61.2011.08.16.02.54.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 02:54:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179419>

vcs-svn/ writes a progress line after each processed revision. It
is too noisy for big imports. That's a stress for a terminal and
any other output can be lost or scrolled away among these lines.
If svn-fe is invoked by a remote helper the import stream with
progress lines in it will go directly to the git fast-import which
always prints every progress line met in the stream.

For now just add a switch to turn progress lines off:
$ svn-fe --no-progress ...

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/svn-fe.c   |    3 +++
 contrib/svn-fe/svn-fe.txt |    4 ++++
 test-svn-fe.c             |    1 +
 vcs-svn/svndump.c         |    6 +++++-
 vcs-svn/svndump.h         |    1 +
 5 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index a4fd7f5..6aedba2 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -15,6 +15,9 @@ static const char * const svn_fe_usage[] = {
 static struct svndump_options options;
 
 static struct option svn_fe_options[] = {
+	{ OPTION_SET_INT, 0, "progress", &options.progress,
+		NULL, "don't write a progress line after each commit",
+		PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
 	OPT_STRING(0, "git-svn-id-url", &options.git_svn_url, "url",
 		"add git-svn-id line to log messages, imitating git-svn"),
 	OPT_STRING(0, "ref", &options.ref, "refname",
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 7bfc5a6..abeebfe 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -42,6 +42,10 @@ OPTIONS
 	responses to 'ls' and 'cat-blob' requests will come.
 	Default is fd=3.
 
+--[no-]progress::
+	Write 'progress' lines to fast-import stream. These
+	can be displayed by fast-import.
+
 INPUT FORMAT
 ------------
 Subversion's repository dump format is documented in full in
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 568e47e..e51a9bb 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -57,6 +57,7 @@ static int apply_delta(int argc, const char *argv[])
 int main(int argc, const char *argv[])
 {
 	options.backflow_fd = 3;
+	options.progress = 1;
 	argc = parse_options(argc, argv, NULL, test_svnfe_options,
 						test_svnfe_usage, 0);
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 847d733..ec68649 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -37,6 +37,8 @@
 
 #define MAX_GITSVN_LINE_LEN 4096
 
+static int print_progress;
+
 static struct line_buffer input = LINE_BUFFER_INIT;
 
 static struct {
@@ -344,7 +346,8 @@ static void begin_revision(void)
 static void end_revision(void)
 {
 	if (rev_ctx.revision) {
-		fast_export_progress(rev_ctx.revision);
+		if (print_progress)
+			fast_export_progress(rev_ctx.revision);
 		dump_ctx.first_commit_done = 1;
 	}
 }
@@ -497,6 +500,7 @@ int svndump_init(const struct svndump_options *o)
 		ref = "refs/heads/master";
 	if (buffer_init(&input, o->dumpfile))
 		return error("cannot open %s: %s", o->dumpfile, strerror(errno));
+	print_progress = o->progress;
 	fast_export_init(o->backflow_fd);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index 8de9999..de54969 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -8,6 +8,7 @@ struct svndump_options {
 	const char *dumpfile, *git_svn_url;
 	const char *ref;
 	int backflow_fd;
+	int progress;
 };
 
 int svndump_init(const struct svndump_options *o);
-- 
1.7.3.4
