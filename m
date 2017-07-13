Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35EC202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbdGMPCe (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:02:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:39110 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751200AbdGMPCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:02:33 -0400
Received: (qmail 24157 invoked by uid 109); 13 Jul 2017 15:02:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:02:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32125 invoked by uid 111); 13 Jul 2017 15:02:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:02:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:02:30 -0400
Date:   Thu, 13 Jul 2017 11:02:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/15] ref-filter: move need_color_reset_at_eol into
 ref_format
Message-ID: <20170713150230.sy7zuksbgjcrllxh@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calling verify_ref_format() doesn't just confirm that the
format is sane; it actually sets some global variables that
will be used later when formatting the refs. These logically
should belong to the ref_format, which would make it
possible to use multiple formats within a single program
invocation.

Let's move one such flag into the ref_format struct. There
are still others that would need to be moved before it would
be safe to use multiple formats, but this commit gives a
blueprint for how that should look.

Signed-off-by: Jeff King <peff@peff.net>
---
This commit is strictly optional for this series, but I wanted to give a
sense of how the rest of the movement might look, since I was thinking
about it. The big thing to move would be the used_atoms array, but I
punted on that for now.

 ref-filter.c | 7 +++----
 ref-filter.h | 3 +++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 66d234bb1..178396e1f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -97,7 +97,6 @@ static struct used_atom {
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
-static int need_color_reset_at_eol;
 
 static void color_atom_parser(struct used_atom *atom, const char *color_value)
 {
@@ -661,7 +660,7 @@ int verify_ref_format(struct ref_format *format)
 {
 	const char *cp, *sp;
 
-	need_color_reset_at_eol = 0;
+	format->need_color_reset_at_eol = 0;
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
 		const char *color, *ep = strchr(sp, ')');
 		int at;
@@ -673,7 +672,7 @@ int verify_ref_format(struct ref_format *format)
 		cp = ep + 1;
 
 		if (skip_prefix(used_atom[at].name, "color:", &color))
-			need_color_reset_at_eol = !!strcmp(color, "reset");
+			format->need_color_reset_at_eol = !!strcmp(color, "reset");
 	}
 	return 0;
 }
@@ -2083,7 +2082,7 @@ void format_ref_array_item(struct ref_array_item *info,
 		sp = cp + strlen(cp);
 		append_literal(cp, sp, &state);
 	}
-	if (need_color_reset_at_eol) {
+	if (format->need_color_reset_at_eol) {
 		struct atom_value resetv;
 		resetv.s = GIT_COLOR_RESET;
 		append_atom(&resetv, &state);
diff --git a/ref-filter.h b/ref-filter.h
index 2bb58879d..9e1e89c19 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -79,6 +79,9 @@ struct ref_format {
 	 */
 	const char *format;
 	int quote_style;
+
+	/* Internal state to ref-filter */
+	int need_color_reset_at_eol;
 };
 
 #define REF_FORMAT_INIT { NULL, 0 }
-- 
2.13.2.1157.gc6daca446

