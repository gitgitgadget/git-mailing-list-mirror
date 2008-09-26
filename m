From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Use remove_path from dir.c instead of own implementation
Date: Sat, 27 Sep 2008 00:59:14 +0200
Message-ID: <20080926225914.GA13879@blimp.localhost>
References: <87k5d1v71l.fsf@cup.kalibalik.dk> <20080925201245.GB3959@blimp.localhost> <20080925201734.GA18315@blimp.localhost> <20080925202237.GB18315@blimp.localhost> <20080926152823.GA17470@spearce.org> <20080926225645.GA13412@blimp.localhost>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 01:00:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjMIW-0002Zu-5Z
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 01:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbYIZW7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 18:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbYIZW7T
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 18:59:19 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:21938 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbYIZW7S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 18:59:18 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AU8zrdc=
Received: from tigra.home (Faa4e.f.strato-dslnet.de [195.4.170.78])
	by post.webmailer.de (fruni mo38) (RZmta 17.7)
	with ESMTP id j0551ek8QLfOOM ; Sat, 27 Sep 2008 00:59:14 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 78F8A277AE;
	Sat, 27 Sep 2008 00:59:14 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 58C2136D1E; Sat, 27 Sep 2008 00:59:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080926225645.GA13412@blimp.localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96892>

Besides, it fixes a memleak (builtin-rm.c) and accidental change of
the input const argument (builtin-merge-recursive.c).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Sat, Sep 27, 2008 00:56:45 +0200:
> > remove_path is its long-lost soul mate.  I'm not applying this
> > builtin-rm fix, and am hoping you'll rewrite it around a move
> > of remove_path to dir.c...  ;-)
> >  
> 
> Okay :) The next one is on top of the previous fix in merge-recursive
> (removes ENOENT conditional)
> 

This one.

 builtin-apply.c           |   11 ++---------
 builtin-merge-recursive.c |   21 ++-------------------
 builtin-rm.c              |   22 +---------------------
 3 files changed, 5 insertions(+), 49 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 20bef1f..70c9f93 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -13,6 +13,7 @@
 #include "delta.h"
 #include "builtin.h"
 #include "string-list.h"
+#include "dir.h"
 
 /*
  *  --check turns on checking that the working tree matches the
@@ -2735,15 +2736,7 @@ static void remove_file(struct patch *patch, int rmdir_empty)
 				warning("unable to remove submodule %s",
 					patch->old_name);
 		} else if (!unlink(patch->old_name) && rmdir_empty) {
-			char *name = xstrdup(patch->old_name);
-			char *end = strrchr(name, '/');
-			while (end) {
-				*end = 0;
-				if (rmdir(name))
-					break;
-				end = strrchr(name, '/');
-			}
-			free(name);
+			remove_path(patch->old_name);
 		}
 	}
 }
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index a29b47f..36aa798 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -18,6 +18,7 @@
 #include "ll-merge.h"
 #include "interpolate.h"
 #include "attr.h"
+#include "dir.h"
 #include "merge-recursive.h"
 
 static int subtree_merge;
@@ -416,24 +417,6 @@ static int update_stages(const char *path, struct diff_filespec *o,
 	return 0;
 }
 
-static int remove_path(const char *name)
-{
-	int ret;
-	char *slash, *dirs;
-
-	ret = unlink(name);
-	if (ret)
-		return ret;
-	dirs = xstrdup(name);
-	while ((slash = strrchr(name, '/'))) {
-		*slash = '\0';
-		if (rmdir(name) != 0)
-			break;
-	}
-	free(dirs);
-	return ret;
-}
-
 static int remove_file(int clean, const char *path, int no_wd)
 {
 	int update_cache = index_only || clean;
@@ -444,7 +427,7 @@ static int remove_file(int clean, const char *path, int no_wd)
 			return -1;
 	}
 	if (update_working_directory) {
-		if (remove_path(path) && errno != ENOENT)
+		if (remove_path(path))
 			return -1;
 	}
 	return 0;
diff --git a/builtin-rm.c b/builtin-rm.c
index fdac34f..50ae6d5 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -29,26 +29,6 @@ static void add_list(const char *name)
 	list.name[list.nr++] = name;
 }
 
-static int remove_file(const char *name)
-{
-	int ret;
-	char *slash;
-
-	ret = unlink(name);
-	if (ret && errno == ENOENT)
-		/* The user has removed it from the filesystem by hand */
-		ret = errno = 0;
-
-	if (!ret && (slash = strrchr(name, '/'))) {
-		char *n = xstrdup(name);
-		do {
-			n[slash - name] = 0;
-			name = n;
-		} while (!rmdir(name) && (slash = strrchr(name, '/')));
-	}
-	return ret;
-}
-
 static int check_local_mod(unsigned char *head, int index_only)
 {
 	/* items in list are already sorted in the cache order,
@@ -239,7 +219,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		int removed = 0;
 		for (i = 0; i < list.nr; i++) {
 			const char *path = list.name[i];
-			if (!remove_file(path)) {
+			if (!remove_path(path)) {
 				removed = 1;
 				continue;
 			}
-- 
1.6.0.2.328.g14651
