From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] attr.c::path_matches(): the basename is part of the
 pathname
Date: Tue, 26 Mar 2013 11:39:28 -0700
Message-ID: <1364323171-20299-2-git-send-email-gitster@pobox.com>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com, peff@peff.net, avila.jn@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 19:40:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKYn5-0002XY-CX
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 19:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760127Ab3CZSjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 14:39:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60917 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495Ab3CZSjf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 14:39:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E9F7A862;
	Tue, 26 Mar 2013 14:39:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Lf7u
	KrJVBHu8P6ZtnOADzozKq8A=; b=nTM4VNjFbqS9X6o25s82Txz3q54C6q+9QoYX
	2dSkyAHeBpM19zYhMXy742qod5yBQjm78pp0/S65UzgORZRE90uViNHKxDlGcFUV
	fSu7Gf8purCOeKPsrB3+OWoHA7d1Ikeo6sXihS3CUXOyjncOGxmgKsRbimO/wUFE
	pQQWYsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	cAaB+LpDcP5bVn6tgQ/SzzXbo73jJWKOuVUdtu/pSTilGlyY1wek9DMkBl1LNUrb
	UgLS+hF57DI7wQdkLdnhc4JIUdDibxqnBqT1v6Kmcyhu9g64AFjshno0iVTu9jdT
	LBqVBW3P4Mb0njvd4mOm31BRAfFoQdUxXPtDEwiQZE4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F5A1A861;
	Tue, 26 Mar 2013 14:39:35 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DCB5A85A; Tue, 26 Mar 2013
 14:39:34 -0400 (EDT)
X-Mailer: git-send-email 1.8.2-350-g3df87a1
In-Reply-To: <1364323171-20299-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 81446F2A-9644-11E2-9E5D-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219178>

The function takes two strings (pathname and basename) as if they
are independent strings, but in reality, the latter is always
pointing into a substring in the former.

Clarify this relationship by expressing the latter as an offset into
the former.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/attr.c b/attr.c
index ab2aab2..4cfe0ee 100644
--- a/attr.c
+++ b/attr.c
@@ -655,7 +655,7 @@ static void prepare_attr_stack(const char *path, int dirlen)
 }
 
 static int path_matches(const char *pathname, int pathlen,
-			const char *basename,
+			int basename_offset,
 			const struct pattern *pat,
 			const char *base, int baselen)
 {
@@ -667,8 +667,8 @@ static int path_matches(const char *pathname, int pathlen,
 		return 0;
 
 	if (pat->flags & EXC_FLAG_NODIR) {
-		return match_basename(basename,
-				      pathlen - (basename - pathname),
+		return match_basename(pathname + basename_offset,
+				      pathlen - basename_offset,
 				      pattern, prefix,
 				      pat->patternlen, pat->flags);
 	}
@@ -701,7 +701,7 @@ static int fill_one(const char *what, struct match_attr *a, int rem)
 	return rem;
 }
 
-static int fill(const char *path, int pathlen, const char *basename,
+static int fill(const char *path, int pathlen, int basename_offset,
 		struct attr_stack *stk, int rem)
 {
 	int i;
@@ -711,7 +711,7 @@ static int fill(const char *path, int pathlen, const char *basename,
 		struct match_attr *a = stk->attrs[i];
 		if (a->is_macro)
 			continue;
-		if (path_matches(path, pathlen, basename,
+		if (path_matches(path, pathlen, basename_offset,
 				 &a->u.pat, base, stk->originlen))
 			rem = fill_one("fill", a, rem);
 	}
@@ -750,7 +750,8 @@ static void collect_all_attrs(const char *path)
 {
 	struct attr_stack *stk;
 	int i, pathlen, rem, dirlen;
-	const char *basename, *cp, *last_slash = NULL;
+	const char *cp, *last_slash = NULL;
+	int basename_offset;
 
 	for (cp = path; *cp; cp++) {
 		if (*cp == '/' && cp[1])
@@ -758,10 +759,10 @@ static void collect_all_attrs(const char *path)
 	}
 	pathlen = cp - path;
 	if (last_slash) {
-		basename = last_slash + 1;
+		basename_offset = last_slash + 1 - path;
 		dirlen = last_slash - path;
 	} else {
-		basename = path;
+		basename_offset = 0;
 		dirlen = 0;
 	}
 
@@ -771,7 +772,7 @@ static void collect_all_attrs(const char *path)
 
 	rem = attr_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, basename, stk, rem);
+		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
 int git_check_attr(const char *path, int num, struct git_attr_check *check)
-- 
1.8.2-350-g3df87a1
