Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3E4C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FBF218AC
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIITNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:13:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:52520 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIITNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 15:13:47 -0400
Received: (qmail 6957 invoked by uid 109); 9 Sep 2020 19:13:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Sep 2020 19:13:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4753 invoked by uid 111); 9 Sep 2020 19:13:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Sep 2020 15:13:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Sep 2020 15:13:45 -0400
From:   Jeff King <peff@peff.net>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        whydoubt@gmail.com, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
Message-ID: <20200909191345.GA2511547@coredump.intra.peff.net>
References: <20200907171639.766547-1-eantoranz@gmail.com>
 <ce94b41f-e829-d7ca-a5f5-e41748caea81@gmail.com>
 <20200909091149.GB2496536@coredump.intra.peff.net>
 <CAOc6etZS3mGxsPPh25XFi2-qR0TNzq0Gx1NrydgQwmHbsjxejA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOc6etZS3mGxsPPh25XFi2-qR0TNzq0Gx1NrydgQwmHbsjxejA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 09, 2020 at 08:00:57AM -0600, Edmundo Carmona Antoranz wrote:

> On Wed, Sep 9, 2020 at 3:11 AM Jeff King <peff@peff.net> wrote:
> >
> > Yeah, it looks obviously correct. I am puzzled why "make coccicheck"
> > doesn't find this, though. +cc René, as my favorite target for
> > coccinelle nerd-snipes. :)
> >
> 
> I added this to contrib/coccinelle/object_id.cocci in v2.27.0
> 
> @@
> identifier f != oideq;
> expression E1, E2;
> @@
> - !oidcmp(E1, E2)
> + oideq(E1, E2)
> 
> And it found it:

Interesting. The existing rule is:

  struct object_id *OIDPTR1;
  struct object_id *OIDPTR2;
  @@
  - oidcmp(OIDPTR1, OIDPTR2) == 0
  + oideq(OIDPTR1, OIDPTR2)

The "== 0" part looks like it might be significant, but it's not.
Coccinelle knows that "!foo" is the same as "foo == 0" (and you can
confirm by tweaking it).

The addition of "identifer f != oideq" here isn't necessary (we don't
even define an "f" in the semantic patch part). And anyway, we use
hasheq() inside oideq(), so no need to override the rule there.

So the relevant part is probably that our existing rule specifies the
exact type, whereas your rule allows any expression.

And indeed, if I do this, it works:

diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index ddf4f22bd7..62a6cee0eb 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -55,8 +55,8 @@ struct object_id OID;
 + oidcmp(&OID, OIDPTR)
 
 @@
-struct object_id *OIDPTR1;
-struct object_id *OIDPTR2;
+expression OIDPTR1;
+expression OIDPTR2;
 @@
 - oidcmp(OIDPTR1, OIDPTR2) == 0
 + oideq(OIDPTR1, OIDPTR2)

Which really _seems_ like a bug in coccinelle, unless I am missing
something. Because both of those parameters look like object_id pointers
(and the compiler would be complaining if it were not the case).  But I
also wonder if giving the specific types in the coccinelle rule is
buying us anything. If you passed two void pointers or ints or whatever
to !oidcmp(), we'd still want to rewrite it as oideq().

-Peff
