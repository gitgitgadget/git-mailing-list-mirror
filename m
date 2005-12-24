From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/4] short circuit out of a few places where we would allocate zero bytes
Date: Sat, 24 Dec 2005 04:12:43 -0800
Message-ID: <20051224121243.GA3963@mail.yhbt.net>
References: <20051224121007.GA19136@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 24 13:12:47 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq8GV-0008MZ-3g
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 13:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVLXMMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 07:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVLXMMo
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 07:12:44 -0500
Received: from hand.yhbt.net ([66.150.188.102]:27267 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932518AbVLXMMn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 07:12:43 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 5A6C97DC005; Sat, 24 Dec 2005 04:12:43 -0800 (PST)
To: git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051224121007.GA19136@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14020>

dietlibc versions of malloc, calloc and realloc all return NULL if
they're told to allocate 0 bytes, causes the x* wrappers to die().

There are several more places where these calls could end up asking
for 0 bytes, too...

Maybe simply not die()-ing in the x* wrappers if 0/NULL is returned
when the requested size is zero is a safer and easier way to go.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 commit.c          |    3 +++
 diffcore-rename.c |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

ee9d90c652be126345dec2ac204284e80e685160
diff --git a/commit.c b/commit.c
index e867b86..edd4ded 100644
--- a/commit.c
+++ b/commit.c
@@ -560,6 +560,9 @@ void sort_in_topological_order(struct co
 		next = next->next;
 		count++;
 	}
+	
+	if (!count)
+		return;
 	/* allocate an array to help sort the list */
 	nodes = xcalloc(count, sizeof(*nodes));
 	/* link the list to the array */
diff --git a/diffcore-rename.c b/diffcore-rename.c
index dba965c..39d9126 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -282,7 +282,7 @@ void diffcore_rename(struct diff_options
 		else if (detect_rename == DIFF_DETECT_COPY)
 			register_rename_src(p->one, 1);
 	}
-	if (rename_dst_nr == 0 ||
+	if (rename_dst_nr == 0 || rename_src_nr == 0 ||
 	    (0 < rename_limit && rename_limit < rename_dst_nr))
 		goto cleanup; /* nothing to do */
 
-- 
1.0.GIT
