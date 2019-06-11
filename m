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
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE971F462
	for <e@80x24.org>; Tue, 11 Jun 2019 18:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392015AbfFKSpC (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 14:45:02 -0400
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:39386 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728412AbfFKSpB (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Jun 2019 14:45:01 -0400
Received: from resomta-ch2-18v.sys.comcast.net ([69.252.207.114])
        by resqmta-ch2-02v.sys.comcast.net with ESMTP
        id agSwhRW5hJXG7allUhNvTC; Tue, 11 Jun 2019 18:45:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1560278700;
        bh=GJUl3duHSXCFT5ZvoVc82w+AOH0XUutyJeKT4PuN8z8=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=EbiQEbatwOUUjP0gilzMH5ajd9HijzGtT+zRBlI8EUsU/fP0gQOmL0PmErEYv2CNa
         VHheqxBfVeLBoi7W4p2eQsnjwhQ1BgIRR3GZ5748EOXoO5wXNVYo3/fiRlDPYO6zWF
         sItf4nlAyA/GUlud9/3vv+RF6fQ7s8zEkdL/EdsGvVl4u2uXKleRNFTKXPxeNR3X0o
         +LhXFrF9M5Bk1Zd9Pxx/pneoKHly8IphBXmpkMpD8MhcPraUII/vaapnpzJ+NaOr/N
         TG3thajG1tiUZeo4Fgps1pmngFhk2fnA0XNa4Z/i0BOH6H9DMeO0QPE6b8i4OnSY0P
         A/fM57E3c/fuQ==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:8dc5:35e2:73b6:2c5e])
        by resomta-ch2-18v.sys.comcast.net with ESMTPSA
        id alkxh8ZWsBeEball6hRkyU; Tue, 11 Jun 2019 18:44:58 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Tue, 11 Jun 2019 11:44:27 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrn@google.com, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 6/9] list-objects-filter-options: make filter_spec a
 strbuf
Message-ID: <20190611184426.GB58112@comcast.net>
References: <20190601003603.90794-1-matvore@google.com>
 <20190601003603.90794-7-matvore@google.com>
 <xmqqimtdmc59.fsf@gitster-ct.c.googlers.com>
 <20190611003456.GB10396@comcast.net>
 <xmqqtvcwkowx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvcwkowx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 11, 2019 at 10:33:18AM -0700, Junio C Hamano wrote:
> Matthew DeVore <matvore@comcast.net> writes:
> 
> >> convention, and it may even be a useful one (i.e. it allows you to
> >> calloc() a structure with an embedded strbuf in it and the "if
> >> .buf==NULL, call strbuf_init() lazily" can become an established
> >> pattern), but at the same time it feels a bit brittle.  
> >
> > Is it brittle because a strbuf may be initialized to non-zero memory, and so
> > the "if (buf.buf == NULL)" may evaluate to false, and then go on treating
> > garbage like a valid buffer?
> 
> It is brittle because callers are bound to forget doing "if
> (!x->buf.buf) lazy_init(&x->buf)" at some point, and blindly use an
> uninitialized x->buf.  Making sure x->buf is always initialized

A corallary proposition would be to make this particular strbuf a "struct
strbuf *" rather than an inline strbuf. It should then be rather clear to users
that it may be null. Then whoever allocates the memory can also do the
strbuf_init one-liner. The free'ing logic of list_objects_filter_options then
only becomes trivially more complicated than it was before. Does that sound
like a good compromise to you?

> before any caller touches is the only way to solve it, and as you
> said, there are two possible ways to make that happen.  One way that
> does not violate the current API contract is to make sure whoever
> allocates and/or initializes the surrounding struct that embeds a
> strbuf does strbuf_init(&x->buf) before any user sees the struct.

The thing I don't like about that is that the non-zeroness of its
initialization percolates upward to whatever the top-level struct is, which
means implementation details leak a lot. This seems quite brittle as well,
since anyone can forget to initialize some struct in the nested line.

> 
> Another would be to update strbuf API so that strbuf_init() does not
> even have to use slopbuf.  But that is a much larger change that
> potentially breaks existing users of strbuf API.  When you have a
> strbuf that has been prepared to be usable, the current API contract
> allows its users to expect buf.buf is never NULL, so they assume
> that they can safely write "if (!buf.buf)", so auditing strbuf.c and
> making sure a strbuf with buf==NULL gets lazily initialized is not
> enough.

That's true. I didn't think it matters in the case of filter_spec in
particular, since users of list_objects_filter_options are supposed to use an
accessor and not touch the strbuf directly, but looking at it like a more
general API change, it seems risky.
