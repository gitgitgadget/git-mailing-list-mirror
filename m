From: Jeff King <peff@peff.net>
Subject: Re: t5505-remote fails on Windows
Date: Thu, 19 Mar 2009 00:43:13 -0400
Message-ID: <20090319044313.GA341@coredump.intra.peff.net>
References: <49C0DE23.8020809@viscovery.net> <20090319041837.GA32642@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 05:47:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkAAa-0006iU-Jf
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 05:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbZCSEnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 00:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbZCSEnX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 00:43:23 -0400
Received: from peff.net ([208.65.91.99]:39327 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbZCSEnX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 00:43:23 -0400
Received: (qmail 29574 invoked by uid 107); 19 Mar 2009 04:43:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Mar 2009 00:43:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2009 00:43:13 -0400
Content-Disposition: inline
In-Reply-To: <20090319041837.GA32642@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113714>

On Thu, Mar 19, 2009 at 12:18:37AM -0400, Jeff King wrote:

> > As you can see, the entries for "master pushes to..." are reversed. It
> > seems that this output is not stable. Before I delve into this, do you
> > know whether there is some data structure involved that does not guarantee
> > the order? Such as a hash table, a opendir/readdir sequence, or perhaps
> > while reading the config file?
> 
> That is quite curious, because it is sorted immediately before printing:
> 
>   $ sed -n 1034,1040p builtin-remote.c
>         for_each_string_list(add_push_to_show_info, &states.push, &info);
>         sort_string_list(info.list);

Oh, nevermind. I didn't look closely enough at your issue, which is one
ref pushing to two different places. For that, the sort needs to take
into account the util field, which holds the destination.

The patch below probably fixes it, but as I can't actually reproduce
here, it is largely untested.

As a side note, I find this solution a little bit ugly. String lists
should sort on their strings, not on some other random magic in the util
field. This usage really abuses string_list a bit as a data type because
we have no generic "list" type.

---
diff --git a/builtin-remote.c b/builtin-remote.c
index 993acd6..f94ecd6 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -922,6 +922,16 @@ int add_push_to_show_info(struct string_list_item *push_item, void *cb_data)
 	return 0;
 }
 
+static int push_cmp(const void *va, const void *vb)
+{
+	const struct string_list_item *a = va;
+	const struct string_list_item *b = vb;
+	const struct push_info *a_push = a->util;
+	const struct push_info *b_push = b->util;
+	int cmp = strcmp(a->string, b->string);
+	return cmp ? cmp : strcmp(a_push->dest, b_push->dest);
+}
+
 int show_push_info_item(struct string_list_item *item, void *cb_data)
 {
 	struct show_info *show_info = cb_data;
@@ -1032,7 +1042,7 @@ static int show(int argc, const char **argv)
 
 		info.width = info.width2 = 0;
 		for_each_string_list(add_push_to_show_info, &states.push, &info);
-		sort_string_list(info.list);
+		sort_string_list_with_fn(info.list, push_cmp);
 		if (info.list->nr)
 			printf("  Local ref%s configured for 'git push'%s:\n",
 				info.list->nr > 1 ? "s" : "",
diff --git a/string-list.c b/string-list.c
index 1ac536e..f404a26 100644
--- a/string-list.c
+++ b/string-list.c
@@ -163,9 +163,15 @@ static int cmp_items(const void *a, const void *b)
 	return strcmp(one->string, two->string);
 }
 
+void sort_string_list_with_fn(struct string_list *list,
+			      int (*fn)(const void *, const void *))
+{
+	qsort(list->items, list->nr, sizeof(*list->items), fn);
+}
+
 void sort_string_list(struct string_list *list)
 {
-	qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
+	sort_string_list_with_fn(list, cmp_items);
 }
 
 int unsorted_string_list_has_string(struct string_list *list, const char *string)
diff --git a/string-list.h b/string-list.h
index 14bbc47..4bbc7e8 100644
--- a/string-list.h
+++ b/string-list.h
@@ -37,6 +37,8 @@ struct string_list_item *string_list_lookup(const char *string, struct string_li
 /* Use these functions only on unsorted lists: */
 struct string_list_item *string_list_append(const char *string, struct string_list *list);
 void sort_string_list(struct string_list *list);
+void sort_string_list_with_fn(struct string_list *list,
+			      int (*fn)(const void *, const void *));
 int unsorted_string_list_has_string(struct string_list *list, const char *string);
 
 #endif /* PATH_LIST_H */
