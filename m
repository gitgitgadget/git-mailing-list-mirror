Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A072C64EC4
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 10:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCDK2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 05:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCDK17 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 05:27:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58907422B
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 02:27:58 -0800 (PST)
Received: (qmail 16806 invoked by uid 109); 4 Mar 2023 10:27:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Mar 2023 10:27:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3729 invoked by uid 111); 4 Mar 2023 10:27:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Mar 2023 05:27:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Mar 2023 05:27:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: [PATCH 3/5] bundle: don't blindly apply prefix_filename() to "-"
Message-ID: <ZAMdLKmQaWR3neVl@coredump.intra.peff.net>
References: <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

A user can specify a filename to a command from the command line,
either as the value given to a command line option, or a command
line argument.  When it is given as a relative filename, in the
user's mind, it is relative to the directory "git" was started from,
but by the time the filename is used, "git" would almost always have
chdir()'ed up to the root level of the working tree.

The given filename, if it is relative, needs to be prefixed with the
path to the current directory, and it typically is done by calling
prefix_filename() helper function.  For commands that can also take
"-" to use the standard input or the standard output, however, this
needs to be done with care.

"git bundle create" uses the next word on the command line as the
output filename, and can take "-" to mean "write to the standard
output".  It blindly called prefix_filename(), so running it in a
subdirectory did not quite work as expected.

Introduce a new helper, prefix_filename_except_for_dash(), and use
it to help "git bundle create" codepath.

Reported-by: Michael Henry
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I didn't modify the commit message. I guess we could mention that it
works for files that read, too (but that we didn't bother to test every
command).

 abspath.c              |  7 +++++++
 builtin/bundle.c       |  2 +-
 cache.h                |  3 +++
 t/t6020-bundle-misc.sh | 11 +++++++++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/abspath.c b/abspath.c
index 39e06b58486..9a81c5525be 100644
--- a/abspath.c
+++ b/abspath.c
@@ -280,3 +280,10 @@ char *prefix_filename(const char *pfx, const char *arg)
 #endif
 	return strbuf_detach(&path, NULL);
 }
+
+char *prefix_filename_except_for_dash(const char *pfx, const char *arg)
+{
+	if (!strcmp(arg, "-"))
+		return xstrdup(arg);
+	return prefix_filename(pfx, arg);
+}
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 02dab1cfa02..eca39b64bf9 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -59,7 +59,7 @@ static int parse_options_cmd_bundle(int argc,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	if (!argc)
 		usage_msg_opt(_("need a <file> argument"), usagestr, options);
-	*bundle_file = prefix_filename(prefix, argv[0]);
+	*bundle_file = prefix_filename_except_for_dash(prefix, argv[0]);
 	return argc;
 }
 
diff --git a/cache.h b/cache.h
index 12789903e88..38867de41af 100644
--- a/cache.h
+++ b/cache.h
@@ -638,6 +638,9 @@ char *prefix_path_gently(const char *prefix, int len, int *remaining, const char
  */
 char *prefix_filename(const char *prefix, const char *path);
 
+/* Likewise, but path=="-" always yields "-" */
+char *prefix_filename_except_for_dash(const char *prefix, const char *path);
+
 int check_filename(const char *prefix, const char *name);
 void verify_filename(const char *prefix,
 		     const char *name,
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 45d93588c91..6a5877a09ef 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -621,4 +621,15 @@ test_expect_success 'read bundle over stdin' '
 	test_cmp expect actual
 '
 
+test_expect_success 'send a bundle to standard output' '
+	git bundle create - --all HEAD >bundle-one &&
+	mkdir -p down &&
+	git -C down bundle create - --all HEAD >bundle-two &&
+	git bundle verify bundle-one &&
+	git bundle verify bundle-two &&
+	git ls-remote bundle-one >expect &&
+	git ls-remote bundle-two >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.40.0.rc1.500.g967c04631e

