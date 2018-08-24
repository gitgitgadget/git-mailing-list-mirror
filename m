Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5491F404
	for <e@80x24.org>; Fri, 24 Aug 2018 00:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeHXDin (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 23:38:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:54092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726085AbeHXDim (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 23:38:42 -0400
Received: (qmail 31689 invoked by uid 109); 24 Aug 2018 00:06:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Aug 2018 00:06:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22349 invoked by uid 111); 24 Aug 2018 00:06:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 Aug 2018 20:06:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2018 20:06:37 -0400
Date:   Thu, 23 Aug 2018 20:06:37 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, paul@mad-scientist.net,
        Git mailing list <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180824000637.GA10847@sigill.intra.peff.net>
References: <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net>
 <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
 <20180823161451.GB29579@sigill.intra.peff.net>
 <CA+P7+xqbt_BVi9+1-4=ha64LW_07dJB84F0gjKd9TRE1R-Ld7A@mail.gmail.com>
 <20180823234049.GA3855@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823234049.GA3855@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 07:40:49PM -0400, Jeff King wrote:

> > You can look for explicitly "if (oidcmp(...))" though. I don't know if
> > you can catch *any* use which degrades to boolean outside of an if
> > statement, but I wouldn't expect there to be too many of those?
> 
> Yeah, that was my thought, too. And I've been trying this all afternoon
> without success. Why doesn't this work:
> 
>   @@
>   expression a, b;
>   @@
>   - if (oidcmp(a, b))
>   + if (!oideq(a, b))
> 
> I get:
> 
>   Fatal error: exception Failure("minus: parse error: \n = File
>   \"contrib/coccinelle/oideq.cocci\", line 21, column 0,  charpos =
>   221\n    around = '', whole content = \n")
> 
> If I do:
> 
>   - if (oidcmp(a, b)) { ... }
> 
> that seems to please the parser for the minus line. But I cannot include
> the "..." on the plus line. Clearly the "..." part should be context,
> but I can't seem to find the right syntax.

This almost works:

  @@
  expression a, b;
  statement s;
  @@
  - if (oidcmp(a, b)) s
  + if (!oideq(a, b)) s

It generates this, for example:

diff -u -p a/bisect.c b/bisect.c
--- a/bisect.c
+++ b/bisect.c
@@ -595,7 +595,7 @@ static struct commit_list *skip_away(str
 
 	for (i = 0; cur; cur = cur->next, i++) {
 		if (i == index) {
-			if (oidcmp(&cur->item->object.oid, current_bad_oid))
+			if (!oideq(&cur->item->object.oid, current_bad_oid))
 				return cur;
 			if (previous)
 				return previous;

which is what we want. But it also generates this:

diff -u -p a/bundle.c b/bundle.c
--- a/bundle.c
+++ b/bundle.c
@@ -369,25 +369,11 @@ static int write_bundle_refs(int bundle_
 		 * commit that is referenced by the tag, and not the tag
 		 * itself.
 		 */
-		if (oidcmp(&oid, &e->item->oid)) {
-			/*
-			 * Is this the positive end of a range expressed
-			 * in terms of a tag (e.g. v2.0 from the range
-			 * "v1.0..v2.0")?
-			 */
-			struct commit *one = lookup_commit_reference(the_repository,
-								     &oid);
+		if (!oideq(&oid, &e->item->oid)) {
+			struct commit *one=lookup_commit_reference(the_repository,
+								   &oid);
 			struct object *obj;
-
 			if (e->item == &(one->object)) {
-				/*
-				 * Need to include e->name as an
-				 * independent ref to the pack-objects
-				 * input, so that the tag is included
-				 * in the output; otherwise we would
-				 * end up triggering "empty bundle"
-				 * error.
-				 */
 				obj = parse_object_or_die(&oid, e->name);
 				obj->flags |= SHOWN;
 				add_pending_object(revs, obj, e->name);

So I really do want some way of saying "all of the block, no matter what
it is". Or of leaving it out as context.

-Peff
