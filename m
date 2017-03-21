Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B26902095B
	for <e@80x24.org>; Tue, 21 Mar 2017 01:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755341AbdCUBWA (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:22:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:48306 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755368AbdCUBWA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 21:22:00 -0400
Received: (qmail 10114 invoked by uid 109); 21 Mar 2017 01:20:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 01:20:47 +0000
Received: (qmail 9833 invoked by uid 111); 21 Mar 2017 01:21:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 21:21:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 21:20:42 -0400
Date:   Mon, 20 Mar 2017 21:20:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] hash-object: fix buffer reuse with --path in a
 subdirectory
Message-ID: <20170321012042.jb5biz2min7a34gu@sigill.intra.peff.net>
References: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The hash-object command uses prefix_filename() without
duplicating its return value. Since that function returns a
static buffer, the value is overwritten by subsequent calls.

This can cause incorrect results when we use --path along
with hashing a file by its relative path, both of which need
to call prefix_filename(). We overwrite the filename
computed for --path, effectively ignoring it.

We can fix this by calling xstrdup on the return value. Note
that we don't bother freeing the "vpath" instance, as it
remains valid until the program exit.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/hash-object.c  |  7 +++++--
 t/t1007-hash-object.sh | 10 ++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 9028e1fdc..56df77b0c 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -115,7 +115,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 
 	prefix_length = prefix ? strlen(prefix) : 0;
 	if (vpath && prefix)
-		vpath = prefix_filename(prefix, prefix_length, vpath);
+		vpath = xstrdup(prefix_filename(prefix, prefix_length, vpath));
 
 	git_config(git_default_config, NULL);
 
@@ -144,11 +144,14 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 
 	for (i = 0 ; i < argc; i++) {
 		const char *arg = argv[i];
+		char *to_free = NULL;
 
 		if (0 <= prefix_length)
-			arg = prefix_filename(prefix, prefix_length, arg);
+			arg = to_free =
+				xstrdup(prefix_filename(prefix, prefix_length, arg));
 		hash_object(arg, type, no_filters ? NULL : vpath ? vpath : arg,
 			    flags, literally);
+		free(to_free);
 	}
 
 	if (stdin_paths)
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index c5245c5cb..532682f51 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -134,6 +134,16 @@ test_expect_success 'gitattributes also work in a subdirectory' '
 	)
 '
 
+test_expect_success '--path works in a subdirectory' '
+	(
+		cd subdir &&
+		path1_sha=$(git hash-object --path=../file1 ../file0) &&
+		path0_sha=$(git hash-object --path=../file0 ../file1) &&
+		test "$file0_sha" = "$path0_sha" &&
+		test "$file1_sha" = "$path1_sha"
+	)
+'
+
 test_expect_success 'check that --no-filters option works' '
 	nofilters_file1=$(git hash-object --no-filters file1) &&
 	test "$file0_sha" = "$nofilters_file1" &&
-- 
2.12.1.683.gcd02edfec

