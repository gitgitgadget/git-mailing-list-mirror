Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3393C25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 08:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347871AbiHSIvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 04:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347848AbiHSIu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 04:50:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23B7CE45D
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 01:50:55 -0700 (PDT)
Received: (qmail 17540 invoked by uid 109); 19 Aug 2022 08:50:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 08:50:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 411 invoked by uid 111); 19 Aug 2022 08:50:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 04:50:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 04:50:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 3/6] match_pathname(): drop unused "flags" parameter
Message-ID: <Yv9O7nSS+WMzm0I7@coredump.intra.peff.net>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This field has not been used since the function was introduced in
b559263216 (exclude: split pathname matching code into a separate
function, 2012-10-15), though there was a brief period where it was
erroneously used and then reverted in ed4958477b (dir: fix pattern
matching on dirs, 2021-09-24) and 5ceb663e92 (dir: fix
directory-matching bug, 2021-11-02).

It's possible we'd eventually add a flag that makes it useful here, but
there are only a handful of callers. It would be easy to add back if
necessary, and in the meantime this makes the function interface less
misleading.

Signed-off-by: Jeff King <peff@peff.net>
---
 attr.c | 2 +-
 dir.c  | 6 ++----
 dir.h  | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/attr.c b/attr.c
index 21e4ad25ad..8a78dde69e 100644
--- a/attr.c
+++ b/attr.c
@@ -1023,7 +1023,7 @@ static int path_matches(const char *pathname, int pathlen,
 	}
 	return match_pathname(pathname, pathlen - isdir,
 			      base, baselen,
-			      pattern, prefix, pat->patternlen, pat->flags);
+			      pattern, prefix, pat->patternlen);
 }
 
 static int macroexpand_one(struct all_attrs_item *all_attrs, int nr, int rem);
diff --git a/dir.c b/dir.c
index d7cfb08e44..50eeb8b11e 100644
--- a/dir.c
+++ b/dir.c
@@ -1244,8 +1244,7 @@ int match_basename(const char *basename, int basenamelen,
 
 int match_pathname(const char *pathname, int pathlen,
 		   const char *base, int baselen,
-		   const char *pattern, int prefix, int patternlen,
-		   unsigned flags)
+		   const char *pattern, int prefix, int patternlen)
 {
 	const char *name;
 	int namelen;
@@ -1347,8 +1346,7 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 		if (match_pathname(pathname, pathlen,
 				   pattern->base,
 				   pattern->baselen ? pattern->baselen - 1 : 0,
-				   exclude, prefix, pattern->patternlen,
-				   pattern->flags)) {
+				   exclude, prefix, pattern->patternlen)) {
 			res = pattern;
 			break;
 		}
diff --git a/dir.h b/dir.h
index 7bc862030c..674747d93a 100644
--- a/dir.h
+++ b/dir.h
@@ -414,7 +414,7 @@ int match_basename(const char *, int,
 		   const char *, int, int, unsigned);
 int match_pathname(const char *, int,
 		   const char *, int,
-		   const char *, int, int, unsigned);
+		   const char *, int, int);
 
 struct path_pattern *last_matching_pattern(struct dir_struct *dir,
 					   struct index_state *istate,
-- 
2.37.2.928.g0821088f4a

