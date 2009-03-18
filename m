From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 08/10] t2200, t7004: Avoid glob pattern that also matches files
Date: Wed, 18 Mar 2009 22:27:10 +0100
Message-ID: <3827d7fab3e9e233a0ac528b84ab2d6a36658365.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:30:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3Ks-000574-8F
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbZCRV1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754715AbZCRV1l
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:27:41 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46793 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853AbZCRV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:27:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 85C4A10025;
	Wed, 18 Mar 2009 22:27:18 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0EBA160DD4;
	Wed, 18 Mar 2009 22:27:18 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113681>

On Windows, there is an unfortunate interaction between the MSYS bash and
git's command line processing:

- Since Windows's CMD does not do the wildcard expansion, but passes
  arguments like path* through to the programs, the programs must do the
  expansion themselves. This happens in the startup code before main() is
  entered.

- bash, however, passes the argument "path*" to git, assuming that git will
  see the unquoted word unchanged as a single argument.

But actually git expands the unquoted word before main() is entered.

In t2200, not all names that the test case is interested in exist as files
at the time when 'git ls-files' is invoked. git expands "path?" to only
the subset of files the exist, and only that subset was listed, so that the
test failed.  We now list all interesting paths explicitly.

In t7004, git exanded the pattern "*a*" to "actual" (the file that stdout
was redirected to), which is not what the was tested for. We fix it by
renaming the output file (and removing any existing files matching *a*).
This was originally fixed by Johannes Schindelin.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t2200-add-update.sh |    2 +-
 t/t7004-tag.sh        |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index b2ddf5a..652801e 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -150,7 +150,7 @@ test_expect_success 'add -u resolves unmerged paths' '
 	echo 2 >path3 &&
 	echo 2 >path5 &&
 	git add -u &&
-	git ls-files -s "path?" >actual &&
+	git ls-files -s path1 path3 path4 path5 path6 >actual &&
 	{
 		echo "100644 $three 0	path1"
 		echo "100644 $one 1	path3"
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 06e6e17..1c27ffb 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -185,8 +185,9 @@ cba
 EOF
 test_expect_success \
 	'listing tags with substring as pattern must print those matching' '
-	git tag -l "*a*" > actual &&
-	test_cmp expect actual
+	rm *a* &&
+	git tag -l "*a*" > current &&
+	test_cmp expect current
 '
 
 cat >expect <<EOF
-- 
1.6.2.1.224.g2225f
