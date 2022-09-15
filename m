Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947A0ECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 03:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiIODi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 23:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiIODiT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 23:38:19 -0400
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD0692F70
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 20:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1663213054; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=KKOkj+U5w257qZn7F73y08pvRpqkdh3uOUqBZuCPM8xkWV0jwu18VllrE4VT8YIOL6IBqmOgPOUbgCOWfMeBuNYYEGX6/DOD+mcC0dTvJKwWwj0dtU2qtwxLqHHm8kNqzV4t2TaOAulbjDtNjVpp97ovG8Jpt0RVk7/l0aMnQaI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1663213054; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=RxHnYmT5v9bqm6WmfbujHt5DntoBIDWzvfRFDU9dtJY=; 
        b=nCDmowteUnJc404oMIr2EITxXudqaB54rbzCktgZpazaa9lXVl9ku4i9x8AuS6dpdF2xpqSKl2BGItqHilQcpYxHjOjbkyyrym7Sk1h84NFTR/lL1K7kHr7VbXBbf4fSGOd/QoBVNW+K3lPyXPIVQC2PcYiM8+Pfwrl6hlnWKVI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1663213054171709.0585200489435; Wed, 14 Sep 2022 20:37:34 -0700 (PDT)
Date:   Wed, 14 Sep 2022 20:37:34 -0700
From:   Elijah Conners <business@elijahpepe.com>
To:     "git" <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>, "hanwen" <hanwen@google.com>
Message-ID: <1833f3928cb.acf3c97d869879.7909589521159235166@elijahpepe.com>
In-Reply-To: 
Subject: [PATCH v2] reftable: use a pointer for pq_entry param
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The speed of the merged_iter_pqueue_add() can be improved by using a
pointer to the pq_entry struct, which is 96 bytes. Since the pq_entry
param is worked directly on the stack and does not currently have a
pointer to it, the merged_iter_pqueue_add() function is slightly
slower.

References to pq_entry in reftable have typically included pointers,
such as both of the params for pq_less().

Since we are working with pointers in the pq_entry param, as keenly
pointed out, the pq_entry param has also been made into a const since
the contents of the pq_entry param are copied and not manipulated.

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
-                       merged_iter_pqueue_add(&mi->pq, e);
+                       merged_iter_pqueue_add(&mi->pq, &e);
                }
        }

@@ -71,7 +71,7 @@ static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
                return 0;
        }

-       merged_iter_pqueue_add(&mi->pq, e);
+       merged_iter_pqueue_add(&mi->pq, &e);
        return 0;
 }

diff --git a/reftable/pq.c b/reftable/pq.c
index 96ca6dd37b..dcefeb793a 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -71,7 +71,7 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
        return e;
 }

-void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e)
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)
 {
        int i = 0;

@@ -81,7 +81,7 @@ void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e)
                                            pq->cap * sizeof(struct pq_entry));
        }

-       pq->heap[pq->len++] = e;
+       pq->heap[pq->len++] = *e;
        i = pq->len - 1;
        while (i > 0) {
                int j = (i - 1) / 2;
diff --git a/reftable/pq.h b/reftable/pq.h
index 56fc1b6d87..e85bac9b52 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -26,7 +26,7 @@ struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq);
 int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq);
 void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
-void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e);
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e);
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
-               merged_iter_pqueue_add(&pq, e);
+               merged_iter_pqueue_add(&pq, &e);
                merged_iter_pqueue_check(pq);
                i = (i * 7) % N;
        } while (i != 1);
--
2.29.2.windows.2
