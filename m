Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958861F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 22:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdAaWgJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 17:36:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:47544 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750873AbdAaWgI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 17:36:08 -0500
Received: (qmail 1396 invoked by uid 109); 31 Jan 2017 22:36:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Jan 2017 22:36:08 +0000
Received: (qmail 6098 invoked by uid 111); 31 Jan 2017 22:36:10 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Jan 2017 17:36:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2017 23:36:04 +0100
Date:   Tue, 31 Jan 2017 23:36:04 +0100
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] add SWAP macro
Message-ID: <20170131223604.oa4h5ykhefvlergd@sigill.intra.peff.net>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301643260.3469@virtualbox>
 <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
 <alpine.DEB.2.20.1701302158110.3469@virtualbox>
 <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
 <20170130222157.GC35626@google.com>
 <8e94756a-c3a5-9b81-268d-d0f36876f710@web.de>
 <20170131213507.uiwmkkcg7umvd3f4@sigill.intra.peff.net>
 <xmqqy3xqq2w0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3xqq2w0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2017 at 02:29:51PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... I wonder if it would be more natural for it to take
> > pointers-to-objects, making it look more like a real function (i.e.,
> > SWAP(&a, &b) instead of SWAP(a, b)". And then these funny corner cases
> > become quite obvious in the caller, because the caller is the one who
> > has to type "&".
> 
> Hmmmm.  
> 
> While this looks very attractive in theory by forcing 'a' and 'b' to
> be lvalues, it probably invites mistakes go unnoticed during the
> review when the code wants to swap two pointer variables.  
> 
> For example,
> 
> apply.c:            SWAP(p->new_name, p->old_name);
> 
> is now a bug and will swap only the first byte of these names, and
> the correct way to spell it would become:
> 
> apply.c:            SWAP(&p->new_name, &p->old_name);
> 
> The latter clearly looks like swapping the new and old names, which
> is good, but I do not have any confidence that I will immediately
> spot a bug when presented the former under the new world order.

Yes, it's a problem with any function (or function-like interface) that
takes an untyped pointer. You don't know if the caller meant the pointer
or the pointer-to-pointer. In that sense it's no different than:

  memcpy(p->new_name, p->old_name, len);

Is that right, or did we mean to copy the pointers themselves?

It does also help the reverse case:

  int a, b;
  SWAP(a, b);

which would give an error (you forgot the "&"). I don't know which is
more likely to be productive. But at least requiring pointer values
makes it consistent with other functions like memcpy, etc.

-Peff
