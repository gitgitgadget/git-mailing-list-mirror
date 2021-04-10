Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E9C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A13C6113A
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhDJPXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:23:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58536 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234680AbhDJPXR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 11:23:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1E91F6078D;
        Sat, 10 Apr 2021 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618068152;
        bh=rova5aT9bFHVo7BVfbEJo1bVISoH7/lf9o753jcpXkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZCf9UR6NuWZKR75hCxLrtlTqFuWBxBakPDbKzIENPw+mTzb8F0x4Ls1T2j6pc7ytt
         ED2srSuovK9YnRCwi52vasT3mmAykFpn7EkE6ByGmL84SH04MxpH555otcC/dFV8DO
         ngOI/enpRl9Fd7TEVpimxEk8267GRjODj6vfa09zPIZhy877sr8QK9UnjA8BaglwDQ
         3omaWE74lmPW2irHlQ0oi/fsqSbJTEY7c98Hd1HU72SlMrtBph0vkajRpEA2Kgt4RC
         TuY9QsFzqXhScgTqSoOs0dgGUbSwp5ev1HevuIu8AcAmWInzwWsS/mZK4muf3A4eMP
         Grxy54MrOIpygE24yKam9I8yXvdcrW6fVgzgsoTWPUoTj9BReLqhSuuZvoT4lkv3gn
         YyMBUHSyKxVpv4MR884txvnzaJukAg97AzvYkoJwZQk6q4VRl+q627s/nUNBOnMMV9
         a1cKXvi8Q8o4M2cCGmqM+kXMVqFlVykRO4hOAWL/7I0vbOvveGw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 02/15] builtin/hash-object: allow literally hashing with a given algorithm
Date:   Sat, 10 Apr 2021 15:21:27 +0000
Message-Id: <20210410152140.3525040-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf
In-Reply-To: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an --object-format argument to git hash-object that allows hashing
an object with a given algorithm. Currently this options is limited to
use with --literally, since the index_* functions do not yet handle
multiple hash algorithms.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/hash-object.c  | 47 ++++++++++++++++++++++++++++++------------
 t/t1007-hash-object.sh | 10 +++++++++
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 640ef4ded5..0203cfbe9a 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -17,7 +17,8 @@
  * needs to bypass the data conversion performed by, and the type
  * limitation imposed by, index_fd() and its callees.
  */
-static int hash_literally(struct object_id *oid, int fd, const char *type, unsigned flags)
+static int hash_literally(struct object_id *oid, int fd, const char *type,
+			  unsigned flags, const struct git_hash_algo *algo)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
@@ -25,42 +26,46 @@ static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
 	if (strbuf_read(&buf, fd, 4096) < 0)
 		ret = -1;
 	else
-		ret = hash_object_file_literally(buf.buf, buf.len, type, oid,
-						 flags);
+		ret = hash_object_file_literally_algop(buf.buf, buf.len, type, oid,
+						       flags, algo);
 	strbuf_release(&buf);
 	return ret;
 }
 
 static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
-		    int literally)
+		    int literally, const struct git_hash_algo *algo)
 {
 	struct stat st;
 	struct object_id oid;
 
+	if (!literally && algo != the_hash_algo)
+		die(_("Can't use hash algo %s except literally yet"), algo->name);
+
 	if (fstat(fd, &st) < 0 ||
 	    (literally
-	     ? hash_literally(&oid, fd, type, flags)
+	     ? hash_literally(&oid, fd, type, flags, algo)
 	     : index_fd(the_repository->index, &oid, fd, &st,
 			type_from_string(type), path, flags)))
 		die((flags & HASH_WRITE_OBJECT)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
-	printf("%s\n", oid_to_hex(&oid));
+	printf("%s\n", hash_to_hex_algop(oid.hash, algo));
 	maybe_flush_or_die(stdout, "hash to stdout");
 }
 
 static void hash_object(const char *path, const char *type, const char *vpath,
-			unsigned flags, int literally)
+			unsigned flags, int literally,
+			const struct git_hash_algo *algo)
 {
 	int fd;
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		die_errno("Cannot open '%s'", path);
-	hash_fd(fd, type, vpath, flags, literally);
+	hash_fd(fd, type, vpath, flags, literally, algo);
 }
 
 static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
-			     int literally)
+			     int literally, const struct git_hash_algo *algo)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -73,7 +78,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 			strbuf_swap(&buf, &unquoted);
 		}
 		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags,
-			    literally);
+			    literally, algo);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&unquoted);
@@ -94,6 +99,8 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	int nongit = 0;
 	unsigned flags = HASH_FORMAT_CHECK;
 	const char *vpath = NULL;
+	const char *object_format = NULL;
+	const struct git_hash_algo *algo;
 	const struct option hash_object_options[] = {
 		OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
 		OPT_BIT('w', NULL, &flags, N_("write the object into the object database"),
@@ -103,6 +110,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
 		OPT_BOOL( 0, "literally", &literally, N_("just hash any random garbage to create corrupt objects for debugging Git")),
 		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
+		OPT_STRING( 0 , "object-format", &object_format, N_("object-format"), N_("Use this hash algorithm")),
 		OPT_END()
 	};
 	int i;
@@ -121,6 +129,19 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	algo = the_hash_algo;
+	if (object_format) {
+		if (flags & HASH_WRITE_OBJECT)
+			errstr = "Can't use -w with --object-format";
+		else {
+			int id = hash_algo_by_name(object_format);
+			if (id == GIT_HASH_UNKNOWN)
+				errstr = "Unknown object format";
+			else
+				algo = &hash_algos[id];
+		}
+	}
+
 	if (stdin_paths) {
 		if (hashstdin)
 			errstr = "Can't use --stdin-paths with --stdin";
@@ -142,7 +163,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	}
 
 	if (hashstdin)
-		hash_fd(0, type, vpath, flags, literally);
+		hash_fd(0, type, vpath, flags, literally, algo);
 
 	for (i = 0 ; i < argc; i++) {
 		const char *arg = argv[i];
@@ -151,12 +172,12 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		if (prefix)
 			arg = to_free = prefix_filename(prefix, arg);
 		hash_object(arg, type, no_filters ? NULL : vpath ? vpath : arg,
-			    flags, literally);
+			    flags, literally, algo);
 		free(to_free);
 	}
 
 	if (stdin_paths)
-		hash_stdin_paths(type, no_filters, flags, literally);
+		hash_stdin_paths(type, no_filters, flags, literally, algo);
 
 	return 0;
 }
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 64b340f227..ea4b3d2bda 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -83,6 +83,11 @@ test_expect_success 'hash a file' '
 	test "$(test_oid hello)" = $(git hash-object hello)
 '
 
+test_expect_failure 'hash a file with a given algorithm' '
+	test "$(test_oid --hash=sha1 hello)" = $(git hash-object --object-format=sha1 hello) &&
+	test "$(test_oid --hash=sha256 hello)" = $(git hash-object --object-format=sha256 hello)
+'
+
 test_blob_does_not_exist "$(test_oid hello)"
 
 test_expect_success 'hash from stdin' '
@@ -248,4 +253,9 @@ test_expect_success '--literally with extra-long type' '
 	echo example | git hash-object -t $t --literally --stdin
 '
 
+test_expect_success '--literally with --object-format' '
+	test $(test_oid --hash=sha1 hello) = $(git hash-object -t blob --literally --object-format=sha1 hello) &&
+	test $(test_oid --hash=sha256 hello) = $(git hash-object -t blob --literally --object-format=sha256 hello)
+'
+
 test_done
