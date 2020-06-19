Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343CEC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E2721527
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mkzvlWav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404757AbgFSR4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39596 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404498AbgFSR4g (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8FA0260A7B;
        Fri, 19 Jun 2020 17:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589390;
        bh=TEKon/4etoHuZ6CSdrrFzoql3Vs+ljSPCfqhYISu0ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mkzvlWavD+sGv/lvqJFlDInAkBm3uxLQOGaO8jqoNggAqBXx5WBXBNL40gfNkh+pr
         YnGIyIaO7oEhRbXVL01QsKrnq5UAbwr+BO9pfwBwa9Sudz6MccCgdNqnRks6GhgesK
         PBKpYrsssozNZYxYZmfvb8OAPWk9uhaYdZLNBai+PtLq9KG86UGFCtBONFYtfkNdSt
         Yx7SWwd/BY8/nlEQUxZPCZ1G0cejYleUu9f47eOXhsNGzcQAGwI1vkDTUXIjld/Dx6
         YWhtnrR/9yd+q6zR/g79pkGemgo/SvP7eT9Eak2+ArQKfDtOtKlu7iu8ye3mcGX71s
         Fd4BtatlquajbHYyJq0fVcSSYi4byOYqck3HpJAfy/pStNOkL1Dz8fNAMRc6Lz/jPj
         ephsm5WXnTw6fQMj5Z0GhWQIKMyz9FY8Qd4Uma7d5KIMWSWo/ov1qvBYMiE4I6F7rR
         OvhvL2wFN7A7ug9YV4XXg+p7aiP09T94tHEvI0MN0OwGj8n3Xnv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 34/44] remote-curl: detect algorithm for dumb HTTP by size
Date:   Fri, 19 Jun 2020 17:55:51 +0000
Message-Id: <20200619175601.569856-35-sandals@crustytoothpaste.net>
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

When reading the info/refs file for a repository, we have no explicit
way to detect which hash algorithm is in use because the file doesn't
provide one. Detect the hash algorithm in use by the size of the first
object ID.

If we have an empty repository, we don't know what the hash algorithm is
on the remote side, so default to whatever the local side has
configured.  Without doing this, we cannot clone an empty repository
since we don't know its hash algorithm.  Test this case appropriately,
since we currently have no tests for cloning an empty repository with
the dumb HTTP protocol.

We anonymize the URL like elsewhere in the function in case the user has
decided to include a secret in the URL.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c              | 23 +++++++++++++++++++++--
 t/t5550-http-fetch-dumb.sh | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index f0203547c5..e666845d9d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -252,6 +252,19 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 	return list;
 }
 
+static const struct git_hash_algo *detect_hash_algo(struct discovery *heads)
+{
+	const char *p = memchr(heads->buf, '\t', heads->len);
+	int algo;
+	if (!p)
+		return the_hash_algo;
+
+	algo = hash_algo_by_length((p - heads->buf) / 2);
+	if (algo == GIT_HASH_UNKNOWN)
+		return NULL;
+	return &hash_algos[algo];
+}
+
 static struct ref *parse_info_refs(struct discovery *heads)
 {
 	char *data, *start, *mid;
@@ -262,6 +275,12 @@ static struct ref *parse_info_refs(struct discovery *heads)
 	struct ref *ref = NULL;
 	struct ref *last_ref = NULL;
 
+	options.hash_algo = detect_hash_algo(heads);
+	if (!options.hash_algo)
+		die("%sinfo/refs not valid: could not determine hash algorithm; "
+		    "is this a git repository?",
+		    transport_anonymize_url(url.buf));
+
 	data = heads->buf;
 	start = NULL;
 	mid = data;
@@ -272,13 +291,13 @@ static struct ref *parse_info_refs(struct discovery *heads)
 		if (data[i] == '\t')
 			mid = &data[i];
 		if (data[i] == '\n') {
-			if (mid - start != the_hash_algo->hexsz)
+			if (mid - start != options.hash_algo->hexsz)
 				die(_("%sinfo/refs not valid: is this a git repository?"),
 				    transport_anonymize_url(url.buf));
 			data[i] = 0;
 			ref_name = mid + 1;
 			ref = alloc_ref(ref_name);
-			get_oid_hex(start, &ref->old_oid);
+			get_oid_hex_algop(start, &ref->old_oid, options.hash_algo);
 			if (!refs)
 				refs = ref;
 			if (last_ref)
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 50485300eb..e57716bacd 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -50,6 +50,24 @@ test_expect_success 'create password-protected repository' '
 	       "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/repo.git"
 '
 
+test_expect_success 'create empty remote repository' '
+	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/empty.git" &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH/empty.git" &&
+	 mkdir -p hooks &&
+	 write_script "hooks/post-update" <<-\EOF &&
+	 exec git update-server-info
+	EOF
+	 hooks/post-update
+	)
+'
+
+test_expect_success 'empty dumb HTTP repository has default hash algorithm' '
+	test_when_finished "rm -fr clone-empty" &&
+	git clone $HTTPD_URL/dumb/empty.git clone-empty &&
+	git -C clone-empty rev-parse --show-object-format >empty-format &&
+	test "$(cat empty-format)" = "$(test_oid algo)"
+'
+
 setup_askpass_helper
 
 test_expect_success 'cloning password-protected repository can fail' '
