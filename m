From: Jeff King <peff@peff.net>
Subject: [PATCH 09/14] shortlog: optimize out useless string list
Date: Tue, 29 Dec 2015 02:32:19 -0500
Message-ID: <20151229073219.GI8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:32:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDole-000158-CX
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbbL2HcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:32:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:46634 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751756AbbL2HcW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:32:22 -0500
Received: (qmail 18253 invoked by uid 102); 29 Dec 2015 07:32:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:32:22 -0600
Received: (qmail 19950 invoked by uid 107); 29 Dec 2015 07:32:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:32:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:32:19 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283100>

If we are in "--summary" mode, then we do not care about the
actual list of subject onelines associated with each author.
We care only about the number. So rather than store a
string-list for each author full of "<none>", let's just
keep a count.

This drops my best-of-five for "git shortlog -ns HEAD" on
linux.git from:

  real    0m5.194s
  user    0m5.028s
  sys     0m0.168s

to:

  real    0m5.057s
  user    0m4.916s
  sys     0m0.144s

That's about 2.5%.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 400e03b..7ec6b76 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -14,7 +14,26 @@ static char const * const shortlog_usage[] = {
 	NULL
 };
 
-static int compare_by_number(const void *a1, const void *a2)
+/*
+ * The util field of our string_list_items will contain one of two things:
+ *
+ *   - if --summary is not in use, it will point to a string list of the
+ *     oneline subjects assigned to this author
+ *
+ *   - if --summary is in use, we don't need that list; we only need to know
+ *     its size. So we abuse the pointer slot to store our integer counter.
+ *
+ *  This macro accesses the latter.
+ */
+#define UTIL_TO_INT(x) ((intptr_t)(x)->util)
+
+static int compare_by_counter(const void *a1, const void *a2)
+{
+	const struct string_list_item *i1 = a1, *i2 = a2;
+	return UTIL_TO_INT(i2) - UTIL_TO_INT(i1);
+}
+
+static int compare_by_list(const void *a1, const void *a2)
 {
 	const struct string_list_item *i1 = a1, *i2 = a2;
 	const struct string_list *l1 = i1->util, *l2 = i2->util;
@@ -52,11 +71,9 @@ static void insert_one_record(struct shortlog *log,
 		strbuf_addf(&namemailbuf, " <%.*s>", (int)maillen, mailbuf);
 
 	item = string_list_insert(&log->list, namemailbuf.buf);
-	if (item->util == NULL)
-		item->util = xcalloc(1, sizeof(struct string_list));
 
 	if (log->summary)
-		string_list_append(item->util, xstrdup(""));
+		item->util = (void *)(UTIL_TO_INT(item) + 1);
 	else {
 		const char *dot3 = log->common_repo_prefix;
 		char *buffer, *p;
@@ -90,6 +107,8 @@ static void insert_one_record(struct shortlog *log,
 			}
 		}
 
+		if (item->util == NULL)
+			item->util = xcalloc(1, sizeof(struct string_list));
 		string_list_append(item->util, buffer);
 	}
 }
@@ -291,14 +310,14 @@ void shortlog_output(struct shortlog *log)
 
 	if (log->sort_by_number)
 		qsort(log->list.items, log->list.nr, sizeof(struct string_list_item),
-			compare_by_number);
+		      log->summary ? compare_by_counter : compare_by_list);
 	for (i = 0; i < log->list.nr; i++) {
-		struct string_list *onelines = log->list.items[i].util;
-
+		const struct string_list_item *item = &log->list.items[i];
 		if (log->summary) {
-			printf("%6d\t%s\n", onelines->nr, log->list.items[i].string);
+			printf("%6d\t%s\n", (int)UTIL_TO_INT(item), item->string);
 		} else {
-			printf("%s (%d):\n", log->list.items[i].string, onelines->nr);
+			struct string_list *onelines = item->util;
+			printf("%s (%d):\n", item->string, onelines->nr);
 			for (j = onelines->nr - 1; j >= 0; j--) {
 				const char *msg = onelines->items[j].string;
 
@@ -311,11 +330,11 @@ void shortlog_output(struct shortlog *log)
 					printf("      %s\n", msg);
 			}
 			putchar('\n');
+			onelines->strdup_strings = 1;
+			string_list_clear(onelines, 0);
+			free(onelines);
 		}
 
-		onelines->strdup_strings = 1;
-		string_list_clear(onelines, 0);
-		free(onelines);
 		log->list.items[i].util = NULL;
 	}
 
-- 
2.7.0.rc3.367.g09631da
