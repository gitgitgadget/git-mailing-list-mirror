Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB381FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 04:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbcFREPj (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:15:39 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55974 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751132AbcFREPi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:15:38 -0400
X-AuditID: 12074413-487ff700000008c7-84-5764cae9f7d2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 36.85.02247.9EAC4675; Sat, 18 Jun 2016 00:15:37 -0400 (EDT)
Received: from michael.fritz.box (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4FLJh029401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:15:35 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/13] get_ref_cache(): only create an instance if there is a submodule
Date:	Sat, 18 Jun 2016 06:15:12 +0200
Message-Id: <1c274be0695c79785604e0534ecdcf402bedb6cc.1466222921.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1466222921.git.mhagger@alum.mit.edu>
References: <cover.1466222921.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqPvyVEq4wa9ONYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGe8vNfMUnBAqOLn2pXsDYwd/F2M
	nBwSAiYSLxcvZOti5OIQEtjKKHH6zHV2COckk8Ty3xtYQKrYBHQlFvU0M4HYIgIREg2vWhhB
	ipgF5jBJ3H7YyQySEBaIkti+8j47iM0ioCpxY9MDsDgvUPzC7B9MEOvkJC5Pf8AGYnMKWEgs
	2LIPKM4BtM1cYu9iwwmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW6KWmlG5i
	hASd8A7GXSflDjEKcDAq8fAG2KeEC7EmlhVX5h5ilORgUhLlvVIJFOJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCu+UEUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMGr
	DIwuIcGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQDMQXA6MAJMUDtDcKpJ23uCAx
	FygK0XqKUVFKnPfZSaCEAEgiozQPbiwslbxiFAf6Upg3AaSdB5iG4LpfAQ1mAhqsOS8ZZHBJ
	IkJKqoHR1e5wyIoU+4bDhtNfms+5yHDknvidqjvPDJhWdOza3bb6+cXOO4xWPzYGLeSfXvKy
	Yx6PdjjLG0Zv38u8m/j4PG+bLOYxspjjItQ64/q0r4sb/GWsw1tcZt0v69+24E3Mg/jFj51y
	9k2PL1q4U/dRTumK1hucnTr8M/rnXD6f+ej4xVshxtMdlViKMxINtZiLihMBGvlrBAADAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If there is not a nonbare repository where a submodule is supposedly
located, then don't instantiate a ref_cache for it.

The analogous check can be removed from resolve_gitlink_ref().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e15f7ae..b563a7e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -954,15 +954,26 @@ static struct ref_cache *lookup_ref_cache(const char *submodule)
 
 /*
  * Return a pointer to a ref_cache for the specified submodule. For
- * the main repository, use submodule==NULL. The returned structure
- * will be allocated and initialized but not necessarily populated; it
- * should not be freed.
+ * the main repository, use submodule==NULL; such a call cannot fail.
+ * For a submodule, the submodule must exist and be a nonbare
+ * repository, otherwise return NULL.
+ *
+ * The returned structure will be allocated and initialized but not
+ * necessarily populated; it should not be freed.
  */
 static struct ref_cache *get_ref_cache(const char *submodule)
 {
 	struct ref_cache *refs = lookup_ref_cache(submodule);
-	if (!refs)
-		refs = create_ref_cache(submodule);
+
+	if (!refs) {
+		struct strbuf submodule_sb = STRBUF_INIT;
+
+		strbuf_addstr(&submodule_sb, submodule);
+		if (is_nonbare_repository_dir(&submodule_sb))
+			refs = create_ref_cache(submodule);
+		strbuf_release(&submodule_sb);
+	}
+
 	return refs;
 }
 
@@ -1341,13 +1352,10 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 		return -1;
 
 	strbuf_add(&submodule, path, len);
-	refs = lookup_ref_cache(submodule.buf);
+	refs = get_ref_cache(submodule.buf);
 	if (!refs) {
-		if (!is_nonbare_repository_dir(&submodule)) {
-			strbuf_release(&submodule);
-			return -1;
-		}
-		refs = create_ref_cache(submodule.buf);
+		strbuf_release(&submodule);
+		return -1;
 	}
 	strbuf_release(&submodule);
 
@@ -1885,6 +1893,9 @@ int do_for_each_ref(const char *submodule, const char *prefix,
 	struct ref_cache *refs;
 
 	refs = get_ref_cache(submodule);
+	if (!refs)
+		return 0;
+
 	data.prefix = prefix;
 	data.trim = trim;
 	data.flags = flags;
-- 
2.8.1

