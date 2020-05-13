Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A458C2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B98720675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xPYgU9mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbgEMAzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38140 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731912AbgEMAyx (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:53 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 758C960D10;
        Wed, 13 May 2020 00:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331291;
        bh=i88gs3LGI63F5dBfTz3y5WYylMYflhUfS0VuYjhQUUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xPYgU9mgreT1DznvkiC8TUVVA+xay63M6fOuumXZpAEQ1pC1NfKRk53IDP9Nq/wG/
         CV+gtrDHKNAAdtpSwOoBq9f1bRfu1HNo9yTQRKt3qvwtusySbH9em6BIzWs0QOaj9N
         1kO82kjo6jPHkRVvhq5910ZmOqNlFEmfsWA1vIi4yisLT8PoY1WnB9fnAq+lqJCIDy
         46CWNDf7HOD8AzGnc+Gm8GAHPKw7Iy+ZWZfwp+dPY91pkjzCEG0b76lnoWylYxI2fT
         aFSuUP7+xpSuWunULLHaFBQ/A/P3rmyfSmKa8d9korlF/pH5R5MSkJhy9ZwP3G+0ft
         F4d+Ho7jLqLdeaQw4xTmejf7gPWvESAyXgO0ynLEzv1mH2HPVaMBgiJLfGIbJ5IZnK
         NrsKSWZuviLIXShNGc62FOOscbDkOD2zKOHVkVEk5m3E18marrqXD3EYkWAVzx7FHj
         MjGfAZtvPJQ3gPLTfd55gGlpE4fKdhedBJXVXQPS6N9dfhW4QU9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 32/44] serve: advertise object-format capability for protocol v2
Date:   Wed, 13 May 2020 00:54:12 +0000
Message-Id: <20200513005424.81369-33-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
format" message. Add a wrapper function that specifies this header if
required.  Skip specifying this header for SHA-1 to test that it works
both with and without this header.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 serve.c              | 27 +++++++++++++++++++++++++++
 t/t5701-git-serve.sh | 28 ++++++++++++++++++++--------
 2 files changed, 47 insertions(+), 8 deletions(-)

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
index ffb9613885..bcb6453ae3 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -4,13 +4,24 @@ test_description='test protocol v2 server commands'
 
 . ./test-lib.sh
 
+write_command () {
+	echo "command=$1"
+
+	if test "$(test_oid algo)" != sha1
+	then
+		echo "object-format=$(test_oid algo)"
+	fi
+}
+
 test_expect_success 'test capability advertisement' '
+	test_oid_init &&
 	cat >expect <<-EOF &&
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
 	ls-refs
 	fetch=shallow
 	server-option
+	object-format=$(test_oid algo)
 	0000
 	EOF
 
@@ -45,6 +56,7 @@ test_expect_success 'request invalid capability' '
 test_expect_success 'request with no command' '
 	test-tool pkt-line pack >in <<-EOF &&
 	agent=git/test
+	object-format=$(test_oid algo)
 	0000
 	EOF
 	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
@@ -53,7 +65,7 @@ test_expect_success 'request with no command' '
 
 test_expect_success 'request invalid command' '
 	test-tool pkt-line pack >in <<-EOF &&
-	command=foo
+	$(write_command foo)
 	agent=git/test
 	0000
 	EOF
@@ -73,7 +85,7 @@ test_expect_success 'setup some refs and tags' '
 
 test_expect_success 'basics of ls-refs' '
 	test-tool pkt-line pack >in <<-EOF &&
-	command=ls-refs
+	$(write_command ls-refs)
 	0000
 	EOF
 
@@ -95,7 +107,7 @@ test_expect_success 'basics of ls-refs' '
 
 test_expect_success 'basic ref-prefixes' '
 	test-tool pkt-line pack >in <<-EOF &&
-	command=ls-refs
+	$(write_command ls-refs)
 	0001
 	ref-prefix refs/heads/master
 	ref-prefix refs/tags/one
@@ -115,7 +127,7 @@ test_expect_success 'basic ref-prefixes' '
 
 test_expect_success 'refs/heads prefix' '
 	test-tool pkt-line pack >in <<-EOF &&
-	command=ls-refs
+	$(write_command ls-refs)
 	0001
 	ref-prefix refs/heads/
 	0000
@@ -135,7 +147,7 @@ test_expect_success 'refs/heads prefix' '
 
 test_expect_success 'peel parameter' '
 	test-tool pkt-line pack >in <<-EOF &&
-	command=ls-refs
+	$(write_command ls-refs)
 	0001
 	peel
 	ref-prefix refs/tags/
@@ -156,7 +168,7 @@ test_expect_success 'peel parameter' '
 
 test_expect_success 'symrefs parameter' '
 	test-tool pkt-line pack >in <<-EOF &&
-	command=ls-refs
+	$(write_command ls-refs)
 	0001
 	symrefs
 	ref-prefix refs/heads/
@@ -177,7 +189,7 @@ test_expect_success 'symrefs parameter' '
 
 test_expect_success 'sending server-options' '
 	test-tool pkt-line pack >in <<-EOF &&
-	command=ls-refs
+	$(write_command ls-refs)
 	server-option=hello
 	server-option=world
 	0001
@@ -199,7 +211,7 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
 	git init server &&
 
 	test-tool pkt-line pack >in <<-EOF &&
-	command=fetch
+	$(write_command fetch)
 	0001
 	this-is-not-a-command
 	0000
