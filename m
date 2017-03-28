Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348241FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755778AbdC1Tqm (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:46:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:53161 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755768AbdC1Tql (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:46:41 -0400
Received: (qmail 11792 invoked by uid 109); 28 Mar 2017 19:46:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:46:35 +0000
Received: (qmail 5740 invoked by uid 111); 28 Mar 2017 19:46:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:46:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:46:33 -0400
Date:   Tue, 28 Mar 2017 15:46:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/18] avoid using mksnpath for refs
Message-ID: <20170328194633.ok3tamreao5u7gjp@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like the previous commit, we'd like to avoid the assumption
that refs fit into PATH_MAX-sized buffers. These callsites
have an extra twist, though: they write the refnames using
mksnpath. This does two things beyond a regular snprintf:

  1. It quietly writes "/bad-path/" when truncation occurs.
     This saves the caller having to check the error code,
     but if you aren't actually feeding the result to a
     system call (and we aren't here), it's questionable.

  2. It calls cleanup_path(), which removes leading
     instances of "./".  That's questionable when dealing
     with refnames, as we could silently canonicalize a
     syntactically bogus refname into a valid one.

Let's convert each case to use a strbuf. This is preferable
to xstrfmt() because we can reuse the same buffer as we
loop.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index e7606716d..9de6979ac 100644
--- a/refs.c
+++ b/refs.c
@@ -429,29 +429,31 @@ int expand_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
 	const char **p, *r;
 	int refs_found = 0;
+	struct strbuf fullref = STRBUF_INIT;
 
 	*ref = NULL;
 	for (p = ref_rev_parse_rules; *p; p++) {
-		char fullref[PATH_MAX];
 		unsigned char sha1_from_ref[20];
 		unsigned char *this_result;
 		int flag;
 
 		this_result = refs_found ? sha1_from_ref : sha1;
-		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r = resolve_ref_unsafe(fullref, RESOLVE_REF_READING,
+		strbuf_reset(&fullref);
+		strbuf_addf(&fullref, *p, len, str);
+		r = resolve_ref_unsafe(fullref.buf, RESOLVE_REF_READING,
 				       this_result, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
 			if (!warn_ambiguous_refs)
 				break;
-		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD")) {
-			warning("ignoring dangling symref %s.", fullref);
-		} else if ((flag & REF_ISBROKEN) && strchr(fullref, '/')) {
-			warning("ignoring broken ref %s.", fullref);
+		} else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
+			warning("ignoring dangling symref %s.", fullref.buf);
+		} else if ((flag & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
+			warning("ignoring broken ref %s.", fullref.buf);
 		}
 	}
+	strbuf_release(&fullref);
 	return refs_found;
 }
 
@@ -460,21 +462,22 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	char *last_branch = substitute_branch_name(&str, &len);
 	const char **p;
 	int logs_found = 0;
+	struct strbuf path = STRBUF_INIT;
 
 	*log = NULL;
 	for (p = ref_rev_parse_rules; *p; p++) {
 		unsigned char hash[20];
-		char path[PATH_MAX];
 		const char *ref, *it;
 
-		mksnpath(path, sizeof(path), *p, len, str);
-		ref = resolve_ref_unsafe(path, RESOLVE_REF_READING,
+		strbuf_reset(&path);
+		strbuf_addf(&path, *p, len, str);
+		ref = resolve_ref_unsafe(path.buf, RESOLVE_REF_READING,
 					 hash, NULL);
 		if (!ref)
 			continue;
-		if (reflog_exists(path))
-			it = path;
-		else if (strcmp(ref, path) && reflog_exists(ref))
+		if (reflog_exists(path.buf))
+			it = path.buf;
+		else if (strcmp(ref, path.buf) && reflog_exists(ref))
 			it = ref;
 		else
 			continue;
@@ -485,6 +488,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		if (!warn_ambiguous_refs)
 			break;
 	}
+	strbuf_release(&path);
 	free(last_branch);
 	return logs_found;
 }
@@ -944,6 +948,7 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	static char **scanf_fmts;
 	static int nr_rules;
 	char *short_name;
+	struct strbuf resolved_buf = STRBUF_INIT;
 
 	if (!nr_rules) {
 		/*
@@ -1002,7 +1007,6 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 		 */
 		for (j = 0; j < rules_to_fail; j++) {
 			const char *rule = ref_rev_parse_rules[j];
-			char refname[PATH_MAX];
 
 			/* skip matched rule */
 			if (i == j)
@@ -1013,9 +1017,10 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 			 * (with this previous rule) to a valid ref
 			 * read_ref() returns 0 on success
 			 */
-			mksnpath(refname, sizeof(refname),
-				 rule, short_name_len, short_name);
-			if (ref_exists(refname))
+			strbuf_reset(&resolved_buf);
+			strbuf_addf(&resolved_buf, rule,
+				    short_name_len, short_name);
+			if (ref_exists(resolved_buf.buf))
 				break;
 		}
 
@@ -1023,10 +1028,13 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 		 * short name is non-ambiguous if all previous rules
 		 * haven't resolved to a valid ref
 		 */
-		if (j == rules_to_fail)
+		if (j == rules_to_fail) {
+			strbuf_release(&resolved_buf);
 			return short_name;
+		}
 	}
 
+	strbuf_release(&resolved_buf);
 	free(short_name);
 	return xstrdup(refname);
 }
-- 
2.12.2.845.g55fcf8b10

