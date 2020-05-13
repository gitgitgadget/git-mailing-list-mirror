Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36077C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1E520753
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OgQNuYsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbgEMAzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38208 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731999AbgEMAzK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:55:10 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B2E5760797;
        Wed, 13 May 2020 00:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331280;
        bh=cCM6VaFve35hSJGWj+rO2ac6FpNeh7H9Z9FzADHZSbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OgQNuYsLY5EnMOZNoibG7xcGSpP0qfyizlNpxzxvw6aWWWoTZSUWRhA7Wm/ajtVAU
         qiX6hP83+nWwvnG+7DU3aDTDWRc0FEX2aQeGXe4f7GjJeIPJfXr2Rb9Q+tJ8su3iAf
         ueFpFO8aXery1dWaIzw/sMhqnCC98NQkOqEWBRLKb536FSqZtgehofQQxi5vSqdQY7
         7vlZ1hwUIvbDTUVz1sdAwDPv+xKv9CrKsYZMEtxz4MUem9g8QKKRAMfeT56KoOzZPb
         R0ufsjfeCNdIQLLjI1UjH/IjRbg51kXEwdcm5cVBJeO5BCpha5kZIz/fPmeHU+bfzp
         j0o1B/9nl1xVfoJ7VxpzUUeAMZDELVgs1iuF7mBf5KT794ex8SGjbC+aYLD8KXXNzJ
         bBHh7VlKHgU15z8mYYpvPWtde4RG08rbIAo7fn0AbCRoWDkaoxekLZLd7f/wmRGC94
         XBj8exo52zCj9CUOKVqOpgEJx1CMePrzZ46MfjNLwrpH+WYnxmI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 05/44] remote: advertise the object-format capability on the server side
Date:   Wed, 13 May 2020 00:53:45 +0000
Message-Id: <20200513005424.81369-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
index d37ab776b3..a4159b559e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -248,6 +248,7 @@ static void show_ref(const char *path, const struct object_id *oid)
 			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
 		if (advertise_push_options)
 			strbuf_addstr(&cap, " push-options");
+		strbuf_addf(&cap, " object-format=%s", the_hash_algo->name);
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write_fmt(1, "%s %s%c%s\n",
 			     oid_to_hex(oid), path, 0, cap.buf);
diff --git a/upload-pack.c b/upload-pack.c
index 902d0ad5e1..df6cb51db7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1005,7 +1005,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		struct strbuf symref_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, cb_data);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s agent=%s\n",
+		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s object-format=%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
@@ -1015,6 +1015,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			     stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     allow_filter ? " filter" : "",
+			     the_hash_algo->name,
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
