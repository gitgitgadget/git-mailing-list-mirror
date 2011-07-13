From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 05/11] vcs-svn: move url parameter from _read to _init
Date: Wed, 13 Jul 2011 18:21:07 +0600
Message-ID: <1310559673-5026-6-git-send-email-divanorama@gmail.com>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 14:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgyRK-0004QA-M5
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088Ab1GMMVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 08:21:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35552 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab1GMMVB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 08:21:01 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4787045bwd.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zsZHeQxTzwhFlvmL5DOqDXw/sIU9z1fIRL4tROvyEtU=;
        b=q9loDoeyQDGcZStBHgLFLsA7un+Q2nxGd/SegvPBNWF8Bw/YZdEP2mujRWejYBx1Z0
         i+vwWfoAxf38/NKPMe2vG0xF7Kc0bfLgT5C82GCbIrwPVAMmTUMCfLHGo6rmBKwmEJ0E
         spSL5CrWirMZqsWbBooZZGoxCJiVgN7hmfZg8=
Received: by 10.204.30.215 with SMTP id v23mr482669bkc.377.1310559660211;
        Wed, 13 Jul 2011 05:21:00 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id c8sm1653987bkc.15.2011.07.13.05.20.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 05:20:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177033>

svndump_read takes a url parameter that is used in git-svn-id: lines
generation. Internally it is stored in dump_ctx which is initialized
in svndump_init with reset_dump_ctx and then is reinitialized again
in svndump_read.

Move url parameter to svndump_init so that reset_dump_ctx is done
once per dump and in the same place as other resets. Wrap all _init
parameters to a struct svndump_args. More parameters will arise and
all will go to this struct to setup the module for dumping. Having
a struct reduces a chance to confuse one parameter with another a
bit, if they are filled via named assignments or common defines.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/svn-fe.c |   12 ++++++------
 test-svn-fe.c           |    7 +++++--
 vcs-svn/svndump.c       |   12 ++++++------
 vcs-svn/svndump.h       |    8 ++++++--
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 7e829b9..59141d6 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -12,10 +12,10 @@ static const char * const svn_fe_usage[] = {
 	NULL
 };
 
-static const char *url;
+static struct svndump_args args;
 
 static struct option svn_fe_options[] = {
-	OPT_STRING(0, "git-svn-id-url", &url, "url",
+	OPT_STRING(0, "git-svn-id-url", &args.url, "url",
 		"append git-svn metadata line to commit messages"),
 	OPT_END()
 };
@@ -25,16 +25,16 @@ int main(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL, svn_fe_options,
 						svn_fe_usage, 0);
 	if (argc == 1) {
-		if (url)
+		if (args.url)
 			usage_msg_opt("git-svn-id-url is set twice: as a "
 					"--parameter and as a [parameter]",
 					svn_fe_usage, svn_fe_options);
-		url = argv[0];
+		args.url = argv[0];
 	} else if (argc)
 		usage_with_options(svn_fe_usage, svn_fe_options);
-	if (svndump_init(NULL))
+	if (svndump_init(&args))
 		return 1;
-	svndump_read(url);
+	svndump_read();
 	svndump_deinit();
 	svndump_reset();
 	return 0;
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 0aab245..9e5b1a6 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -14,6 +14,8 @@ static const char * const test_svnfe_usage[] = {
 	NULL
 };
 
+static struct svndump_args args;
+
 static int d;
 
 static struct option test_svnfe_options[] = {
@@ -56,9 +58,10 @@ int main(int argc, const char *argv[])
 		return apply_delta(argc, argv);
 
 	if (argc == 1) {
-		if (svndump_init(argv[0]))
+		args.filename = argv[0];
+		if (svndump_init(&args))
 			return 1;
-		svndump_read(NULL);
+		svndump_read();
 		svndump_deinit();
 		svndump_reset();
 		return 0;
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index b1f4161..60cccad 100644
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
+int svndump_init(const struct svndump_args *args)
 {
-	if (buffer_init(&input, filename))
-		return error("cannot open %s: %s", filename, strerror(errno));
+	if (buffer_init(&input, args->filename))
+		return error("cannot open %s: %s", args->filename, strerror(errno));
 	fast_export_init(REPORT_FILENO);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
@@ -466,7 +466,7 @@ int svndump_init(const char *filename)
 	strbuf_init(&rev_ctx.author, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(NULL);
+	reset_dump_ctx(args->url);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	return 0;
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index df9ceb0..b3dbf24 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -1,8 +1,12 @@
 #ifndef SVNDUMP_H_
 #define SVNDUMP_H_
 
-int svndump_init(const char *filename);
-void svndump_read(const char *url);
+struct svndump_args {
+	const char *filename, *url;
+};
+
+int svndump_init(const struct svndump_args *args);
+void svndump_read(void);
 void svndump_deinit(void);
 void svndump_reset(void);
 
-- 
1.7.3.4
