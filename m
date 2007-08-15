From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH][RESEND] path-list.c: always free strdup'ed paths
Date: Wed, 15 Aug 2007 17:59:24 +0200
Message-ID: <46C322DC.9030007@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Aug 15 17:59:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILLHm-0006DV-6e
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 17:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484AbXHOP7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 11:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbXHOP7o
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 11:59:44 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:42214
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754171AbXHOP7n (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2007 11:59:43 -0400
Received: from [10.0.1.201] (p508ED580.dip.t-dialin.net [80.142.213.128])
	by neapel230.server4you.de (Postfix) with ESMTP id E26298B008;
	Wed, 15 Aug 2007 17:59:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55915>

Always free .paths if .strdup_paths is set, no matter if the
parameter free_items is set or not, plugging a minor memory leak.
And to clarify the meaning of the flag, rename it to free_util,
since it now only affects the freeing of the .util field.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 path-list.c |   14 ++++++++------
 path-list.h |    2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/path-list.c b/path-list.c
index dcb4b3a..3d83b7b 100644
--- a/path-list.c
+++ b/path-list.c
@@ -76,16 +76,18 @@ struct path_list_item *path_list_lookup(const char *path, struct path_list *list
 	return list->items + i;
 }
 
-void path_list_clear(struct path_list *list, int free_items)
+void path_list_clear(struct path_list *list, int free_util)
 {
 	if (list->items) {
 		int i;
-		if (free_items)
-			for (i = 0; i < list->nr; i++) {
-				if (list->strdup_paths)
-					free(list->items[i].path);
+		if (list->strdup_paths) {
+			for (i = 0; i < list->nr; i++)
+				free(list->items[i].path);
+		}
+		if (free_util) {
+			for (i = 0; i < list->nr; i++)
 				free(list->items[i].util);
-			}
+		}
 		free(list->items);
 	}
 	list->items = NULL;
diff --git a/path-list.h b/path-list.h
index ce5ffab..5931e2c 100644
--- a/path-list.h
+++ b/path-list.h
@@ -15,7 +15,7 @@ struct path_list
 void print_path_list(const char *text, const struct path_list *p);
 
 int path_list_has_path(const struct path_list *list, const char *path);
-void path_list_clear(struct path_list *list, int free_items);
+void path_list_clear(struct path_list *list, int free_util);
 struct path_list_item *path_list_insert(const char *path, struct path_list *list);
 struct path_list_item *path_list_lookup(const char *path, struct path_list *list);
 
