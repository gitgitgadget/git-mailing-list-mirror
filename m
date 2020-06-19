Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A433AC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F9D20776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yacW+pcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393758AbgFSR4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39446 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390892AbgFSR4S (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2542460A64;
        Fri, 19 Jun 2020 17:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589377;
        bh=A9L/mi6WLEtEwD2dFxGufSJkHStABYOr6fMktVS0ij8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yacW+pcljV2Hj/2DGQ5ZAqFmTMxfvLbbDP7dYjrn1Eki304ly+UqHD2DRibx2bKUF
         2Q6jGf1qCm24GKXr2oxkd+19MXaZsi9bD2RPA8726JHWWERejMtlN+OmgHjeQHZxxJ
         0p8/3SADUEYtBIJY/zJG0VIXoz2dHAvl2HhFd9SBRvNYEYyjRqtChuLZYoI6mP8mgi
         IL6X/Wwa9KNlm2rkMqG/DWJJTV/ErcPtIpv9MSFXTh3eku5qGD1+X/1B7dUCbk68OM
         IvKWCl9EQl50ws6z+q7CK5vd/1vyuQuq9ty2Fn6FNybBpBqfxxe5fCoD1hM0v9DaRY
         zJWSfBLA0BXBfq/yRvcFs8jMmvh3EC2qRdJpMQG4D8HfKhsux/ncJ6y+Qt9ihZycbL
         sE+QPp1762ue01nrTUkplBACdZTrgULnQMpEWaDRRY9LPcn1zyA5OrNo9Rs7eziONC
         iWPGZDFE17IfzAWSPJkTC8CML9Avu7Fx/Hx9zv14RuvnYHganIu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 08/44] pkt-line: add a member for hash algorithm
Date:   Fri, 19 Jun 2020 17:55:25 +0000
Message-Id: <20200619175601.569856-9-sandals@crustytoothpaste.net>
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

Add a member for the hash algorithm currently in use to the packet
reader so it can parse references correctly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pkt-line.c | 1 +
 pkt-line.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 8f9bc68ee2..844c253ccd 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -490,6 +490,7 @@ void packet_reader_init(struct packet_reader *reader, int fd,
 	reader->buffer_size = sizeof(packet_buffer);
 	reader->options = options;
 	reader->me = "git";
+	reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
 }
 
 enum packet_read_status packet_reader_read(struct packet_reader *reader)
diff --git a/pkt-line.h b/pkt-line.h
index 5b373fe4cd..8c90daa59e 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -177,6 +177,9 @@ struct packet_reader {
 
 	unsigned use_sideband : 1;
 	const char *me;
+
+	/* hash algorithm in use */
+	const struct git_hash_algo *hash_algo;
 };
 
 /*
