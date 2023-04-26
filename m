Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E577AC77B7C
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 20:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbjDZUxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjDZUxh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 16:53:37 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CEB1FC9
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 13:53:34 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B15E95B3A2;
        Wed, 26 Apr 2023 20:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1682542413;
        bh=+JPb588FGQIc7yz9rKsLTCpbAO7tzpMvwA8SpSqRvos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ALq2vrVs0RTrukE4iPp8v3FeEtqLWBys8aeCLJ/LUYFoUZbdOybylnerP3VhlPSTz
         nThEQDmg1VvafBemRGvSAdrjAqb6LSX7WSwBDGaxYVLem4UW0kocka/GGop0OnVbuv
         eoqCoBnO23aaDUfzvNvrmJD2ZZVkNblzUhKEzdylBnohFbEzmxFSOvs4TxANUdgWrr
         mnBm5kljn6K42gEQ6HynGErcoib6KoDKWudoHYEqdYX8DAsp3DVMP2XYYjG3TAMWU8
         w4rGyPefWKC+UyITKxYffyUN1VUjVFMaWSXuKb8IBty8+rHbEBKhW4++KYr1aIIQII
         qJBpz8qEjy4K0DO8yOYO5wszMk59qaSqGhFYb1hTwV/ZyE6EjUjAp5AT9xkRf5xGzG
         gIrAK1c8ZOoM8bOvzAI4r49FwvmbYItJiltAgh8/KJWI5lYl4OeA5hYLef2fHuvD6R
         Z/tKbS++O1pQHZJJv1an9GOaIwMGJ3wrNtClz3+xcVYOxaLxDbV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Adam Majer <adamm@zombino.com>
Subject: [PATCH 2/2] Honor GIT_DEFAULT_HASH for empty clones without remote algo
Date:   Wed, 26 Apr 2023 20:53:24 +0000
Message-Id: <20230426205324.326501-3-sandals@crustytoothpaste.net>
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

The previous commit introduced a change that allows HTTP v0 and v1
operations to determine the hash of an empty remote repository by
sending capabilities.  However, there are still some cases, such as when
cloning locally, where the capabilities are not sent.  This is because
for local operations, we don't strip out the fake "capabilities^{}" ref,
and thus "git ls-remote" would produce incorrect values if we did.

However, up until 8b214c2e9d ("clone: propagate object-format when
cloning from void", 2023-04-05), we honored GIT_DEFAULT_HASH in this
case, so let's continue to do that.  Check whether the hash algorithm
was explicitly set, and if so, continue to use that value.  If not, use
the default value for GIT_DEFAULT_HASH to ensure that we can at least
properly configure an empty clone whose hash algorithm we know.

Note that without this patch, git clone cannot create a SHA-256
repository from an empty remote without protocol v2 (except over HTTP,
as in the previous patch).
---
 Documentation/git.txt  | 10 +++++++---
 builtin/clone.c        |  8 +++++---
 connect.c              |  5 ++++-
 pkt-line.h             |  2 ++
 t/t5700-protocol-v1.sh | 11 +++++++++++
 transport-helper.c     |  1 +
 transport.c            | 14 ++++++++++++++
 transport.h            | 14 ++++++++++++++
 8 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 74973d3cc4..48eda9f883 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -547,9 +547,13 @@ double-quotes and respecting backslash escapes. E.g., the value
 `GIT_DEFAULT_HASH`::
 	If this variable is set, the default hash algorithm for new
 	repositories will be set to this value. This value is currently
-	ignored when cloning; the setting of the remote repository
-	is used instead. The default is "sha1". THIS VARIABLE IS
-	EXPERIMENTAL! See `--object-format` in linkgit:git-init[1].
+	ignored when cloning if the remote value can be definitively
+	determined; the setting of the remote repository is used
+	instead. The value is honored if the remote repository's
+	algorithm cannot be determined, such as some cases when
+	the remote repository is empty. The default is "sha1".
+	THIS VARIABLE IS EXPERIMENTAL! See `--object-format`
+	in linkgit:git-init[1].
 
 Git Commits
 ~~~~~~~~~~~
diff --git a/builtin/clone.c b/builtin/clone.c
index 186845ef0b..c207798de9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1316,13 +1316,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (transport_get_hash_algo_explicit(transport)) {
 		/*
 		 * Now that we know what algorithm the remote side is using,
 		 * let's set ours to the same thing.
 		 */
-	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
-	initialize_repository_version(hash_algo, 1);
-	repo_set_hash_algo(the_repository, hash_algo);
+		hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
+		initialize_repository_version(hash_algo, 1);
+		repo_set_hash_algo(the_repository, hash_algo);
+	}
 
 	if (mapped_refs) {
 		/*
diff --git a/connect.c b/connect.c
index 3a0186280c..40cb9bf261 100644
--- a/connect.c
+++ b/connect.c
@@ -243,8 +243,10 @@ static void process_capabilities(struct packet_reader *reader, int *linelen)
 	if (feat_val) {
 		char *hash_name = xstrndup(feat_val, feat_len);
 		int hash_algo = hash_algo_by_name(hash_name);
-		if (hash_algo != GIT_HASH_UNKNOWN)
+		if (hash_algo != GIT_HASH_UNKNOWN) {
 			reader->hash_algo = &hash_algos[hash_algo];
+			reader->hash_algo_explicit = 1;
+		}
 		free(hash_name);
 	} else {
 		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
@@ -493,6 +495,7 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 		if (hash_algo == GIT_HASH_UNKNOWN)
 			die(_("unknown object format '%s' specified by server"), hash_name);
 		reader->hash_algo = &hash_algos[hash_algo];
+		reader->hash_algo_explicit = 1;
 		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
 	} else {
 		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
diff --git a/pkt-line.h b/pkt-line.h
index 8e9846f315..10700a9d8c 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -190,6 +190,8 @@ struct packet_reader {
 	int line_peeked;
 
 	unsigned use_sideband : 1;
+	/* indicates if we saw an explicit capability */
+	unsigned hash_algo_explicit : 1;
 	const char *me;
 
 	/* hash algorithm in use */
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 3cd9db9012..ad24c7fe64 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -244,6 +244,17 @@ test_expect_success 'push with ssh:// using protocol v1' '
 	grep "push< version 1" log
 '
 
+test_expect_success 'clone propagates object-format from empty repo' '
+	test_when_finished "rm -fr src256 dst256" &&
+
+	echo sha256 >expect &&
+	git init --object-format=sha256 src256 &&
+	GIT_DEFAULT_HASH=sha256 git -c protocol.version=1 clone --no-local src256 dst256 &&
+	git -C dst256 rev-parse --show-object-format >actual &&
+
+	test_cmp expect actual
+'
+
 # Test protocol v1 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/transport-helper.c b/transport-helper.c
index 6b816940dc..c65cf7c620 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1236,6 +1236,7 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 					die(_("unsupported object format '%s'"),
 					    value);
 				transport->hash_algo = &hash_algos[algo];
+				transport->hash_algo_explicit = 1;
 			}
 			continue;
 		}
diff --git a/transport.c b/transport.c
index 67afdae57c..7774487e8d 100644
--- a/transport.c
+++ b/transport.c
@@ -147,6 +147,12 @@ static void get_refs_from_bundle_inner(struct transport *transport)
 		die(_("could not read bundle '%s'"), transport->url);
 
 	transport->hash_algo = data->header.hash_algo;
+	/*
+	 * This is always set, even if we didn't get an explicit object-format
+	 * capability, since we know that a missing capability or a v2 bundle
+	 * definitively indicates SHA-1.
+	 */
+	transport->hash_algo_explicit = 1;
 }
 
 static struct ref *get_refs_from_bundle(struct transport *transport,
@@ -190,6 +196,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	ret = unbundle(the_repository, &data->header, data->fd,
 		       &extra_index_pack_args, 0);
 	transport->hash_algo = data->header.hash_algo;
+	transport->hash_algo_explicit = 1;
 	return ret;
 }
 
@@ -360,6 +367,7 @@ static struct ref *handshake(struct transport *transport, int for_push,
 	}
 	data->finished_handshake = 1;
 	transport->hash_algo = reader.hash_algo;
+	transport->hash_algo_explicit = reader.hash_algo_explicit;
 
 	if (reader.line_peeked)
 		BUG("buffer must be empty at the end of handshake()");
@@ -1190,6 +1198,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	}
 
 	ret->hash_algo = &hash_algos[GIT_HASH_SHA1];
+	ret->hash_algo_explicit = 0;
 
 	return ret;
 }
@@ -1199,6 +1208,11 @@ const struct git_hash_algo *transport_get_hash_algo(struct transport *transport)
 	return transport->hash_algo;
 }
 
+int transport_get_hash_algo_explicit(struct transport *transport)
+{
+	return transport->hash_algo_explicit;
+}
+
 int transport_set_option(struct transport *transport,
 			 const char *name, const char *value)
 {
diff --git a/transport.h b/transport.h
index 6393cd9823..ce67eefc58 100644
--- a/transport.h
+++ b/transport.h
@@ -128,6 +128,11 @@ struct transport {
 	 * in transport_set_verbosity().
 	 **/
 	unsigned progress : 1;
+	/*
+	 * Indicates whether the hash algorithm was initialized explicitly as
+	 * opposed to using a fallback.
+	 */
+	unsigned hash_algo_explicit : 1;
 	/*
 	 * If transport is at least potentially smart, this points to
 	 * git_transport_options structure to use in case transport
@@ -305,6 +310,15 @@ int transport_get_remote_bundle_uri(struct transport *transport);
  * This can only be called after fetching the remote refs.
  */
 const struct git_hash_algo *transport_get_hash_algo(struct transport *transport);
+/*
+ * Fetch whether the hash algorithm provided was explicitly set.
+ *
+ * If this value is false, "transport_get_hash_algo" will always return a value
+ * of SHA-1, which is the default algorithm if none is specified.
+ *
+ * This can only be called after fetching the remote refs.
+ */
+int transport_get_hash_algo_explicit(struct transport *transport);
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
 
 /*
