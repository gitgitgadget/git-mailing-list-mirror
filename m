From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 3/4] add --missing-ok option to write-tree
Date: Sun, 10 Jul 2005 23:53:44 -0400
Message-ID: <20050711035338.22229.47651.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050711035305.22229.87752.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 05:54:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrpMe-0008FO-Tv
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 05:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVGKDxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 23:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVGKDxq
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 23:53:46 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:54105 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262219AbVGKDxo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 23:53:44 -0400
Received: (qmail 25389 invoked from network); 11 Jul 2005 03:53:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=a7Gu748zKdG6NDXz8AvgrGQuzYH264XaP50S3xD/dlwK8vj5oERXW+OCB++p0NakI4IP0dwzIYP5wo8S6QPN5UbGZWyGrcHN5A5fqL8A1KNoMxgLt75MH4EfpUzQGt0asZpqmMM1y1EQaJ6qs+ICKCKnr0vtxp0Xv1FStszKBgs=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp106.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 03:53:43 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050711035305.22229.87752.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add --missing-ok option to git-write.tree.  This option allows a write-tree even if the referenced objects are not in the database.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -10,6 +10,7 @@ git-write-tree - Creates a tree from the
 SYNOPSIS
 --------
 'git-write-tree'
+		[--missing-ok]
 
 DESCRIPTION
 -----------
@@ -23,7 +24,11 @@ In order to have that match what is actu
 now, you need to have done a "git-update-cache" phase before you did the
 "git-write-tree".
 
-
+OPTIONS
+-------
+--missing-ok::
+	Normally "git-write-tree" ensures that the objects referenced by the
+	directory exist in the object database.  This option disables this check.
 
 
 ////////////////////////////////////////////////////////////////
diff --git a/write-tree.c b/write-tree.c
--- a/write-tree.c
+++ b/write-tree.c
@@ -5,6 +5,8 @@
  */
 #include "cache.h"
 
+static int missing_ok = 0;
+
 static int check_valid_sha1(unsigned char *sha1)
 {
 	int ret;
@@ -61,7 +63,7 @@ static int write_tree(struct cache_entry
 			sha1 = subdir_sha1;
 		}
 
-		if (check_valid_sha1(sha1) < 0)
+		if (!missing_ok && check_valid_sha1(sha1) < 0)
 			exit(1);
 
 		entrylen = pathlen - baselen;
@@ -86,6 +88,16 @@ int main(int argc, char **argv)
 	int i, funny;
 	int entries = read_cache();
 	unsigned char sha1[20];
+	
+	if (argc==2) {
+		if (!strcmp(argv[1], "--missing-ok"))
+			missing_ok = 1;
+		else
+			die("unknown option %s", argv[1]);
+	}
+	
+	if (argc>2)
+		die("too many options");
 
 	if (entries < 0)
 		die("git-write-tree: error reading cache");
