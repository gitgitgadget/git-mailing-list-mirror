From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Catch empty pathnames in trees during fsck
Date: Sat, 28 Apr 2007 20:29:23 -0400
Message-ID: <20070429002923.GA30026@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 02:30:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhxJI-00060z-DY
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 02:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469AbXD2A32 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 20:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbXD2A32
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 20:29:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46742 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469AbXD2A31 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 20:29:27 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HhxHv-0005q1-J3; Sat, 28 Apr 2007 20:29:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EC80320FBAE; Sat, 28 Apr 2007 20:29:23 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45804>

Released versions of fast-import have been able to create a tree that
contains files or subtrees that contain no name.  Unfortunately these
trees aren't valid, but people may have actually tried to create them
due to bugs in import-tars.perl or their own fast-import frontend.

We now look for this unusual condition and warn the user if at
least one of their tree objects contains the problem.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fsck.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index fcb8ed5..44ce629 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -219,6 +219,7 @@ static int fsck_tree(struct tree *item)
 {
 	int retval;
 	int has_full_path = 0;
+	int has_empty_name = 0;
 	int has_zero_pad = 0;
 	int has_bad_modes = 0;
 	int has_dup_entries = 0;
@@ -242,6 +243,8 @@ static int fsck_tree(struct tree *item)
 
 		if (strchr(name, '/'))
 			has_full_path = 1;
+		if (!*name)
+			has_empty_name = 1;
 		has_zero_pad |= *(char *)desc.buffer == '0';
 		update_tree_entry(&desc);
 
@@ -291,6 +294,9 @@ static int fsck_tree(struct tree *item)
 	if (has_full_path) {
 		objwarning(&item->object, "contains full pathnames");
 	}
+	if (has_empty_name) {
+		objwarning(&item->object, "contains empty pathname");
+	}
 	if (has_zero_pad) {
 		objwarning(&item->object, "contains zero-padded file modes");
 	}
-- 
1.5.1.1.135.gf948
