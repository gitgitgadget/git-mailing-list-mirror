From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/6] string-list: add functions to work with unsorted lists
Date: Sat, 1 Mar 2008 13:15:47 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803011315400.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <alpine.LSU.1.00.0802290144410.22527@racer.site> <7vprugfrgw.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802290214150.22527@racer.site> <alpine.LSU.1.00.0803011313020.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 14:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVRaV-0007R3-0x
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 14:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbYCANQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 08:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755890AbYCANQ3
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 08:16:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:58309 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755879AbYCANQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 08:16:28 -0500
Received: (qmail invoked by alias); 01 Mar 2008 13:16:26 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp011) with SMTP; 01 Mar 2008 14:16:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/j01FckaDj01NXvdKvQgB5UvJJhqxn5H7cqDwHHW
	T/C4NxUH9ZRGp/
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803011313020.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75667>


Up to now, string-lists were sorted at all times.  But sometimes it
is much more convenient to build the list and sort it at the end,
or sort it not at all.

Add string_list_append() and sort_string_list() to allow that.

Also, add the unsorted_string_list_has_string() function, to do a
linear search.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/CodingGuidelines |    5 +++--
 string-list.c                  |   29 +++++++++++++++++++++++++++++
 string-list.h                  |    8 +++++++-
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index fe7c74b..7507053 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -91,8 +91,9 @@ For C programs:
 
  - Use the API.  No, really.  We have a strbuf (variable length
    string), several arrays with the ALLOC_GROW() macro, a
-   string_list for sorted string lists, a hash map (mapping struct
-   objects) named "struct decorate", amongst other things.
+   string_list for sorted and unsorted string lists, a hash map
+   (mapping struct objects) named "struct decorate", amongst other
+   things.
 
  - When you come up with an API, document it.
 
diff --git a/string-list.c b/string-list.c
index 699e754..ddd83c8 100644
--- a/string-list.c
+++ b/string-list.c
@@ -103,3 +103,32 @@ void print_string_list(const char *text, const struct string_list *p)
 		printf("%s:%p\n", p->items[i].string, p->items[i].util);
 }
 
+struct string_list_item *string_list_append(const char *string, struct string_list *list)
+{
+	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
+	list->items[list->nr].string =
+		list->strdup_strings ? xstrdup(string) : (char *)string;
+	return list->items + list->nr++;
+}
+
+static int cmp_items(const void *a, const void *b)
+{
+	const struct string_list_item *one = a;
+	const struct string_list_item *two = b;
+	return strcmp(one->string, two->string);
+}
+
+void sort_string_list(struct string_list *list)
+{
+	qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
+}
+
+int unsorted_string_list_has_string(struct string_list *list, const char *string)
+{
+	int i;
+	for (i = 0; i < list->nr; i++)
+		if (!strcmp(string, list->items[i].string))
+			return 1;
+	return 0;
+}
+
diff --git a/string-list.h b/string-list.h
index 6195791..4d6a705 100644
--- a/string-list.h
+++ b/string-list.h
@@ -13,10 +13,16 @@ struct string_list
 };
 
 void print_string_list(const char *text, const struct string_list *p);
+void string_list_clear(struct string_list *list, int free_util);
 
+/* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
-void string_list_clear(struct string_list *list, int free_util);
 struct string_list_item *string_list_insert(const char *string, struct string_list *list);
 struct string_list_item *string_list_lookup(const char *string, struct string_list *list);
 
+/* Use these functions only on unsorted lists: */
+struct string_list_item *string_list_append(const char *string, struct string_list *list);
+void sort_string_list(struct string_list *list);
+int unsorted_string_list_has_string(struct string_list *list, const char *string);
+
 #endif /* PATH_LIST_H */
-- 
1.5.4.3.446.gbe8932


