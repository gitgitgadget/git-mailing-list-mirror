Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0341F462
	for <e@80x24.org>; Wed, 12 Jun 2019 00:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404185AbfFLAhq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 20:37:46 -0400
Received: from resqmta-po-03v.sys.comcast.net ([96.114.154.162]:54750 "EHLO
        resqmta-po-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391217AbfFLAhq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Jun 2019 20:37:46 -0400
Received: from resomta-po-10v.sys.comcast.net ([96.114.154.234])
        by resqmta-po-03v.sys.comcast.net with ESMTP
        id ar3yhWM4OJWz7arGrhrZxw; Wed, 12 Jun 2019 00:37:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1560299865;
        bh=xREF0E7AwrZWGz4jOoUOmMmC5fcXm5rXfTgnsYPzL3I=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=GDlYP1Tcq4TcOU95Noh33AB0LBuG+7VAnGFR4y+bYM6GJLyaov+3uo+I0mqzfCv4T
         33glHFFaNHjMKifh0SgFWZndch99yX1yrZ1MAE+NN8VOQeAEw8tTmElW3Q5ouXoGL2
         SgQxv2lHuBn/EU5qMZFI03DQrdJxF0IzBuyH7BmwQ0qUAxaOWFYfA0bN6Mlh96c0jX
         kZX5wliv7K01oP96K4B+4MIrfDoi8pQLAHHh7PqQcnAUMn5+PcUj1A6P7I3fe+Oe9z
         fdPIiDVuz1x02T48FE14dYu9bLpMjWrSLfY3sv783xCAVSuohTgPkAR/6/yBvUClVs
         wOsd9LOXrQJCw==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:8dc5:35e2:73b6:2c5e])
        by resomta-po-10v.sys.comcast.net with ESMTPSA
        id arGOhVFFXOGz5arGSh1sEi; Wed, 12 Jun 2019 00:37:43 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Tue, 11 Jun 2019 17:37:16 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrn@google.com, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 6/9] list-objects-filter-options: make filter_spec a
 strbuf
Message-ID: <20190612003716.GD58112@comcast.net>
References: <20190601003603.90794-1-matvore@google.com>
 <20190601003603.90794-7-matvore@google.com>
 <xmqqimtdmc59.fsf@gitster-ct.c.googlers.com>
 <20190611003456.GB10396@comcast.net>
 <xmqqtvcwkowx.fsf@gitster-ct.c.googlers.com>
 <20190611184426.GB58112@comcast.net>
 <xmqqmuinkd30.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmuinkd30.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 11, 2019 at 02:48:51PM -0700, Junio C Hamano wrote:
> Matthew DeVore <matvore@comcast.net> writes:
> 
> >> It is brittle because callers are bound to forget doing "if
> >> (!x->buf.buf) lazy_init(&x->buf)" at some point, and blindly use an
> >> uninitialized x->buf.  Making sure x->buf is always initialized
> >
> > A corallary proposition would be to make this particular strbuf a "struct
> > strbuf *" rather than an inline strbuf. It should then be rather clear to users
> > that it may be null.
> 
> Would make it less likely for uses of an uninitialized strbuf to be
> left undetected as errors?  I guess so, and if that is the case it
> would definitely be an improvement.
> 
> But initializing the strbuf at the point where the enclosing
> structure is initialized (or calloc()'ed) is also a vaiable option,
> and between the two, I think that would be even more robust.
> 
> There may be reasons why it is cumbersome to arrange it that way,
> though (e.g. if the code does not introduce a "new_stuff()"
> allocator that also initializes, and instead uses xcalloc() from
> many places, initializing the enclosing structure properly might
> take a preliminary clean-up step before the main part of the patch
> series can begin).

These are all the locations where a struct which ultimately contains a
list_objects_filter_options is instantiated:

GLOBAL VARIABLES:

builtin/clone.c:68:static struct list_objects_filter_options filter_options;
builtin/fetch.c:66:static struct list_objects_filter_options filter_options;
builtin/pack-objects.c:112:static struct list_objects_filter_options filter_options;
builtin/rev-list.c:65:static struct list_objects_filter_options filter_options;

LOCAL VARIABLES:

builtin/fetch-pack.c:54:        struct fetch_pack_args args;
transport.c:327:        struct fetch_pack_args args;

HEAP ALLOCATIONS:

transport-helper.c:1123:	struct helper_data *data = xcalloc(1, sizeof(*data));
transport.c:964:                struct git_transport_data *data = xcalloc(1, sizeof(*data));

git_transport_options is also not directly instantiated as a local or static
variable, but it would need to have a git_transport_options_init function
defined.

I didn't count exactly the number of _INIT macros and _init functions that
would need to be defined. It seems like a lot of work. It is hard to believe
that our ability to exhaustively pinpoint all these instantiations, and to
catch ALL future instantiations, is all that reliable. I think our ability to
find the places we need to lazily instantiate the strbuf-containing-struct
(struct filter_spec in the interdiff) is more reliable.
