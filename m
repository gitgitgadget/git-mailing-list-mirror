Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585FC202A0
	for <e@80x24.org>; Sat, 28 Oct 2017 09:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbdJ1JuN (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 05:50:13 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58430 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750930AbdJ1JuG (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 05:50:06 -0400
X-AuditID: 1207440d-853ff70000000f42-9c-59f452caf9b2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 7D.F6.03906.BC254F95; Sat, 28 Oct 2017 05:50:03 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE7F1.dip0.t-ipconnect.de [84.170.231.241])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9S9nwqW016802
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 28 Oct 2017 05:50:01 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/7] files_transaction_prepare(): don't leak flags to packed transaction
Date:   Sat, 28 Oct 2017 11:49:50 +0200
Message-Id: <b8e61183ad5d5c046a9eff75ea0401cf2c2567c6.1509183413.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509183413.git.mhagger@alum.mit.edu>
References: <cover.1509183413.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqHsm6Eukwb+TghZdV7qZLBp6rzBb
        3F4xn9nizJtGRgcWj7/vPzB5XLyk7LH4gZfH501yASxRXDYpqTmZZalF+nYJXBkz179mLHjE
        UXHr8RymBsYJ7F2MnBwSAiYS55f/Zeli5OIQEtjBJNG/+gEbhHOKSWLO/hZWkCo2AV2JRT3N
        TCC2iICaxMS2QywgNrNAkcTX9WfB4sICERJPts9mA7FZBFQl5p6aBLaBVyBKYtrj6UwQ2+Ql
        zj24zQxicwpYSNxdthbMFhIwl3j7ZgHrBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0
        jfRyM0v0UlNKNzFCgoR3B+P/dTKHGAU4GJV4eCVyP0cKsSaWFVfmHmKU5GBSEuXdd/5TpBBf
        Un5KZUZicUZ8UWlOavEhRgkOZiUR3os+XyKFeFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1Kz
        U1MLUotgsjIcHEoSvFzAaBASLEpNT61Iy8wpQUgzcXCCDOcBGv4jEGR4cUFibnFmOkT+FKMx
        R8fNu3+YOJ7NfN3ALMSSl5+XKiXO+wKkVACkNKM0D24aLNJfMYoDPSfMOxukigeYJODmvQJa
        xQS0SkMSbFVJIkJKqoGR5d7Trdtsgu9M79ja4PRiT9i5E1/7ndb7M3715Lypcv7lhTWaOh+U
        dZiMnq7rvrnzxNEnVqonze1OGx94o5bHvV1CuMXn8mGto16T62+7Hjs321jt3z+BlGaPsi9L
        ex5X7xfXuBm3XG7z1Badt3tqLspc3bg6daP94WrtsGNLA/qO2hrcXDbPXomlOCPRUIu5qDgR
        ABatYDjPAgAA
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

