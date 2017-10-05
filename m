Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F07722036B
	for <e@80x24.org>; Thu,  5 Oct 2017 08:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdJEI5b (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 04:57:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:33220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751295AbdJEI5a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 04:57:30 -0400
Received: (qmail 13920 invoked by uid 109); 5 Oct 2017 08:57:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 08:57:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25508 invoked by uid 111); 5 Oct 2017 08:57:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 04:57:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 04:57:27 -0400
Date:   Thu, 5 Oct 2017 04:57:27 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com
Subject: Re: [PATCH v2 2/5] p0008-abbrev.sh: Test find_unique_abbrev() perf
Message-ID: <20171005085727.vdbli23n62xkiuq7@sigill.intra.peff.net>
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20170925095452.66833-3-dstolee@microsoft.com>
 <20171005085553.v3eqk73aaknt5fem@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171005085553.v3eqk73aaknt5fem@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 04:55:53AM -0400, Jeff King wrote:

> On Mon, Sep 25, 2017 at 05:54:49AM -0400, Derrick Stolee wrote:
> 
> > Create helper program test-abbrev to compute the minimum length of a
> > disambiguating short-sha for an input list of object ids.
> 
> This seems like something that Git ought to be able to do via real
> commands.
> 
> Using "log --stdin --no-walk --format=%h" doesn't quite work, since it
> only handles commits. We ought to be able to ask "cat-file" for this,
> though. E.g., with the patch below you can do:
> 
>   git cat-file --batch-check='%(objectsize:short)' <input
> 
> Or even just dispense with your earlier randomization helper and do:
> 
>   git cat-file --batch-all-objects --batch-check='%(objectsize:short)'
> 
> to compute the abbreviation for every object.

Of course it would help if I bothered to include the patch. Here it is.

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f5fa4fd75a..a5f911a632 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -225,6 +225,9 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 	if (is_atom("objectname", atom, len)) {
 		if (!data->mark_query)
 			strbuf_addstr(sb, oid_to_hex(&data->oid));
+	} else if (is_atom("objectname:short", atom, len)) {
+		if (!data->mark_query)
+			strbuf_add_unique_abbrev(sb, data->oid.hash, MINIMUM_ABBREV);
 	} else if (is_atom("objecttype", atom, len)) {
 		if (data->mark_query)
 			data->info.typep = &data->type;

-Peff
