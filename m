From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/6] path-list: add functions to work with unsorted lists
Date: Wed, 5 Dec 2007 19:05:09 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712051905000.27959@racer.site>
References: <Pine.LNX.4.64.0712051858270.27959@racer.site>
 <Pine.LNX.4.64.0712051900370.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 05 20:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzzZJ-0002tX-1p
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbXLETFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbXLETFk
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:05:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:39167 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751701AbXLETFj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:05:39 -0500
Received: (qmail invoked by alias); 05 Dec 2007 19:05:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 05 Dec 2007 20:05:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BVuQayekBUjWxUIeMkChLQmL3shU3epSfJ9rwPY
	ZHo4nBPk1jYlwO
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712051900370.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67180>


Up to now, path-lists were sorted at all times.  But sometimes it
is much more convenient to build the list and sort it at the end,
or sort it not at all.

Add path_list_append() and sort_path_list() to allow that.

Also, add the unsorted_path_list_has_path() function, to do a linear
search.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I should have done that long ago.

 path-list.c |   30 ++++++++++++++++++++++++++++++
 path-list.h |    8 +++++++-
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/path-list.c b/path-list.c
index 3d83b7b..92e5cf2 100644
--- a/path-list.c
+++ b/path-list.c
@@ -102,3 +102,33 @@ void print_path_list(const char *text, const struct path_list *p)
 	for (i = 0; i < p->nr; i++)
 		printf("%s:%p\n", p->items[i].path, p->items[i].util);
 }
+
+struct path_list_item *path_list_append(const char *path, struct path_list *list)
+{
+	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
+	list->items[list->nr].path =
+		list->strdup_paths ? xstrdup(path) : (char *)path;
+	return list->items + list->nr++;
+}
+
+static int cmp_items(const void *a, const void *b)
+{
+	const struct path_list_item *one = a;
+	const struct path_list_item *two = b;
+	return strcmp(one->path, two->path);
+}
+
+void sort_path_list(struct path_list *list)
+{
+	qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
+}
+
+int unsorted_path_list_has_path(struct path_list *list, const char *path)
+{
+	int i;
+	for (i = 0; i < list->nr; i++)
+		if (!strcmp(path, list->items[i].path))
+			return 1;
+	return 0;
+}
+
diff --git a/path-list.h b/path-list.h
index 5931e2c..ca2cbba 100644
--- a/path-list.h
+++ b/path-list.h
@@ -13,10 +13,16 @@ struct path_list
 };
 
 void print_path_list(const char *text, const struct path_list *p);
+void path_list_clear(struct path_list *list, int free_util);
 
+/* Use these functions only on sorted lists: */
 int path_list_has_path(const struct path_list *list, const char *path);
-void path_list_clear(struct path_list *list, int free_util);
 struct path_list_item *path_list_insert(const char *path, struct path_list *list);
 struct path_list_item *path_list_lookup(const char *path, struct path_list *list);
 
+/* Use these functions only on unsorted lists: */
+struct path_list_item *path_list_append(const char *path, struct path_list *list);
+void sort_path_list(struct path_list *list);
+int unsorted_path_list_has_path(struct path_list *list, const char *path);
+
 #endif /* PATH_LIST_H */
-- 
1.5.3.7.2157.g9598e
