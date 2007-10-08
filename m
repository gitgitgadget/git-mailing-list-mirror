From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Remove duplicate ref matches in fetch
Date: Mon, 8 Oct 2007 00:25:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710080014000.23070@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 06:25:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IekBD-0007BK-Rq
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 06:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbXJHEZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 00:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbXJHEZK
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 00:25:10 -0400
Received: from iabervon.org ([66.92.72.58]:60883 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbXJHEZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 00:25:09 -0400
Received: (qmail 23291 invoked by uid 1000); 8 Oct 2007 04:25:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Oct 2007 04:25:07 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60286>

If multiple refspecs matched the same ref, the update would be
processed multiple times. Now having the same destination for the same
source has no additional effect, and having the same destination for
different sources is an error.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
I tested this with the usual tests, but (a) they don't include this case 
(yet), and (b) they passed before I fixed a bug. So this should get some 
good testing, and probably by somebody with valgrind --leak-check to make 
sure I'm deallocating things correctly.

 builtin-fetch.c |    1 +
 remote.c        |   27 +++++++++++++++++++++++++++
 remote.h        |    5 +++++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index cf7498b..caaca63 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -112,6 +112,7 @@ static struct ref *get_ref_map(struct transport *transport,
 			ref_map->merge = 1;
 		}
 	}
+	ref_remove_duplicates(ref_map);
 
 	return ref_map;
 }
diff --git a/remote.c b/remote.c
index e7d735b..e2ca4d3 100644
--- a/remote.c
+++ b/remote.c
@@ -380,6 +380,33 @@ int for_each_remote(each_remote_fn fn, void *priv)
 	return result;
 }
 
+void ref_remove_duplicates(struct ref *ref_map)
+{
+	struct ref **posn;
+	struct ref *next;
+	for (; ref_map; ref_map = ref_map->next) {
+		if (!ref_map->peer_ref)
+			continue;
+		posn = &ref_map->next;
+		while (*posn) {
+			if ((*posn)->peer_ref &&
+			    !strcmp((*posn)->peer_ref->name,
+				    ref_map->peer_ref->name)) {
+				if (strcmp((*posn)->name, ref_map->name))
+					die("%s tracks both %s and %s",
+					    ref_map->peer_ref->name,
+					    (*posn)->name, ref_map->name);
+				next = (*posn)->next;
+				free((*posn)->peer_ref);
+				free(*posn);
+				*posn = next;
+			} else {
+				posn = &(*posn)->next;
+			}
+		}
+	}
+}
+
 int remote_has_url(struct remote *remote, const char *url)
 {
 	int i;
diff --git a/remote.h b/remote.h
index 05add06..c62636d 100644
--- a/remote.h
+++ b/remote.h
@@ -49,6 +49,11 @@ struct ref *alloc_ref(unsigned namelen);
  */
 void free_refs(struct ref *ref);
 
+/*
+ * Removes and frees any duplicate refs in the map.
+ */
+void ref_remove_duplicates(struct ref *ref_map);
+
 struct refspec *parse_ref_spec(int nr_refspec, const char **refspec);
 
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
-- 
1.5.3.4.1155.gfe96ee
