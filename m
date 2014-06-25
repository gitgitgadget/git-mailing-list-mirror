From: Jeff King <peff@peff.net>
Subject: [PATCH 2/8] tag: factor out decision to stream tags
Date: Wed, 25 Jun 2014 19:35:24 -0400
Message-ID: <20140625233524.GB23146@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 01:35:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzwiw-0007nG-BK
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 01:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbaFYXf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 19:35:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:51216 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752641AbaFYXf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 19:35:26 -0400
Received: (qmail 4799 invoked by uid 102); 25 Jun 2014 23:35:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 18:35:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 19:35:24 -0400
Content-Disposition: inline
In-Reply-To: <20140625233429.GA20457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252474>

Right now we stream tags if we are not sorting. If we are
sorting, we save them in a list and print them at the end.
Let's abstract this decision into a function to make it
easier to add more cases where we use the list.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 2adfc3d..3ef2fab 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -225,6 +225,11 @@ static void print_tag(const char *refname, const unsigned char *sha1,
 		}
 }
 
+static int filter_can_stream(struct tag_filter *filter)
+{
+	return !filter->sort;
+}
+
 static int show_reference(const char *refname, const unsigned char *sha1,
 			  int flag, void *cb_data)
 {
@@ -244,7 +249,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 		if (points_at.nr && !match_points_at(refname, sha1))
 			return 0;
 
-		if (filter->sort)
+		if (!filter_can_stream(filter))
 			string_list_append(&filter->tags, refname)->util = hashdup(sha1);
 		else
 			print_tag(refname, sha1, filter->lines);
@@ -273,11 +278,11 @@ static int list_tags(const char **patterns, int lines,
 	filter.tags.strdup_strings = 1;
 
 	for_each_tag_ref(show_reference, (void *) &filter);
-	if (sort) {
+	if ((sort & SORT_MASK) == VERCMP_SORT)
+		qsort(filter.tags.items, filter.tags.nr,
+		      sizeof(struct string_list_item), sort_by_version);
+	if (!filter_can_stream(&filter)) {
 		int i;
-		if ((sort & SORT_MASK) == VERCMP_SORT)
-			qsort(filter.tags.items, filter.tags.nr,
-			      sizeof(struct string_list_item), sort_by_version);
 		if (sort & REVERSE_SORT)
 			for (i = filter.tags.nr - 1; i >= 0; i--) {
 				struct string_list_item *it = &filter.tags.items[i];
-- 
2.0.0.566.gfe3e6b2
