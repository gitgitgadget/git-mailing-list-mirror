Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD0B202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbdGMPDB (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:03:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:39132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751200AbdGMPDB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:03:01 -0400
Received: (qmail 24177 invoked by uid 109); 13 Jul 2017 15:03:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:03:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32207 invoked by uid 111); 13 Jul 2017 15:03:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:03:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:02:58 -0400
Date:   Thu, 13 Jul 2017 11:02:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/15] ref-filter: factor out the parsing of sorting atoms
Message-ID: <20170713150258.i62ohcembl2wfrqm@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We parse sort strings as single formatting atoms, and just
build on parse_ref_filter_atom(). Let's pull this idea into
its own function, since it's about to get a little more
complex. As a bonus, we can give the function a slightly
more natural interface, since our single atoms are in their
own strings.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ee97d7218..080f5aceb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2114,6 +2114,12 @@ void pretty_print_ref(const char *name, const unsigned char *sha1,
 	free_array_item(ref_item);
 }
 
+static int parse_sorting_atom(const char *atom)
+{
+	const char *end = atom + strlen(atom);
+	return parse_ref_filter_atom(atom, end);
+}
+
 /*  If no sorting option is given, use refname to sort as default */
 struct ref_sorting *ref_default_sorting(void)
 {
@@ -2122,14 +2128,13 @@ struct ref_sorting *ref_default_sorting(void)
 	struct ref_sorting *sorting = xcalloc(1, sizeof(*sorting));
 
 	sorting->next = NULL;
-	sorting->atom = parse_ref_filter_atom(cstr_name, cstr_name + strlen(cstr_name));
+	sorting->atom = parse_sorting_atom(cstr_name);
 	return sorting;
 }
 
 void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg)
 {
 	struct ref_sorting *s;
-	int len;
 
 	s = xcalloc(1, sizeof(*s));
 	s->next = *sorting_tail;
@@ -2142,8 +2147,7 @@ void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg)
 	if (skip_prefix(arg, "version:", &arg) ||
 	    skip_prefix(arg, "v:", &arg))
 		s->version = 1;
-	len = strlen(arg);
-	s->atom = parse_ref_filter_atom(arg, arg+len);
+	s->atom = parse_sorting_atom(arg);
 }
 
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
-- 
2.13.2.1157.gc6daca446

