Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B231F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeJOHpC (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:45:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50554 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbeJOHpC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:45:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1E5E661B79;
        Mon, 15 Oct 2018 00:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561737;
        bh=K13ZfQ45guTuC54UyPu3sK9+mK2LthXD+W7VT9EqKZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xFhE3+YX517mYFZ/CHkIVaAPrPBc3/W99+k8VquZKGeyxC1bDZQI7hfCyf+x19VxJ
         wusvf7KBOoh0WtQQgccgtqF9McF4j223Nf9866azFHJNg6+p5asyHVAmuYskZ+HZ0g
         nIGm+xAnG073KctpraBNQs8otpxIds7dSo4kWDgDUUj/TMoj7ByBlvNT49fv5SLBBJ
         G3fPl7neQ+CTz9ys6SLCFLl0V6DsDlcvsnP66+R5qQsHfCJw6r6WYEk2quZ9lYmWi/
         veT2EA+w8bBq6AnGa60ghl9AReeecTqarRZnlXQdWsagNl7XypKPu5pEflsA/gJJvg
         bDrUWw6s0tjI2f4ySUSXGJWwPVObSq4pt1tSOUl0F1B9PKkMbLZGGsoPUPDitDpjB3
         RXyzEoxT4B6uKH/VApd1BnoEIvGKefupIwyQjJ7RIftP69ffFRaqbBey4qOoUbqe7J
         NM3z1Fpkp+f0MQe3VwBksnTcAk1h3hiHlSWKj0k5mhmPj4b2F5W
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 05/15] builtin/fetch-pack: remove constants with parse_oid_hex
Date:   Mon, 15 Oct 2018 00:01:52 +0000
Message-Id: <20181015000202.951965-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015000202.951965-1-sandals@crustytoothpaste.net>
References: <20181015000202.951965-1-sandals@crustytoothpaste.net>
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
