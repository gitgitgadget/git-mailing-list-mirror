Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44D0C77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 17:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjEARHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 13:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjEARHY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 13:07:24 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AE73C17
        for <git@vger.kernel.org>; Mon,  1 May 2023 10:02:10 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id BFF485AF9E;
        Mon,  1 May 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1682960426;
        bh=14Q4kDXvDHbE6Bk7oExxKqiZhJG6oG9CJqjLc4DOxzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=WdbD0S23qccpSzqtw+keX77TEPw7GdstciKNkGt0oeqn7VDsaz9khMcN9kxPL/Mgt
         qypwuEY5XPgS6WNwSy56Wdw9C7/4WXklvpcvmSIWCDdQdSM16G5kMGmmIJRyyFsjo+
         rqTwkzy3EaGefUUpYPxiVwEOteJd3a6GSXMn/U58pRKmAu3rTe0FT+W7t/Q0cFc6gI
         ruuIhq9s1AtqPflAi/HIVYCAUJ4Y/FNTAJCzk4De1F0+DStGzPCgRtlXlKgyPh2skE
         Z5Zhh2/M4YkwFZPkuzpDtUlCbvg2T3NC9mfyg8iw0gJFoKOUciUYUmPDWAOzevBxtX
         HMyLCeWdva96B/wdctuOaV4t7tXVVBAIcq3naELxGAul3+v3Mt6lDjokDpCE2IiwG7
         bbu1JfXAYEVUajpepe0cIg9Kz2VabiDhrv/l3YfJsVV/xmHT3ApHehzUmTHw5+w9m/
         4oOgt1BARuTqb+wpOm2AWgX+o+7lY8lIa6I6V1Hf57QbN4pFeZd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Adam Majer <adamm@zombino.com>
Subject: [PATCH v2 1/1] upload-pack: advertise capabilities when cloning empty repos
Date:   Mon,  1 May 2023 17:00:18 +0000
Message-ID: <20230501170018.1410567-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230501170018.1410567-1-sandals@crustytoothpaste.net>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230501170018.1410567-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

When cloning an empty repository, protocol versions 0 and 1 currently
offer nothing but the header and flush packets for the /info/refs
endpoint. This means that no capabilities are provided, so the client
side doesn't know what capabilities are present.

However, this does pose a problem when working with SHA-256
repositories, since we use the capabilities to know the remote side's
object format (hash algorithm).  As of 8b214c2e9d ("clone: propagate
object-format when cloning from void", 2023-04-05), this has been fixed
for protocol v2, since there we always read the hash algorithm from the
remote.

Fortunately, the push version of the protocol already indicates a clue
for how to solve this.  When the /info/refs endpoint is accessed for a
push and the remote is empty, we include a dummy "capabilities^{}" ref
pointing to the all-zeros object ID.  The protocol documentation already
indicates this should _always_ be sent, even for fetches and clones, so
let's just do that, which means we'll properly announce the hash
algorithm as part of the capabilities.  This just works with the
existing code because we share the same ref code for fetches and clones,
and libgit2, JGit, and dulwich do as well.

There is one minor issue to fix, though.  When we call send_ref with
namespaces, we would return NULL with the capabilities entry, which
would cause a crash.  Instead, let's make sure we don't try to strip the
namespace if we're using our special capabilities entry.

Add several sets of tests for HTTP as well as for local clones.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 t/t5551-http-fetch-smart.sh | 27 +++++++++++++++++++++++++++
 t/t5700-protocol-v1.sh      | 31 +++++++++++++++++++++++++++++--
 upload-pack.c               |  7 ++++++-
 3 files changed, 62 insertions(+), 3 deletions(-)

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
index 6c8d4c6cf1..a73b4d4ff6 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -244,15 +244,28 @@ test_expect_success 'push with ssh:// using protocol v1' '
 	grep "push< version 1" log
 '
 
+test_expect_success 'clone propagates object-format from empty repo' '
+	test_when_finished "rm -fr src256 dst256" &&
+
+	echo sha256 >expect &&
+	git init --object-format=sha256 src256 &&
+	git clone --no-local src256 dst256 &&
+	git -C dst256 rev-parse --show-object-format >actual &&
+
+	test_cmp expect actual
+'
+
 # Test protocol v1 with 'http://' transport
 #
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
@@ -269,6 +282,20 @@ test_expect_success 'clone with http:// using protocol v1' '
 	grep "git< version 1" log
 '
 
+test_expect_success 'clone with http:// using protocol v1 with empty SHA-256 repo' '
+	GIT_TRACE_PACKET=1 GIT_TRACE_CURL=1 git -c protocol.version=1 \
+		clone "$HTTPD_URL/smart/sha256" sha256 2>log &&
+
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
index 08633dc121..d7b31d0527 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -120,6 +120,7 @@ struct upload_pack_data {
 	unsigned allow_ref_in_want : 1;				/* v2 only */
 	unsigned allow_sideband_all : 1;			/* v2 only */
 	unsigned advertise_sid : 1;
+	unsigned sent_capabilities : 1;
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -1212,7 +1213,8 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
 		" deepen-relative no-progress include-tag multi_ack_detailed";
-	const char *refname_nons = strip_namespace(refname);
+	const char *refname_nons = !strcmp(refname, "capabilities^{}") ?
+				   refname : strip_namespace(refname);
 	struct object_id peeled;
 	struct upload_pack_data *data = cb_data;
 
@@ -1240,6 +1242,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 		strbuf_release(&session_id);
+		data->sent_capabilities = 1;
 	} else {
 		packet_fwrite_fmt(stdout, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
@@ -1379,6 +1382,8 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 			data.no_done = 1;
 		head_ref_namespaced(send_ref, &data);
 		for_each_namespaced_ref(send_ref, &data);
+		if (!data.sent_capabilities)
+			send_ref("capabilities^{}", null_oid(), 0, &data);
 		/*
 		 * fflush stdout before calling advertise_shallow_grafts because send_ref
 		 * uses stdio.
