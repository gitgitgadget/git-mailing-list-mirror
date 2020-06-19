Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D59C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D643921531
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CaMnhLis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgFSR5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39634 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404763AbgFSR4s (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3DE7360A60;
        Fri, 19 Jun 2020 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589375;
        bh=tcIo6T7g/Bgpnie25bur+FqoLMQVSB4Gb07k96qKCxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=CaMnhLis7nUL1h5dXHGmWKgtYoQks3BWniHNCw20NHbSUAbI0JksrBK4NhwmtzJ4N
         4nC6VieRyL+w2GBXwV+0qBld75A4VQE694pTQ/i5qerkrkmw8H4dgPfm1etYl7IGY4
         8z77JsLYePdfdiDlVShxT1+nJbvS4wzqE+eYUkPxyPfoPRxYkgSRYiLnlVRAsEq5P2
         E01LtsBexfVuyWG/+bJaQOSWVI9CF42FE1YYlqejaM2aIgBuu3xP1ICWJ/9R32OKb4
         RPEKQJZA4VpLEkWsALBmdNW26PB6rIoZgTsAbQV4P3xqU6TNCewHJZutHX50NwzIqO
         MDQ9mFfLMzGYBB7Md62mOFTa4nsxtnDpWM3cEZDTzz8iQmQNIdy69TxdMKQlNzM64y
         1+xSM2oKADgCtS8pYo5+to1y88d6ZOiL3+Uvcjs0kXwshH4OwPaXiI1OitB+YTMrLu
         IRg98OI9EA6n1obmC4Srhr10HlYORIGjkZL1Z6Ou2akfzZ+Je8r
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 05/44] remote: advertise the object-format capability on the server side
Date:   Fri, 19 Jun 2020 17:55:22 +0000
Message-Id: <20200619175601.569856-6-sandals@crustytoothpaste.net>
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

Advertise the current hash algorithm in use by using the object-format
capability as part of the ref advertisement.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 1 +
 upload-pack.c          | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ea3d0f01af..4ffa501dce 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -249,6 +249,7 @@ static void show_ref(const char *path, const struct object_id *oid)
 			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
 		if (advertise_push_options)
 			strbuf_addstr(&cap, " push-options");
+		strbuf_addf(&cap, " object-format=%s", the_hash_algo->name);
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write_fmt(1, "%s %s%c%s\n",
 			     oid_to_hex(oid), path, 0, cap.buf);
diff --git a/upload-pack.c b/upload-pack.c
index 401c9e6c4b..a72eef9d14 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1063,7 +1063,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		struct strbuf symref_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, &data->symref);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s agent=%s\n",
+		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s object-format=%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
@@ -1073,6 +1073,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			     data->stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     allow_filter ? " filter" : "",
+			     the_hash_algo->name,
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
