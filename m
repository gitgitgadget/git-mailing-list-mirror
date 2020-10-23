Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A074FC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 07:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEB02177B
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 07:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375813AbgJWHpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 03:45:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:40222 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374437AbgJWHpL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 03:45:11 -0400
Received: (qmail 26712 invoked by uid 109); 23 Oct 2020 07:45:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Oct 2020 07:45:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14490 invoked by uid 111); 23 Oct 2020 07:45:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Oct 2020 03:45:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Oct 2020 03:45:10 -0400
From:   Jeff King <peff@peff.net>
To:     VenomVendor <info@venomvendor.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 4/3] am, sequencer: stop parsing our own committer ident
Message-ID: <20201023074510.GB2918369@coredump.intra.peff.net>
References: <20201023070747.GA2198273@coredump.intra.peff.net>
 <20201023070939.GB2913115@coredump.intra.peff.net>
 <20201023072630.GA2918369@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023072630.GA2918369@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 03:26:30AM -0400, Jeff King wrote:

> By the way, I wondered why we needed to do this parsing at all. The
> patch below does this in a much simpler way. It's a little bit ugly, I
> think, because we have to call getenv() ourselves. But that's the way
> fmt_ident() has always worked. We could probably improve that now that
> it takes a whose_ident flag (before that, it had no idea if we wanted
> author or committer ident).

I took a brief look at refactoring fmt_ident() to auto-fill from the
environment variables (patch below). It's mostly sensible for
name/email, because callers pass either the environment variables or
some custom-provided value. But for the date, we sometimes pass NULL to
mean "use the current time, even if $GIT_*_DATE is set". I'm not 100%
sure that isn't a bug, though.

---
 builtin/am.c |  4 +--
 ident.c      | 47 ++++++++++++++++-------------------
 sequencer.c  |  4 +--
 3 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 52206bc56b..9f0d1b4859 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1580,9 +1580,7 @@ static void do_commit(const struct am_state *state)
 			IDENT_STRICT);
 
 	if (state->committer_date_is_author_date)
-		committer = fmt_ident(getenv("GIT_COMMITTER_NAME"),
-				      getenv("GIT_COMMITTER_EMAIL"),
-				      WANT_COMMITTER_IDENT,
+		committer = fmt_ident(NULL, NULL, WANT_COMMITTER_IDENT,
 				      state->ignore_date ? NULL
 							 : state->author_date,
 				      IDENT_STRICT);
diff --git a/ident.c b/ident.c
index 6aba4b5cb6..7743c1ed05 100644
--- a/ident.c
+++ b/ident.c
@@ -384,6 +384,12 @@ const char *fmt_ident(const char *name, const char *email,
 	struct strbuf *ident = &ident_pool[index];
 	index = (index + 1) % ARRAY_SIZE(ident_pool);
 
+	if (!email) {
+		if (whose_ident == WANT_AUTHOR_IDENT)
+			email = getenv("GIT_AUTHOR_EMAIL");
+		else if (whose_ident == WANT_COMMITTER_IDENT)
+			email = getenv("GIT_COMMITTER_EMAIL");
+	}
 	if (!email) {
 		if (whose_ident == WANT_AUTHOR_IDENT && git_author_email.len)
 			email = git_author_email.buf;
@@ -405,6 +411,12 @@ const char *fmt_ident(const char *name, const char *email,
 
 	if (want_name) {
 		int using_default = 0;
+		if (!name) {
+			if (whose_ident == WANT_AUTHOR_IDENT)
+				name = getenv("GIT_AUTHOR_NAME");
+			else if (whose_ident == WANT_COMMITTER_IDENT)
+				name = getenv("GIT_COMMITTER_NAME");
+		}
 		if (!name) {
 			if (whose_ident == WANT_AUTHOR_IDENT && git_author_name.len)
 				name = git_author_name.buf;
@@ -449,6 +461,12 @@ const char *fmt_ident(const char *name, const char *email,
 		strbuf_addch(ident, '>');
 	if (want_date) {
 		strbuf_addch(ident, ' ');
+		if (!date_str) {
+			if (whose_ident == WANT_AUTHOR_IDENT)
+				date_str = getenv("GIT_AUTHOR_DATE");
+			else if (whose_ident == WANT_COMMITTER_IDENT)
+				date_str = getenv("GIT_COMMITTER_DATE");
+		}
 		if (date_str && date_str[0]) {
 			if (parse_date(date_str, ident) < 0)
 				die(_("invalid date format: %s"), date_str);
@@ -462,22 +480,7 @@ const char *fmt_ident(const char *name, const char *email,
 
 const char *fmt_name(enum want_ident whose_ident)
 {
-	char *name = NULL;
-	char *email = NULL;
-
-	switch (whose_ident) {
-	case WANT_BLANK_IDENT:
-		break;
-	case WANT_AUTHOR_IDENT:
-		name = getenv("GIT_AUTHOR_NAME");
-		email = getenv("GIT_AUTHOR_EMAIL");
-		break;
-	case WANT_COMMITTER_IDENT:
-		name = getenv("GIT_COMMITTER_NAME");
-		email = getenv("GIT_COMMITTER_EMAIL");
-		break;
-	}
-	return fmt_ident(name, email, whose_ident, NULL,
+	return fmt_ident(NULL, NULL, whose_ident, NULL,
 			IDENT_STRICT | IDENT_NO_DATE);
 }
 
@@ -487,11 +490,7 @@ const char *git_author_info(int flag)
 		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
 	if (getenv("GIT_AUTHOR_EMAIL"))
 		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
-			 getenv("GIT_AUTHOR_EMAIL"),
-			 WANT_AUTHOR_IDENT,
-			 getenv("GIT_AUTHOR_DATE"),
-			 flag);
+	return fmt_ident(NULL, NULL, WANT_AUTHOR_IDENT, NULL, flag);
 }
 
 const char *git_committer_info(int flag)
@@ -500,11 +499,7 @@ const char *git_committer_info(int flag)
 		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
 	if (getenv("GIT_COMMITTER_EMAIL"))
 		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
-			 getenv("GIT_COMMITTER_EMAIL"),
-			 WANT_COMMITTER_IDENT,
-			 getenv("GIT_COMMITTER_DATE"),
-			 flag);
+	return fmt_ident(NULL, NULL, WANT_COMMITTER_IDENT, NULL, flag);
 }
 
 static int ident_is_sufficient(int user_ident_explicitly_given)
diff --git a/sequencer.c b/sequencer.c
index 07321a7d95..6a8a5c077b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1458,9 +1458,7 @@ static int try_to_commit(struct repository *r,
 		} else {
 			reset_ident_date();
 		}
-		committer = fmt_ident(getenv("GIT_COMMITTER_NAME"),
-				      getenv("GIT_COMMITTER_EMAIL"),
-				      WANT_COMMITTER_IDENT,
+		committer = fmt_ident(NULL, NULL, WANT_COMMITTER_IDENT,
 				      opts->ignore_date ? NULL : date.buf,
 				      IDENT_STRICT);
 		strbuf_release(&date);
