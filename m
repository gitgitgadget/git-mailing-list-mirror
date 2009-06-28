From: Martin Renold <martinxyz@gmx.ch>
Subject: [PATCH] Remove filename from conflict markers
Date: Sun, 28 Jun 2009 17:45:59 +0200
Message-ID: <20090628154559.GA29049@old.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 17:46:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKwa5-0007op-UY
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 17:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbZF1Pp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 11:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbZF1Pp6
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 11:45:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:53069 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751669AbZF1Pp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 11:45:57 -0400
Received: (qmail invoked by alias); 28 Jun 2009 15:45:59 -0000
Received: from 84-74-83-103.dclient.hispeed.ch (EHLO bazaar) [84.74.83.103]
  by mail.gmx.net (mp047) with SMTP; 28 Jun 2009 17:45:59 +0200
X-Authenticated: #1936982
X-Provags-ID: V01U2FsdGVkX19gFDN/woJgpFNM9xHlJEJv9TkFWJO9bXWxx85TYd
	WYjHtN/jc/cDh8
Received: from martin by bazaar with local (Exim 4.69)
	(envelope-from <martinxyz@gmx.ch>)
	id 1MKwZs-0007bi-0W
	for git@vger.kernel.org; Sun, 28 Jun 2009 17:46:00 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122410>

Put filenames into the conflict markers only when they are different.
Otherwise they are redundant information clutter.

Signed-off-by: Martin Renold <martinxyz@gmx.ch>
---
 merge-recursive.c             |    9 +++++++--
 t/t3404-rebase-interactive.sh |    4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c703445..53cad96 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -622,8 +622,13 @@ static int merge_3way(struct merge_options *o,
 	char *name1, *name2;
 	int merge_status;
 
-	name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
-	name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
+	if (strcmp(a->path, b->path)) {
+		name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
+		name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
+	} else {
+		name1 = xstrdup(mkpath("%s", branch1));
+		name2 = xstrdup(mkpath("%s", branch2));
+	}
 
 	fill_mm(one->sha1, &orig);
 	fill_mm(a->sha1, &src1);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c32ff66..a973628 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -119,11 +119,11 @@ index e69de29..00750ed 100644
 EOF
 
 cat > expect2 << EOF
-<<<<<<< HEAD:file1
+<<<<<<< HEAD
 2
 =======
 3
->>>>>>> b7ca976... G:file1
+>>>>>>> b7ca976... G
 EOF
 
 test_expect_success 'stop on conflicting pick' '
-- 
1.6.3.1
