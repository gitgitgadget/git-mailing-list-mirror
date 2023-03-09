Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E495C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 06:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCIGMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 01:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCIGMm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 01:12:42 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00ECD90E0
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:12:38 -0800 (PST)
Received: (qmail 6287 invoked by uid 109); 9 Mar 2023 06:12:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 06:12:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28343 invoked by uid 111); 9 Mar 2023 06:12:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 01:12:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 01:12:37 -0500
From:   Jeff King <peff@peff.net>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 5/5] format-patch: add format.noprefix option
Message-ID: <ZAl41V7n77ej844x@coredump.intra.peff.net>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit dropped support for diff.noprefix in format-patch.
While this will do the right thing in most cases (where sending patches
without a prefix was an accidental side effect of the sender preferring
to see their local patches without prefixes), it left no good option for
a project or workflow where you really do want to send patches without
prefixes. You'd be stuck using "--no-prefix" for every invocation.

So let's add a config option specific to format-patch that enables this
behavior. That gives people who have such a workflow a way to get what
they want, but makes it hard to accidentally trigger it.

A more backwards-compatible way of doing the transition would be to have
format.noprefix default to diff.noprefix when it's not set. But that
doesn't really help the "accidental" problem; people would have to
manually set format.noprefix=false. And it's unlikely that anybody
really wants format.noprefix=true in the first place. I'm adding it here
mostly as an escape hatch, not because anybody has expressed any
interest in it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config/format.txt |  7 +++++++
 builtin/log.c                   |  8 ++++++++
 t/t4014-format-patch.sh         | 11 +++++++++++
 3 files changed, 26 insertions(+)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 73678d88a1d..8cf6f00d936 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -144,3 +144,10 @@ will only show notes from `refs/notes/bar`.
 format.mboxrd::
 	A boolean value which enables the robust "mboxrd" format when
 	`--stdout` is in use to escape "^>+From " lines.
+
+format.noprefix::
+	If set, do not show any source or destination prefix in patches.
+	This is equivalent to the `diff.noprefix` option used by `git
+	diff` (but which is not respected by `format-patch`). Note that
+	by setting this, the receiver of any patches you generate will
+	have to apply them using the `-p0` option.
diff --git a/builtin/log.c b/builtin/log.c
index eaf511aab86..b1f59062f40 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -56,6 +56,7 @@ static int stdout_mboxrd;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX_DEFAULT;
 static const char *fmt_pretty;
+static int format_no_prefix;
 
 static const char * const builtin_log_usage[] = {
 	N_("git log [<options>] [<revision-range>] [[--] <path>...]"),
@@ -1084,6 +1085,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		stdout_mboxrd = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "format.noprefix")) {
+		format_no_prefix = 1;
+		return 0;
+	}
 
 	/*
 	 * ignore some porcelain config which would otherwise be parsed by
@@ -2002,6 +2007,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	s_r_opt.def = "HEAD";
 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
 
+	if (format_no_prefix)
+		diff_set_noprefix(&rev.diffopt);
+
 	if (default_attach) {
 		rev.mime_boundary = default_attach;
 		rev.no_inline = 1;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f5a41fd47ed..2711fd09ca0 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2391,4 +2391,15 @@ test_expect_success 'format-patch does not respect diff.noprefix' '
 	grep "^--- a/blorp" actual
 '
 
+test_expect_success 'format-patch respects format.noprefix' '
+	git -c format.noprefix format-patch -1 --stdout >actual &&
+	grep "^--- blorp" actual
+'
+
+test_expect_success 'format-patch --default-prefix overrides format.noprefix' '
+	git -c format.noprefix \
+		format-patch -1 --default-prefix --stdout >actual &&
+	grep "^--- a/blorp" actual
+'
+
 test_done
-- 
2.40.0.rc2.537.g928a61c97db
