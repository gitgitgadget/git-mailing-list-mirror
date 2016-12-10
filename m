Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D141FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 20:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbcLJUEm (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 15:04:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:54736 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbcLJUEl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 15:04:41 -0500
Received: (qmail 7692 invoked by uid 109); 10 Dec 2016 20:04:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 20:04:41 +0000
Received: (qmail 29012 invoked by uid 111); 10 Dec 2016 20:05:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 15:05:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2016 15:04:38 -0500
Date:   Sat, 10 Dec 2016 15:04:38 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 4/5] Make sequencer abort safer
Message-ID: <20161210200437.ijmahia6e6xifhk6@sigill.intra.peff.net>
References: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
 <20161209190111.9571-1-s-beyer@gmx.net>
 <20161209190111.9571-4-s-beyer@gmx.net>
 <CAP8UFD0hCke_W6C=gOHinpj+G3WCFKf7Cji6zREDer4RUBxKxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0hCke_W6C=gOHinpj+G3WCFKf7Cji6zREDer4RUBxKxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 08:56:26PM +0100, Christian Couder wrote:

> > +static int rollback_is_safe(void)
> > +{
> > +       struct strbuf sb = STRBUF_INIT;
> > +       struct object_id expected_head, actual_head;
> > +
> > +       if (strbuf_read_file(&sb, git_path_abort_safety_file(), 0) >= 0) {
> > +               strbuf_trim(&sb);
> > +               if (get_oid_hex(sb.buf, &expected_head)) {
> > +                       strbuf_release(&sb);
> > +                       die(_("could not parse %s"), git_path_abort_safety_file());
> > +               }
> > +               strbuf_release(&sb);
> > +       }
> 
> Maybe the following is a bit simpler:
> 
>        if (strbuf_read_file(&sb, git_path_abort_safety_file(), 0) >= 0) {
>                int res;
>                strbuf_trim(&sb);
>                res = get_oid_hex(sb.buf, &expected_head);
>                strbuf_release(&sb);
>                if (res)
>                    die(_("could not parse %s"), git_path_abort_safety_file());
>        }

Is there any point in calling strbuf_release() if we're about to die
anyway? I could see it if it were "return error()", but it's normal in
our code base for die() to be abrupt.

-Peff
