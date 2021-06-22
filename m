Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8677C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0B361026
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFVQHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:07:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:36014 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhFVQHH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 12:07:07 -0400
Received: (qmail 5807 invoked by uid 109); 22 Jun 2021 16:04:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jun 2021 16:04:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28290 invoked by uid 111); 22 Jun 2021 16:04:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jun 2021 12:04:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Jun 2021 12:04:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/5] log: avoid loading decorations for userformats that
 don't need it
Message-ID: <YNIKItEutZcytcgb@coredump.intra.peff.net>
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If no --decorate option is given, we default to auto-decoration. And
when that kicks in, cmd_log_init_finish() will unconditionally load the
decoration refs.

However, if we are using a user-format that does not include "%d" or
"%D", we won't show the decorations at all, so we don't need to load
them. We can detect this case and auto-disable them by adding a new
field to our userformat_want helper. We can do this even when the user
explicitly asked for --decorate, because it can't affect the output at
all.

This patch consistently reduces the time to run "git log -1 --format=%H"
on my git.git clone (with ~2k refs) from 34ms to 7ms. On a much more
extreme real-world repository (with ~220k refs), it goes from 2.5s to
4ms.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 3 +++
 pretty.c      | 4 ++++
 pretty.h      | 1 +
 3 files changed, 8 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 6102893fcc..6ba7f20726 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -245,6 +245,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			rev->abbrev_commit = 0;
 	}
 
+	if (rev->commit_format == CMIT_FMT_USERFORMAT && !w.decorate)
+		decoration_style = 0;
+
 	if (decoration_style) {
 		const struct string_list *config_exclude =
 			repo_config_get_value_multi(the_repository,
diff --git a/pretty.c b/pretty.c
index b1ecd039ce..9631529c10 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1735,6 +1735,10 @@ static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
 	case 'S':
 		w->source = 1;
 		break;
+	case 'd':
+	case 'D':
+		w->decorate = 1;
+		break;
 	}
 	return 0;
 }
diff --git a/pretty.h b/pretty.h
index c81cf40d38..2f16acd213 100644
--- a/pretty.h
+++ b/pretty.h
@@ -73,6 +73,7 @@ static inline int cmit_fmt_is_mail(enum cmit_fmt fmt)
 struct userformat_want {
 	unsigned notes:1;
 	unsigned source:1;
+	unsigned decorate:1;
 };
 void userformat_find_requirements(const char *fmt, struct userformat_want *w);
 
-- 
2.32.0.352.gff02c21e72

