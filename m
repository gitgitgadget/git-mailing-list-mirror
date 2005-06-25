From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [PATCH] git-write-tree doesn't check alternate directories
Date: Sat, 25 Jun 2005 14:23:36 -0400
Message-ID: <20050625182336.GA10425@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jun 25 20:17:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmFDc-0006wI-Nf
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 20:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVFYSXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 14:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVFYSXz
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 14:23:55 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:27779 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261259AbVFYSXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 14:23:42 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DmFJY-0002lQ-00; Sat, 25 Jun 2005 14:23:36 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-write-tree failed when referenced objects only exist in the
GIT_ALTERNATE_OBJECT_DIRECTORIES path.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>


diff --git a/write-tree.c b/write-tree.c
--- a/write-tree.c
+++ b/write-tree.c
@@ -7,14 +7,13 @@
 
 static int check_valid_sha1(unsigned char *sha1)
 {
-	char *filename = sha1_file_name(sha1);
 	int ret;
 
 	/* If we were anal, we'd check that the sha1 of the contents actually matches */
-	ret = access(filename, R_OK);
-	if (ret)
-		perror(filename);
-	return ret;
+	ret = has_sha1_file(sha1);
+	if (ret == 0)
+		perror(sha1_file_name(sha1));
+	return ret ? 0 : -1;
 }
 
 static int write_tree(struct cache_entry **cachep, int maxentries, const char *base, int baselen, unsigned char *returnsha1)
