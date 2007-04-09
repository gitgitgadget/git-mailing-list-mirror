From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-archive: make tar the default format
Date: Mon, 09 Apr 2007 17:12:53 +0200
Message-ID: <461A57F5.7080403@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 18:59:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HavYZ-0007NJ-4p
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 17:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbXDIPNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 11:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbXDIPNK
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 11:13:10 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:35566
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752140AbXDIPNJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2007 11:13:09 -0400
Received: from [10.0.1.201] (p508e4249.dip.t-dialin.net [80.142.66.73])
	by neapel230.server4you.de (Postfix) with ESMTP id F0F5022006;
	Mon,  9 Apr 2007 17:13:05 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44058>

As noted by Junio, --format=tar should be assumed if no format
was specified.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-archive.txt |    3 ++-
 builtin-archive.c             |    4 +---
 t/t5000-tar-tree.sh           |   10 +++++++++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 493474b..8d10415 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -30,7 +30,8 @@ OPTIONS
 -------
 
 --format=<fmt>::
-	Format of the resulting archive: 'tar', 'zip'...
+	Format of the resulting archive: 'tar', 'zip'...  The default
+	is 'tar'.
 
 --list::
 	Show all available formats.
diff --git a/builtin-archive.c b/builtin-archive.c
index 8ea6cb1..7f4e409 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -149,7 +149,7 @@ int parse_archive_args(int argc, const char **argv, struct archiver *ar)
 {
 	const char *extra_argv[MAX_EXTRA_ARGS];
 	int extra_argc = 0;
-	const char *format = NULL; /* might want to default to "tar" */
+	const char *format = "tar";
 	const char *base = "";
 	int verbose = 0;
 	int i;
@@ -190,8 +190,6 @@ int parse_archive_args(int argc, const char **argv, struct archiver *ar)
 	/* We need at least one parameter -- tree-ish */
 	if (argc - 1 < i)
 		usage(archive_usage);
-	if (!format)
-		die("You must specify an archive format");
 	if (init_archiver(format, ar) < 0)
 		die("Unknown archive format '%s'", format);
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index b4359df..e223c07 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -50,8 +50,16 @@ test_expect_success \
      git-commit-tree $treeid </dev/null)'
 
 test_expect_success \
+    'git-archive' \
+    'git-archive HEAD >b.tar'
+
+test_expect_success \
     'git-tar-tree' \
-    'git-tar-tree HEAD >b.tar'
+    'git-tar-tree HEAD >b2.tar'
+
+test_expect_success \
+    'git-archive vs. git-tar-tree' \
+    'diff b.tar b2.tar'
 
 test_expect_success \
     'validate file modification time' \
-- 
1.5.1.53.g77e6f
