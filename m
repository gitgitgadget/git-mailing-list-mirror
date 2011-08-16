From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3 04/10] vcs-svn: make svndump_init parameters a struct
Date: Tue, 16 Aug 2011 15:54:49 +0600
Message-ID: <1313488495-2203-5-git-send-email-divanorama@gmail.com>
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
	id 1QtGLi-00089W-3l
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 11:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab1HPJyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 05:54:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61184 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab1HPJyC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 05:54:02 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3585259bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mrnMw0TS8M7qkXXjo7TGsT4ugVS1yglCrxbCgm2PnP0=;
        b=cbNSGGw5eUEtIMXvysp8sDoh/SohiJDyWQAZ+2LO3+21KGibi/X86h5fngEMI86taI
         q1GfENiRbr+50CHo/TlrOEkWX2BQ/8cNdZ/QPJREt5MjK18grjWB/FAaa8r1cs3hZwz5
         H4ji4AxKmfoZ4diDdxGno2J1wi4aYFQ/AJKA4=
Received: by 10.205.65.133 with SMTP id xm5mr844304bkb.395.1313488441512;
        Tue, 16 Aug 2011 02:54:01 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zx9sm1841723bkb.61.2011.08.16.02.53.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 02:54:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179418>

svndump_init takes a dumpfile parameter and svndump_read takes url
parameter. Internally url is stored in dump_ctx that is in fact
reset in svndump_init, but then is reset once more in svndump_read.
It'd be better to make url a svndump_init parameter and avoid this
double reset.

A bunch of new svndump parameters are going to be introduced. So wrap
them all to a svndump_options struct to make adding new ones smooth
and easy.

The usage changes like following.
Before:
	if (svndump_init(dumpfile))
		die("svndump_init failed");
	svndump_read(url);
After:
	struct svndump_args opts;
	memset(&opts, 0, sizeof(opts));
	opts.url = url;
	opts.filename = dumpfile;
	if (svndump_init(&opts))
		die("svndump_init failed");
	svndump_read();

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/svn-fe.c |   12 ++++++------
 test-svn-fe.c           |    7 +++++--
 vcs-svn/svndump.c       |   12 ++++++------
 vcs-svn/svndump.h       |   11 +++++++++--
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index a95e72f..0165c3f 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -12,10 +12,10 @@ static const char * const svn_fe_usage[] = {
 	NULL
 };
 
-static const char *url;
+static struct svndump_options options;
 
 static struct option svn_fe_options[] = {
-	OPT_STRING(0, "git-svn-id-url", &url, "url",
+	OPT_STRING(0, "git-svn-id-url", &options.git_svn_url, "url",
 		"add git-svn-id line to log messages, imitating git-svn"),
 	OPT_END()
 };
@@ -28,15 +28,15 @@ int main(int argc, const char **argv)
 		usage_with_options(svn_fe_usage, svn_fe_options);
 
 	if (argc == 1) {
-		if (url)
+		if (options.git_svn_url)
 			usage_msg_opt("git-svn-id-url is set twice: as a "
 					"--parameter and as a [parameter]",
 					svn_fe_usage, svn_fe_options);
-		url = argv[0];
+		options.git_svn_url = argv[0];
 	}
-	if (svndump_init(NULL))
+	if (svndump_init(&options))
 		return 1;
-	svndump_read(url);
+	svndump_read();
 	svndump_deinit();
 	svndump_reset();
 	return 0;
diff --git a/test-svn-fe.c b/test-svn-fe.c
index c10d3ca..0dd0657 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -15,6 +15,8 @@ static const char * const test_svnfe_usage[] = {
 	NULL
 };
 
+static struct svndump_options options;
+
 static int delta_test;
 
 static struct option test_svnfe_options[] = {
@@ -57,9 +59,10 @@ int main(int argc, const char *argv[])
 		return apply_delta(argc, argv);
 
 	if (argc == 1) {
-		if (svndump_init(argv[0]))
+		options.dumpfile = argv[0];
+		if (svndump_init(&options))
 			return 1;
-		svndump_read(NULL);
+		svndump_read();
 		svndump_deinit();
 		svndump_reset();
 		return 0;
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index b1f4161..5cdf6b8 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -12,6 +12,7 @@
 #include "fast_export.h"
 #include "line_buffer.h"
 #include "strbuf.h"
+#include "svndump.h"
 
 /*
  * Compare start of string to literal of equal length;
@@ -313,14 +314,13 @@ static void end_revision(void)
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
@@ -455,10 +455,10 @@ void svndump_read(const char *url)
 		end_revision();
 }
 
-int svndump_init(const char *filename)
+int svndump_init(const struct svndump_options *o)
 {
-	if (buffer_init(&input, filename))
-		return error("cannot open %s: %s", filename, strerror(errno));
+	if (buffer_init(&input, o->dumpfile))
+		return error("cannot open %s: %s", o->dumpfile, strerror(errno));
 	fast_export_init(REPORT_FILENO);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
@@ -466,7 +466,7 @@ int svndump_init(const char *filename)
 	strbuf_init(&rev_ctx.author, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(NULL);
+	reset_dump_ctx(o->git_svn_url);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	return 0;
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index df9ceb0..db39dfe 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -1,8 +1,15 @@
 #ifndef SVNDUMP_H_
 #define SVNDUMP_H_
 
-int svndump_init(const char *filename);
-void svndump_read(const char *url);
+struct svndump_options {
+	/*
+	 * dumpfile is opened in svndump_init and is read in svndump_read.
+	 */
+	const char *dumpfile, *git_svn_url;
+};
+
+int svndump_init(const struct svndump_options *o);
+void svndump_read(void);
 void svndump_deinit(void);
 void svndump_reset(void);
 
-- 
1.7.3.4
