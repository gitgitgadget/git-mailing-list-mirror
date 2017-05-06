Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1EC5207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754493AbdEFWL3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:11:29 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37622 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754139AbdEFWLH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DC441280B5;
        Sat,  6 May 2017 22:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108666;
        bh=2NSpD/LyhkhM4CA1zbv1XExfrT+1NOxf8jIFQ2ob+cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbdZ16o/93re0amxm4Nfx6GAIPRx9LZ5rrF+UUph0nZ9OKaf31QFO9HmpEprxNvBd
         QX5PK3Rsw+3oj8NEutaJwk6tI5XBWDLD5EL9YR0T6kUwrgmbrEEWZ+PLrIUP+V+3YE
         67bo6vk1Ck9xWRRD4JiCCV4puzbhBeZLh/ySzjPazd1hZ9rAdwUiaAQHqdF60Cp/Cv
         mgKDm/W7CO09X33JR8oQclSKxB2CplSYJStc+YF4eA7dnFcLE2xBEKty1Va0AEvsdE
         TlAwK/i0GVxPjW1nIeRSKXfcYo4QtpLWZMYVRppNA+GUFlmDX1EyrNOsbrgrWVCSPX
         MP/Y2DHE6LrefgoEJ+h/Q3L7vANrgZCGUVKIoyRt8afWyb5zKq6tRkmYAgo1R5/5wG
         Jx81yMxk0maX3Hk/FaPbTBAgDeRrf2QwXko/mFPDHCX/pMYl5/HLN3+kkX8JGbRd70
         V9QXkUv5UuvywVbHfAs4KO6yRvoxLz6syS+iNnf93WRlu26K325
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 08/53] builtin/blame: convert static function to struct object_id
Date:   Sat,  6 May 2017 22:09:53 +0000
Message-Id: <20170506221038.296722-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is a caller of lookup_commit_reference_gently, which we
will convert later.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/blame.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 07506a3e4..7d644d092 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2461,7 +2461,7 @@ static const char *dwim_reverse_initial(struct scoreboard *sb)
 	 */
 	struct object *obj;
 	struct commit *head_commit;
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 
 	if (sb->revs->pending.nr != 1)
 		return NULL;
@@ -2473,9 +2473,9 @@ static const char *dwim_reverse_initial(struct scoreboard *sb)
 		return NULL;
 
 	/* Do we have HEAD? */
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
 		return NULL;
-	head_commit = lookup_commit_reference_gently(head_sha1, 1);
+	head_commit = lookup_commit_reference_gently(head_oid.hash, 1);
 	if (!head_commit)
 		return NULL;
 
