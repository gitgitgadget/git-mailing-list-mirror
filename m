Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0351C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCCB20771
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgC3NhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:37:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:55530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728056AbgC3NhP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 09:37:15 -0400
Received: (qmail 15029 invoked by uid 109); 30 Mar 2020 13:37:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Mar 2020 13:37:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18210 invoked by uid 111); 30 Mar 2020 13:47:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2020 09:47:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Mar 2020 09:37:14 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] connected: always use partial clone optimization
Message-ID: <20200330133714.GA2410648@coredump.intra.peff.net>
References: <20200320220045.258462-1-jonathantanmy@google.com>
 <20200326211156.GA37946@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326211156.GA37946@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 02:11:56PM -0700, Emily Shaffer wrote:

> Having a look at the final structure of the loop with these gotos, I'm a
> little confused. Could be this isn't C-idiomatic but I think the code
> could be easier to read with helpers instead of gotos. I realize it's
> longer but I have a hard time understanding that your gotos are used to
> double-continue or double-break; nested loops tend to make me want to
> use helpers. But - I'm a lowly barely-reformed C++ developer, so what do
> I know ;)
> 
>   int oid_in_promisor(oid) {
>     for (p = get_all_packs(the_repository); p; p = p->next) {
>       if (!p->pack_promisor)
>         continue;
>       if (find_pack_entry_one(oid.hash, p)
>         return 1;
>     }
>   }
> 
>   int all_oids_in_promisors(oid, fn, cb_data)
>   {
>     do {
>       if (! oid_in_promisor(oid))
>         return 0;
>     } while (!fn(cb_data, &oid));
>     return 1;
>   }
> 
>   int check_connected(...)
>   {
>     ...
>     if (has_promisor_remote()) {
>       if (all_oids_in_promisors(oid, fn, cb_data))
>         return 0;
>       if (opt->shallow_file) {
>        ...
>   }

I agree the current code is a bit hard to follow, and I do like the
separation you gave here. But there's something subtle going on in the
current code with the fn() callback. It lets us iterate forward over the
list, but we can never seek back to the beginning to reset. Yet we have
multiple loops calling fn().

This works in the current code because we do something like:

  fn(&oid);
  do {
    /* check for oid in promisor packs; if not, jump to rev-list below */
  } while(!fn(&oid));

  start_command(&rev_list);
  do {
    /* feed oid to rev-list */
  } while(!fn(&oid));

The two subtle things are:

 - we keep the cursor in the same spot after breaking out of the
   promisor loop, so that we don't feed any promisor objects to rev-list

 - by using the same local object_id buffer, when we break out of the
   promisor-checking loop, our do-while will pick up where we left off,
   and not miss checking that first object

I'd worry that splitting the two loops across separate functions would
make it easier for that second thing to be forgotten. On the other hand,
maybe pulling out some of the details into loops would make the
dependency more clear (because there'd be less intervening cruft).

-Peff
