Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40FF20372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbdJOWHm (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:07:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55026 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751461AbdJOWHl (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 19B3B6044D;
        Sun, 15 Oct 2017 22:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105260;
        bh=YdMAf3BOEYBWL6dc2QNJg+VUPkkinLKGIRVPvRhljzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hisO2qbg0RGXOkUb7Dm8OlHBBTZvQG6TW3Obcz6/jirVhlbFfzwuQBlvcQ3FOFXhC
         n79YrWjEssHYWc4zOEq+EAQp8xLWkP7TwGjPOOLfmmmlCsicwyiOFUo4i45VBm62y/
         5rH0cdu2YA/wU6ut+ALWO9rossVm9wkA4MzmVS8iu/duj23nqp46SDlrlDWSgHZaK/
         Kl7RI417WA/NXl1W/sXZylgT/W3k86K6bg4rqEufgnPwE46lULEm42l8ShCWmSN4NP
         HhpWeRCCGN8mtgBfcwMvOtMU4AOEXUp1G7/oxYCLWtk/uPUHyvhebQxdM6TjQTrt1V
         0MzbFo1idF272H/IsOOb2ZWXdOBudpMuQoweHAjOe7gloWXe/nF5EUfVQNRtZ3dFPE
         UFsv9wm+hj/NfIUofvX124eW+GHqZcHhh3zfkrt0q+pWV8Iaf4KXcmpYhJO4e6QXOF
         fMqKm2mFX0Zc+EkSN1n+8h19hDXBVDU3lvKP7m8plHAy/5zqpNj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 05/25] refs: prevent accidental NULL dereference in write_pseudoref
Date:   Sun, 15 Oct 2017 22:06:52 +0000
Message-Id: <20171015220712.97308-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several of the refs functions take NULL to indicate that the ref is not
to be updated.  If refs_update_ref were called with a NULL new object
ID, we could pass that NULL pointer to write_pseudoref, which would then
segfault when it dereferenced it.  Instead, simply return successfully,
since if we don't want to update the pseudoref, there's nothing to do.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs.c b/refs.c
index edd20044c6..91c2af78b6 100644
--- a/refs.c
+++ b/refs.c
@@ -583,6 +583,9 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 	struct strbuf buf = STRBUF_INIT;
 	int ret = -1;
 
+	if (!oid)
+		return 0;
+
 	strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
 
 	filename = git_path("%s", pseudoref);
-- 
2.15.0.rc0.271.g36b669edcc

