From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Cleanup check_valid in commit-tree.
Date: Tue, 27 Feb 2007 10:00:33 -0500
Message-ID: <20070227150033.GA3242@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9BE-0000mq-GW
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933806AbXB0Unm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933106AbXB0Unl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:43:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45634 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933808AbXB0Unj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:43:39 -0500
X-Greylist: delayed 657 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Feb 2007 15:43:33 EST
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HM3oc-0005PA-8Q; Tue, 27 Feb 2007 10:00:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 93C5220FBAE; Tue, 27 Feb 2007 10:00:33 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40798>

This routine should be using the object_type enum rather than a
string comparsion, as the expected type is always supplied and is
known at compile time.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 On top of Nico's cleanups.

 builtin-commit-tree.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 04f61d5..4a8d8d8 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -45,14 +45,14 @@ static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
 	memcpy(buf + size, one_line, len);
 }
 
-static void check_valid(unsigned char *sha1, const char *expect)
+static void check_valid(unsigned char *sha1, enum object_type expect)
 {
 	enum object_type type = sha1_object_info(sha1, NULL);
 	if (type < 0)
 		die("%s is not a valid object", sha1_to_hex(sha1));
-	if (expect && type != type_from_string(expect))
+	if (type != expect)
 		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
-		    expect);
+		    typename(expect));
 }
 
 /*
@@ -100,7 +100,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	if (get_sha1(argv[1], tree_sha1))
 		die("Not a valid object name %s", argv[1]);
 
-	check_valid(tree_sha1, tree_type);
+	check_valid(tree_sha1, OBJ_TREE);
 	for (i = 2; i < argc; i += 2) {
 		const char *a, *b;
 		a = argv[i]; b = argv[i+1];
@@ -111,7 +111,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			die("Too many parents (%d max)", MAXPARENT);
 		if (get_sha1(b, parent_sha1[parents]))
 			die("Not a valid object name %s", b);
-		check_valid(parent_sha1[parents], commit_type);
+		check_valid(parent_sha1[parents], OBJ_COMMIT);
 		if (new_parent(parents))
 			parents++;
 	}
-- 
1.5.0.2.775.g1a500
