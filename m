Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0D6C6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 05:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiIMFIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 01:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiIMFIx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 01:08:53 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Sep 2022 22:08:52 PDT
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4683242AD5
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 22:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1663044823; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MQbZGnAb6Wq4RnoGkJzlVwrgY2IQStygkwHzee7ot6YMPhXGZ/BN2mF/vpcRN7WZjPmIm4FsLABnZtiw769xLKEksl7JiEq2IxN8QR2xXZVT6FIFK1dVbB3/g9MVNpI5iTNyOr/kWGeu8qjDi3cRksi8lG9I0Cl/47lhyKYddbs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1663044823; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=oc9dpMUduf5NHpRACu+GX3vhmwlhEyZ6DeRWVU+jBR0=; 
        b=jqssaESW/AgCuOieVz2fVDZq37VSw+NxoD2qnAcswd9tjLQtDnm4TKiebUI/CEmWFiN17fQQfw81Swb59ZiGEpWmp0edVQvv5ML0LJpWexn1cSaGZXVn6QJRckMayFhy9XdsmNvjzP+8IQRZOcapu9SygyTyPn2MEflIC3pGH10=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1663044821261850.3311356889716; Mon, 12 Sep 2022 21:53:41 -0700 (PDT)
Date:   Mon, 12 Sep 2022 21:53:41 -0700
From:   Elijah Conners <business@elijahpepe.com>
To:     "git" <git@vger.kernel.org>
Cc:     "hanwen" <hanwen@google.com>
Message-ID: <183353220fe.d7826593472673.3445243727369286065@elijahpepe.com>
In-Reply-To: 
Subject: [PATCH] reftable: pass pq_entry by address
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In merged_iter_pqueue_add, the pq_entry parameter is passed by value,
although it exceeds 64 bytes.

Signed-off-by: Elijah Conners <business@elijahpepe.com>
---
 reftable/merged.c  | 4 ++--
 reftable/pq.c      | 4 ++--
 reftable/pq.h      | 2 +-
 reftable/pq_test.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 2a6efa110d..5ded470c08 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -36,7 +36,7 @@ static int merged_iter_init(struct merged_iter *mi)
 				.rec = rec,
 				.index = i,
 			};
-			merged_iter_pqueue_add(&mi->pq, e);
+			merged_iter_pqueue_add(&mi->pq, &e);
 		}
 	}
 
@@ -71,7 +71,7 @@ static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
 		return 0;
 	}
 
-	merged_iter_pqueue_add(&mi->pq, e);
+	merged_iter_pqueue_add(&mi->pq, &e);
 	return 0;
 }
 
diff --git a/reftable/pq.c b/reftable/pq.c
index 96ca6dd37b..156f78a064 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -71,7 +71,7 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 	return e;
 }
 
-void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e)
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry *e)
 {
 	int i = 0;
 
@@ -81,7 +81,7 @@ void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e)
 					    pq->cap * sizeof(struct pq_entry));
 	}
 
-	pq->heap[pq->len++] = e;
+	pq->heap[pq->len++] = *e;
 	i = pq->len - 1;
 	while (i > 0) {
 		int j = (i - 1) / 2;
diff --git a/reftable/pq.h b/reftable/pq.h
index 56fc1b6d87..e5e9234baf 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -26,7 +26,7 @@ struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq);
 int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq);
 void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
-void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e);
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry *e);
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
 int pq_less(struct pq_entry *a, struct pq_entry *b);
 
diff --git a/reftable/pq_test.c b/reftable/pq_test.c
index 7de5e886f3..011b5c7502 100644
--- a/reftable/pq_test.c
+++ b/reftable/pq_test.c
@@ -46,7 +46,7 @@ static void test_pq(void)
 					       .u.ref = {
 						       .refname = names[i],
 					       } } };
-		merged_iter_pqueue_add(&pq, e);
+		merged_iter_pqueue_add(&pq, &e);
 		merged_iter_pqueue_check(pq);
 		i = (i * 7) % N;
 	} while (i != 1);
-- 
2.29.2.windows.2



