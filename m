Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D7361F859
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932521AbcH1X2x (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:53 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41016 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756177AbcH1X2F (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 099DD280AE;
        Sun, 28 Aug 2016 23:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426884;
        bh=q+dH1vUodKqLnCgAERe7xxZ8qXATbbHKsYqoEEIEteE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iiI3c13JgONaeslsbhc9wQDwg7FK8LWjmCTML+9mYuulhQ0/a6AEu4SZ/DrXt007r
         IK1sL9uo4CCfzC2zcK8fEaQJoNHaY/xKRLr/mG5OhYmnfpod0dOrr/8vJNobV/IZ0h
         Az+M3ZIJqOL/kuYcIyu5BdRWuK8kFVmgguNAWhiHPdEHmQH9Bc6oJBQUg1XipaQX1B
         hba43bwWomhp+OQubBKAKaH+RzKfUFciZta53eEKrFcALnfndimw2FN3cCng0j4jT+
         r+DZvzQ8cDuIO7nJfZVTTkrmp8JL3kllYy3kMXiLmJIzKSV7N8kVkeenzI9E1z9ehg
         fm5OCKF6s0UMgR46XZEcdPqHnBMxJQ6OSmihHWQDMiitUcT0uWnypHKumhBJyyJL0O
         Wx9h660nNoNLmpf65Djpxn6Ntr7ElHazCpBAlGom5bDLTDv5AG6HvuzrOWHaJzVFiC
         aoYn4pyIjvvHdQtgv5ekL7EIPwI5BNUDAChj6RuCxugrruMFd1D
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 08/20] streaming: make stream_blob_to_fd take struct object_id
Date:   Sun, 28 Aug 2016 23:27:45 +0000
Message-Id: <20160828232757.373278-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since all of its callers have been updated, modify stream_blob_to_fd to
take a struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/cat-file.c | 6 +++---
 builtin/fsck.c     | 2 +-
 builtin/log.c      | 4 ++--
 entry.c            | 2 +-
 streaming.c        | 4 ++--
 streaming.h        | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7b2e0537..49b8fa8e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -83,7 +83,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		}
 
 		if (type == OBJ_BLOB)
-			return stream_blob_to_fd(1, oid.hash, NULL, 0);
+			return stream_blob_to_fd(1, &oid, NULL, 0);
 		buf = read_sha1_file(oid.hash, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
@@ -105,7 +105,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 				oidcpy(&blob_oid, &oid);
 
 			if (sha1_object_info(blob_oid.hash, NULL) == OBJ_BLOB)
-				return stream_blob_to_fd(1, blob_oid.hash, NULL, 0);
+				return stream_blob_to_fd(1, &blob_oid, NULL, 0);
 			/*
 			 * we attempted to dereference a tag to a blob
 			 * and failed; there may be new dereference
@@ -240,7 +240,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	if (data->type == OBJ_BLOB) {
 		if (opt->buffer_output)
 			fflush(stdout);
-		if (stream_blob_to_fd(1, oid->hash, NULL, 0) < 0)
+		if (stream_blob_to_fd(1, oid, NULL, 0) < 0)
 			die("unable to stream %s to stdout", oid_to_hex(oid));
 	}
 	else {
diff --git a/builtin/fsck.c b/builtin/fsck.c
index f604adff..055dfdcf 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -268,7 +268,7 @@ static void check_unreachable_object(struct object *obj)
 			if (!(f = fopen(filename, "w")))
 				die_errno("Could not open '%s'", filename);
 			if (obj->type == OBJ_BLOB) {
-				if (stream_blob_to_fd(fileno(f), obj->oid.hash, NULL, 1))
+				if (stream_blob_to_fd(fileno(f), &obj->oid, NULL, 1))
 					die_errno("Could not write '%s'", filename);
 			} else
 				fprintf(f, "%s\n", describe_object(obj));
diff --git a/builtin/log.c b/builtin/log.c
index 48b9db51..0b427b67 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -474,13 +474,13 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	fflush(rev->diffopt.file);
 	if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
 	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
-		return stream_blob_to_fd(1, oid->hash, NULL, 0);
+		return stream_blob_to_fd(1, oid, NULL, 0);
 
 	if (get_sha1_with_context(obj_name, 0, oidc.hash, &obj_context))
 		die(_("Not a valid object name %s"), obj_name);
 	if (!obj_context.path[0] ||
 	    !textconv_object(obj_context.path, obj_context.mode, &oidc, 1, &buf, &size))
-		return stream_blob_to_fd(1, oid->hash, NULL, 0);
+		return stream_blob_to_fd(1, oid, NULL, 0);
 
 	if (!buf)
 		die(_("git show %s: bad file"), obj_name);
diff --git a/entry.c b/entry.c
index ce80d292..c6eea240 100644
--- a/entry.c
+++ b/entry.c
@@ -127,7 +127,7 @@ static int streaming_write_entry(const struct cache_entry *ce, char *path,
 	if (fd < 0)
 		return -1;
 
-	result |= stream_blob_to_fd(fd, ce->oid.hash, filter, 1);
+	result |= stream_blob_to_fd(fd, &ce->oid, filter, 1);
 	*fstat_done = fstat_output(fd, state, statbuf);
 	result |= close(fd);
 
diff --git a/streaming.c b/streaming.c
index 811fcc24..3c48f049 100644
--- a/streaming.c
+++ b/streaming.c
@@ -497,7 +497,7 @@ static open_method_decl(incore)
  * Users of streaming interface
  ****************************************************************/
 
-int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *filter,
+int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter *filter,
 		      int can_seek)
 {
 	struct git_istream *st;
@@ -506,7 +506,7 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
 	ssize_t kept = 0;
 	int result = -1;
 
-	st = open_istream(sha1, &type, &sz, filter);
+	st = open_istream(oid->hash, &type, &sz, filter);
 	if (!st) {
 		if (filter)
 			free_stream_filter(filter);
diff --git a/streaming.h b/streaming.h
index 1d05c2a4..73c1d156 100644
--- a/streaming.h
+++ b/streaming.h
@@ -12,6 +12,6 @@ extern struct git_istream *open_istream(const unsigned char *, enum object_type
 extern int close_istream(struct git_istream *);
 extern ssize_t read_istream(struct git_istream *, void *, size_t);
 
-extern int stream_blob_to_fd(int fd, const unsigned char *, struct stream_filter *, int can_seek);
+extern int stream_blob_to_fd(int fd, const struct object_id *, struct stream_filter *, int can_seek);
 
 #endif /* STREAMING_H */
