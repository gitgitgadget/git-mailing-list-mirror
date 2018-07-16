Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF6D1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeGPBxY (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58984 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727538AbeGPBxX (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:23 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6D3046077F;
        Mon, 16 Jul 2018 01:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704506;
        bh=1f5XEZegPsdoKDv51stikjpS8jjzcl4+ST/yl36buOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vbSGLNbSfyCbkYRxwfRVDpyVgJxMDqQaGLmB/emSWtyqITlMUPNtoxSo6df6HnxOG
         wtprEMvOeWmtf0gxG10AAntqefsLNFU28VIgRkZGm6jLADT9OOCKxl6XfkDvBPNNiH
         KyfECRBCzQCa4Ss4ztYR3/szagkHPfTzKqM4froqXKyhcLWxK9A9HsY0hBhA1qE3CP
         HdmC1YjTWPI9xiuxGSHY2HxUlu5VVyUxKluJ+VyyX7sE0ewsql4q39zLdVhEkNjpey
         GngA3ZmCfB7JLzEzlv/J2mFJbKx2yGyuJfwWh3yp79Y/Z7B1QShwY1LwoRhEc12Mcq
         4FjXogvDikiAXz/DQ1dbzGc2EiS9jBKZ/uxGmOICkENnetOg/jZHJueLGUBz+9/VOp
         dNe9Bab2STgk1h5NQFNimDc4x93/HH9xD1leAVCKlyMRA6JuOyT5S+xdiJdC76gUSO
         Nbv0Q+xbDEoKN1Soz4rUukgO4rmRHhvHQy/bXYnZ1Tu0A5CkRpc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 08/16] builtin/update-index: convert to using the_hash_algo
Date:   Mon, 16 Jul 2018 01:28:00 +0000
Message-Id: <20180716012808.961328-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch from using GIT_SHA1_HEXSZ to the_hash_algo to make the parsing of
the index information hash independent.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/update-index.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a8709a26ec..031cef5229 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -492,6 +492,7 @@ static void update_one(const char *path)
 
 static void read_index_info(int nul_term_line)
 {
+	const int hexsz = the_hash_algo->hexsz;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf uq = STRBUF_INIT;
 	strbuf_getline_fn getline_fn;
@@ -529,7 +530,7 @@ static void read_index_info(int nul_term_line)
 		mode = ul;
 
 		tab = strchr(ptr, '\t');
-		if (!tab || tab - ptr < GIT_SHA1_HEXSZ + 1)
+		if (!tab || tab - ptr < hexsz + 1)
 			goto bad_line;
 
 		if (tab[-2] == ' ' && '0' <= tab[-1] && tab[-1] <= '3') {
@@ -542,8 +543,8 @@ static void read_index_info(int nul_term_line)
 			ptr = tab + 1; /* point at the head of path */
 		}
 
-		if (get_oid_hex(tab - GIT_SHA1_HEXSZ, &oid) ||
-			tab[-(GIT_SHA1_HEXSZ + 1)] != ' ')
+		if (get_oid_hex(tab - hexsz, &oid) ||
+			tab[-(hexsz + 1)] != ' ')
 			goto bad_line;
 
 		path_name = ptr;
@@ -571,7 +572,7 @@ static void read_index_info(int nul_term_line)
 			 * ptr[-1] points at tab,
 			 * ptr[-41] is at the beginning of sha1
 			 */
-			ptr[-(GIT_SHA1_HEXSZ + 2)] = ptr[-1] = 0;
+			ptr[-(hexsz + 2)] = ptr[-1] = 0;
 			if (add_cacheinfo(mode, &oid, path_name, stage))
 				die("git update-index: unable to update %s",
 				    path_name);
