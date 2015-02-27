From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] diffcore-rename: split locate_rename_dst into two
 functions
Date: Thu, 26 Feb 2015 20:39:48 -0500
Message-ID: <20150227013948.GA3210@peff.net>
References: <20150227013847.GA2983@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 02:39:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR9uF-0006hh-SM
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 02:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbbB0Bjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 20:39:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:53997 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750822AbbB0Bjv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 20:39:51 -0500
Received: (qmail 28314 invoked by uid 102); 27 Feb 2015 01:39:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 19:39:51 -0600
Received: (qmail 30156 invoked by uid 107); 27 Feb 2015 01:39:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 20:39:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2015 20:39:48 -0500
Content-Disposition: inline
In-Reply-To: <20150227013847.GA2983@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264487>

This function manages the mapping of destination pathnames
to filepairs, and it handles both insertion and lookup. This
makes the return value a bit confusing, as we return a newly
created entry (even though no caller cares), and have no
room to indicate to the caller that an entry already
existed.

Instead, let's break this up into two distinct functions,
both backed by a common binary search. The binary search
will use our normal "return the index if we found something,
or negative index minus one to show where it would have
gone" semantics.

Signed-off-by: Jeff King <peff@peff.net>
---
 diffcore-rename.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 4e132f1..4250cc0 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -15,8 +15,7 @@ static struct diff_rename_dst {
 } *rename_dst;
 static int rename_dst_nr, rename_dst_alloc;
 
-static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
-						 int insert_ok)
+static int find_rename_dst(struct diff_filespec *two)
 {
 	int first, last;
 
@@ -27,16 +26,33 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 		struct diff_rename_dst *dst = &(rename_dst[next]);
 		int cmp = strcmp(two->path, dst->two->path);
 		if (!cmp)
-			return dst;
+			return next;
 		if (cmp < 0) {
 			last = next;
 			continue;
 		}
 		first = next+1;
 	}
-	/* not found */
-	if (!insert_ok)
-		return NULL;
+	return -first - 1;
+}
+
+static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two)
+{
+	int ofs = find_rename_dst(two);
+	return ofs < 0 ? NULL : &rename_dst[ofs];
+}
+
+/*
+ * Returns 0 on success, -1 if we found a duplicate.
+ */
+static int add_rename_dst(struct diff_filespec *two)
+{
+	int first = find_rename_dst(two);
+
+	if (first >= 0)
+		return -1;
+	first = -first - 1;
+
 	/* insert to make it at "first" */
 	ALLOC_GROW(rename_dst, rename_dst_nr + 1, rename_dst_alloc);
 	rename_dst_nr++;
@@ -46,7 +62,7 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 	rename_dst[first].two = alloc_filespec(two->path);
 	fill_filespec(rename_dst[first].two, two->sha1, two->sha1_valid, two->mode);
 	rename_dst[first].pair = NULL;
-	return &(rename_dst[first]);
+	return 0;
 }
 
 /* Table of rename/copy src files */
@@ -451,7 +467,7 @@ void diffcore_rename(struct diff_options *options)
 				 is_empty_blob_sha1(p->two->sha1))
 				continue;
 			else
-				locate_rename_dst(p->two, 1);
+				add_rename_dst(p->two);
 		}
 		else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
 			 is_empty_blob_sha1(p->one->sha1))
@@ -582,8 +598,7 @@ void diffcore_rename(struct diff_options *options)
 			 * We would output this create record if it has
 			 * not been turned into a rename/copy already.
 			 */
-			struct diff_rename_dst *dst =
-				locate_rename_dst(p->two, 0);
+			struct diff_rename_dst *dst = locate_rename_dst(p->two);
 			if (dst && dst->pair) {
 				diff_q(&outq, dst->pair);
 				pair_to_free = p;
@@ -613,8 +628,7 @@ void diffcore_rename(struct diff_options *options)
 			 */
 			if (DIFF_PAIR_BROKEN(p)) {
 				/* broken delete */
-				struct diff_rename_dst *dst =
-					locate_rename_dst(p->one, 0);
+				struct diff_rename_dst *dst = locate_rename_dst(p->one);
 				if (dst && dst->pair)
 					/* counterpart is now rename/copy */
 					pair_to_free = p;
-- 
2.3.0.449.g1690e78
