Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA4F1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 23:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeHKBlm (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:41:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:50662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727026AbeHKBlm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:41:42 -0400
Received: (qmail 27980 invoked by uid 109); 10 Aug 2018 23:09:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 23:09:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24629 invoked by uid 111); 10 Aug 2018 23:09:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 19:09:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 19:09:44 -0400
Date:   Fri, 10 Aug 2018 19:09:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/7] for_each_*_object: take flag arguments as enum
Message-ID: <20180810230944.GB19875@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810230729.GA19090@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not wrong to pass our flags in an "unsigned", as we
know it will be at least as large as the enum.  However,
using the enum in the declaration makes it more obvious
where to find the list of flags.

While we're here, let's also drop the "extern" noise-words
from the declarations, per our modern coding style.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     | 3 ++-
 packfile.c  | 3 ++-
 packfile.h  | 5 +++--
 sha1-file.c | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 4187238ecf..9e02fc494e 100644
--- a/cache.h
+++ b/cache.h
@@ -1640,7 +1640,8 @@ enum for_each_object_flags {
  * repository and any alternates repositories (unless the
  * LOCAL_ONLY flag is set).
  */
-extern int for_each_loose_object(each_loose_object_fn, void *, unsigned flags);
+int for_each_loose_object(each_loose_object_fn, void *,
+			  enum for_each_object_flags flags);
 
 /*
  * Set this to 0 to prevent sha1_object_info_extended() from fetching missing
diff --git a/packfile.c b/packfile.c
index 6974903e58..9da8f6d728 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1904,7 +1904,8 @@ int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void
 	return r;
 }
 
-int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
+int for_each_packed_object(each_packed_object_fn cb, void *data,
+			   enum for_each_object_flags flags)
 {
 	struct packed_git *p;
 	int r = 0;
diff --git a/packfile.h b/packfile.h
index 6ddc6a2e91..9861728514 100644
--- a/packfile.h
+++ b/packfile.h
@@ -158,8 +158,9 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data);
-extern int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn, void *data);
-extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
+int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn, void *data);
+int for_each_packed_object(each_packed_object_fn, void *,
+			   enum for_each_object_flags flags);
 
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
diff --git a/sha1-file.c b/sha1-file.c
index dfa8a35d68..cc0b57a751 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2146,7 +2146,8 @@ static int loose_from_alt_odb(struct alternate_object_database *alt,
 	return r;
 }
 
-int for_each_loose_object(each_loose_object_fn cb, void *data, unsigned flags)
+int for_each_loose_object(each_loose_object_fn cb, void *data,
+			  enum for_each_object_flags flags)
 {
 	struct loose_alt_odb_data alt;
 	int r;
-- 
2.18.0.1058.g7433f71063

