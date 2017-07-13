Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD88B202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbdGMPCr (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:02:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:39116 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751200AbdGMPCq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:02:46 -0400
Received: (qmail 24163 invoked by uid 109); 13 Jul 2017 15:02:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:02:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32141 invoked by uid 111); 13 Jul 2017 15:02:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:02:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:02:44 -0400
Date:   Thu, 13 Jul 2017 11:02:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/15] ref-filter: provide a function for parsing sort options
Message-ID: <20170713150244.ygpefrbaz53rl6e6@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref-filter module currently provides a callback suitable
for parsing command-line --sort options. But since git-tag
also supports the tag.sort config option, it needs a
function whose implementation is quite similar, but with a
slightly different interface. The end result is that
builtin/tag.c has a copy-paste of parse_opt_ref_sorting().

Instead, let's provide a function to parse an arbitrary
sort string, which we can then trivially wrap to make the
parse_opt variant.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c | 26 +-------------------------
 ref-filter.c  | 13 ++++++++-----
 ref-filter.h  |  2 ++
 3 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 207c9eb03..66e35b823 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -136,30 +136,6 @@ static const char tag_template_nocleanup[] =
 	"Lines starting with '%c' will be kept; you may remove them"
 	" yourself if you want to.\n");
 
-/* Parse arg given and add it the ref_sorting array */
-static int parse_sorting_string(const char *arg, struct ref_sorting **sorting_tail)
-{
-	struct ref_sorting *s;
-	int len;
-
-	s = xcalloc(1, sizeof(*s));
-	s->next = *sorting_tail;
-	*sorting_tail = s;
-
-	if (*arg == '-') {
-		s->reverse = 1;
-		arg++;
-	}
-	if (skip_prefix(arg, "version:", &arg) ||
-	    skip_prefix(arg, "v:", &arg))
-		s->version = 1;
-
-	len = strlen(arg);
-	s->atom = parse_ref_filter_atom(arg, arg+len);
-
-	return 0;
-}
-
 static int git_tag_config(const char *var, const char *value, void *cb)
 {
 	int status;
@@ -168,7 +144,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "tag.sort")) {
 		if (!value)
 			return config_error_nonbool(var);
-		parse_sorting_string(value, sorting_tail);
+		parse_ref_sorting(sorting_tail, value);
 		return 0;
 	}
 
diff --git a/ref-filter.c b/ref-filter.c
index 178396e1f..432121219 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2126,15 +2126,11 @@ struct ref_sorting *ref_default_sorting(void)
 	return sorting;
 }
 
-int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
+void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg)
 {
-	struct ref_sorting **sorting_tail = opt->value;
 	struct ref_sorting *s;
 	int len;
 
-	if (!arg) /* should --no-sort void the list ? */
-		return -1;
-
 	s = xcalloc(1, sizeof(*s));
 	s->next = *sorting_tail;
 	*sorting_tail = s;
@@ -2148,6 +2144,13 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 		s->version = 1;
 	len = strlen(arg);
 	s->atom = parse_ref_filter_atom(arg, arg+len);
+}
+
+int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
+{
+	if (!arg) /* should --no-sort void the list ? */
+		return -1;
+	parse_ref_sorting(opt->value, arg);
 	return 0;
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 9e1e89c19..67fa6261b 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -116,6 +116,8 @@ void format_ref_array_item(struct ref_array_item *info,
 			   struct strbuf *final_buf);
 /*  Print the ref using the given format and quote_style */
 void show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
+/*  Parse a single sort specifier and add it to the list */
+void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *atom);
 /*  Callback function for parsing the sort option */
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
-- 
2.13.2.1157.gc6daca446

