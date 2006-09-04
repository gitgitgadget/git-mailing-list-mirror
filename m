From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Do 3-way diff between HEAD, index and working directory
Date: Mon, 4 Sep 2006 21:38:40 +1000
Message-ID: <17660.4160.642852.177249@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 13:53:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKD0f-0004SG-KR
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 13:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWIDLwo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 07:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWIDLwo
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 07:52:44 -0400
Received: from ozlabs.org ([203.10.76.45]:7097 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964813AbWIDLwm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 07:52:42 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 85F7967BEB; Mon,  4 Sep 2006 21:52:41 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26416>

This implements a 3-way diff between the HEAD commit, the state in the
index, and the working directory.  This is like the n-way diff for a
merge, and uses much of the same code.  It is invoked with the -c flag
to git-diff-index, which it already accepted and did nothing with.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Junio, does this look right?  It seems to work OK, and I need it for
my new git commit tool, for the cases where the user has done a
checkin and then further modified the working file.  It will be needed
even more when I implement partial checkins within a file.

Thanks,
Paul.

diff --git a/diff-lib.c b/diff-lib.c
index 9edfa92..fc69fb9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -213,6 +213,31 @@ static int show_modified(struct rev_info
 		return -1;
 	}
 
+	if (revs->combine_merges && !cached &&
+	    (hashcmp(sha1, old->sha1) || hashcmp(old->sha1, new->sha1))) {
+		struct combine_diff_path *p;
+		int pathlen = ce_namelen(new);
+
+		p = xmalloc(combine_diff_path_size(2, pathlen));
+		p->path = (char *) &p->parent[2];
+		p->next = NULL;
+		p->len = pathlen;
+		memcpy(p->path, new->name, pathlen);
+		p->path[pathlen] = 0;
+		p->mode = ntohl(mode);
+		hashclr(p->sha1);
+		memset(p->parent, 0, 2 * sizeof(struct combine_diff_parent));
+		p->parent[0].status = DIFF_STATUS_MODIFIED;
+		p->parent[0].mode = ntohl(new->ce_mode);
+		hashcpy(p->parent[0].sha1, new->sha1);
+		p->parent[1].status = DIFF_STATUS_MODIFIED;
+		p->parent[1].mode = ntohl(old->ce_mode);
+		hashcpy(p->parent[1].sha1, old->sha1);
+		show_combined_diff(p, 2, revs->dense_combined_merges, revs);
+		free(p);
+		return 0;
+	}
+
 	oldmode = old->ce_mode;
 	if (mode == oldmode && !hashcmp(sha1, old->sha1) &&
 	    !revs->diffopt.find_copies_harder)

-- 
VGER BF report: U 0.519891
