From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] clone --bare: Add ".git" suffix to the directory name
 to clone into
Date: Fri, 1 Aug 2008 16:01:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808011601200.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808011600170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 01 15:58:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOv96-0000EX-MI
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 15:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbYHAN5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 09:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbYHAN5Q
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 09:57:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:39869 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752657AbYHAN5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 09:57:15 -0400
Received: (qmail invoked by alias); 01 Aug 2008 13:57:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 01 Aug 2008 15:57:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pgcYHLLopVfluTkyTLo/7LVqFBBrga03l11kjs3
	oUMEMP8NwWx1Vw
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0808011600170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91067>


We have a tradition that bare repositories live in directories ending
in ".git".  To make this more a convention than just a tradition, teach
"git clone --bare" to add a ".git" suffix to the directory name.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This patch is only conceptionally dependent on patch 1/2.

 builtin-clone.c  |   10 ++++++++--
 t/t5601-clone.sh |    7 +++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index a45179c..82f5b67 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -95,7 +95,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 	return NULL;
 }
 
-static char *guess_dir_name(const char *repo, int is_bundle)
+static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 {
 	const char *end = repo + strlen(repo), *start;
 
@@ -131,6 +131,12 @@ static char *guess_dir_name(const char *repo, int is_bundle)
 			end -= 4;
 	}
 
+	if (is_bare) {
+		char *result = xmalloc(end - start + 5);
+		sprintf(result, "%.*s.git", (int)(end - start), start);
+		return result;
+	}
+
 	return xstrndup(start, end - start);
 }
 
@@ -388,7 +394,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (argc == 2)
 		dir = xstrdup(argv[1]);
 	else
-		dir = guess_dir_name(repo_name, is_bundle);
+		dir = guess_dir_name(repo_name, is_bundle, option_bare);
 
 	if (!stat(dir, &buf))
 		die("destination directory '%s' already exists.", dir);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 4b2533f..e0a68ab 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -80,4 +80,11 @@ test_expect_success 'clone --mirror' '
 
 '
 
+test_expect_success 'clone --bare names the local repository <name>.git' '
+
+	git clone --bare src &&
+	test -d src.git
+
+'
+
 test_done
-- 
1.6.0.rc1.46.g279e5
