Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD081F404
	for <e@80x24.org>; Fri, 24 Aug 2018 03:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeHXGdm (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 02:33:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:54220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726956AbeHXGcd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 02:32:33 -0400
Received: (qmail 5618 invoked by uid 109); 24 Aug 2018 02:59:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Aug 2018 02:59:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23093 invoked by uid 111); 24 Aug 2018 03:00:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 Aug 2018 23:00:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2018 22:59:55 -0400
Date:   Thu, 23 Aug 2018 22:59:55 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>,
        Git mailing list <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180824025955.GA24535@sigill.intra.peff.net>
References: <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net>
 <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
 <20180823161451.GB29579@sigill.intra.peff.net>
 <CA+P7+xqbt_BVi9+1-4=ha64LW_07dJB84F0gjKd9TRE1R-Ld7A@mail.gmail.com>
 <20180823234049.GA3855@sigill.intra.peff.net>
 <20180824000637.GA10847@sigill.intra.peff.net>
 <20180824001643.GA14259@sigill.intra.peff.net>
 <CA+P7+xpm-gsjCpPOZ=2z03Peb1Jb6axKo2nTp=UUpAFgWNureg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xpm-gsjCpPOZ=2z03Peb1Jb6axKo2nTp=UUpAFgWNureg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 07:48:42PM -0700, Jacob Keller wrote:

> Odd...
> 
> What about..
> 
> - if (oidcmp(a,b))
> + if(!oideq(a,b))
>   { ... }

Nope, it doesn't like that syntactically.

> Or maybe you need to use something like
> 
>   <...
> - if (oidcmp(a,b))
> + if (!oideq(a,b))
>   ...>

Nor that (I also tried finding documentation on what exactly the angle
brackets mean, but couldn't).

> Hmm. Yea, semantic patches are a bit confusing overall sometimes.
> 
> But it looks like you got something which works?

Actually, what I showed earlier does seem to have some weirdness with
else-if. But I finally stumbled on something even better:

  - oidcmp(a, b) != 0
  + !oideq(a, b)

Because of the isomorphisms that coccinelle knows about, that catches
everything we want.  Obvious ones like:

diff --git a/bisect.c b/bisect.c
index 41c56a665e..7c1d8f1a6d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -595,7 +595,7 @@ static struct commit_list *skip_away(struct commit_list *list, int count)
 
        for (i = 0; cur; cur = cur->next, i++) {
                if (i == index) {
-                       if (oidcmp(&cur->item->object.oid, current_bad_oid))
+                       if (!oideq(&cur->item->object.oid, current_bad_oid))
                                return cur;
                        if (previous)
                                return previous;

and compound conditionals like:

diff --git a/blame.c b/blame.c
index 10d72e36dd..538d0ab1aa 100644
--- a/blame.c
+++ b/blame.c
@@ -1834,7 +1834,7 @@ void setup_scoreboard(struct blame_scoreboard *sb,

                sb->revs->children.name = "children";
                while (c->parents &&
-                      oidcmp(&c->object.oid, &sb->final->object.oid)) {
+                      !oideq(&c->object.oid, &sb->final->object.oid)) {
                        struct commit_list *l = xcalloc(1, sizeof(*l));

                        l->item = c;

and even non-if contexts, like:

diff --git a/sha1-file.c b/sha1-file.c
index 631f6b9dc2..d85f4e93e1 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -825,7 +825,7 @@ int check_object_signature(const struct object_id *oid, void *map,
 
        if (map) {
                hash_object_file(map, size, type, &real_oid);
-               return oidcmp(oid, &real_oid) ? -1 : 0;
+               return !oideq(oid, &real_oid) ? -1 : 0;
        }

So I think we have a winner. I'll polish that up into patches and send
it out later tonight.

-Peff
