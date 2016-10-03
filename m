Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE22207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbcJCUew (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:34:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:51439 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752098AbcJCUev (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:34:51 -0400
Received: (qmail 17305 invoked by uid 109); 3 Oct 2016 20:34:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:34:51 +0000
Received: (qmail 29756 invoked by uid 111); 3 Oct 2016 20:35:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:35:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:34:48 -0400
Date:   Mon, 3 Oct 2016 16:34:48 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 08/18] link_alt_odb_entry: refactor string handling
Message-ID: <20161003203448.cdfbitl5jmhlpb5o@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The string handling in link_alt_odb_entry() is mostly an
artifact of the original version, which took the path as a
ptr/len combo, and did not have a NUL-terminated string
until we created one in the alternate_object_database
struct.  But since 5bdf0a8 (sha1_file: normalize alt_odb
path before comparing and storing, 2011-09-07), the first
thing we do is put the path into a strbuf, which gives us
some easy opportunities for cleanup.

In particular:

  - we call strlen(pathbuf.buf), which is silly; we can look
    at pathbuf.len.

  - even though we have a strbuf, we don't maintain its
    "len" field when chomping extra slashes from the
    end, and instead keep a separate "pfxlen" variable. We
    can fix this and then drop "pfxlen" entirely.

  - we don't check whether the path is usable until after we
    allocate the new struct, making extra cleanup work for
    ourselves. Since we have a NUL-terminated string, we can
    bump the "is it usable" checks higher in the function.
    While we're at it, we can move that logic to its own
    helper, which makes the flow of link_alt_odb_entry()
    easier to follow.

Signed-off-by: Jeff King <peff@peff.net>
---
And you can probably guess now how I found the issue in the last patch
where pathbuf.len is totally bogus after calling normalize_path_copy. :)

 sha1_file.c | 83 +++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 68571bd..f396823 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -234,6 +234,36 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 struct alternate_object_database *alt_odb_list;
 static struct alternate_object_database **alt_odb_tail;
 
+/*
+ * Return non-zero iff the path is usable as an alternate object database.
+ */
+static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
+{
+	struct alternate_object_database *alt;
+
+	/* Detect cases where alternate disappeared */
+	if (!is_directory(path->buf)) {
+		error("object directory %s does not exist; "
+		      "check .git/objects/info/alternates.",
+		      path->buf);
+		return 0;
+	}
+
+	/*
+	 * Prevent the common mistake of listing the same
+	 * thing twice, or object directory itself.
+	 */
+	for (alt = alt_odb_list; alt; alt = alt->next) {
+		if (path->len == alt->name - alt->base - 1 &&
+		    !memcmp(path->buf, alt->base, path->len))
+			return 0;
+	}
+	if (!fspathcmp(path->buf, normalized_objdir))
+		return 0;
+
+	return 1;
+}
+
 /*
  * Prepare alternate object database registry.
  *
@@ -253,8 +283,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	int depth, const char *normalized_objdir)
 {
 	struct alternate_object_database *ent;
-	struct alternate_object_database *alt;
-	size_t pfxlen, entlen;
+	size_t entlen;
 	struct strbuf pathbuf = STRBUF_INIT;
 
 	if (!is_absolute_path(entry) && relative_base) {
@@ -270,47 +299,26 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 		return -1;
 	}
 
-	pfxlen = strlen(pathbuf.buf);
-
 	/*
 	 * The trailing slash after the directory name is given by
 	 * this function at the end. Remove duplicates.
 	 */
-	while (pfxlen && pathbuf.buf[pfxlen-1] == '/')
-		pfxlen -= 1;
-
-	entlen = st_add(pfxlen, 43); /* '/' + 2 hex + '/' + 38 hex + NUL */
-	ent = xmalloc(st_add(sizeof(*ent), entlen));
-	memcpy(ent->base, pathbuf.buf, pfxlen);
-	strbuf_release(&pathbuf);
-
-	ent->name = ent->base + pfxlen + 1;
-	ent->base[pfxlen + 3] = '/';
-	ent->base[pfxlen] = ent->base[entlen-1] = 0;
+	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
+		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	/* Detect cases where alternate disappeared */
-	if (!is_directory(ent->base)) {
-		error("object directory %s does not exist; "
-		      "check .git/objects/info/alternates.",
-		      ent->base);
-		free(ent);
+	if (!alt_odb_usable(&pathbuf, normalized_objdir)) {
+		strbuf_release(&pathbuf);
 		return -1;
 	}
 
-	/* Prevent the common mistake of listing the same
-	 * thing twice, or object directory itself.
-	 */
-	for (alt = alt_odb_list; alt; alt = alt->next) {
-		if (pfxlen == alt->name - alt->base - 1 &&
-		    !memcmp(ent->base, alt->base, pfxlen)) {
-			free(ent);
-			return -1;
-		}
-	}
-	if (!fspathcmp(ent->base, normalized_objdir)) {
-		free(ent);
-		return -1;
-	}
+	entlen = st_add(pathbuf.len, 43); /* '/' + 2 hex + '/' + 38 hex + NUL */
+	ent = xmalloc(st_add(sizeof(*ent), entlen));
+	memcpy(ent->base, pathbuf.buf, pathbuf.len);
+
+	ent->name = ent->base + pathbuf.len + 1;
+	ent->base[pathbuf.len] = '/';
+	ent->base[pathbuf.len + 3] = '/';
+	ent->base[entlen-1] = 0;
 
 	/* add the alternate entry */
 	*alt_odb_tail = ent;
@@ -318,10 +326,9 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	ent->next = NULL;
 
 	/* recursively add alternates */
-	read_info_alternates(ent->base, depth + 1);
-
-	ent->base[pfxlen] = '/';
+	read_info_alternates(pathbuf.buf, depth + 1);
 
+	strbuf_release(&pathbuf);
 	return 0;
 }
 
-- 
2.10.0.618.g82cc264

