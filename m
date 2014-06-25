From: Jeff King <peff@peff.net>
Subject: [PATCH 5/8] string-list: add pos to iterator callback
Date: Wed, 25 Jun 2014 19:42:52 -0400
Message-ID: <20140625234252.GE23146@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 01:43:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzwqB-0005Vj-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 01:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810AbaFYXmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 19:42:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:51223 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752641AbaFYXmy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 19:42:54 -0400
Received: (qmail 5148 invoked by uid 102); 25 Jun 2014 23:42:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 18:42:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 19:42:52 -0400
Content-Disposition: inline
In-Reply-To: <20140625233429.GA20457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252477>

When we are running a string-list foreach or filter, the
callback function sees only the string_list_item, along with
a void* data pointer provided by the caller. This is
sufficient for most purposes.

However, it can also be useful to know the position of the
item within the string (for example, if the data pointer
points to a secondary array in which each element
corresponds to part of the string list). We can help this
use case by providing the position to each callback.

Signed-off-by: Jeff King <peff@peff.net>
---
The diff here is noisy, and I expect in the long run that the one caller
I add to builtin/tag.c later in the series will eventually stop using
string_list entirely (in favor of a custom struct), which may leave us
with no callers that actually use the new field.

I do think the logic above is sound, though, and it's a potentially
useful thing. There may be other sites that avoid the for_each wrapper
in favor of iterating themselves simply _because_ they needed to know
the position (I would just do the same here, except that my new caller
wants to use filter_string_list, which is a little more complicated).

 builtin/clone.c    |  2 +-
 builtin/remote.c   | 12 ++++++------
 notes.c            |  1 +
 setup.c            |  1 +
 string-list.c      |  6 +++---
 string-list.h      |  9 +++++++--
 test-path-utils.c  |  2 +-
 test-string-list.c |  2 +-
 8 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b12989d..89d0709 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -227,7 +227,7 @@ static void strip_trailing_slashes(char *dir)
 	*end = '\0';
 }
 
-static int add_one_reference(struct string_list_item *item, void *cb_data)
+static int add_one_reference(struct string_list_item *item, int pos, void *cb_data)
 {
 	char *ref_git;
 	const char *repo;
diff --git a/builtin/remote.c b/builtin/remote.c
index c9102e8..bea0b58 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -925,7 +925,7 @@ struct show_info {
 	int any_rebase;
 };
 
-static int add_remote_to_show_info(struct string_list_item *item, void *cb_data)
+static int add_remote_to_show_info(struct string_list_item *item, int pos, void *cb_data)
 {
 	struct show_info *info = cb_data;
 	int n = strlen(item->string);
@@ -935,7 +935,7 @@ static int add_remote_to_show_info(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-static int show_remote_info_item(struct string_list_item *item, void *cb_data)
+static int show_remote_info_item(struct string_list_item *item, int pos, void *cb_data)
 {
 	struct show_info *info = cb_data;
 	struct ref_states *states = info->states;
@@ -962,7 +962,7 @@ static int show_remote_info_item(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-static int add_local_to_show_info(struct string_list_item *branch_item, void *cb_data)
+static int add_local_to_show_info(struct string_list_item *branch_item, int pos, void *cb_data)
 {
 	struct show_info *show_info = cb_data;
 	struct ref_states *states = show_info->states;
@@ -984,7 +984,7 @@ static int add_local_to_show_info(struct string_list_item *branch_item, void *cb
 	return 0;
 }
 
-static int show_local_info_item(struct string_list_item *item, void *cb_data)
+static int show_local_info_item(struct string_list_item *item, int pos, void *cb_data)
 {
 	struct show_info *show_info = cb_data;
 	struct branch_info *branch_info = item->util;
@@ -1016,7 +1016,7 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-static int add_push_to_show_info(struct string_list_item *push_item, void *cb_data)
+static int add_push_to_show_info(struct string_list_item *push_item, int pos, void *cb_data)
 {
 	struct show_info *show_info = cb_data;
 	struct push_info *push_info = push_item->util;
@@ -1045,7 +1045,7 @@ static int cmp_string_with_push(const void *va, const void *vb)
 	return cmp ? cmp : strcmp(a_push->dest, b_push->dest);
 }
 
-static int show_push_info_item(struct string_list_item *item, void *cb_data)
+static int show_push_info_item(struct string_list_item *item, int pos, void *cb_data)
 {
 	struct show_info *show_info = cb_data;
 	struct push_info *push_info = item->util;
diff --git a/notes.c b/notes.c
index 5fe691d..f7a84f9 100644
--- a/notes.c
+++ b/notes.c
@@ -881,6 +881,7 @@ static int string_list_add_note_lines(struct string_list *list,
 }
 
 static int string_list_join_lines_helper(struct string_list_item *item,
+					 int pos,
 					 void *cb_data)
 {
 	struct strbuf *buf = cb_data;
diff --git a/setup.c b/setup.c
index 0a22f8b..0fe92fe 100644
--- a/setup.c
+++ b/setup.c
@@ -586,6 +586,7 @@ static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_
  * subsequent entries.
  */
 static int canonicalize_ceiling_entry(struct string_list_item *item,
+				      int pos,
 				      void *cb_data)
 {
 	int *empty_entry_found = cb_data;
diff --git a/string-list.c b/string-list.c
index aabb25e..85e1e41 100644
--- a/string-list.c
+++ b/string-list.c
@@ -116,7 +116,7 @@ int for_each_string_list(struct string_list *list,
 {
 	int i, ret = 0;
 	for (i = 0; i < list->nr; i++)
-		if ((ret = fn(&list->items[i], cb_data)))
+		if ((ret = fn(&list->items[i], i, cb_data)))
 			break;
 	return ret;
 }
@@ -126,7 +126,7 @@ void filter_string_list(struct string_list *list, int free_util,
 {
 	int src, dst = 0;
 	for (src = 0; src < list->nr; src++) {
-		if (want(&list->items[src], cb_data)) {
+		if (want(&list->items[src], src, cb_data)) {
 			list->items[dst++] = list->items[src];
 		} else {
 			if (list->strdup_strings)
@@ -138,7 +138,7 @@ void filter_string_list(struct string_list *list, int free_util,
 	list->nr = dst;
 }
 
-static int item_is_not_empty(struct string_list_item *item, void *unused)
+static int item_is_not_empty(struct string_list_item *item, int pos, void *unused)
 {
 	return *item->string != '\0';
 }
diff --git a/string-list.h b/string-list.h
index dd5e294..3318076 100644
--- a/string-list.h
+++ b/string-list.h
@@ -26,8 +26,13 @@ void string_list_clear(struct string_list *list, int free_util);
 typedef void (*string_list_clear_func_t)(void *p, const char *str);
 void string_list_clear_func(struct string_list *list, string_list_clear_func_t clearfunc);
 
-/* Use this function or the macro below to iterate over each item */
-typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
+/*
+ * Use this function or the macro below to iterate over each item. Each item
+ * is passed as the first argument to an invocation of the callback. The second
+ * argument, "pos", is the numeric position of the first argument within the
+ * list (_not_ an offset from the first item).
+ */
+typedef int (*string_list_each_func_t)(struct string_list_item *, int pos, void *);
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t, void *cb_data);
 #define for_each_string_list_item(item,list) \
diff --git a/test-path-utils.c b/test-path-utils.c
index 3dd3744..f3c584b 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -6,7 +6,7 @@
  * GIT_CEILING_DIRECTORIES.  If the path is unusable for some reason,
  * die with an explanation.
  */
-static int normalize_ceiling_entry(struct string_list_item *item, void *unused)
+static int normalize_ceiling_entry(struct string_list_item *item, int pos, void *unused)
 {
 	const char *ceil = item->string;
 	int len = strlen(ceil);
diff --git a/test-string-list.c b/test-string-list.c
index 14bdf9d..85d9893 100644
--- a/test-string-list.c
+++ b/test-string-list.c
@@ -35,7 +35,7 @@ static void write_list_compact(const struct string_list *list)
 	}
 }
 
-static int prefix_cb(struct string_list_item *item, void *cb_data)
+static int prefix_cb(struct string_list_item *item, int pos, void *cb_data)
 {
 	const char *prefix = (const char *)cb_data;
 	return starts_with(item->string, prefix);
-- 
2.0.0.566.gfe3e6b2
