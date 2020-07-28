Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDA1C433E4
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD92520809
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgG1UYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:24:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:40208 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbgG1UYD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:24:03 -0400
Received: (qmail 29729 invoked by uid 109); 28 Jul 2020 20:24:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:24:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28528 invoked by uid 111); 28 Jul 2020 20:24:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:24:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:24:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/11] quote: rename sq_dequote_to_argv_array to mention
 strvec
Message-ID: <20200728202402.GD1021513@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to eventually drop the use of the "argv_array" name in favor of
"strvec." Unlike most other uses of the name, this one is embedded in a
function name, so the definition and all of the callers need to be
updated at the same time.

We don't technically need to update the parameter types here (our
preprocessor compat macros make the two names interchangeable), but
let's do so to keep the site consistent for now.

Signed-off-by: Jeff King <peff@peff.net>
---
 bisect.c     | 2 +-
 builtin/am.c | 2 +-
 quote.c      | 2 +-
 quote.h      | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 3160e82e96..77e35ddd43 100644
--- a/bisect.c
+++ b/bisect.c
@@ -464,7 +464,7 @@ static void read_bisect_paths(struct argv_array *array)
 
 	while (strbuf_getline_lf(&str, fp) != EOF) {
 		strbuf_trim(&str);
-		if (sq_dequote_to_argv_array(str.buf, array))
+		if (sq_dequote_to_strvec(str.buf, array))
 			die(_("Badly quoted content in file '%s': %s"),
 			    filename, str.buf);
 	}
diff --git a/builtin/am.c b/builtin/am.c
index 69e50de018..0641316e35 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -399,7 +399,7 @@ static void am_load(struct am_state *state)
 
 	read_state_file(&sb, state, "apply-opt", 1);
 	argv_array_clear(&state->git_apply_opts);
-	if (sq_dequote_to_argv_array(sb.buf, &state->git_apply_opts) < 0)
+	if (sq_dequote_to_strvec(sb.buf, &state->git_apply_opts) < 0)
 		die(_("could not parse %s"), am_path(state, "apply-opt"));
 
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
diff --git a/quote.c b/quote.c
index dac8b4e55e..10b383cc1d 100644
--- a/quote.c
+++ b/quote.c
@@ -198,7 +198,7 @@ int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc)
 	return sq_dequote_to_argv_internal(arg, argv, nr, alloc, NULL);
 }
 
-int sq_dequote_to_argv_array(char *arg, struct argv_array *array)
+int sq_dequote_to_strvec(char *arg, struct strvec *array)
 {
 	return sq_dequote_to_argv_internal(arg, NULL, NULL, NULL, array);
 }
diff --git a/quote.h b/quote.h
index 210d580229..fa09309cf6 100644
--- a/quote.h
+++ b/quote.h
@@ -56,12 +56,12 @@ char *sq_dequote(char *);
 int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc);
 
 /*
- * Same as above, but store the unquoted strings in an argv_array. We will
- * still modify arg in place, but unlike sq_dequote_to_argv, the argv_array
+ * Same as above, but store the unquoted strings in a strvec. We will
+ * still modify arg in place, but unlike sq_dequote_to_argv, the strvec
  * will duplicate and take ownership of the strings.
  */
 struct strvec;
-int sq_dequote_to_argv_array(char *arg, struct strvec *);
+int sq_dequote_to_strvec(char *arg, struct strvec *);
 
 int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
 size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_dq);
-- 
2.28.0.rc2.475.g53c7e1c7f4

