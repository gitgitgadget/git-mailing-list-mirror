Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E757C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA7321527
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MChPRlvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404795AbgFSR4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39458 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393914AbgFSR4g (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1549960A77;
        Fri, 19 Jun 2020 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589388;
        bh=gcmPlShg+W0YG/VVs2GsdWxNbZDEeQ+gaiDzhdzhpqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MChPRlvG9H4vqXqH2/p/LBp0uqGAmac8SYHoUUsBTgjAtscYwhbSyEEX4ZSZwTCtZ
         z3daRE+pu4YrBuL+ZYLBCt4atnCah0HvHzxbHJ864pmyqM4BwOGqd4ES1Gr/hTtKV0
         ssfh5qMoSPg5PTBk1lC75hS+IrvNPFQ68AqhpmYr8rCW/C3HLnKBEwXfT5o6v+at8r
         8ZbHPSzVz/hIYrRAS3P8hZzp/3Y6Ntp5oga0w0EJL6jkB29DwP37Qp+4ltaGcsGAVy
         HoS9ng8RDBADrgBMc61YG6/tT4DBJKdx424vjZO7R4uWCz/sg5MDu0FZIWagmX8Wdx
         +9BuYxObnEzWG8hw9/IT/9M0tX/HCwv/5hY0vPA3OmFiYW0I+WhSyC57+geAObRGnY
         XZJv4aW6MzfhpKIfxfYgd593j5UGBKM3zVi3yLejy1jCjjrLYAzBHBP/DRnLkJ8yg1
         n9RvhpO6lEmUvSEpBGzoM2iVMkyrJflRCqeW9SqQs/kbp5YfaJh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 29/44] connect: pass full packet reader when parsing v2 refs
Date:   Fri, 19 Jun 2020 17:55:46 +0000
Message-Id: <20200619175601.569856-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
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
 connect.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index b6e110cb24..320cc2016d 100644
--- a/connect.c
+++ b/connect.c
@@ -376,7 +376,7 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 }
 
 /* Returns 1 when a valid ref has been added to `list`, 0 otherwise */
-static int process_ref_v2(const char *line, struct ref ***list)
+static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 {
 	int ret = 1;
 	int i = 0;
@@ -384,6 +384,7 @@ static int process_ref_v2(const char *line, struct ref ***list)
 	struct ref *ref;
 	struct string_list line_sections = STRING_LIST_INIT_DUP;
 	const char *end;
+	const char *line = reader->line;
 
 	/*
 	 * Ref lines have a number of fields which are space deliminated.  The
@@ -482,7 +483,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 
 	/* Process response from server */
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
-		if (!process_ref_v2(reader->line, &list))
+		if (!process_ref_v2(reader, &list))
 			die(_("invalid ls-refs response: %s"), reader->line);
 	}
 
