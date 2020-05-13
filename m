Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39C0C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87FA923126
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="V9sYlPqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbgEMAzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38268 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732044AbgEMAzX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:55:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4FDC060D13;
        Wed, 13 May 2020 00:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331292;
        bh=ncte7hr0FKpv6U+a48mfFqqVQlIIMBOljR5O5MmRll4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=V9sYlPqZkrOk6JlOqCGxE/jzCdYHNMrLB0/uRFKZ3fWQviUvwOmM734JBlZbmgH1F
         PdH0QVsacL4e4Lh/yA8HT+00KtnLJcjJQtJ+rnqpkZXq9BFlSS/eeYVJDFSalyCzrz
         T4m7XxkYE3ScyPhoUUjl6zHtHdR8xPlmlYBFwDcwix7Isckz0iwZNqGs8DPR+/q69m
         gxLsuk66FaBRaCHUQr3zcDa8aCSpzkSEsadDeyfgnqk0RvYvlxcEjnZcQTekEAPnvT
         8vzDZ8XO7fKKA/C8RrHHN9CppGR/mJXysoVeYiflaRLXvZ7fM66OnJKHGkY2PjVpuq
         qmGA0dBxHTHPAg8BRzR1VGbu+tJ+Myz40setkDAAptxHbZICxPNcxuB2SAViqJWIMK
         Pze1Im8pyPjknayMHpMopT8KlUKAVE8OwKdeUcaeJqiOT3ANYeQHzMBD3L+mbNkRDS
         oIWfrnkObdmRy/qyUK23ywHVHcn7DeRGa+tQ8vGavG29esWoCdf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 34/44] builtin/ls-remote: initialize repository based on fetch
Date:   Wed, 13 May 2020 00:54:14 +0000
Message-Id: <20200513005424.81369-35-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
