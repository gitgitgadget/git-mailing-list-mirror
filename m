Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01141F4BE
	for <e@80x24.org>; Fri,  4 Oct 2019 17:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbfJDR0E (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 13:26:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33654 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388146AbfJDR0D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 13:26:03 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 65A781F4BD;
        Fri,  4 Oct 2019 17:26:03 +0000 (UTC)
Date:   Fri, 4 Oct 2019 17:26:03 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 18/19] OFFSETOF_VAR macro to simplify hashmap iterators
Message-ID: <20191004172603.GA7215@dcvr>
References: <20190924010324.22619-1-e@80x24.org>
 <20190924010324.22619-19-e@80x24.org>
 <xmqqr23t8g0t.fsf@gitster-ct.c.googlers.com>
 <20191004025115.GA26605@dcvr>
 <xmqqk19l89xt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk19l89xt.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > That seems too tedious.  I'm learning towards just initializing
> > var = NULL in the start of the for-loop:
> >
> > @@ -449,7 +449,8 @@ static inline struct hashmap_entry *hashmap_iter_first(struct hashmap *map,
> >   * containing a @member which is a "struct hashmap_entry"
> >   */
> >  #define hashmap_for_each_entry(map, iter, var, member) \
> > -	for (var = hashmap_iter_first_entry_offset(map, iter, \
> > +	for (var = NULL /* squelch uninitialized warnings for OFFSETOF_VAR */, \
> > +		var = hashmap_iter_first_entry_offset(map, iter, \
> >  						OFFSETOF_VAR(var, member)); \
> 
> That looks a bit too ugly for my taste.  I've added an updated
> version (see below) and then rebased the whole thing on top of it.

I prefer to minimize the amount of stuff we do to work around
buggy compilers (in case they get fixed and old versions are
obsoleted).

If it's just clang with this problem, we know clang sets
__GNUC__, so we can use __typeof__ directly (bypassing extra
parentheses in our TYPEOF macro) to get around the warning:

#if defined(__GNUC__) /* clang sets this, too */
#define OFFSETOF_VAR(ptr, member) offsetof(__typeof__(*ptr), member)
#else /* !__GNUC__ */
...


That said, there could be other compilers which don't set
__GNUC__ and have the same problem as clang.  But maybe those
compilers are too buggy and we already ignore invalid warnings
on those compilers.
