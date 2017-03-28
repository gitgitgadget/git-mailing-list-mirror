Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E991D1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 21:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbdC1Vt5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 17:49:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:53274 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752666AbdC1Vt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 17:49:56 -0400
Received: (qmail 19191 invoked by uid 109); 28 Mar 2017 21:49:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 21:49:33 +0000
Received: (qmail 23616 invoked by uid 111); 28 Mar 2017 21:49:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 17:49:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 17:49:30 -0400
Date:   Tue, 28 Mar 2017 17:49:30 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: support long paths w/o read rights in
 strbuf_getcwd() on FreeBSD
Message-ID: <20170328214930.bj4etqn5qecv45im@sigill.intra.peff.net>
References: <4026bc3b-2999-9daf-d6ab-10c6d007b1e7@web.de>
 <CAP8UFD3pXSf+RhysULQyd2kdKSkBWdoKs+L6GPQ4jwpoeP+yOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3pXSf+RhysULQyd2kdKSkBWdoKs+L6GPQ4jwpoeP+yOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 11:15:12PM +0200, Christian Couder wrote:

> On Sun, Mar 26, 2017 at 3:43 PM, René Scharfe <l.s.r@web.de> wrote:
> > FreeBSD implements getcwd(3) as a syscall, but falls back to a version
> > based on readdir(3) if it fails for some reason.  The latter requires
> > permissions to read and execute path components, while the former does
> > not.  That means that if our buffer is too small and we're missing
> > rights we could get EACCES, but we may succeed with a bigger buffer.
> >
> > Keep retrying if getcwd(3) indicates lack of permissions until our
> > buffer can fit PATH_MAX bytes, as that's the maximum supported by the
> > syscall on FreeBSD anyway.  This way we do what we can to be able to
> > benefit from the syscall, but we also won't loop forever if there is a
> > real permission issue.
> 
> Sorry to be late and maybe I missed something obvious, but the above
> and the patch seem complex to me compared with something like:
> 
> diff --git a/strbuf.c b/strbuf.c
> index ace58e7367..25eadcbedc 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -441,7 +441,7 @@ int strbuf_readlink(struct strbuf *sb, const char
> *path, size_t hint)
>  int strbuf_getcwd(struct strbuf *sb)
>  {
>         size_t oldalloc = sb->alloc;
> -       size_t guessed_len = 128;
> +       size_t guessed_len = PATH_MAX > 128 ? PATH_MAX : 128;
> 
>         for (;; guessed_len *= 2) {
>                 strbuf_grow(sb, guessed_len);

I think the main reason is just that we do not have to pay the price to
allocate PATH_MAX-sized buffers when they are rarely used.

I doubt it matters all that much in practice, though.

-Peff
