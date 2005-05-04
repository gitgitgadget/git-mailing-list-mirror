From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Making cg-seek more robust
Date: Tue, 03 May 2005 20:08:32 -0400
Message-ID: <1115165312.22116.8.camel@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 04 02:03:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT7Lv-0000wE-O4
	for gcvg-git@gmane.org; Wed, 04 May 2005 02:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVEDAIz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 20:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVEDAIz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 20:08:55 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:11757
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261939AbVEDAIe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 20:08:34 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id 4A8DBEFE11; Tue,  3 May 2005 20:08:32 -0400 (EDT)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

This patch does following:

If .git/HEAD is not a link, it's detected early, so that basename is not
called without arguments.

.git/HEAD is not deleted until validity of the branch is verified.

.git/blocked is deleted by "rm -f" to suppress unneeded error message if
it's missing.

Signed-off-by: Pavel Roskin <proski@gnu.org>

--- aa6233be6d1b8bf42797c409a7c23b50593afc99/cg-seek  (mode:100755 sha1:111f7842e5ec20a1e0714e162ca221da5e06ce33)
+++ uncommitted/cg-seek  (mode:100755)
@@ -29,18 +29,23 @@
 if [ -s .git/blocked ]; then
 	branch=$(grep '^seeked from ' .git/blocked | sed 's/^seeked from //')
 else
-	branch=$(basename $(readlink .git/HEAD)) || die "HEAD is not on branch"
+	tmp=$(readlink .git/HEAD)
+	[ "$tmp" ] || die "HEAD is not on branch"
+	branch=$(basename "$tmp")
 fi
 
 curcommit=$(commit-id)
 
-rm .git/HEAD
 if [ ! "$dstcommit" ] || [ "$dstcommit" = "$branch" ]; then
+	rm .git/HEAD
 	ln -s "refs/heads/$branch" .git/HEAD
-	rm .git/blocked
+	rm -f .git/blocked
 	dstcommit=$(commit-id)
 else
-	echo $(commit-id "$dstcommit") >.git/HEAD
+	tmp=$(commit-id "$dstcommit")
+	[ "$tmp" ] || die "branch $dstcommit not found"
+	rm .git/HEAD
+	echo "$tmp" >.git/HEAD
 	[ -s .git/blocked ] || echo "seeked from $branch" >.git/blocked
 fi
 


-- 
Regards,
Pavel Roskin

