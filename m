Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E249F1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfHRUFi (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57932 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727127AbfHRUFg (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D3C5D60748;
        Sun, 18 Aug 2019 20:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158735;
        bh=INVjGOkpeZlh5ucqkeOAjH8Scw2PZtu0y8eyEwGBhvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=VROTxXsrX3S2r4HChw1j3Y2tt6dHzoRtSuIvp5LsqU3wYC7yqdY1WidNfhN15k35B
         7FkWCANt8Uqw6ZIZA5eVCm8XzmJGfWfOx/7viu5NAcQsVaZCbUDy8c2VTxV9g3sEqi
         xJRWfexjZw7/Mv7V8nBRelmnZ28lFBbGKGnHBxWslQ6tLnsdhl7G7dMdxIVW+ysYXa
         2WYKQv+XMhN2NBKKK+aAC4ZPGS8VHhHZUDMWB0/HjD+H4wJoxJVSHA5uJKUMzrvLAe
         i8d1sZ+yhFcknBS1BPwFqEWrVd6LGdvjFTT8sQyg39ZQ2/MmU+s+hoY5cD57/a3RMq
         zrNwBOcOd7BJZefO2PbYA7iwz83qxf1fADI7h1aqdCWBhYvRLdaD0cFAkCPf/H0F6J
         1KBYV+DewHvWgGl6C9ECshjVg39lH7KQ8HrvvJAzTVm/lVx91AgOHOlFFfVb/+EQh+
         ejFF+oimSa28XeF6sbB0RqP3hGlEPkEVf7JedgCCbCJ1h5mPydA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 07/26] blame: remove needless comparison with GIT_SHA1_HEXSZ
Date:   Sun, 18 Aug 2019 20:04:08 +0000
Message-Id: <20190818200427.870753-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When faking a working tree commit, we read in lines from MERGE_HEAD into
a strbuf.  Because the strbuf is NUL-terminated and get_oid_hex will
fail if it unexpectedly encounters a NUL, the check for the length of
the line is unnecessary.  There is no optimization benefit from this
case, either, since on failure we call die.  Remove this check, since it
is no longer needed.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 blame.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blame.c b/blame.c
index 36a2e7ef11..6596d8de88 100644
--- a/blame.c
+++ b/blame.c
@@ -144,7 +144,7 @@ static void append_merge_parents(struct repository *r,
 
 	while (!strbuf_getwholeline_fd(&line, merge_head, '\n')) {
 		struct object_id oid;
-		if (line.len < GIT_SHA1_HEXSZ || get_oid_hex(line.buf, &oid))
+		if (get_oid_hex(line.buf, &oid))
 			die("unknown line in '%s': %s",
 			    git_path_merge_head(r), line.buf);
 		tail = append_parent(r, tail, &oid);
