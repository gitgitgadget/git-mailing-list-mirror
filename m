Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A106C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DBC20DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kyKHiAfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405263AbgFSR5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39640 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404806AbgFSR4t (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A093A60A66;
        Fri, 19 Jun 2020 17:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589378;
        bh=vQNbFM+sOv8/dUxFZz1qhNxgDyUocSrlxBAs+oTyN7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kyKHiAfXvvkPhDWFy39R5zKIG/Ax5gYrBb3XDMlO4eWrHsr0+4zh1AQsTiKVD2RSk
         7YPJzK9YKqLZADwJ4pM/A6dlUQy3tzehv22CY7HKHXHgaBOW0D4mHih/qTT1xVK+dl
         L+KZRsfCSGkqIN+pwRHe1ezsIDNeF/l08YvHk0hgUhCFbCGLgLEDEgeofTmaNKK+MM
         kyu5tinvG5tkg574nHazpEV+APL50eZZXHHQhTPvDqf0k2aStO+xLXM1Jnms3R1mJM
         SRix0WneA7DjoZdkZBnPALph8YJglJLGx2hbSk0nv4TfciB2NFeuM6HoaUOk4c4igL
         r1P1YXYEUnMINUGFuB1grmNgGx+PpOyqMHb6bYSFq2XdBGCb/cwDiHbI4NyjGlzkIk
         4D1Uod19L899Nj9jAdNJVWNCUdrZGrC537inObjzW9PSFdPNfUlJc+ElzfEdN1x4fZ
         Q3v+gGKEuZD1N+R1+Kmow86GQykgjHP6RXuTThQllPHE3jZwv5M
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 09/44] transport: add a hash algorithm member
Date:   Fri, 19 Jun 2020 17:55:26 +0000
Message-Id: <20200619175601.569856-10-sandals@crustytoothpaste.net>
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

When connecting to a remote system, we need to know what hash algorithm
it will be using to talk to us.  Add a hash_algo member to struct
transport and add a function to read this data from the transport
object.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 transport.c | 8 ++++++++
 transport.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/transport.c b/transport.c
index 7d50c502ad..a016f41702 100644
--- a/transport.c
+++ b/transport.c
@@ -312,6 +312,7 @@ static struct ref *handshake(struct transport *transport, int for_push,
 		BUG("unknown protocol version");
 	}
 	data->got_remote_heads = 1;
+	transport->hash_algo = reader.hash_algo;
 
 	if (reader.line_peeked)
 		BUG("buffer must be empty at the end of handshake()");
@@ -988,9 +989,16 @@ struct transport *transport_get(struct remote *remote, const char *url)
 			ret->smart_options->receivepack = remote->receivepack;
 	}
 
+	ret->hash_algo = &hash_algos[GIT_HASH_SHA1];
+
 	return ret;
 }
 
+const struct git_hash_algo *transport_get_hash_algo(struct transport *transport)
+{
+	return transport->hash_algo;
+}
+
 int transport_set_option(struct transport *transport,
 			 const char *name, const char *value)
 {
diff --git a/transport.h b/transport.h
index 4298c855be..2a9f96c05a 100644
--- a/transport.h
+++ b/transport.h
@@ -115,6 +115,8 @@ struct transport {
 	struct git_transport_options *smart_options;
 
 	enum transport_family family;
+
+	const struct git_hash_algo *hash_algo;
 };
 
 #define TRANSPORT_PUSH_ALL			(1<<0)
@@ -243,6 +245,12 @@ int transport_push(struct repository *repo,
 const struct ref *transport_get_remote_refs(struct transport *transport,
 					    const struct argv_array *ref_prefixes);
 
+/*
+ * Fetch the hash algorithm used by a remote.
+ *
+ * This can only be called after fetching the remote refs.
+ */
+const struct git_hash_algo *transport_get_hash_algo(struct transport *transport);
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
