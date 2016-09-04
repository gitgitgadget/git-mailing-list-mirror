Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AAB20193
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754426AbcIDQL7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:11:59 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55340 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754346AbcIDQLu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:50 -0400
X-AuditID: 12074414-c8fff70000000931-58-57cc475d51d2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 6B.9A.02353.D574CC75; Sun,  4 Sep 2016 12:10:05 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n60026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:10:03 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        David Turner <dturner@twopensource.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 38/38] refs: implement iteration over only per-worktree refs
Date:   Sun,  4 Sep 2016 18:08:44 +0200
Message-Id: <d4e799241de9186f05187d820707c103bc5b4e8e.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqBvrfibcYO9DCYv5m04wWnRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li5lVrizNvGhkdOD3+vv/A5LFz1l12j672I2we
        z3r3MHpcvKTssX/pNjaPxQ+8PBY8v8/u8XmTXABnFJdNSmpOZllqkb5dAlfGp8WvWQr2CFQ8
        e/WAsYHxKm8XIyeHhICJxJrHV1m6GLk4hAS2Mkqc+7eaGcI5ySSx8NsMRpAqNgFdiUU9zUwg
        toiAmsTEtkNgHcwCv5kkLmx9zg6SEBbwl+j9+xKsgUVAVeLqoWtgDbwCURLrZnewQqyTk7i0
        7QsziM0pYCFxZvdcIJsDaJu5RPuL7AmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro
        5WaW6KWmlG5ihIShyA7GIyflDjEKcDAq8fBaaJ8JF2JNLCuuzD3EKMnBpCTKO+vgyXAhvqT8
        lMqMxOKM+KLSnNTiQ4wSHMxKIrzaLkDlvCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1ML
        UotgsjIcHEoSvNddgRoFi1LTUyvSMnNKENJMHJwgw3mAht8EqeEtLkjMLc5Mh8ifYlSUEud9
        CZIQAElklObB9cLSxCtGcaBXhHkT3ICqeIApBq77FdBgJqDB63afBhlckoiQkmpgXLb1mP/s
        8ksPip/nb715/iyf8nE7SYUgp3vH30raamh/Oish7BA6b09ZzPd3r+QPz9iV/YYllDXhhXja
        58BvlRsn8McGVh5PSqkT6f1q/X1qZuKjVWle+bvnmdyr0NgV6XLyjdDSfFdfRdHNYfPm1p8L
        tRXu6byR9eP/hY5JKddTRHXe/00rV2Ipzkg01GIuKk4EAI4NoH3uAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

Alternate refs backends might still use files to store per-worktree
refs. So provide a way to iterate over only the per-worktree references
in a ref_store. The other backend can set up a files ref_store and
iterate using the new DO_FOR_EACH_PER_WORKTREE_ONLY flag when iterating.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c |  4 ++++
 refs/refs-internal.h | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0714c3f..2644792 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1798,6 +1798,10 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	int ok;
 
 	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
+		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+		    ref_type(iter->iter0->refname) != REF_TYPE_PER_WORKTREE)
+			continue;
+
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
 		    !ref_resolves_to_object(iter->iter0->refname,
 					    iter->iter0->oid,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 681982b..708b260 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -467,10 +467,18 @@ extern struct ref_iterator *current_ref_iter;
 int do_for_each_ref_iterator(struct ref_iterator *iter,
 			     each_ref_fn fn, void *cb_data);
 
-/* refs backends */
+/*
+ * Only include per-worktree refs in a do_for_each_ref*() iteration.
+ * Normally this will be used with a files ref_store, since that's
+ * where all reference backends will presumably store their
+ * per-worktree refs.
+ */
+#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
 
 struct ref_store;
 
+/* refs backends */
+
 /*
  * Initialize the ref_store for the specified submodule, or for the
  * main repository if submodule == NULL. These functions should call
-- 
2.9.3

