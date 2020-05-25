Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262F6C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A062071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mpMLrE17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390567AbgEYUAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38728 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390435AbgEYT75 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5AAB960D11;
        Mon, 25 May 2020 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436795;
        bh=5uPFqOaJshb/wWN27Pe6v8ivFx+zjEBHwTu4yPt9+nI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mpMLrE17rtzG0jAC7EN7SnoWCkABIX/SYEIK5ErroJjoHaqMTeYxUMdtLfV/FQpB4
         Cnck9U1kjA0fmZ60MWVSxilwUpSfWp7XQiwaWqBgyxPWIhSB85MjIGDwF9w4wSA20N
         DP1FnFQI/jKGDE4RYF/d5luFk4ht4vhRDdKOEGy68RIVASGs7tBf0m7NnJBXUt3+rn
         Fvvv8b38cN+K65lovHcrwBu8DVY778UgNXLrs6JjfHjalN/gtjEIixplS9FyyOVEDT
         G2fjXsyCyCSVWk6bw8oiKIdqpHQWVnu2DwBAWCx/HCXVwWjwKyZ2xm2f67YPzX0c1v
         AAwXxMtKnt54koHM0hOghJb2aqewRTgzFA59vWX4qDyFPXU0cO/7P5rS6E2AC6Rdwf
         p5CH959E4Z8zur/2mbDWGFSqYN+jLojej2KJm4bS2akxQhOWMlzBYz299BXT+uQm+f
         CT1SMGaPsNWmbDFvSDObI6UPaKAcqdaP2BkrVtNLyaoiZyIlh95
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 29/44] connect: pass full packet reader when parsing v2 refs
Date:   Mon, 25 May 2020 19:59:15 +0000
Message-Id: <20200525195930.309665-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
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
index 915f1736a0..1d05bc56ed 100644
--- a/connect.c
+++ b/connect.c
@@ -374,7 +374,7 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 }
 
 /* Returns 1 when a valid ref has been added to `list`, 0 otherwise */
-static int process_ref_v2(const char *line, struct ref ***list)
+static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 {
 	int ret = 1;
 	int i = 0;
@@ -382,6 +382,7 @@ static int process_ref_v2(const char *line, struct ref ***list)
 	struct ref *ref;
 	struct string_list line_sections = STRING_LIST_INIT_DUP;
 	const char *end;
+	const char *line = reader->line;
 
 	/*
 	 * Ref lines have a number of fields which are space deliminated.  The
@@ -469,7 +470,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 
 	/* Process response from server */
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
-		if (!process_ref_v2(reader->line, &list))
+		if (!process_ref_v2(reader, &list))
 			die(_("invalid ls-refs response: %s"), reader->line);
 	}
 
