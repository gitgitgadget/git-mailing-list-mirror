Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956E2C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EAB42073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="htUN3E69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390528AbgEYUAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38718 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390441AbgEYT76 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1174D60D15;
        Mon, 25 May 2020 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436797;
        bh=MWvvjYEo5Rp8KtFH0luFagYjxGUaEerSNE9nw0RTEhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=htUN3E69PhnTVOd7HW/PuRFXEIbvGVjYC/fI4eA9RGuKRBa42ykRR1RGWjnIySj9q
         OYeYhMPfJehCL+RaA+pYbsisldRwrdld8RkswhqLSr0CabtV5mUVWUBnjFbPvlmjWq
         Gu0oO/sGtVnwOfueWbIXs6U0jty//FdrcKBLd7la8aCzYV4CJU3gLcIy6acHiz82Mz
         LOPa2RBRzYPD9SINfNQ8OjcmiTj845e0vn6pQrAs8aVnzHnl8OyB1HnL+wCul/Ckyh
         uAeM9fqpAibYv6ywIzEsNrZdmwjFJrmkWlYz0Wg1k8DiCDsGoV4r/Bc83oDKscgiXd
         VGvgyGBXYOLIggxJu7ZL0s4+A0pIVr/ScmDIFa8bn7WvWLPt7rwmd2FfOmtOlofwF3
         afTwvGclDXwr+G2Abx5VfrKUH7OosV0uRRl8HrNgw9kuezjde/f27Jj7QF7panJAgO
         hiCya8dOKGAvXbLGSlAk/SGTEKCcsPsBeID/jYfLOQm6nLHoBmK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 33/44] builtin/ls-remote: initialize repository based on fetch
Date:   Mon, 25 May 2020 19:59:19 +0000
Message-Id: <20200525195930.309665-34-sandals@crustytoothpaste.net>
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
