Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5DB20229
	for <e@80x24.org>; Sat, 22 Oct 2016 04:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbcJVEKZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 00:10:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:32776 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbcJVEKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 00:10:25 -0400
Received: (qmail 9995 invoked by uid 109); 22 Oct 2016 04:10:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 04:10:24 +0000
Received: (qmail 9264 invoked by uid 111); 22 Oct 2016 04:10:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 00:10:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Oct 2016 00:10:22 -0400
Date:   Sat, 22 Oct 2016 00:10:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] transport: allow summary-width to be computed
 dynamically
Message-ID: <20161022041021.cpe7pooacl6tywqd@sigill.intra.peff.net>
References: <xmqqa8dxbb9r.fsf@gitster.mtv.corp.google.com>
 <20161021223927.26364-1-gitster@pobox.com>
 <20161021223927.26364-4-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161021223927.26364-4-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 03:39:27PM -0700, Junio C Hamano wrote:

> Now we have identified three callchains that have a set of refs that
> they want to show their <old, new> object names in an aligned output,
> we can replace their reference to the constant TRANSPORT_SUMMARY_WIDTH
> with a helper function call to transport_summary_width() that takes
> the set of ref as a parameter.  This step does not yet iterate over
> the refs and compute, which is left as an exercise to the readers.

The final step could be something like this:

diff --git a/transport.c b/transport.c
index 4dac713063..c1eaa4a 100644
--- a/transport.c
+++ b/transport.c
@@ -443,7 +443,21 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 
 int transport_summary_width(const struct ref *refs)
 {
-	return (2 * FALLBACK_DEFAULT_ABBREV + 3);
+	int max_abbrev;
+
+	/*
+	 * Computing the complete set of abbreviated sha1s is expensive just to
+	 * find their lengths, but we can at least find our real dynamic
+	 * minimum by picking an arbitrary sha1.
+	 */
+	if (refs)
+		max_abbrev = strlen(find_unique_abbrev(refs->old_oid.hash,
+						       DEFAULT_ABBREV));
+	else
+		max_abbrev = FALLBACK_DEFAULT_ABBREV;
+
+	/* 2 abbreviated sha1s, plus "..." in between */
+	return (2 * max_abbrev + 3);
 }
 
 void transport_print_push_status(const char *dest, struct ref *refs,


which produces reasonable results for me. But if we really wanted the
true value, I think we'd want to compute and store the abbreviated
sha1s, and then the refactoring done by your series probably isn't the
right direction.

I think we'd instead want to replace "struct strbuf *display" passed
down to update_local_ref() with something more like:

  struct ref_status_table {
	struct ref_status_item {
		char old_hash[GIT_SHA1_HEX + 1];
		char new_hash[GIT_SHA1_HEX + 1];
		char *remote_ref;
		char *local_ref;
		char *summary;
		char code;
	} *items;
	size_t alloc, nr;
  };

and then format_display() would just add to the list (including calling
find_unique_abbrev()), and then at the end we'd call a function to show
them all.

That would also get rid of prepare_format_display(), as we could easily
walk over the prepared list before printing any of them (as opposed to
what that function does now, which is to walk over the ref map; that
requires that it know which refs are going to be printed).

-Peff
