From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 4/8] svn-fe: add usage and unpositional arguments versions
Date: Sun,  3 Jul 2011 23:57:53 +0600
Message-ID: <1309715877-13814-5-git-send-email-divanorama@gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 19:57:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdQut-00025S-RC
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 19:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407Ab1GCR4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jul 2011 13:56:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62342 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab1GCR4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 13:56:48 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so3614734bwd.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AtG2mhUTN/P5XhGH7yzA8+ewe5a/kQF2/0TbjizTt1M=;
        b=U6lbXBO/HqeR4EfmPtW1X7ApqIRTNtR0iBDn5DS2oc6RqE0OGc1wOL424+b3RQVUS5
         9EB/r3tetZ2pMBULBeyAlpMXivsrFShPVEE1OcxK1mb3N7MzrRR1ZJHthffXn/ARIhiB
         VWlPP8l8rEFsBedfWp5rq+5puZ/uilkMvu4TI=
Received: by 10.204.48.210 with SMTP id s18mr4663317bkf.176.1309715807366;
        Sun, 03 Jul 2011 10:56:47 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id af13sm4841383bkc.19.2011.07.03.10.56.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 10:56:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176582>

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
index 11d7128..033dd5b 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -3,12 +3,36 @@
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
-	if (svndump_init(NULL, (argc > 1) ? argv[1] : NULL))
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
+	if (svndump_init(NULL, url))
 		return 1;
 	svndump_read();
 	svndump_deinit();
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
