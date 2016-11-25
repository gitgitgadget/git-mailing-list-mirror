Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D93D1FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 17:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932762AbcKYRWp (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 12:22:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:47211 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932973AbcKYRWb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 12:22:31 -0500
Received: (qmail 19577 invoked by uid 109); 25 Nov 2016 17:15:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Nov 2016 17:15:49 +0000
Received: (qmail 19052 invoked by uid 111); 25 Nov 2016 17:16:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Nov 2016 12:16:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Nov 2016 12:15:47 -0500
Date:   Fri, 25 Nov 2016 12:15:47 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge-recursive.c: use string_list_sort instead of
 qsort
Message-ID: <20161125171546.fa3zpapbjngjcl26@sigill.intra.peff.net>
References: <20161122123019.7169-1-pclouds@gmail.com>
 <20161124114536.22249-1-pclouds@gmail.com>
 <20161124205242.ts4qhvfz2hvxez36@sigill.intra.peff.net>
 <CACsJy8Atv9rkwmCcXgOqDb6pLP8RxQ7XnxMYt3=hN6KG4X79iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Atv9rkwmCcXgOqDb6pLP8RxQ7XnxMYt3=hN6KG4X79iA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 25, 2016 at 07:15:15PM +0700, Duy Nguyen wrote:

> > I guess I haven't used string_list_sort() in a while, but I was
> > surprised to find that it just feeds the strings to the comparator. That
> > makes sense for using a raw strcmp() as the comparator, but I wonder if
> > any callers would ever want to take the util field into account (e.g.,
> > to break ties).
> >
> > We don't seem to care here, though (which can be verified by reading the
> > code, but also because any mention of one->util would be a compilation
> > error after your patch). So I guess we can punt on it until the day that
> > some caller does need it.
> 
> Some callers do need it, or at least fmt-merge-msg.c:add_people_info()
> does, maybe builtin/remote.c:show() and shortlog.c:shortlog_output()
> too. But I'll stop here and get back to my worktree stuff.

I started to work on this, figuring it would be a nice warm-up for the
day. But it actually is a little complicated, and I think not worth
doing. :)

The obvious backwards-compatible way to do it is to add a "cmp_item"
field to the string list. Sorting should use that if non-NULL, and
fallback to the string-oriented "cmp" otherwise.

And that does work when you want to sort via string_list_sort, like:

  authors->cmp_item = cmp_string_list_util_as_integral;
  string_list_sort(authors);

(the example is from fmt-merge-message.c). But the original use of
sorting in string-list was to keep a sorted list as you go with
string_list_insert(). And in that call we have _only_ the newly added
string, and the caller has not yet had an opportunity to set the util
field. So:

  struct string_list list = STRING_LIST_INIT_DUP;
  list.cmp_item = cmp_util_fields;
  for (...)
	string_list_insert(&list, foo[i])->util = bar[i];

is nonsense. It would always see a NULL util field during the
comparison.

Certainly "don't do that" is a possible answer. But it's just a bad
interface. It encourages a nonsensical use, and it makes a natural use
(sorting after the fact) more clunky by making the caller set a field in
the struct rather than pass a parameter. The correct interface is more
like:

  string_list_sort_items(authors, cmp_string_list_util_as_integral);

but then we are not really saving much over the more generic:

  QSORT(authors->items, authors->nr, cmp_string_list_util_as_integral);

So I'm inclined to leave it as-is.

-Peff
