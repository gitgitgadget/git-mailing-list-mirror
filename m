From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3 03/10] svn-fe,test-svn-fe: use parse-options
Date: Tue, 16 Aug 2011 15:54:48 +0600
Message-ID: <1313488495-2203-4-git-send-email-divanorama@gmail.com>
References: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 11:54:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGLg-00089W-IR
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 11:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab1HPJyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 05:54:03 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61184 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab1HPJyA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 05:54:00 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3585259bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/aK5QTDxNB3qfbDtP5lBabEZAcBVtoM0fyEFg4l1ls4=;
        b=JoKPF+gdKjjmZk61YiCejZQfsTDBEpciLPB+v98IPaqeI5BYYe8I5pDfRntiq+XCpR
         8NiHDtzNfG5X9cVNagbTHg7QfkY1sO3E6XoEnrhufGkjx7DUGfc2tuyHjWGn511GmDPW
         MgKrHBmrmtlM3UVwpV8FJrH/7WTLo/1dt0zNs=
Received: by 10.204.232.17 with SMTP id js17mr1226394bkb.219.1313488439586;
        Tue, 16 Aug 2011 02:53:59 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zx9sm1841723bkb.61.2011.08.16.02.53.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 02:53:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179414>

There was custom options parsing. As more options arise it will
be easier to add and document new options with parse-options api.

Use parse-options api in svn-fe and test-svn-fe. This implies adding
help messages. And by the way clarify the "url" parameter meaning,
renaming it to git-svn-id-url and updating svn-fe.txt. Also allow a
--git-svn-id-url=url way of specifying it.

$ svn-fe --git-svn-id-url=url
does the same thing as
$ svn-fe url
i.e., url is used to generate git-svn-id: lines, if url is set.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/svn-fe/Makefile   |    2 +-
 contrib/svn-fe/svn-fe.c   |   32 +++++++++++++++++++++++++++++---
 contrib/svn-fe/svn-fe.txt |   17 +++++++++++++----
 test-svn-fe.c             |   43 +++++++++++++++++++++++++++++--------------
 4 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 8b12df1..15ba24d 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -41,7 +41,7 @@ svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
 		$(ALL_LDFLAGS) $(LIBS)
 
 svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
-	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -I../../vcs-svn -I../.. -o $*.o -c $(ALL_CFLAGS) $<
 
 svn-fe.html: svn-fe.txt
 	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 35db24f..a95e72f 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -3,14 +3,40 @@
  * You may freely use, modify, distribute, and relicense it.
  */
 
-#include <stdlib.h>
+#include "git-compat-util.h"
+#include "parse-options.h"
 #include "svndump.h"
 
-int main(int argc, char **argv)
+static const char * const svn_fe_usage[] = {
+	"svn-fe [options] [git-svn-id-url] < dump | fast-import-backend",
+	NULL
+};
+
+static const char *url;
+
+static struct option svn_fe_options[] = {
+	OPT_STRING(0, "git-svn-id-url", &url, "url",
+		"add git-svn-id line to log messages, imitating git-svn"),
+	OPT_END()
+};
+
+int main(int argc, const char **argv)
 {
+	argc = parse_options(argc, argv, NULL, svn_fe_options,
+						svn_fe_usage, 0);
+	if (argc > 1)
+		usage_with_options(svn_fe_usage, svn_fe_options);
+
+	if (argc == 1) {
+		if (url)
+			usage_msg_opt("git-svn-id-url is set twice: as a "
+					"--parameter and as a [parameter]",
+					svn_fe_usage, svn_fe_options);
+		url = argv[0];
+	}
 	if (svndump_init(NULL))
 		return 1;
-	svndump_read((argc > 1) ? argv[1] : NULL);
+	svndump_read(url);
 	svndump_deinit();
 	svndump_reset();
 	return 0;
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 2dd27ce..8c6d347 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 mkfifo backchannel &&
 svnadmin dump --deltas REPO |
-	svn-fe [url] 3<backchannel |
+	svn-fe [options] [git-svn-id-url] 3<backchannel |
 	git fast-import --cat-blob-fd=3 3>backchannel
 
 DESCRIPTION
@@ -25,6 +25,14 @@ command.
 Note: this tool is very young.  The details of its commandline
 interface may change in backward incompatible ways.
 
+OPTIONS
+-------
+
+--git-svn-id-url=<url>::
+	Url to be used in git-svn-id: lines in git-svn
+	metadata lines format. See NOTES for more detailed
+	description.
+
 INPUT FORMAT
 ------------
 Subversion's repository dump format is documented in full in
@@ -50,9 +58,10 @@ user <user@UUID>
 as committer, where 'user' is the value of the `svn:author` property
 and 'UUID' the repository's identifier.
 
-To support incremental imports, 'svn-fe' puts a `git-svn-id` line at
-the end of each commit log message if passed an url on the command
-line.  This line has the form `git-svn-id: URL@REVNO UUID`.
+'svn-fe' can be used in preparing a repository for 'git-svn' as follows.
+If `git-svn-id-url` is specified, 'svn-fe' will put `git-svn-id` line at
+the end of each commit log message.
+This line has the form `git-svn-id: URL@REVNO UUID`.
 
 The resulting repository will generally require further processing
 to put each project in its own repository and to separate the history
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 332a5f7..c10d3ca 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -3,28 +3,39 @@
  */
 
 #include "git-compat-util.h"
+#include "parse-options.h"
 #include "vcs-svn/svndump.h"
 #include "vcs-svn/svndiff.h"
 #include "vcs-svn/sliding_window.h"
 #include "vcs-svn/line_buffer.h"
 
-static const char test_svnfe_usage[] =
-	"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
+static const char * const test_svnfe_usage[] = {
+	"test-svn-fe <dumpfile>",
+	"test-svn-fe -d <preimage> <delta> <len>",
+	NULL
+};
 
-static int apply_delta(int argc, char *argv[])
+static int delta_test;
+
+static struct option test_svnfe_options[] = {
+	OPT_SET_INT('d', "apply-delta", &delta_test, "test apply_delta", 1),
+	OPT_END()
+};
+
+static int apply_delta(int argc, const char *argv[])
 {
 	struct line_buffer preimage = LINE_BUFFER_INIT;
 	struct line_buffer delta = LINE_BUFFER_INIT;
 	struct sliding_view preimage_view = SLIDING_VIEW_INIT(&preimage, -1);
 
-	if (argc != 5)
-		usage(test_svnfe_usage);
+	if (argc != 3)
+		usage_with_options(test_svnfe_usage, test_svnfe_options);
 
-	if (buffer_init(&preimage, argv[2]))
+	if (buffer_init(&preimage, argv[0]))
 		die_errno("cannot open preimage");
-	if (buffer_init(&delta, argv[3]))
+	if (buffer_init(&delta, argv[1]))
 		die_errno("cannot open delta");
-	if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
+	if (svndiff0_apply(&delta, (off_t) strtoull(argv[2], NULL, 0),
 					&preimage_view, stdout))
 		return 1;
 	if (buffer_deinit(&preimage))
@@ -37,10 +48,16 @@ static int apply_delta(int argc, char *argv[])
 	return 0;
 }
 
-int main(int argc, char *argv[])
+int main(int argc, const char *argv[])
 {
-	if (argc == 2) {
-		if (svndump_init(argv[1]))
+	argc = parse_options(argc, argv, NULL, test_svnfe_options,
+						test_svnfe_usage, 0);
+
+	if (delta_test)
+		return apply_delta(argc, argv);
+
+	if (argc == 1) {
+		if (svndump_init(argv[0]))
 			return 1;
 		svndump_read(NULL);
 		svndump_deinit();
@@ -48,7 +65,5 @@ int main(int argc, char *argv[])
 		return 0;
 	}
 
-	if (argc >= 2 && !strcmp(argv[1], "-d"))
-		return apply_delta(argc, argv);
-	usage(test_svnfe_usage);
+	usage_with_options(test_svnfe_usage, test_svnfe_options);
 }
-- 
1.7.3.4
