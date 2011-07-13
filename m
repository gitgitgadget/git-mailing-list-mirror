From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 04/11] svn-fe: add usage and unpositional arguments versions
Date: Wed, 13 Jul 2011 18:21:06 +0600
Message-ID: <1310559673-5026-5-git-send-email-divanorama@gmail.com>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 14:21:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgyRK-0004QA-5B
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab1GMMVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 08:21:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35552 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab1GMMU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 08:20:58 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4787045bwd.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=i79PzDRFMv4G6ez0jbVIQA014RIcz42t6qrF+4ftTWE=;
        b=j15e9RQSmn1RB/YssSXPk1Oi3ycKvPP2eLr0uAF+CR4MCtFaKx10FRkpR/R0LFxWa4
         SbV8f6V0sY3W3KlijU0UkotNLo5IsZowEXUXKqgVRPjd2Va4HOKa1ZXC1wm2RxTiyTZp
         HTf0s5rv+I/ZQOk8hrMRP6UUHrbq4eMGpaW3k=
Received: by 10.204.130.24 with SMTP id q24mr508704bks.74.1310559658213;
        Wed, 13 Jul 2011 05:20:58 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id c8sm1653987bkc.15.2011.07.13.05.20.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 05:20:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177029>

There will be more command line options for svn-fe so support
unpositional version for flexibility. Also clarify the meaning
of url parameter.

$ svn-fe --git-svn-id-url=url
does the same thing as
$ svn-fe url
i.e., url is used to generate git-svn-id: lines, if url is set.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/Makefile   |    2 +-
 contrib/svn-fe/svn-fe.c   |   30 +++++++++++++++++++++++++++---
 contrib/svn-fe/svn-fe.txt |   17 +++++++++++++----
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index bf1625c..3e18395 100644
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
index 35db24f..7e829b9 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -3,14 +3,38 @@
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
+		"append git-svn metadata line to commit messages"),
+	OPT_END()
+};
+
+int main(int argc, const char **argv)
 {
+	argc = parse_options(argc, argv, NULL, svn_fe_options,
+						svn_fe_usage, 0);
+	if (argc == 1) {
+		if (url)
+			usage_msg_opt("git-svn-id-url is set twice: as a "
+					"--parameter and as a [parameter]",
+					svn_fe_usage, svn_fe_options);
+		url = argv[0];
+	} else if (argc)
+		usage_with_options(svn_fe_usage, svn_fe_options);
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
-- 
1.7.3.4
