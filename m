From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git rm: refresh index before up-to-date check
Date: Tue, 7 Oct 2008 18:08:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810071807500.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Oct 07 18:08:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnF1h-00045p-0v
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 18:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbYJGQB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 12:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbYJGQB4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 12:01:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:53589 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753237AbYJGQBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 12:01:55 -0400
Received: (qmail invoked by alias); 07 Oct 2008 16:01:53 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 07 Oct 2008 18:01:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18N/qJRREENDk50jfJBc8aD9Rtubct4YjupNkOcUG
	hKqVAP6WffGjVD
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97723>


Since "git rm" is supposed to be porcelain, we should convince it to
be user friendly by refreshing the index itself.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-rm.c  |    1 +
 t/t3600-rm.sh |   25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index 50ae6d5..e06640c 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -137,6 +137,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	if (read_cache() < 0)
 		die("index file corrupt");
+	refresh_cache(REFRESH_QUIET);
 
 	pathspec = get_pathspec(prefix, argv);
 	seen = NULL;
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 558c80e..66aca99 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -219,14 +219,23 @@ test_expect_success 'Remove nonexistent file returns nonzero exit status' '
 
 test_expect_success 'Call "rm" from outside the work tree' '
 	mkdir repo &&
-	cd repo &&
-	git init &&
-	echo something > somefile &&
-	git add somefile &&
-	git commit -m "add a file" &&
-	(cd .. &&
-	 git --git-dir=repo/.git --work-tree=repo rm somefile) &&
-	test_must_fail git ls-files --error-unmatch somefile
+	(cd repo &&
+	 git init &&
+	 echo something > somefile &&
+	 git add somefile &&
+	 git commit -m "add a file" &&
+	 (cd .. &&
+	  git --git-dir=repo/.git --work-tree=repo rm somefile) &&
+	test_must_fail git ls-files --error-unmatch somefile)
+'
+
+test_expect_success 'refresh index before checking if it is up-to-date' '
+
+	git reset --hard &&
+	test-chmtime -86400 frotz/nitfol &&
+	git rm frotz/nitfol &&
+	test ! -f frotz/nitfol
+
 '
 
 test_done
-- 
1.6.0.2.713.g3dcb0
