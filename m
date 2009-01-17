From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t5540: clarify that http-push does not handle packed-refs
 on the remote
Date: Sat, 17 Jan 2009 16:41:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901171640530.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901171632330.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 17 16:42:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODJd-0000IZ-E0
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760965AbZAQPlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 10:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760902AbZAQPlD
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:41:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:56198 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760798AbZAQPlB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:41:01 -0500
Received: (qmail invoked by alias); 17 Jan 2009 15:40:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 17 Jan 2009 16:40:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UOv4g8bKUWiqaVcViIXflGunZADMOF2VnioQjI2
	fF+zX1ufmrJMrB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901171632330.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106064>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sat, 17 Jan 2009, Johannes Schindelin wrote:

	> 	Note that the push in t5540 is still broken, as http-push does
	> 	not handle packed-refs (when looking what branches are on the 
	> 	remote side).

	... and this clarifies the issue.

 t/t5540-http-push.sh |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 22cfbb6..c236b5e 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -51,17 +51,29 @@ test_expect_success 'clone remote repository' '
 	git clone $HTTPD_URL/test_repo.git test_repo_clone
 '
 
-test_expect_failure 'push to remote repository' '
+test_expect_failure 'push to remote repository with packed refs' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	: >path2 &&
 	git add path2 &&
 	test_tick &&
 	git commit -m path2 &&
+	HEAD=$(git rev-parse --verify HEAD) &&
 	git push &&
-	[ -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/refs/heads/master" ]
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
-test_expect_failure 'create and delete remote branch' '
+test_expect_success ' push to remote repository with unpacked refs' '
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 rm packed-refs &&
+	 git update-ref refs/heads/master \
+		0c973ae9bd51902a28466f3850b543fa66a6aaf4) &&
+	git push &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 test $HEAD = $(git rev-parse --verify HEAD))
+'
+
+test_expect_success 'create and delete remote branch' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout -b dev &&
 	: >path3 &&
-- 
1.6.1.325.g062d4
