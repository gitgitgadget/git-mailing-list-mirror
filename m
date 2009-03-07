From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] MinGW: fix diff --no-index /dev/null ...
Date: Sat, 7 Mar 2009 16:51:33 +0100 (CET)
Message-ID: <dba002b9e521c639847650fbaeb8b87b66b9562e.1236441065u.git.johannes.schindelin@gmx.de>
References: <cover.1236441065u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 07 16:51:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfyoG-0000GV-PP
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 16:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbZCGPuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 10:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbZCGPuE
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 10:50:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:57081 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751073AbZCGPuC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 10:50:02 -0500
Received: (qmail invoked by alias); 07 Mar 2009 15:49:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 07 Mar 2009 16:49:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zEpxW8gQzdptQFpaNVLyyI/55LWgawJ+qUlUa/2
	R7QVZsgbIYO2+j
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1236441065u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112543>

When launching "diff --no-index" with a parameter "/dev/null", the MSys
bash converts the "/dev/null" to a "nul", which usually makes sense.  But
diff --no-index got confused and tried to access a _file_ called "nul".

While at it, the comment in t4012, expressed as ":# <text>" was turned
into ": <text>" so that MSys' path name mangling does not kick in.

With this patch, t4012 passes in msysGit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-no-index.c        |    4 ++++
 t/t4012-diff-binary.sh |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 0a14268..598687b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -38,6 +38,10 @@ static int get_mode(const char *path, int *mode)
 
 	if (!path || !strcmp(path, "/dev/null"))
 		*mode = 0;
+#ifdef _WIN32
+	else if (!strcasecmp(path, "nul"))
+		*mode = 0;
+#endif
 	else if (!strcmp(path, "-"))
 		*mode = create_ce_mode(0666);
 	else if (lstat(path, &st))
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 3cf5b5c..f64aa48 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -87,7 +87,7 @@ nul_to_q() {
 
 test_expect_success 'diff --no-index with binary creation' '
 	echo Q | q_to_nul >binary &&
-	(:# hide error code from diff, which just indicates differences
+	(: hide error code from diff, which just indicates differences
 	 git diff --binary --no-index /dev/null binary >current ||
 	 true
 	) &&
-- 
1.6.2.327.g0fa6c
