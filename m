Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBFBC433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFCA20767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgFVViP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:38:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:39310 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730484AbgFVViP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:38:15 -0400
Received: (qmail 1845 invoked by uid 109); 22 Jun 2020 21:38:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Jun 2020 21:38:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8472 invoked by uid 111); 22 Jun 2020 21:38:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jun 2020 17:38:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Jun 2020 17:38:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] fast-export: allow dumping the path mapping
Message-ID: <20200622213813.GC1376217@coredump.intra.peff.net>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
 <20200619132923.GA2540897@coredump.intra.peff.net>
 <xmqqr1uahn9t.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1uahn9t.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 12:24:30PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > When working with an anonymized repo, it can be useful to be able to
> > refer to particular paths. E.g., reproducing a bug with "git rev-list --
> > foo.c" in the original repo would need to replace "foo.c" with its
> > anonymized counterpart to produce the same effect.
> 
> That would not work with "git rev-list -- 'foo*'", where there is no
> counterpart, no?

Correct. There's no way that can work without treating the "foo" prefix
as a token and anonymizing it consistently. We currently only treat full
path components as tokens. So "foo/" will always be "ref123/", but
"foobar" will have no relation.

> It almost feels as if we want a separate knob to disable
> anonymization for paths and perhaps refs while still anonymizing the
> blob contents, or something like that.

I think such a knob could be useful for some situations, but I don't
think it's a complete replacement for a mapping dump, since you may not
want to reveal your pathnames (or refnames). Unlike refnames, where I
can easily point a tag "foo" at a commit of interest and then ask that
"foo" not be anonymized, pathnames are harder to change.

An alternative would be to let users seed the mapping (e.g., to ask that
"foo1" and "foo2" become "anon1" and "anon2"). That requires a little
more forethought on the part of the user, but it also avoids them having
to dig through the mapping to rewrite their commands (instead they use
the mappings they already invented).

-Peff
