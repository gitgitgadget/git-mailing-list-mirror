From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] git-merge-file: refuse to merge binary files
Date: Tue, 5 Jun 2007 03:37:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706050337010.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 05 04:39:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvOx7-0004A8-Jr
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 04:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760192AbXFECjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 22:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756130AbXFECjT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 22:39:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:44260 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760192AbXFECjT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 22:39:19 -0400
Received: (qmail invoked by alias); 05 Jun 2007 02:39:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 05 Jun 2007 04:39:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+22iwReGa29oF7mgapxeaB82b+fLnFTcHYlUnFHX
	wuI00rVBlIPwrv
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49147>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-merge-file.c  |    6 +++++-
 t/t6023-merge-file.sh |    5 +++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 9135773..10ec63b 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -36,9 +36,13 @@ int cmd_merge_file(int argc, char **argv, char **envp)
 	for (; i < 3; i++)
 		names[i] = argv[i + 1];
 
-	for (i = 0; i < 3; i++)
+	for (i = 0; i < 3; i++) {
 		if (read_mmfile(mmfs + i, argv[i + 1]))
 			return -1;
+		if (buffer_is_binary(mmfs[i].ptr, mmfs[i].size))
+			return error("Cannot merge binary files: %s\n",
+					argv[i + 1]);
+	}
 
 	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
 			&xpp, XDL_MERGE_ZEALOUS, &result);
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index c76fccf..1decbfb 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -134,5 +134,10 @@ EOF
 
 test_expect_success "expected conflict markers" "git diff expect out"
 
+test_expect_success 'binary files cannot be merged' '
+	! git merge-file -p orig.txt ../test4012.png new1.txt 2> merge.err &&
+	grep "Cannot merge binary files" merge.err
+'
+
 test_done
 
-- 
1.5.2.1.2626.ge1044-dirty
