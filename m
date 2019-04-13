Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56A7820248
	for <e@80x24.org>; Sat, 13 Apr 2019 05:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDMFyd (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 01:54:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:57218 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726944AbfDMFyc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 01:54:32 -0400
Received: (qmail 27766 invoked by uid 109); 13 Apr 2019 05:54:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Apr 2019 05:54:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12654 invoked by uid 111); 13 Apr 2019 05:55:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Apr 2019 01:55:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Apr 2019 01:54:31 -0400
Date:   Sat, 13 Apr 2019 01:54:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 6/7] remote.c: make singular free_ref() public
Message-ID: <20190413055430.GF19495@sigill.intra.peff.net>
References: <20190413055127.GA32340@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190413055127.GA32340@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We provide a free_refs() function to free a list, but there's no easy
way for a caller to free a single ref. Let's make our singular
free_ref() function public. Since its name is so similar to the
list-freeing free_refs(), and because both of those functions have the
same signature, it might be easy to accidentally use the wrong one.
Let's call the singular version the more verbose "free_one_ref()" to
distinguish it.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 6 +++---
 remote.h | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 9cc3b07d21..3fe34eae85 100644
--- a/remote.c
+++ b/remote.c
@@ -820,11 +820,11 @@ struct ref *copy_ref_list(const struct ref *ref)
 	return ret;
 }
 
-static void free_ref(struct ref *ref)
+void free_one_ref(struct ref *ref)
 {
 	if (!ref)
 		return;
-	free_ref(ref->peer_ref);
+	free_one_ref(ref->peer_ref);
 	free(ref->remote_status);
 	free(ref->symref);
 	free(ref);
@@ -835,7 +835,7 @@ void free_refs(struct ref *ref)
 	struct ref *next;
 	while (ref) {
 		next = ref->next;
-		free_ref(ref);
+		free_one_ref(ref);
 		ref = next;
 	}
 }
diff --git a/remote.h b/remote.h
index da53ad570b..f58332a27e 100644
--- a/remote.h
+++ b/remote.h
@@ -131,8 +131,10 @@ int ref_compare_name(const void *, const void *);
 int check_ref_type(const struct ref *ref, int flags);
 
 /*
- * Frees the entire list and peers of elements.
+ * Free a single ref and its peer, or an entire list of refs and their peers,
+ * respectively.
  */
+void free_one_ref(struct ref *ref);
 void free_refs(struct ref *ref);
 
 struct oid_array;
-- 
2.21.0.931.gd0bc72a411

