Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B711C64EC4
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 10:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCDK0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 05:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCDK0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 05:26:16 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598D013DF8
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 02:26:15 -0800 (PST)
Received: (qmail 16763 invoked by uid 109); 4 Mar 2023 10:26:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Mar 2023 10:26:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3714 invoked by uid 111); 4 Mar 2023 10:26:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Mar 2023 05:26:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Mar 2023 05:26:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: [PATCH 1/5] bundle: let "-" mean stdin for reading operations
Message-ID: <ZAMcxlaQ1h2bN1fm@coredump.intra.peff.net>
References: <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For writing, "bundle create -" indicates that the bundle should be
written to stdout. But there's no matching handling of "-" for reading
operations. This is inconsistent, and a little inflexible (though one
can always use "/dev/stdin" on systems that support it).

However, it's easy to change. Once upon a time, the bundle-reading code
required a seekable descriptor, but that was fixed long ago in
e9ee84cf28b (bundle: allowing to read from an unseekable fd,
2011-10-13). So we just need to handle "-" explicitly when opening the
file.

We _could_ do this by handling "-" in read_bundle_header(), which the
reading functions all call already. But that is probably a bad idea.
It's also used by low-level code like the transport functions, and we
may want to be more careful there. We do not know that stdin is even
available to us, and certainly we would not want to get confused by a
configured URL that happens to point to "-".

So instead, let's add a helper to builtin/bundle.c. Since both the
bundle code and some of the callers refer to the bundle by name for
error messages, let's use the string "<stdin>" to make the output a bit
nicer to read.

Signed-off-by: Jeff King <peff@peff.net>
---
It occurs to me while sending this that even though the new tests check
stdin, they don't confirm that it works with an unseekable descriptor.
It does. I don't know if the lack of fseek/lseek calls gives us enough
confidence, or if we want to protect this with a test that does:

  cat some.bundle | git bundle unbundle -

 builtin/bundle.c       | 26 ++++++++++++++++++++++----
 t/t6020-bundle-misc.sh | 15 +++++++++++++++
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index acceef62001..02dab1cfa02 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -107,6 +107,23 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 	return ret;
 }
 
+/*
+ * Similar to read_bundle_header(), but handle "-" as stdin.
+ */
+static int open_bundle(const char *path, struct bundle_header *header,
+		       const char **name)
+{
+	if (!strcmp(path, "-")) {
+		if (name)
+			*name = "<stdin>";
+		return read_bundle_header_fd(0, header, "<stdin>");
+	}
+
+	if (name)
+		*name = path;
+	return read_bundle_header(path, header);
+}
+
 static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
@@ -118,12 +135,13 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 		OPT_END()
 	};
 	char *bundle_file;
+	const char *name;
 
 	argc = parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_verify_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
+	if ((bundle_fd = open_bundle(bundle_file, &header, &name)) < 0) {
 		ret = 1;
 		goto cleanup;
 	}
@@ -134,7 +152,7 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 		goto cleanup;
 	}
 
-	fprintf(stderr, _("%s is okay\n"), bundle_file);
+	fprintf(stderr, _("%s is okay\n"), name);
 	ret = 0;
 cleanup:
 	free(bundle_file);
@@ -155,7 +173,7 @@ static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix
 			builtin_bundle_list_heads_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
+	if ((bundle_fd = open_bundle(bundle_file, &header, NULL)) < 0) {
 		ret = 1;
 		goto cleanup;
 	}
@@ -185,7 +203,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 			builtin_bundle_unbundle_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
+	if ((bundle_fd = open_bundle(bundle_file, &header, NULL)) < 0) {
 		ret = 1;
 		goto cleanup;
 	}
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 7d40994991e..45d93588c91 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -606,4 +606,19 @@ test_expect_success 'verify catches unreachable, broken prerequisites' '
 	)
 '
 
+test_expect_success 'read bundle over stdin' '
+	git bundle create some.bundle HEAD &&
+
+	git bundle verify - <some.bundle 2>err &&
+	grep "<stdin> is okay" err &&
+
+	git bundle list-heads some.bundle >expect &&
+	git bundle list-heads - <some.bundle >actual &&
+	test_cmp expect actual &&
+
+	git bundle unbundle some.bundle >expect &&
+	git bundle unbundle - <some.bundle >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.40.0.rc1.500.g967c04631e

