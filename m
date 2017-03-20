Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745C220958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755581AbdCTQeD (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:34:03 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54228 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753006AbdCTQeA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:34:00 -0400
X-AuditID: 12074413-f67ff700000077e1-67-58d004750f23
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id CF.3F.30689.57400D85; Mon, 20 Mar 2017 12:33:57 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9N010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:55 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/20] refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
Date:   Mon, 20 Mar 2017 17:33:18 +0100
Message-Id: <2801bce554d1b23c0efb910a2fdf3a0164153687.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsUixO6iqFvKciHC4NVlaYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6Mya+bWAt+ClRMXH6TrYHxBG8XIyeHhICJxNV5E9m7GLk4hAR2MEnc
        ur4SyjnFJLH75X1WkCo2AV2JRT3NTCC2iICaxMS2QywgRcwCjxglrs6/C9TBwSEs4COx82EZ
        SA2LgKrEvsc9YL28AlES945vYIbYJi+xq+0iWJxTwELiy/1GFhBbSMBconNBL/sERp4FjAyr
        GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MULCSXgH466TcocYBTgYlXh4V1w5
        HyHEmlhWXJl7iFGSg0lJlPfpbaAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6ql0A53pTEyqrU
        onyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEby/ThQghwaLU9NSKtMycEoQ0Ewcn
        yHAeoOF1IDW8xQWJucWZ6RD5U4yKUuK8BYxACQGQREZpHlwvLN5fMYoDvSLMywLSzgNMFXDd
        r4AGMwENXnbjDMjgkkSElFQD49o6vi1n627yOKx2WLBznsapyy8WxRrFr3I+wnDvP4NR7IUD
        UjWNx4R6MputA/sDxCRTDZbO2ZZl7W5gdFk2UHTJ9neJK79/+9O3ZcWqHYF/D0ucq136v+/T
        6+hn89+9rJX0nettW9Q1/axlff/d6S5HNa/JnHVZJ7pz45N7AjtuJR5VTPt966MSS3FGoqEW
        c1FxIgB+HBO50gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That "refs/bisect/" has to be handled specially when filling the
ref_cache for loose references is a peculiarity of the files backend,
and the ref-cache code shouldn't need to know about it. So move this
code to the callback function, `loose_fill_ref_dir()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 15 +++++++++++++++
 refs/ref-cache.c     | 16 ----------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e4d78393ac..7b5f5c1240 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -508,6 +508,21 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	strbuf_release(&refname);
 	strbuf_release(&path);
 	closedir(d);
+
+	/*
+	 * Manually add refs/bisect, which, being per-worktree, might
+	 * not appear in the directory listing for refs/ in the main
+	 * repo.
+	 */
+	if (!strcmp(dirname, "refs/")) {
+		int pos = search_ref_dir(dir, "refs/bisect/", 12);
+
+		if (pos < 0) {
+			struct ref_entry *child_entry = create_dir_entry(
+					dir->cache, "refs/bisect/", 12, 1);
+			add_entry_to_dir(dir, child_entry);
+		}
+	}
 }
 
 static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 7f247b9170..44440e0c13 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -26,22 +26,6 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 			die("BUG: incomplete ref_store without fill_ref_dir function");
 
 		dir->cache->fill_ref_dir(dir->cache->ref_store, dir, entry->name);
-
-		/*
-		 * Manually add refs/bisect, which, being
-		 * per-worktree, might not appear in the directory
-		 * listing for refs/ in the main repo.
-		 */
-		if (!strcmp(entry->name, "refs/")) {
-			int pos = search_ref_dir(dir, "refs/bisect/", 12);
-			if (pos < 0) {
-				struct ref_entry *child_entry;
-				child_entry = create_dir_entry(dir->cache,
-							       "refs/bisect/",
-							       12, 1);
-				add_entry_to_dir(dir, child_entry);
-			}
-		}
 		entry->flag &= ~REF_INCOMPLETE;
 	}
 	return dir;
-- 
2.11.0

