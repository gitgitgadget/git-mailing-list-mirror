Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255AD1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJIFLB (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:11:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49304 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbeJIFLB (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:11:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5747660783;
        Mon,  8 Oct 2018 21:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035831;
        bh=K13ZfQ45guTuC54UyPu3sK9+mK2LthXD+W7VT9EqKZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=G/7WXJBxR3cSCmY5YiIlK63HgpRLOokqkmbLpb9UXsQ8JJg1KqFfmQo8XaC+wqPRn
         Wh6JTxOBazZnfk2dwACrimZJKShu5axg3X1AXG8BfpAsi5kUOuEC+32L/tneGCuLuZ
         hmHs9wAvaFoVvfWfZLD+4BSQR8vPzEgYjGl/b5NliTpK56DKHN+grJZwYSp1sxTm/v
         PB3JQItsTrxwNjoIAAhMr6DNi7t69PHP6mG2oh7vjOcmfT2xck81NgYEt3T8+GkSfM
         hS8gwon6X4TcvATANv05lQdJBmEY+vVJQIXOvL1qYPw5vRueI5EoqfjkDr16ActrEZ
         Y4oaJhF2TSDnRPypTiO1qqNwVJlQVAmjsxTaek/EZMHEC3sv4HZgc6/sD8hW7RYp7R
         VpISQxkrkNrl4qFXt2ipCoTABvts6GUBMMHEqJKfifHN1zv15V/kyqN6mKww4McBpn
         J7IyUZpad5WcyY7iK9Ueof1RfBx7cDhI+lfPqZwCEeVkYtgYkQw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/14] builtin/fetch-pack: remove constants with parse_oid_hex
Date:   Mon,  8 Oct 2018 21:56:51 +0000
Message-Id: <20181008215701.779099-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008215701.779099-1-sandals@crustytoothpaste.net>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using GIT_SHA1_HEXSZ, use parse_oid_hex to compute a pointer
and use that in comparisons.  This is both simpler to read and works
independent of the hash length.  Update references to SHA-1 in the same
function to refer to object IDs instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fetch-pack.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 1a1bc63566..63e69a5801 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -16,13 +16,14 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 {
 	struct ref *ref;
 	struct object_id oid;
+	const char *p;
 
-	if (!get_oid_hex(name, &oid)) {
-		if (name[GIT_SHA1_HEXSZ] == ' ') {
-			/* <sha1> <ref>, find refname */
-			name += GIT_SHA1_HEXSZ + 1;
-		} else if (name[GIT_SHA1_HEXSZ] == '\0') {
-			; /* <sha1>, leave sha1 as name */
+	if (!parse_oid_hex(name, &oid, &p)) {
+		if (*p == ' ') {
+			/* <oid> <ref>, find refname */
+			name = p + 1;
+		} else if (*p == '\0') {
+			; /* <oid>, leave oid as name */
 		} else {
 			/* <ref>, clear cruft from oid */
 			oidclr(&oid);
