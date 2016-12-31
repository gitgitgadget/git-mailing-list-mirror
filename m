Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8076D2078D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbcLaDNl (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:41 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55421 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754672AbcLaDNk (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:40 -0500
X-AuditID: 1207440d-8b7ff700000009ba-a9-586722620d87
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 10.31.02490.26227685; Fri, 30 Dec 2016 22:13:38 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6uG010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:37 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 22/23] try_remove_empty_parents(): teach to remove parents of reflogs, too
Date:   Sat, 31 Dec 2016 04:13:02 +0100
Message-Id: <8a114f536883002b359306194a9bbcdb6401468d.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsUixO6iqJuklB5h0HtV2aLrSjeTRUPvFWaL
        2yvmM1ssefia2eJHSw+zA6vH3/cfmDy62o+weTzr3cPocfGSssfnTXIBrFFcNimpOZllqUX6
        dglcGZcPshTMFKq4O2M3cwPjG74uRk4OCQETiR/vvrB3MXJxCAlcZpSYdvo5G0hCSOA4k0T/
        +UQQm01AV2JRTzMTiC0ioCYxse0QC0gDs8BEoIYtl8ASwgKxEnu3XgNrZhFQlXjXPI8ZxOYV
        iJK4dHYDI8Q2OYlL276AxTkFLCQWf+pjglhmLrFu5yXmCYw8CxgZVjHKJeaU5urmJmbmFKcm
        6xYnJ+blpRbpGunlZpbopaaUbmKEBA7vDsb/62QOMQpwMCrx8D64kRYhxJpYVlyZe4hRkoNJ
        SZTX0jI1QogvKT+lMiOxOCO+qDQntfgQowQHs5II70K59Agh3pTEyqrUonyYlDQHi5I4r9oS
        dT8hgfTEktTs1NSC1CKYrAwHh5IE70JFoEbBotT01Iq0zJwShDQTByfIcB6g4b0gNbzFBYm5
        xZnpEPlTjIpS4rxrFYASAiCJjNI8uF5YZL9iFAd6RZi3FqSdB5gU4LpfAQ1mAhqslpMMMrgk
        ESEl1cA4UaQovsD9qHJYXMqbH21Ls7anX+Zjkjvs/TmxSWmK0e7kmA8TJoWcdOo4HpN8Yl9A
        tZoU26oTr07Lar/nqzjwonzuV+bkS5+2d0Y3PHv3L8fZY0faHx6xmen3Hzwyyt/XfWnJ9bk/
        BZLjHPyV/3mlmsbuXGNleLejq25iJ+/yg5WneeO0zx1RYinOSDTUYi4qTgQAqgR/EccCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new "flags" parameter that tells the function whether to remove
empty parent directories of the loose reference file, of the reflog
file, or both. The new functionality is not yet used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 397488e..2155acf 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2280,10 +2280,18 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
+enum {
+	REMOVE_EMPTY_PARENTS_REF = 0x01,
+	REMOVE_EMPTY_PARENTS_REFLOG = 0x02
+};
+
 /*
- * Remove empty parents, but spare refs/ and immediate subdirs.
+ * Remove empty parent directories associated with the specified
+ * reference and/or its reflog, but spare [logs/]refs/ and immediate
+ * subdirs. flags is a combination of REMOVE_EMPTY_PARENTS_REF and/or
+ * REMOVE_EMPTY_PARENTS_REFLOG.
  */
-static void try_remove_empty_parents(const char *refname)
+static void try_remove_empty_parents(const char *refname, unsigned int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char *p, *q;
@@ -2298,7 +2306,7 @@ static void try_remove_empty_parents(const char *refname)
 			p++;
 	}
 	q = buf.buf + buf.len;
-	while (1) {
+	while (flags & (REMOVE_EMPTY_PARENTS_REF | REMOVE_EMPTY_PARENTS_REFLOG)) {
 		while (q > p && *q != '/')
 			q--;
 		if (q > p && *(q-1) == '/')
@@ -2306,8 +2314,12 @@ static void try_remove_empty_parents(const char *refname)
 		if (q == p)
 			break;
 		strbuf_setlen(&buf, q - buf.buf);
-		if (rmdir(git_path("%s", buf.buf)))
-			break;
+		if ((flags & REMOVE_EMPTY_PARENTS_REF) &&
+		    rmdir(git_path("%s", buf.buf)))
+			flags &= ~REMOVE_EMPTY_PARENTS_REF;
+		if ((flags & REMOVE_EMPTY_PARENTS_REFLOG) &&
+		    rmdir(git_path("logs/%s", buf.buf)))
+			flags &= ~REMOVE_EMPTY_PARENTS_REFLOG;
 	}
 	strbuf_release(&buf);
 }
@@ -2333,7 +2345,7 @@ static void prune_ref(struct ref_to_prune *r)
 	}
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
-	try_remove_empty_parents(r->name);
+	try_remove_empty_parents(r->name, REMOVE_EMPTY_PARENTS_REF);
 }
 
 static void prune_refs(struct ref_to_prune *r)
-- 
2.9.3

