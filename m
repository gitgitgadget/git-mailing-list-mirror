From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] path-list.c: always free strdup'ed paths
Date: Sat, 07 Jul 2007 21:41:08 +0200
Message-ID: <468FEC54.307@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jul 07 21:41:25 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7G9l-0000zH-9H
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 21:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbXGGTlN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 15:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbXGGTlN
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 15:41:13 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:56942
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752988AbXGGTlM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jul 2007 15:41:12 -0400
Received: from [10.0.1.201] (p508E3CFB.dip.t-dialin.net [80.142.60.251])
	by neapel230.server4you.de (Postfix) with ESMTP id 2C17B16022;
	Sat,  7 Jul 2007 21:41:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51836>

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
 
