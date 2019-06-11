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
	by dcvr.yhbt.net (Postfix) with ESMTP id A7A741F462
	for <e@80x24.org>; Tue, 11 Jun 2019 00:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfFKAf2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 20:35:28 -0400
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:58676 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728645AbfFKAf2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jun 2019 20:35:28 -0400
Received: from resomta-ch2-10v.sys.comcast.net ([69.252.207.106])
        by resqmta-ch2-03v.sys.comcast.net with ESMTP
        id aTgUhME0nGd4oaUl5hdwFn; Tue, 11 Jun 2019 00:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1560213328;
        bh=aXWlmEU3ux9UzWsIQiKR5qJ8Q1RyDjdMIwRDVap0cX0=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=urpmIAoexKssYFHQQCnJX6JA9zboxHymxiRnnPwlNJW1wL122EXMpTDNCzXeQcm+S
         YBz1j57abkvSXB/NEA2khUpuA1BPqEUwAXRnD3Xh6rT13e0+p5nY0lJeZ0kxaj/L9X
         qdQtzNRDg1I5wSq3YH0TC/rqOsyZgEs/Gqa7n7UyeC0EQpPX6Mp+lDlmJXvT2Xxsi+
         JSrGf5F4LdaxqPa9dhQrGl6NW3/kYkkuLSeeQLn/4HZH99GVcfb5DOf8SMCuxq1TRQ
         DWeKV31jx7Kp8bVTtqDhD3VfYcDoVyawmcnrYATCk1rEc743rEeHQA0LpPVERct8Yd
         sPlGHru+zKKlg==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:f026:8f18:533c:4f74])
        by resomta-ch2-10v.sys.comcast.net with ESMTPSA
        id aUkahU4DLtJ9IaUkghLDfN; Tue, 11 Jun 2019 00:35:25 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Mon, 10 Jun 2019 17:34:56 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrn@google.com, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 6/9] list-objects-filter-options: make filter_spec a
 strbuf
Message-ID: <20190611003456.GB10396@comcast.net>
References: <20190601003603.90794-1-matvore@google.com>
 <20190601003603.90794-7-matvore@google.com>
 <xmqqimtdmc59.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimtdmc59.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 10, 2019 at 01:13:54PM -0700, Junio C Hamano wrote:
> Matthew DeVore <matvore@google.com> writes:
> 
> > -	filter_options->filter_spec = strdup(core_partial_clone_filter_default);
> > +	if (!filter_options->filter_spec.buf)
> > +		strbuf_init(&filter_options->filter_spec, 0);
> 
> This part made me go "Huh?" a bit.
> 
> Do we document that .buf==NULL means an uninitialized strbuf that is
> safe to run strbuf_init() on?  I do not mind that as a general

Kind of. The first bullet point in strbuf.h says:

 *  - The `buf` member is never NULL, so it can be used in any usual C
 *    string operations safely. strbuf's _have_ to be initialized either by
 *    `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.

So I extrapolated that if buf is NULL, it must be because it was just xcalloc'd
and not initialized. One possible improvement to the API would be to refactor
it such that there is no STRBUF_INIT, but a zero-initialized strbuf is valid.
If you expect to get a non-NULL buf, even for a zero-initialized strbuf, you
should call a function like strbuf_nonnull_buf(&buf), and that will return the
slop buf if buf is null, or the actual buf if it is non-null.

I don't understand why the API designer was so strict about requiring the
buffer to be set to non-null, since it's quite a burden for API users. If I
eagerly set all filter_options's strbuf's to STRBUF_INIT, it involves changing
a couple of global variables which currently do not need an initializer, and it
would make the code a bit messy. The structs which have a strbuf somewhere in
their nested fields would need to know that, and set up an initialization macro
to avoid the null buf.

I kind of suspect the right short-term fix is to avoid strbuf's and use a
string_list, which I join later to a full string when needed.

> convention, and it may even be a useful one (i.e. it allows you to
> calloc() a structure with an embedded strbuf in it and the "if
> .buf==NULL, call strbuf_init() lazily" can become an established
> pattern), but at the same time it feels a bit brittle.  

Is it brittle because a strbuf may be initialized to non-zero memory, and so
the "if (buf.buf == NULL)" may evaluate to false, and then go on treating
garbage like a valid buffer? I would think that's almost impossible because of
the use of xcalloc.

The only reason I realized the strbuf_init was necessary was not because I read
the documentation, but because I mistakenly called strbuf_reset, which calls
strbuf_setlen, which doesn't handle a null buf. Many other functions seem to
handle it well semi-accidentially. After I ran into the crash, I finally read
the documentation I cited above.

> 
> Such a convention forces everybody who might want to use such an
> embedded strbuf to first check .buf==NULL and lazily initialize
> it---and at some point when the embedded strbuf to be used by enough
> codepaths, it would make the code more robust by giving up on the
> lazy initialization (iow, when *filter_options is initialized, run
> strbuf_init() on its .filter_spec field).
