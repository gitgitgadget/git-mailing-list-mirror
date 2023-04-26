Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E9BC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 20:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjDZUxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjDZUxg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 16:53:36 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F83B1A7
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 13:53:34 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9F4DD5B3A1;
        Wed, 26 Apr 2023 20:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1682542413;
        bh=wa1p133rgzZGEnAaWul+iKsjqHm1lMRUMXivY/U5upU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=eUt7ZJcySj4N3D5hojwmrKWtY6oeMX6Lft/HZfMnw5dnLC5/Yu03q5sSwugXLeE3b
         QC9ex/d+I+ZWgSrFxTHPYNdZk6z/M/jl0CYBBH9YDMe3w0534oaqsxf5TqbOIXZcnZ
         EFu+3B+R9LHz1/JZpIaR8uN/RycDyxegkzLyWxbyxe8HtJahPYImtlf3Izpzd7aGkM
         1fyMfCJOQnnj0vK7GWv62rM2+KvDTaphiGaZuUMVC+3psB464hQ729QRLtoyFHZEy6
         oLO1jq4MZjaUcu9OrT3dvmusHTtskbnKfxeqgnDXTPyYwb3XI+UaPTa1t0g9tBCKxx
         pbhh5YPyqg67z8bADEBpONDWY4dpqONj+pmgPxwFasfcRDc2/LzMwR+tqnZym3qCDV
         oz9PGCzZqU1gaffCZGi5EM19pvYXVYwx4/pG2fe+peYkYx0CoGGnG7UT3eO09qpAjz
         FeQyqmFZVnTpcq5fi9K1ntUU2WC7sGihvi5ssKLhVzrOFk7sdVi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Adam Majer <adamm@zombino.com>
Subject: [PATCH 1/2] http: advertise capabilities when cloning empty repos
Date:   Wed, 26 Apr 2023 20:53:23 +0000
Message-Id: <20230426205324.326501-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230426205324.326501-1-sandals@crustytoothpaste.net>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

When cloning an empty repository, the HTTP protocol version 0 currently
offers nothing but the header and flush packets for the /info/refs
endpoint. This means that no capabilities are provided, so the client
side doesn't know what capabilities are present.

However, this does pose a problem when working with SHA-256
repositories, since we use the capabilities to know the remote side's
object format (hash algorithm).  It used to be possible to set the
correct algorithm with `GIT_DEFAULT_HASH` (which is what the Git LFS
testsuite did), but this no longer works as of 8b214c2e9d ("clone:
propagate object-format when cloning from void", 2023-04-05), since
there we always read the hash algorithm from the remote.  If there is no
hash algorithm provided, we default to SHA-1 for backwards
compatibility.

Fortunately, the push version of the protocol already indicates a clue
for how to solve this.  When the /info/refs endpoint is accessed for a
push and the remote is empty, we include a dummy "capabilities^{}" ref
pointing to the all-zeros object ID.  The protocol documentation already
indicates this should _always_ be sent, even for fetches and clones, so
let's just do that, which means we'll properly announce the hash
algorithm as part of the capabilities.  This just works with the
existing code because we share the same ref code for fetches and clones,
and libgit2 does as well.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 t/t5551-http-fetch-smart.sh | 27 +++++++++++++++++++++++++++
 t/t5700-protocol-v1.sh      | 21 +++++++++++++++++++--
 upload-pack.c               |  4 ++++
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 0908534f25..21b7767cbd 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -611,6 +611,33 @@ test_expect_success 'client falls back from v2 to v0 to match server' '
 	grep symref=HEAD:refs/heads/ trace
 '
 
+test_expect_success 'create empty http-accessible SHA-256 repository' '
+	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/sha256.git" &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH/sha256.git" &&
+	 git --bare init --object-format=sha256
+	)
+'
+
+test_expect_success 'clone empty SHA-256 repository with protocol v2' '
+	rm -fr sha256 &&
+	echo sha256 >expected &&
+	git -c protocol.version=2 clone "$HTTPD_URL/smart/sha256.git" &&
+	git -C sha256 rev-parse --show-object-format >actual &&
+	test_cmp actual expected &&
+	git ls-remote "$HTTPD_URL/smart/sha256.git" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'clone empty SHA-256 repository with protocol v0' '
+	rm -fr sha256 &&
+	echo sha256 >expected &&
+	GIT_TRACE=1 GIT_TRACE_PACKET=1 git -c protocol.version=0 clone "$HTTPD_URL/smart/sha256.git" &&
+	git -C sha256 rev-parse --show-object-format >actual &&
+	test_cmp actual expected &&
+	git ls-remote "$HTTPD_URL/smart/sha256.git" >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'passing hostname resolution information works' '
 	BOGUS_HOST=gitbogusexamplehost.invalid &&
 	BOGUS_HTTPD_URL=$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 6c8d4c6cf1..3cd9db9012 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -249,10 +249,12 @@ test_expect_success 'push with ssh:// using protocol v1' '
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-test_expect_success 'create repo to be served by http:// transport' '
+test_expect_success 'create repos to be served by http:// transport' '
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config http.receivepack true &&
-	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
+	git init --object-format=sha256 "$HTTPD_DOCUMENT_ROOT_PATH/sha256" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/sha256" config http.receivepack true
 '
 
 test_expect_success 'clone with http:// using protocol v1' '
@@ -269,6 +271,21 @@ test_expect_success 'clone with http:// using protocol v1' '
 	grep "git< version 1" log
 '
 
+test_expect_success 'clone with http:// using protocol v1 with empty SHA-256 repo' '
+	GIT_TRACE_PACKET=1 GIT_TRACE_CURL=1 git -c protocol.version=1 \
+		clone "$HTTPD_URL/smart/sha256" sha256 2>log &&
+
+	cat log &&
+	echo sha256 >expect &&
+	git -C sha256 rev-parse --show-object-format >actual &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v1
+	grep "Git-Protocol: version=1" log &&
+	# Server responded using protocol v1
+	grep "git< version 1" log
+'
+
 test_expect_success 'fetch with http:// using protocol v1' '
 	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" two &&
 
diff --git a/upload-pack.c b/upload-pack.c
index 08633dc121..5ef9b162b6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -120,6 +120,7 @@ struct upload_pack_data {
 	unsigned allow_ref_in_want : 1;				/* v2 only */
 	unsigned allow_sideband_all : 1;			/* v2 only */
 	unsigned advertise_sid : 1;
+	unsigned sent_capabilities : 1;
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -1240,6 +1241,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 		strbuf_release(&session_id);
+		data->sent_capabilities = 1;
 	} else {
 		packet_fwrite_fmt(stdout, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
@@ -1379,6 +1381,8 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 			data.no_done = 1;
 		head_ref_namespaced(send_ref, &data);
 		for_each_namespaced_ref(send_ref, &data);
+		if (!data.sent_capabilities && advertise_refs)
+			send_ref("capabilities^{}", null_oid(), 0, &data);
 		/*
 		 * fflush stdout before calling advertise_shallow_grafts because send_ref
 		 * uses stdio.
