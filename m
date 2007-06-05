From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] merge-recursive: refuse to merge binary files
Date: Tue, 5 Jun 2007 03:36:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706050336270.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 05 04:39:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvOx7-0004A8-3K
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 04:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760827AbXFECi4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 22:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760192AbXFECi4
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 22:38:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:41613 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760813AbXFECiz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 22:38:55 -0400
Received: (qmail invoked by alias); 05 Jun 2007 02:38:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 05 Jun 2007 04:38:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/s3q9ngLXs6pzstK+dvP5yYGcSQ61GuV7zrNfd8X
	yItUosPAFM9d5J
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49148>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c          |    6 ++++++
 t/t6024-recursive-merge.sh |   14 ++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4d70fd4..02c7983 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -658,6 +658,12 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 {
 	xpparam_t xpp;
 
+	if (buffer_is_binary(orig->ptr, orig->size) ||
+			buffer_is_binary(src1->ptr, src1->size) ||
+			buffer_is_binary(src2->ptr, src2->size))
+		return error("Cannot merge binary files: %s vs. %s\n",
+			name1, name2);
+
 	memset(&xpp, 0, sizeof(xpp));
 	return xdl_merge(orig,
 			 src1, name1,
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index a398556..058db9c 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -81,4 +81,18 @@ EOF
 
 test_expect_success "virtual trees were processed" "git diff expect out"
 
+git reset --hard
+test_expect_success 'refuse to merge binary files' '
+	printf "\0" > binary-file &&
+	git add binary-file &&
+	git commit -m binary &&
+	git checkout G &&
+	printf "\0\0" > binary-file &&
+	git add binary-file &&
+	git commit -m binary2 &&
+	! git merge F > merge.out 2> merge.err &&
+	grep "Cannot merge binary files: HEAD:binary-file vs. F:binary-file" \
+		merge.err
+'
+
 test_done
-- 
1.5.2.1.2626.ge1044-dirty
