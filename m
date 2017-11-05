Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42CF12055E
	for <e@80x24.org>; Sun,  5 Nov 2017 08:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbdKEIm3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 03:42:29 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61071 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752410AbdKEImX (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 03:42:23 -0500
X-AuditID: 12074414-0d3ff70000006ddf-43-59fecee9f6e5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 43.79.28127.9EECEF95; Sun,  5 Nov 2017 03:42:17 -0500 (EST)
Received: from bagpipes.fritz.box (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA58gCCq018723
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 03:42:16 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/9] files_transaction_prepare(): don't leak flags to packed transaction
Date:   Sun,  5 Nov 2017 09:42:01 +0100
Message-Id: <b8e61183ad5d5c046a9eff75ea0401cf2c2567c6.1509870243.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509870243.git.mhagger@alum.mit.edu>
References: <cover.1509870243.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqPvy3L9Ig09v5Cy6rnQzWTT0XmG2
        +Pumi9Hi9or5zBZn3jQyOrB6/H3/gclj56y77B4XLyl7LH7g5fF5k1wAaxSXTUpqTmZZapG+
        XQJXxsz1rxkLHnFU3Ho8h6mBcQJ7FyMnh4SAicTxSzNZuxi5OIQEdjBJPLv1hB3COcEksbv3
        JRtIFZuArsSinmYmEFtEQE1iYtshFpAiZoGtjBJ/u5uZQRLCAtEScx5dZwWxWQRUJbbMnAPW
        zCsQJXH+xzQWiHXyEuce3Aar5xSwkPjzcR5YjZCAucSnTztZJzDyLGBkWMUol5hTmqubm5iZ
        U5yarFucnJiXl1qka6GXm1mil5pSuokREjoiOxiPnJQ7xCjAwajEw3vC41+kEGtiWXFl7iFG
        SQ4mJVHeKy//RArxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4Q1aDFTOm5JYWZValA+TkuZgURLn
        /bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBO+0sUKNgUWp6akVaZk4JQpqJgxNkOA/Q8OUgNbzF
        BYm5xZnpEPlTjMYcz2a+bmDmmHa1tYlZiCUvPy9VSpz3GEipAEhpRmke3DRY/L9iFAd6Tpj3
        MkgVDzB1wM17BbSKCWjVbI4/IKtKEhFSUg2MzeE2Wqy7PFszv4slsh9bwOy8YumLs8mfw6NL
        Dy0WsnA6JdGn5PiEmVPlZssPBfekx+mVzi8atXvv+wjuZ5nlP4/hzWKzR9VLfD9mhXKcPdG6
        cN+mM/lcGsxbTybdm3ibVdey/N7//Q+TTI8snWf42UFleVSxx6Nz6Ql+/KczNMUeMU2eVqKs
        xFKckWioxVxUnAgAptnXq9oCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The files backend uses `ref_update::flags` for several internal flags.
But those flags have no meaning to the packed backend. So when adding
updates for the packed-refs transaction, only use flags that make
sense to the packed backend.

`REF_NODEREF` is part of the public interface, and it's logically what
we want, so include it. In fact it is actually ignored by the packed
backend (which doesn't support symbolic references), but that's its
own business.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2bd54e11ae..fadf1036d3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2594,8 +2594,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 			ref_transaction_add_update(
 					packed_transaction, update->refname,
-					update->flags & ~REF_HAVE_OLD,
-					&update->new_oid, &update->old_oid,
+					REF_HAVE_NEW | REF_NODEREF,
+					&update->new_oid, NULL,
 					NULL);
 		}
 	}
-- 
2.14.1

