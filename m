Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB442B9A7
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159941; cv=none; b=jbzKkAMjAi9uMUBeT9PLbWjVKSru1wPQpT0nZGTZS01t0p4UV4ysPqcvkr8p5NlEjYn9ibcOsUWdKeDoGlc9HsJKcc9rOMfuPE6x9ZPyx5QneruK3xIQAhdEx3JbZeicarDU/XnOHa7anGB4GKoz/FuLC3pf4fQdt80hnRaOqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159941; c=relaxed/simple;
	bh=BU6WuSU90BLaKENMxOxDYdHIL8ENYXpJoWVToaQFrQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWMwV0qHMGlcJHtx4K+KaYAi+Ngi0sE3IuVgLCw7zZIp8WCIe/fYaxjYLpFJPpTAPp4Fxal5J8LODxd+6SZgj+Gvbbrp66IMMSfYAihHfex9ehDr0vlLKjtV3nlBoC71ihqIxP5GuNzKirgJ7fpR2t+f5bJv8JXva3lT0rC7sCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23686 invoked by uid 109); 28 Feb 2024 22:38:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:38:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26768 invoked by uid 111); 28 Feb 2024 22:39:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:39:00 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:38:58 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benjamin Flesch <benjaminflesch@icloud.com>
Subject: [PATCH 6/9] upload-pack: disallow object-info capability by default
Message-ID: <20240228223858.GF1158131@coredump.intra.peff.net>
References: <20240228223700.GA1157826@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228223700.GA1157826@coredump.intra.peff.net>

From: Taylor Blau <me@ttaylorr.com>

We added an "object-info" capability to the v2 upload-pack protocol in
a2ba162cda (object-info: support for retrieving object info,
2021-04-20). In the almost 3 years since, we have not added any
client-side support, and it does not appear to exist in other
implementations either (JGit understands the verb on the server side,
but not on the client side).

Since this largely unused code is accessible over the network by
default, it increases the attack surface of upload-pack. I don't know of
any particularly severe problem, but one issue is that because of the
request/response nature of the v2 protocol, it will happily read an
unbounded number of packets, adding each one to a string list (without
regard to whether they are objects we know about, duplicates, etc).

This may be something we want to improve in the long run, but in the
short term it makes sense to disable the feature entirely. We'll add a
config option as an escape hatch for anybody who wants to develop the
feature further.

A more gentle option would be to add the config option to let people
disable it manually, but leave it enabled by default. But given that
there's no client side support, that seems like the wrong balance with
security.

Disabling by default will slow adoption a bit once client-side support
does become available (there were some patches[1] in 2022, but nothing
got merged and there's been nothing since). But clients have to deal
with older servers that do not understand the option anyway (and the
capability system handles that), so it will just be a matter of servers
flipping their config at that point (and hopefully once any unbounded
allocations have been addressed).

[jk: this is a patch that GitHub has been running for several years, but
     rebased forward and with a new commit message for upstream]

[1] https://lore.kernel.org/git/20220208231911.725273-1-calvinwan@google.com/

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config/transfer.txt |  4 ++++
 serve.c                           | 14 +++++++++++++-
 t/t5555-http-smart-common.sh      |  1 -
 t/t5701-git-serve.sh              | 24 +++++++++++++++++++++++-
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index a9cbdb88a1..f1ce50f4a6 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -121,3 +121,7 @@ transfer.bundleURI::
 	information from the remote server (if advertised) and download
 	bundles before continuing the clone through the Git protocol.
 	Defaults to `false`.
+
+transfer.advertiseObjectInfo::
+	When `true`, the `object-info` capability is advertised by
+	servers. Defaults to false.
diff --git a/serve.c b/serve.c
index a1d71134d4..aa651b73e9 100644
--- a/serve.c
+++ b/serve.c
@@ -12,6 +12,7 @@
 #include "trace2.h"
 
 static int advertise_sid = -1;
+static int advertise_object_info = -1;
 static int client_hash_algo = GIT_HASH_SHA1;
 
 static int always_advertise(struct repository *r UNUSED,
@@ -67,6 +68,17 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
+static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+{
+	if (advertise_object_info == -1 &&
+	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
+				 &advertise_object_info)) {
+		/* disabled by default */
+		advertise_object_info = 0;
+	}
+	return advertise_object_info;
+}
+
 struct protocol_capability {
 	/*
 	 * The name of the capability.  The server uses this name when
@@ -135,7 +147,7 @@ static struct protocol_capability capabilities[] = {
 	},
 	{
 		.name = "object-info",
-		.advertise = always_advertise,
+		.advertise = object_info_advertise,
 		.command = cap_object_info,
 	},
 	{
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index b1cfe8b7db..3dcb3340a3 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -131,7 +131,6 @@ test_expect_success 'git upload-pack --advertise-refs: v2' '
 	fetch=shallow wait-for-done
 	server-option
 	object-format=$(test_oid algo)
-	object-info
 	0000
 	EOF
 
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 3591bc2417..c48830de8f 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -20,7 +20,6 @@ test_expect_success 'test capability advertisement' '
 	fetch=shallow wait-for-done
 	server-option
 	object-format=$(test_oid algo)
-	object-info
 	EOF
 	cat >expect.trailer <<-EOF &&
 	0000
@@ -323,6 +322,8 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
 # Test the basics of object-info
 #
 test_expect_success 'basics of object-info' '
+	test_config transfer.advertiseObjectInfo true &&
+
 	test-tool pkt-line pack >in <<-EOF &&
 	command=object-info
 	object-format=$(test_oid algo)
@@ -380,4 +381,25 @@ test_expect_success 'basics of bundle-uri: dies if not enabled' '
 	test_must_be_empty out
 '
 
+test_expect_success 'object-info missing from capabilities when disabled' '
+	test_config transfer.advertiseObjectInfo false &&
+
+	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
+		--advertise-capabilities >out &&
+	test-tool pkt-line unpack <out >actual &&
+
+	! grep object.info actual
+'
+
+test_expect_success 'object-info commands rejected when disabled' '
+	test_config transfer.advertiseObjectInfo false &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=object-info
+	EOF
+
+	test_must_fail test-tool serve-v2 --stateless-rpc <in 2>err &&
+	grep invalid.command err
+'
+
 test_done
-- 
2.44.0.rc2.424.gbdbf4d014b

