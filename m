Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A648820986
	for <e@80x24.org>; Thu, 20 Oct 2016 06:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbcJTGV2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 02:21:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:59869 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752937AbcJTGV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 02:21:28 -0400
Received: (qmail 18749 invoked by uid 109); 20 Oct 2016 06:21:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 06:21:28 +0000
Received: (qmail 21087 invoked by uid 111); 20 Oct 2016 06:21:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 02:21:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 02:21:25 -0400
Date:   Thu, 20 Oct 2016 02:21:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/7] diff: handle sha1 abbreviations outside of repository
Message-ID: <20161020062125.3iqej3bpdoitr3fz@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When generating diffs outside a repository (e.g., with "diff
--no-index"), we may write abbreviated sha1s as part of
"--raw" output or the "index" lines of "--patch" output.
Since we have no object database, we never find any
collisions, and these sha1s get whatever static abbreviation
length is configured (typically 7).

However, we do blindly look in ".git/objects" to see if any
objects exist, even though we know we are not in a
repository. This is usually harmless because such a
directory is unlikely to exist, but could be wrong in rare
circumstances.

Let's instead notice when we are not in a repository and
behave as if the object database is empty (i.e., just use
the default abbrev length). It would perhaps make sense to
be conservative and show full sha1s in that case, but
showing the default abbreviation is what we've always done
(and is certainly less ugly).

Note that this does mean that:

  cd /not/a/repo
  GIT_OBJECT_DIRECTORY=/some/real/objdir git diff --no-index ...

used to look for collisions in /some/real/objdir but now
does not. This could be considered either a bugfix (we do
not look at objects if we have no repository) or a
regression, but it seems unlikely that anybody would care
much either way.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 8f0f309..ef11001 100644
--- a/diff.c
+++ b/diff.c
@@ -3049,6 +3049,19 @@ static int similarity_index(struct diff_filepair *p)
 	return p->score * 100 / MAX_SCORE;
 }
 
+static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
+{
+	if (startup_info->have_repository)
+		return find_unique_abbrev(oid->hash, abbrev);
+	else {
+		char *hex = oid_to_hex(oid);
+		if (abbrev < 0 || abbrev > GIT_SHA1_HEXSZ)
+			die("BUG: oid abbreviation out of range: %d", abbrev);
+		hex[abbrev] = '\0';
+		return hex;
+	}
+}
+
 static void fill_metainfo(struct strbuf *msg,
 			  const char *name,
 			  const char *other,
@@ -3107,9 +3120,9 @@ static void fill_metainfo(struct strbuf *msg,
 			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
 				abbrev = 40;
 		}
-		strbuf_addf(msg, "%s%sindex %s..", line_prefix, set,
-			    find_unique_abbrev(one->oid.hash, abbrev));
-		strbuf_add_unique_abbrev(msg, two->oid.hash, abbrev);
+		strbuf_addf(msg, "%s%sindex %s..%s", line_prefix, set,
+			    diff_abbrev_oid(&one->oid, abbrev),
+			    diff_abbrev_oid(&two->oid, abbrev));
 		if (one->mode == two->mode)
 			strbuf_addf(msg, " %06o", one->mode);
 		strbuf_addf(msg, "%s\n", reset);
@@ -4144,7 +4157,7 @@ const char *diff_aligned_abbrev(const struct object_id *oid, int len)
 	if (len == GIT_SHA1_HEXSZ)
 		return oid_to_hex(oid);
 
-	abbrev = find_unique_abbrev(oid->hash, len);
+	abbrev = diff_abbrev_oid(oid, len);
 	abblen = strlen(abbrev);
 
 	/*
-- 
2.10.1.619.g16351a7

