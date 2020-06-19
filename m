Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E08C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A1D20DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fMGArPas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404852AbgFSR4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39552 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404496AbgFSR4g (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 160E160A6D;
        Fri, 19 Jun 2020 17:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589390;
        bh=MWvvjYEo5Rp8KtFH0luFagYjxGUaEerSNE9nw0RTEhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fMGArPasp2HdkA0bbE1AYk2zs72buhZbqR5Dgu6UhQyhjOhaTBpAQmGTZHNiQ0cqq
         oKfo8CGGF8FS4ss8/1qzQErdWsKOksRrFVFCGoXIf+lCGK43SoXTUjTuf6BLt3fxvi
         ha0owgYoAgJSMULA7U1j6jVGcxej2c6Vi3DHIdwsaQR5n8bs5CK1ZS/YlCkr9+5u/T
         h4GsRSbYZAZb6dQUNTVd05MVK7xhoriNiv2Jh07GR03ca8G09TrwAtciczPskGlVdY
         WeZI+mm7TrTRS83QTc1dgQp7Yug8atH+ZhvP00JNycZsLt7deLM5HvECmkc26+lXM4
         oNxhG8n9NOObJbEGn5crIV3xGsLkmYfFMOyRXYgiXfiDVoFH3vXbstljDuzNFuv3K9
         nD9ZmpAVLcTaE++l6pgrNzFqT6OwPJkPj/xuXl2YyPnNGC+7GQGSc6apC3BLGqLS5f
         yhD6Pg9D6c6mVM/wxudpWZkNotVRP/I4KdiehMvNv9Wq4gyGFDs
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 33/44] builtin/ls-remote: initialize repository based on fetch
Date:   Fri, 19 Jun 2020 17:55:50 +0000
Message-Id: <20200619175601.569856-34-sandals@crustytoothpaste.net>
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

ls-remote may or may not operate within a repository, and as such will
not have been initialized with the repository's hash algorithm.  Even if
it were, the remote side could be using a different algorithm and we
would still want to display those refs properly.  Find the hash
algorithm used by the remote side by querying the transport object and
set our hash algorithm accordingly.

Without this change, if the remote side is using SHA-256, we truncate
the refs to 40 hex characters, since that's the length of the default
hash algorithm (SHA-1).

Note that technically this is not a correct setting of the repository
hash algorithm since, if we are in a repository, it might be one of a
different hash algorithm from the remote side.  However, our current
code paths don't handle multiple algorithms and won't for some time, so
this is the best we can do.  We rely on the fact that ls-remote never
modifies the current repository, which is a reasonable assumption to
make.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/ls-remote.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 6ef519514b..3a4dd12903 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -118,6 +118,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		transport->server_options = &server_options;
 
 	ref = transport_get_remote_refs(transport, &ref_prefixes);
+	if (ref) {
+		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
+		repo_set_hash_algo(the_repository, hash_algo);
+	}
 	if (transport_disconnect(transport)) {
 		UNLEAK(sorting);
 		return 1;
