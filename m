Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E007D1F97E
	for <e@80x24.org>; Thu, 23 Aug 2018 00:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbeHWERC (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:17:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:52546 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725729AbeHWERC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:17:02 -0400
Received: (qmail 12142 invoked by uid 109); 23 Aug 2018 00:49:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 00:49:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6304 invoked by uid 111); 23 Aug 2018 00:50:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 20:50:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 20:49:56 -0400
Date:   Wed, 22 Aug 2018 20:49:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 5/9] interpret-trailers: allow suppressing "---" divider
Message-ID: <20180823004955.GE3126@sigill.intra.peff.net>
References: <20180823004300.GA1355@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823004300.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even with the newly-tightened "---" parser, it's still
possible for a commit message to trigger a false positive if
it contains something like "--- foo". If the caller knows
that it has only a single commit message, it can now tell us
with the "--no-divider" option, eliminating any false
positives.

If we were designing this from scratch, I'd probably make
this the default. But we've advertised the "---" behavior in
the documentation since interpret-trailers has existed.
Since it's meant to be scripted, breaking that would be a
bad idea.

Note that the logic is in the underlying trailer.c code,
which is used elsewhere. The default there will keep the
current behavior, but many callers will benefit from setting
this new option. That's left for future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-interpret-trailers.txt |  7 ++++++-
 builtin/interpret-trailers.c             |  1 +
 t/t7513-interpret-trailers.sh            | 20 ++++++++++++++++++++
 trailer.c                                |  6 +++++-
 trailer.h                                |  1 +
 5 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 7385bfdb45..a5e8b36f62 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -58,7 +58,7 @@ The group must be preceded by one or more empty (or whitespace-only) lines.
 The group must either be at the end of the message or be the last
 non-whitespace lines before a line that starts with '---' (followed by a
 space or the end of the line). Such three minus signs start the patch
-part of the message.
+part of the message. See also `--no-divider` below.
 
 When reading trailers, there can be whitespaces after the
 token, the separator and the value. There can also be whitespaces
@@ -126,6 +126,11 @@ OPTIONS
 	A convenience alias for `--only-trailers --only-input
 	--unfold`.
 
+--no-divider::
+	Do not treat `---` as the end of the commit message. Use this
+	when you know your input contains just the commit message itself
+	(and not an email or the output of `git format-patch`).
+
 CONFIGURATION VARIABLES
 -----------------------
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index b742539d4d..4b87e0dd2e 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -104,6 +104,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "unfold", &opts.unfold, N_("join whitespace-continued values")),
 		{ OPTION_CALLBACK, 0, "parse", &opts, NULL, N_("set parsing options"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse },
+		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat --- specially")),
 		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add"), option_parse_trailer),
 		OPT_END()
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index e13b40b43f..c441861331 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1439,4 +1439,24 @@ test_expect_success 'handling of --- lines in input' '
 	test_cmp expected actual
 '
 
+test_expect_success 'suppress --- handling' '
+	echo "real-trailer: just right" >expected &&
+
+	git interpret-trailers --parse --no-divider >actual <<-\EOF &&
+	subject
+
+	This commit message has a "---" in it, but because we tell
+	interpret-trailers not to respect that, it has no effect.
+
+	not-a-trailer: too soon
+	---
+
+	This is still the commit message body.
+
+	real-trailer: just right
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
diff --git a/trailer.c b/trailer.c
index 8392c6c030..0796f326b3 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1080,7 +1080,11 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 
 	ensure_configured();
 
-	patch_start = find_patch_start(str);
+	if (opts->no_divider)
+		patch_start = strlen(str);
+	else
+		patch_start = find_patch_start(str);
+
 	trailer_end = find_trailer_end(str, patch_start);
 	trailer_start = find_trailer_start(str, trailer_end);
 
diff --git a/trailer.h b/trailer.h
index b38c8f0d16..b997739649 100644
--- a/trailer.h
+++ b/trailer.h
@@ -71,6 +71,7 @@ struct process_trailer_options {
 	int only_trailers;
 	int only_input;
 	int unfold;
+	int no_divider;
 };
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
-- 
2.19.0.rc0.412.g7005db4e88

