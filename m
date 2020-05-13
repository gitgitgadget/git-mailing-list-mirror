Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AD5C2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A69320753
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iAFVCi52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgEMAzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38156 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731906AbgEMAyw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:52 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9833260D0D;
        Wed, 13 May 2020 00:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331290;
        bh=QofIfR5pOyf6mrSUvF27hy9tTvuhWy8Qz5L3I6VaToU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=iAFVCi52+wITCjGnqor5x1k533AP6tbjBbyiqcGTPmqDMHJs035iwi084FGY0canP
         JTkOM37fdKsYjCJJtQguVnTEDPwJmNn7tgJOxuIlKtBxTsWnzP5JYfjM2O0N6SVvNh
         Oj3tLnrxBMfK66X9R8UUlLfVcL3XvSZiof+ROYr9OYlJ7t+vqpLWpPrebNgcIRchBe
         Rc9sI0rR2BAsNSOIbQd5Nrv00dyTTA8BMU5n+SP0nGC9ewt1modkY5FyoYncVSop2K
         YLWcoW9BjRaUKDnWOfmjZ8feqlvMGKleXiXV4Clv1p8Etgf1VLO0vzcAk82mMdzqSH
         l/AqDDVPIocPCuDEItLql/CWWfgb/OFcyX91eGwXI6Wd/bf7+kC5z91viqCcQqmJHZ
         AKbiDVXTHXsro2xpeh4nJvKC0UWbwgPu1wV832sEnItxFXTvA+QKvaDH+b2/34pqkY
         EWItzslWrNg6Jf62Emh/j9F958fMpeWMiPkgUEIZF2xj5UJAtNj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 30/44] connect: pass full packet reader when parsing v2 refs
Date:   Wed, 13 May 2020 00:54:10 +0000
Message-Id: <20200513005424.81369-31-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're parsing refs, we need to know not only what the line we're
parsing is, but also the hash algorithm we should use to parse it, which
is stored in the reader object.  Pass the packet reader object through
to the protocol v2 ref parsing function.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index a39b843589..bb4bc4ab7f 100644
--- a/connect.c
+++ b/connect.c
@@ -373,7 +373,7 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 }
 
 /* Returns 1 when a valid ref has been added to `list`, 0 otherwise */
-static int process_ref_v2(const char *line, struct ref ***list)
+static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 {
 	int ret = 1;
 	int i = 0;
@@ -381,6 +381,7 @@ static int process_ref_v2(const char *line, struct ref ***list)
 	struct ref *ref;
 	struct string_list line_sections = STRING_LIST_INIT_DUP;
 	const char *end;
+	const char *line = reader->line;
 
 	/*
 	 * Ref lines have a number of fields which are space deliminated.  The
@@ -466,9 +467,10 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	}
 	packet_flush(fd_out);
 
+
 	/* Process response from server */
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
-		if (!process_ref_v2(reader->line, &list))
+		if (!process_ref_v2(reader, &list))
 			die(_("invalid ls-refs response: %s"), reader->line);
 	}
 
