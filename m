Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B4831F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbcIDQKh (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:10:37 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54584 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754040AbcIDQKN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:10:13 -0400
X-AuditID: 1207440d-bf7ff700000008af-ff-57cc47339cb5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 81.86.02223.3374CC75; Sun,  4 Sep 2016 12:09:24 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5c026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:22 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/38] resolve_gitlink_ref(): implement using resolve_ref_recursively()
Date:   Sun,  4 Sep 2016 18:08:22 +0200
Message-Id: <1e7e45a2a96e1ae7d45a1072c3c965bc7c02105c.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqGvifibc4O5eNouuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGU9+/mApeCJTsWWlQQPjPPEuRg4O
        CQETiWnvS7sYuTiEBLYySlze/oYVwjnJJHFiThdjFyMnB5uArsSinmYmEFtEQE1iYtshFpAi
        ZpCiWRNnsoMkhAWiJL5MvgFmswioStyc/YQZxOYFirdvPcMGYksIyElc2vYFLM4pYCFxZvdc
        ZpArhATMJdpfZE9g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIyTc
        eHcw/l8nc4hRgINRiYfXQvtMuBBrYllxZe4hRkkOJiVR3lkHT4YL8SXlp1RmJBZnxBeV5qQW
        H2KU4GBWEuHVdgEq501JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8Da4
        AjUKFqWmp1akZeaUIKSZODhBhvMADb8JUsNbXJCYW5yZDpE/xagoJc4bArJVACSRUZoH1wtL
        B68YxYFeEeZVdAOq4gGmErjuV0CDmYAGr9t9GmRwSSJCSqqBMcBtx4XTLaWKJYUe2ixCjy/e
        C1xh++O2REOc/K69M57vdMrR3+1mb3z/yaXqIoHaNVF9v1sn1sjsLLGUP371wP17PAsiZux/
        s+nQNJ+FJ343KNiXrF87x+J0xKJTXJcWvZfUOpx50HPyvT+vL0Tc2dm4c/HLqMn3G7cfNF2n
        Ur55y6WDJc/s1KKVWIozEg21mIuKEwGOr2iv4gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

resolve_ref_recursively() can handle references in arbitrary files
reference stores, so use it to resolve "gitlink" (i.e., submodule)
references. Aside from removing redundant code, this allows submodule
lookups to benefit from the much more robust code that we use for
reading non-submodule references. And, since the code is now agnostic
about reference backends, it will work for any future references
backend (so move its definition to refs.c).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 24 +++++++++++++++++++
 refs/files-backend.c | 67 ----------------------------------------------------
 2 files changed, 24 insertions(+), 67 deletions(-)

diff --git a/refs.c b/refs.c
index 3723169..647ead5 100644
--- a/refs.c
+++ b/refs.c
@@ -1299,6 +1299,30 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 				       resolve_flags, sha1, flags);
 }
 
+int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+{
+	int len = strlen(path);
+	struct strbuf submodule = STRBUF_INIT;
+	struct ref_store *refs;
+	int flags;
+
+	while (len && path[len-1] == '/')
+		len--;
+	if (!len)
+		return -1;
+
+	strbuf_add(&submodule, path, len);
+	refs = get_ref_store(submodule.buf);
+	strbuf_release(&submodule);
+	if (!refs)
+		return -1;
+
+	if (!resolve_ref_recursively(refs, refname, 0, sha1, &flags) ||
+	    is_null_sha1(sha1))
+		return -1;
+	return 0;
+}
+
 /* A pointer to the ref_store for the main repository: */
 static struct ref_store *main_ref_store;
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ce6fe94..6382c6b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1494,73 +1494,6 @@ static void unlock_ref(struct ref_lock *lock)
 	free(lock);
 }
 
-#define MAXREFLEN (1024)
-
-static int resolve_gitlink_ref_recursive(struct files_ref_store *refs,
-					 const char *refname, unsigned char *sha1,
-					 int recursion)
-{
-	int fd, len;
-	char buffer[128], *p;
-	char *path;
-
-	if (recursion > SYMREF_MAXDEPTH || strlen(refname) > MAXREFLEN)
-		return -1;
-	path = *refs->base.submodule
-		? git_pathdup_submodule(refs->base.submodule, "%s", refname)
-		: git_pathdup("%s", refname);
-	fd = open(path, O_RDONLY);
-	free(path);
-	if (fd < 0) {
-		unsigned int flags;
-
-		return resolve_packed_ref(refs, refname, sha1, &flags);
-	}
-
-	len = read(fd, buffer, sizeof(buffer)-1);
-	close(fd);
-	if (len < 0)
-		return -1;
-	while (len && isspace(buffer[len-1]))
-		len--;
-	buffer[len] = 0;
-
-	/* Was it a detached head or an old-fashioned symlink? */
-	if (!get_sha1_hex(buffer, sha1))
-		return 0;
-
-	/* Symref? */
-	if (strncmp(buffer, "ref:", 4))
-		return -1;
-	p = buffer + 4;
-	while (isspace(*p))
-		p++;
-
-	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
-}
-
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
-{
-	int len = strlen(path);
-	struct strbuf submodule = STRBUF_INIT;
-	struct files_ref_store *refs;
-
-	while (len && path[len-1] == '/')
-		len--;
-	if (!len)
-		return -1;
-
-	strbuf_add(&submodule, path, len);
-	refs = get_files_ref_store(submodule.buf, "resolve_gitlink_ref");
-	if (!refs) {
-		strbuf_release(&submodule);
-		return -1;
-	}
-	strbuf_release(&submodule);
-
-	return resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
-}
-
 /*
  * Lock refname, without following symrefs, and set *lock_p to point
  * at a newly-allocated lock object. Fill in lock->old_oid, referent,
-- 
2.9.3

