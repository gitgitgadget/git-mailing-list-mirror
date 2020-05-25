Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FA4C433E1
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0E82071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="E1rHN6wG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390661AbgEYUAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38852 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390587AbgEYUA1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 35EC360D13;
        Mon, 25 May 2020 19:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436796;
        bh=q3GU+ncEEcVJcUTylYh7psxfcHSiJXW8/1xfhvPzTD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=E1rHN6wGGrnYn12O//LXfZgNNq5poX3ktJMq3mVr+zRrR+79HtgL2Y0EU2/xAND/0
         H/Z3LAkbDwTYqBGZjW9HGawj5389Jym3cxD5C4WTh06Vgg0AWo9MSlkqI4pdzQ3RNK
         rHJYrHaFG1llUQ7mthSJ8yIv5PxzyStYq9HF3I9nGN78W/FlJWewcLjAk3I3e2Qlpe
         +hog1lOO1ptn/0Y55riiSFiBJhW25srEP2UJGuynpgH7gRD3kPbTXmgghDNnEyXVzq
         qUF2QiAsAS9ZpkvXIYmMtKHuwDmW+4BmO56jbr+/1h7aaosu638pXHWSupDDdY0y+S
         mkXz4EXQXBgFAIrdTBQ+rbZ49zorlydhAlYofo0ec2dGg38Crg5kLBDJuJMQvWxESF
         z3KpWkeCoLKe1cI+tnPXlKl644MX0cL2fp8WdoCJhVpQJQF27S8lSIVGU+vJAIjeCQ
         SoepYU9UUGjzRrckSJxyLPAjj3CCP7Zxv6oe1XbM0oMJhbid1+I
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 31/44] serve: advertise object-format capability for protocol v2
Date:   Mon, 25 May 2020 19:59:17 +0000
Message-Id: <20200525195930.309665-32-sandals@crustytoothpaste.net>
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

In order to communicate the protocol supported by the server side, add
support for advertising the object-format capability.  We check that the
client side sends us an identical algorithm if it sends us its own
object-format capability, and assume it speaks SHA-1 if not.

In the test, when we're using an algorithm other than SHA-1, we need to
specify the algorithm in use so we don't get a failure with an "unknown
format" message.  Add a test that we handle a mismatched algorithm.
Remove the test_oid_init call since it's no longer necessary.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c            |  2 ++
 serve.c              | 27 +++++++++++++++++++++++++++
 t/t5701-git-serve.sh | 25 +++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/connect.c b/connect.c
index 66650ff2d3..2ada5b5161 100644
--- a/connect.c
+++ b/connect.c
@@ -460,6 +460,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			die(_("unknown object format '%s' specified by server"), hash_name);
 		reader->hash_algo = &hash_algos[hash_algo];
 		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
+	} else {
+		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
 	}
 
 	if (server_options && server_options->nr &&
diff --git a/serve.c b/serve.c
index 317256c1a4..7ab7807fef 100644
--- a/serve.c
+++ b/serve.c
@@ -22,6 +22,14 @@ static int agent_advertise(struct repository *r,
 	return 1;
 }
 
+static int object_format_advertise(struct repository *r,
+				   struct strbuf *value)
+{
+	if (value)
+		strbuf_addstr(value, r->hash_algo->name);
+	return 1;
+}
+
 struct protocol_capability {
 	/*
 	 * The name of the capability.  The server uses this name when
@@ -57,6 +65,7 @@ static struct protocol_capability capabilities[] = {
 	{ "ls-refs", always_advertise, ls_refs },
 	{ "fetch", upload_pack_advertise, upload_pack_v2 },
 	{ "server-option", always_advertise, NULL },
+	{ "object-format", object_format_advertise, NULL },
 };
 
 static void advertise_capabilities(void)
@@ -153,6 +162,22 @@ int has_capability(const struct argv_array *keys, const char *capability,
 	return 0;
 }
 
+static void check_algorithm(struct repository *r, struct argv_array *keys)
+{
+	int client = GIT_HASH_SHA1, server = hash_algo_by_ptr(r->hash_algo);
+	const char *algo_name;
+
+	if (has_capability(keys, "object-format", &algo_name)) {
+		client = hash_algo_by_name(algo_name);
+		if (client == GIT_HASH_UNKNOWN)
+			die("unknown object format '%s'", algo_name);
+	}
+
+	if (client != server)
+		die("mismatched object format: server %s; client %s\n",
+		    r->hash_algo->name, hash_algos[client].name);
+}
+
 enum request_state {
 	PROCESS_REQUEST_KEYS,
 	PROCESS_REQUEST_DONE,
@@ -223,6 +248,8 @@ static int process_request(void)
 	if (!command)
 		die("no command requested");
 
+	check_algorithm(the_repository, &keys);
+
 	command->command(the_repository, &keys, &reader);
 
 	argv_array_clear(&keys);
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index ffb9613885..a1f5fdc9fd 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -5,12 +5,17 @@ test_description='test protocol v2 server commands'
 . ./test-lib.sh
 
 test_expect_success 'test capability advertisement' '
+	test_oid_cache <<-EOF &&
+	wrong_algo sha1:sha256
+	wrong_algo sha256:sha1
+	EOF
 	cat >expect <<-EOF &&
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
 	ls-refs
 	fetch=shallow
 	server-option
+	object-format=$(test_oid algo)
 	0000
 	EOF
 
@@ -45,6 +50,7 @@ test_expect_success 'request invalid capability' '
 test_expect_success 'request with no command' '
 	test-tool pkt-line pack >in <<-EOF &&
 	agent=git/test
+	object-format=$(test_oid algo)
 	0000
 	EOF
 	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
@@ -54,6 +60,7 @@ test_expect_success 'request with no command' '
 test_expect_success 'request invalid command' '
 	test-tool pkt-line pack >in <<-EOF &&
 	command=foo
+	object-format=$(test_oid algo)
 	agent=git/test
 	0000
 	EOF
@@ -61,6 +68,17 @@ test_expect_success 'request invalid command' '
 	test_i18ngrep "invalid command" err
 '
 
+test_expect_success 'wrong object-format' '
+	test-tool pkt-line pack >in <<-EOF &&
+	command=fetch
+	agent=git/test
+	object-format=$(test_oid wrong_algo)
+	0000
+	EOF
+	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
+	test_i18ngrep "mismatched object format" err
+'
+
 # Test the basics of ls-refs
 #
 test_expect_success 'setup some refs and tags' '
@@ -74,6 +92,7 @@ test_expect_success 'setup some refs and tags' '
 test_expect_success 'basics of ls-refs' '
 	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
+	object-format=$(test_oid algo)
 	0000
 	EOF
 
@@ -96,6 +115,7 @@ test_expect_success 'basics of ls-refs' '
 test_expect_success 'basic ref-prefixes' '
 	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
+	object-format=$(test_oid algo)
 	0001
 	ref-prefix refs/heads/master
 	ref-prefix refs/tags/one
@@ -116,6 +136,7 @@ test_expect_success 'basic ref-prefixes' '
 test_expect_success 'refs/heads prefix' '
 	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
+	object-format=$(test_oid algo)
 	0001
 	ref-prefix refs/heads/
 	0000
@@ -136,6 +157,7 @@ test_expect_success 'refs/heads prefix' '
 test_expect_success 'peel parameter' '
 	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
+	object-format=$(test_oid algo)
 	0001
 	peel
 	ref-prefix refs/tags/
@@ -157,6 +179,7 @@ test_expect_success 'peel parameter' '
 test_expect_success 'symrefs parameter' '
 	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
+	object-format=$(test_oid algo)
 	0001
 	symrefs
 	ref-prefix refs/heads/
@@ -178,6 +201,7 @@ test_expect_success 'symrefs parameter' '
 test_expect_success 'sending server-options' '
 	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
+	object-format=$(test_oid algo)
 	server-option=hello
 	server-option=world
 	0001
@@ -200,6 +224,7 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
 
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
+	object-format=$(test_oid algo)
 	0001
 	this-is-not-a-command
 	0000
