Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C966209AA
	for <e@80x24.org>; Mon, 26 Sep 2016 12:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034361AbcIZMAH (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 08:00:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:48025 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965095AbcIZMAH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 08:00:07 -0400
Received: (qmail 18626 invoked by uid 109); 26 Sep 2016 12:00:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 12:00:06 +0000
Received: (qmail 4372 invoked by uid 111); 26 Sep 2016 12:00:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 08:00:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 08:00:04 -0400
Date:   Mon, 26 Sep 2016 08:00:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 05/10] get_short_sha1: refactor init of disambiguation code
Message-ID: <20160926120003.oixhtotisw5xnvh4@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The disambiguation machinery has two callers: get_short_sha1
and for_each_abbrev. Both need to repeat much of the same
setup: declaring buffers, sanity-checking lengths, preparing
the prefixes, etc.  Let's pull that into a single init
function so we can avoid repeating ourselves.

Pulling the buffers into the "struct disambiguate_state"
isn't strictly necessary, but it does make things simpler
for the callers, who no longer have to worry about sizing
them correctly (i.e., it's an implicit requirement that
the caller provide 20- and 40-byte buffers).

And while we're touching this code, we can convert any
magic-number sizes to the more modern GIT_SHA1_* constants.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c | 79 +++++++++++++++++++++++++++----------------------------------
 1 file changed, 35 insertions(+), 44 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 432a308..79eb1ee 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -13,9 +13,13 @@ static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *)
 typedef int (*disambiguate_hint_fn)(const unsigned char *, void *);
 
 struct disambiguate_state {
+	int len; /* length of prefix in hex chars */
+	char hex_pfx[GIT_SHA1_HEXSZ];
+	unsigned char bin_pfx[GIT_SHA1_RAWSZ];
+
 	disambiguate_hint_fn fn;
 	void *cb_data;
-	unsigned char candidate[20];
+	unsigned char candidate[GIT_SHA1_RAWSZ];
 	unsigned candidate_exists:1;
 	unsigned candidate_checked:1;
 	unsigned candidate_ok:1;
@@ -72,10 +76,10 @@ static void update_candidates(struct disambiguate_state *ds, const unsigned char
 	/* otherwise, current can be discarded and candidate is still good */
 }
 
-static void find_short_object_filename(int len, const char *hex_pfx, struct disambiguate_state *ds)
+static void find_short_object_filename(struct disambiguate_state *ds)
 {
 	struct alternate_object_database *alt;
-	char hex[40];
+	char hex[GIT_SHA1_HEXSZ];
 	static struct alternate_object_database *fakeent;
 
 	if (!fakeent) {
@@ -95,7 +99,7 @@ static void find_short_object_filename(int len, const char *hex_pfx, struct disa
 	}
 	fakeent->next = alt_odb_list;
 
-	xsnprintf(hex, sizeof(hex), "%.2s", hex_pfx);
+	xsnprintf(hex, sizeof(hex), "%.2s", ds->hex_pfx);
 	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
 		struct dirent *de;
 		DIR *dir;
@@ -103,7 +107,7 @@ static void find_short_object_filename(int len, const char *hex_pfx, struct disa
 		 * every alt_odb struct has 42 extra bytes after the base
 		 * for exactly this purpose
 		 */
-		xsnprintf(alt->name, 42, "%.2s/", hex_pfx);
+		xsnprintf(alt->name, 42, "%.2s/", ds->hex_pfx);
 		dir = opendir(alt->base);
 		if (!dir)
 			continue;
@@ -113,7 +117,7 @@ static void find_short_object_filename(int len, const char *hex_pfx, struct disa
 
 			if (strlen(de->d_name) != 38)
 				continue;
-			if (memcmp(de->d_name, hex_pfx + 2, len - 2))
+			if (memcmp(de->d_name, ds->hex_pfx + 2, ds->len - 2))
 				continue;
 			memcpy(hex + 2, de->d_name, 38);
 			if (!get_sha1_hex(hex, sha1))
@@ -138,9 +142,7 @@ static int match_sha(unsigned len, const unsigned char *a, const unsigned char *
 	return 1;
 }
 
-static void unique_in_pack(int len,
-			  const unsigned char *bin_pfx,
-			   struct packed_git *p,
+static void unique_in_pack(struct packed_git *p,
 			   struct disambiguate_state *ds)
 {
 	uint32_t num, last, i, first = 0;
@@ -155,7 +157,7 @@ static void unique_in_pack(int len,
 		int cmp;
 
 		current = nth_packed_object_sha1(p, mid);
-		cmp = hashcmp(bin_pfx, current);
+		cmp = hashcmp(ds->bin_pfx, current);
 		if (!cmp) {
 			first = mid;
 			break;
@@ -174,20 +176,19 @@ static void unique_in_pack(int len,
 	 */
 	for (i = first; i < num && !ds->ambiguous; i++) {
 		current = nth_packed_object_sha1(p, i);
-		if (!match_sha(len, bin_pfx, current))
+		if (!match_sha(ds->len, ds->bin_pfx, current))
 			break;
 		update_candidates(ds, current);
 	}
 }
 
-static void find_short_packed_object(int len, const unsigned char *bin_pfx,
-				     struct disambiguate_state *ds)
+static void find_short_packed_object(struct disambiguate_state *ds)
 {
 	struct packed_git *p;
 
 	prepare_packed_git();
 	for (p = packed_git; p && !ds->ambiguous; p = p->next)
-		unique_in_pack(len, bin_pfx, p, ds);
+		unique_in_pack(p, ds);
 }
 
 #define SHORT_NAME_NOT_FOUND (-1)
@@ -281,14 +282,17 @@ static int disambiguate_blob_only(const unsigned char *sha1, void *cb_data_unuse
 	return kind == OBJ_BLOB;
 }
 
-static int prepare_prefixes(const char *name, int len,
-			    unsigned char *bin_pfx,
-			    char *hex_pfx)
+static int init_object_disambiguation(const char *name, int len,
+				      struct disambiguate_state *ds)
 {
 	int i;
 
-	hashclr(bin_pfx);
-	memset(hex_pfx, 'x', 40);
+	if (len < MINIMUM_ABBREV || len > GIT_SHA1_HEXSZ)
+		return -1;
+
+	memset(ds, 0, sizeof(*ds));
+	memset(ds->hex_pfx, 'x', GIT_SHA1_HEXSZ);
+
 	for (i = 0; i < len ;i++) {
 		unsigned char c = name[i];
 		unsigned char val;
@@ -302,11 +306,14 @@ static int prepare_prefixes(const char *name, int len,
 		}
 		else
 			return -1;
-		hex_pfx[i] = c;
+		ds->hex_pfx[i] = c;
 		if (!(i & 1))
 			val <<= 4;
-		bin_pfx[i >> 1] |= val;
+		ds->bin_pfx[i >> 1] |= val;
 	}
+
+	ds->len = len;
+	prepare_alt_odb();
 	return 0;
 }
 
@@ -319,20 +326,12 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  unsigned flags)
 {
 	int status;
-	char hex_pfx[40];
-	unsigned char bin_pfx[20];
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_SHA1_QUIETLY);
 
-	if (len < MINIMUM_ABBREV || len > 40)
-		return -1;
-	if (prepare_prefixes(name, len, bin_pfx, hex_pfx) < 0)
+	if (init_object_disambiguation(name, len, &ds) < 0)
 		return -1;
 
-	prepare_alt_odb();
-
-	memset(&ds, 0, sizeof(ds));
-
 	if (multiple_bits_set(flags & GET_SHA1_DISAMBIGUATORS))
 		die("BUG: multiple get_short_sha1 disambiguator flags");
 
@@ -347,36 +346,28 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	else if (flags & GET_SHA1_BLOB)
 		ds.fn = disambiguate_blob_only;
 
-	find_short_object_filename(len, hex_pfx, &ds);
-	find_short_packed_object(len, bin_pfx, &ds);
+	find_short_object_filename(&ds);
+	find_short_packed_object(&ds);
 	status = finish_object_disambiguation(&ds, sha1);
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS))
-		return error("short SHA1 %.*s is ambiguous.", len, hex_pfx);
+		return error("short SHA1 %.*s is ambiguous.", ds.len, ds.hex_pfx);
 	return status;
 }
 
 int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 {
-	char hex_pfx[40];
-	unsigned char bin_pfx[20];
 	struct disambiguate_state ds;
-	int len = strlen(prefix);
 
-	if (len < MINIMUM_ABBREV || len > 40)
+	if (init_object_disambiguation(prefix, strlen(prefix), &ds) < 0)
 		return -1;
-	if (prepare_prefixes(prefix, len, bin_pfx, hex_pfx) < 0)
-		return -1;
-
-	prepare_alt_odb();
 
-	memset(&ds, 0, sizeof(ds));
 	ds.always_call_fn = 1;
 	ds.cb_data = cb_data;
 	ds.fn = fn;
 
-	find_short_object_filename(len, hex_pfx, &ds);
-	find_short_packed_object(len, bin_pfx, &ds);
+	find_short_object_filename(&ds);
+	find_short_packed_object(&ds);
 	return ds.ambiguous;
 }
 
-- 
2.10.0.492.g14f803f

