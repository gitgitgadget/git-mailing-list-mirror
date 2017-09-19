Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A6720281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdISGW4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:22:56 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42092 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750713AbdISGWy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:22:54 -0400
X-AuditID: 1207440c-7e5ff7000000143e-e4-59c0b7bd98bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.37.05182.DB7B0C95; Tue, 19 Sep 2017 02:22:53 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1f002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:22:51 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/21] read_packed_refs(): read references with minimal copying
Date:   Tue, 19 Sep 2017 08:22:16 +0200
Message-Id: <597241da13f62d51fefd3396bfbab22a8f633a56.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqLt3+4FIgz/tqhZrn91hsni+/gS7
        RdeVbiaLht4rzBb9y7vYLG6vmM9s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8PH+M8
        Fmwq9XjWu4fR4+IlZY/Pm+QC2KO4bFJSczLLUov07RK4Mr7cWM1ScFi7YtvGwAbGJqUuRk4O
        CQETief7NrN1MXJxCAnsYJJYsGkFO4Rzikni5dPDrCBVbAK6Eot6mplAbBEBNYmJbYdYQIqY
        BVYyS0zaegWsSFggSGL64VvMIDaLgKpE897bYDavQJTEqc29jBDr5CXOPYCIcwpYSDTv2Q40
        iANom7nEgaPFExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdTLzSzRS00p3cQICTie
        HYzf1skcYhTgYFTi4RW4tj9SiDWxrLgy9xCjJAeTkihv2KYDkUJ8SfkplRmJxRnxRaU5qcWH
        GCU4mJVEeA8tAsrxpiRWVqUW5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4FYGR
        JSRYlJqeWpGWmVOCkGbi4AQZzgM0XAWkhre4IDG3ODMdIn+KUZej4+bdP0xCLHn5ealS4rz3
        twEVCYAUZZTmwc2BJYpXjOJAbwnzNoBU8QCTDNykV0BLmICWZG8AW1KSiJCSamDMubVupiiH
        k6WgQP901baNjKFPghsPpvOe8F9bWng68u49j8JE13nK7w5ISthdUjWpfBhcIK/11iXmgiCj
        1e5JIcHeG2XyY75+6/4aEPmMsUDbN9dNdmtac/Kxbx2BZaxJ6zYslnlZuDTkommASvY/4Q2P
        3+10m+F7+P9Jm5kpDM4y/leWL1JiKc5INNRiLipOBACWwdCf7wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of copying data from the `packed-refs` file one line at time
and then processing it, process the data in place as much as possible.

Also, instead of processing one line per iteration of the main loop,
process a reference line plus its corresponding peeled line (if
present) together.

Note that this change slightly tightens up the parsing of the
`parse-ref` file. Previously, the parser would have accepted multiple
"peeled" lines for a single reference (ignoring all but the last one).
Now it would reject that.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 101 ++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 61 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a45e3ff92f..2b80f244c8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -134,33 +134,6 @@ static void clear_packed_ref_cache(struct packed_ref_store *refs)
 	}
 }
 
-/* The length of a peeled reference line in packed-refs, including EOL: */
-#define PEELED_LINE_LENGTH 42
-
-/*
- * Parse one line from a packed-refs file.  Write the SHA1 to sha1.
- * Return a pointer to the refname within the line (null-terminated),
- * or NULL if there was a problem.
- */
-static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
-{
-	const char *ref;
-
-	if (parse_oid_hex(line->buf, oid, &ref) < 0)
-		return NULL;
-	if (!isspace(*ref++))
-		return NULL;
-
-	if (isspace(*ref))
-		return NULL;
-
-	if (line->buf[line->len - 1] != '\n')
-		return NULL;
-	line->buf[--line->len] = 0;
-
-	return ref;
-}
-
 static NORETURN void die_unterminated_line(const char *path,
 					   const char *p, size_t len)
 {
@@ -221,8 +194,7 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	size_t size;
 	char *buf;
 	const char *pos, *eol, *eof;
-	struct ref_entry *last = NULL;
-	struct strbuf line = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
 	struct ref_dir *dir;
 
@@ -264,9 +236,9 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		if (!eol)
 			die_unterminated_line(refs->path, pos, eof - pos);
 
-		strbuf_add(&line, pos, eol - pos);
+		strbuf_add(&tmp, pos, eol - pos);
 
-		if (!skip_prefix(line.buf, "# pack-refs with:", (const char **)&p))
+		if (!skip_prefix(tmp.buf, "# pack-refs with:", (const char **)&p))
 			die_invalid_line(refs->path, pos, eof - pos);
 
 		string_list_split_in_place(&traits, p, ' ', -1);
@@ -281,61 +253,68 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		pos = eol + 1;
 
 		string_list_clear(&traits, 0);
-		strbuf_reset(&line);
+		strbuf_reset(&tmp);
 	}
 
 	dir = get_ref_dir(packed_refs->cache->root);
 	while (pos < eof) {
+		const char *p = pos;
 		struct object_id oid;
 		const char *refname;
+		int flag = REF_ISPACKED;
+		struct ref_entry *entry = NULL;
 
-		eol = memchr(pos, '\n', eof - pos);
+		if (eof - pos < GIT_SHA1_HEXSZ + 2 ||
+		    parse_oid_hex(p, &oid, &p) ||
+		    !isspace(*p++))
+			die_invalid_line(refs->path, pos, eof - pos);
+
+		eol = memchr(p, '\n', eof - p);
 		if (!eol)
 			die_unterminated_line(refs->path, pos, eof - pos);
 
-		strbuf_add(&line, pos, eol + 1 - pos);
+		strbuf_add(&tmp, p, eol - p);
+		refname = tmp.buf;
+
+		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+			if (!refname_is_safe(refname))
+				die("packed refname is dangerous: %s", refname);
+			oidclr(&oid);
+			flag |= REF_BAD_NAME | REF_ISBROKEN;
+		}
+		if (peeled == PEELED_FULLY ||
+		    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
+			flag |= REF_KNOWS_PEELED;
+		entry = create_ref_entry(refname, &oid, flag);
+		add_ref_entry(dir, entry);
 
-		refname = parse_ref_line(&line, &oid);
-		if (refname) {
-			int flag = REF_ISPACKED;
+		pos = eol + 1;
+
+		if (pos < eof && *pos == '^') {
+			p = pos + 1;
+			if (eof - p < GIT_SHA1_HEXSZ + 1 ||
+			    parse_oid_hex(p, &entry->u.value.peeled, &p) ||
+			    *p++ != '\n')
+				die_invalid_line(refs->path, pos, eof - pos);
 
-			if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-				if (!refname_is_safe(refname))
-					die("packed refname is dangerous: %s", refname);
-				oidclr(&oid);
-				flag |= REF_BAD_NAME | REF_ISBROKEN;
-			}
-			last = create_ref_entry(refname, &oid, flag);
-			if (peeled == PEELED_FULLY ||
-			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
-				last->flag |= REF_KNOWS_PEELED;
-			add_ref_entry(dir, last);
-		} else if (last &&
-		    line.buf[0] == '^' &&
-		    line.len == PEELED_LINE_LENGTH &&
-		    line.buf[PEELED_LINE_LENGTH - 1] == '\n' &&
-		    !get_oid_hex(line.buf + 1, &oid)) {
-			oidcpy(&last->u.value.peeled, &oid);
 			/*
 			 * Regardless of what the file header said,
 			 * we definitely know the value of *this*
 			 * reference:
 			 */
-			last->flag |= REF_KNOWS_PEELED;
-		} else {
-			die_invalid_line(refs->path, line.buf, line.len);
+			entry->flag |= REF_KNOWS_PEELED;
+
+			pos = p;
 		}
 
-		/* The "+ 1" is for the LF character. */
-		pos = eol + 1;
-		strbuf_reset(&line);
+		strbuf_reset(&tmp);
 	}
 
 	if (munmap(buf, size))
 		die_errno("error ummapping packed-refs file");
 	close(fd);
 
-	strbuf_release(&line);
+	strbuf_release(&tmp);
 	return packed_refs;
 }
 
-- 
2.14.1

