From: Jeff King <peff@peff.net>
Subject: [PATCH] remote: improve sorting of "configure for git push" list
Date: Sun, 22 Mar 2009 04:59:20 -0400
Message-ID: <20090322085920.GA5201@coredump.intra.peff.net>
References: <20090319200308.GB17028@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 10:01:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlJYe-0005q4-Hf
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 10:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbZCVI71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 04:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbZCVI71
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 04:59:27 -0400
Received: from peff.net ([208.65.91.99]:39922 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbZCVI70 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 04:59:26 -0400
Received: (qmail 10429 invoked by uid 107); 22 Mar 2009 08:59:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 22 Mar 2009 04:59:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2009 04:59:20 -0400
Content-Disposition: inline
In-Reply-To: <20090319200308.GB17028@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114131>

The data structure used to store this list is a string_list
of sources with the destination in the util member. The
current code just sorts on the source; if a single source is
pushed to two different destination refs at a remote, then
the order in which they are printed is non-deterministic.

This patch implements a comparison using both fields.
Besides being a little nicer on the eyes, giving a stable
sort prevents false negatives in the test suite when
comparing output.

Signed-off-by: Jeff King <peff@peff.net>
---
The discussion of the proper interface to the one-line wrapper to qsort
didn't really resolve anything. It seems that the constraints of C make
a nice wrapper a little painful, so let's just use a bare qsort. Once
again, I really don't care what it looks like, so feel free to mark it
up if you prefer differently; I just want it off my todo list, and to
let JSixt run his tests in peace.

I did have one somewhat sick thought for an API: have string_list's
cmp_items (or an alternate cmp_items_with_util) treat a non-NULL util
member as a pointer to a string, and use it as a secondary key in the
sort. It works here because the first member of the push_info struct is
the secondary key.  But I think it is a bit too subtle for my taste.

 builtin-remote.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 993acd6..9ef846f 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -922,6 +922,20 @@ int add_push_to_show_info(struct string_list_item *push_item, void *cb_data)
 	return 0;
 }
 
+/*
+ * Sorting comparison for a string list that has push_info
+ * structs in its util field
+ */
+static int cmp_string_with_push(const void *va, const void *vb)
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
@@ -1032,7 +1046,8 @@ static int show(int argc, const char **argv)
 
 		info.width = info.width2 = 0;
 		for_each_string_list(add_push_to_show_info, &states.push, &info);
-		sort_string_list(info.list);
+		qsort(info.list->items, info.list->nr,
+			sizeof(*info.list->items), cmp_string_with_push);
 		if (info.list->nr)
 			printf("  Local ref%s configured for 'git push'%s:\n",
 				info.list->nr > 1 ? "s" : "",
-- 
1.6.2.1.276.gd47fa
