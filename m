Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15911207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbcIMDXW (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:23:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:42271 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752102AbcIMDXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:23:21 -0400
Received: (qmail 20223 invoked by uid 109); 13 Sep 2016 03:23:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:23:21 +0000
Received: (qmail 18415 invoked by uid 111); 13 Sep 2016 03:23:30 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:23:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:23:17 -0700
Date:   Mon, 12 Sep 2016 20:23:17 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 02/16] hash-object: always try to set up the git repository
Message-ID: <20160913032317.eyddugalfb2atr7v@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "hash-object" is run without "-w", we don't need to be
in a git repository at all; we can just hash the object and
write its sha1 to stdout. However, if we _are_ in a git
repository, we would want to know that so we can follow the
normal rules for respecting config, .gitattributes, etc.

This happens to work at the top-level of a git repository
because we blindly read ".git/config", but as the included
test shows, it does not work when you are in a subdirectory.

The solution is to just do a "gentle" setup in this case. We
already take care to use prefix_filename() on any filename
arguments we get (to handle the "-w" case), so we don't need
to do anything extra to handle the side effects of repo
setup.

An alternative would be to specify RUN_SETUP_GENTLY for this
command in git.c, and then die if "-w" is set but we are not
in a repository. However, the error messages generated at
the time of setup_git_directory() are more detailed, so it's
better to find out which mode we are in, and then call the
appropriate function.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/hash-object.c  | 13 ++++++++-----
 t/t1007-hash-object.sh | 11 +++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index f7d3567..9028e1f 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -87,6 +87,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	int stdin_paths = 0;
 	int no_filters = 0;
 	int literally = 0;
+	int nongit = 0;
 	unsigned flags = HASH_FORMAT_CHECK;
 	const char *vpath = NULL;
 	const struct option hash_object_options[] = {
@@ -107,12 +108,14 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, NULL, hash_object_options,
 			     hash_object_usage, 0);
 
-	if (flags & HASH_WRITE_OBJECT) {
+	if (flags & HASH_WRITE_OBJECT)
 		prefix = setup_git_directory();
-		prefix_length = prefix ? strlen(prefix) : 0;
-		if (vpath && prefix)
-			vpath = prefix_filename(prefix, prefix_length, vpath);
-	}
+	else
+		prefix = setup_git_directory_gently(&nongit);
+
+	prefix_length = prefix ? strlen(prefix) : 0;
+	if (vpath && prefix)
+		vpath = prefix_filename(prefix, prefix_length, vpath);
 
 	git_config(git_default_config, NULL);
 
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index c89faa6..acca9ac 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -123,6 +123,17 @@ test_expect_success 'check that appropriate filter is invoke when --path is used
 	test "$file1_sha" = "$path1_sha"
 '
 
+test_expect_success 'gitattributes also work in a subdirectory' '
+	mkdir subdir &&
+	(
+		cd subdir &&
+		subdir_sha0=$(git hash-object ../file0) &&
+		subdir_sha1=$(git hash-object ../file1) &&
+		test "$file0_sha" = "$subdir_sha0" &&
+		test "$file1_sha" = "$subdir_sha1"
+	)
+'
+
 test_expect_success 'check that --no-filters option works' '
 	nofilters_file1=$(git hash-object --no-filters file1) &&
 	test "$file0_sha" = "$nofilters_file1" &&
-- 
2.10.0.230.g6f8d04b

