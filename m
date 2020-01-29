Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8260C33C9E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 02:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFDB2071E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 02:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgA2ChF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:37:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:47062 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726467AbgA2ChF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 21:37:05 -0500
Received: (qmail 13187 invoked by uid 109); 29 Jan 2020 02:37:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 02:37:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13047 invoked by uid 111); 29 Jan 2020 02:44:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jan 2020 21:44:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jan 2020 21:37:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Zeger-Jan van de Weg <git@zjvandeweg.nl>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] config: learn the --stdin option for instructions
Message-ID: <20200129023704.GB596379@coredump.intra.peff.net>
References: <20200127100933.10765-1-git@zjvandeweg.nl>
 <20200127100933.10765-2-git@zjvandeweg.nl>
 <CAPig+cS03oS9PhN_cusjpzoCzwNmgc5rXiVAmG3ceUCFw71PVg@mail.gmail.com>
 <20200128092414.GB574544@coredump.intra.peff.net>
 <xmqq36bz8job.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36bz8job.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 11:28:36AM -0800, Junio C Hamano wrote:

> > I agree it would probably be rare, but isn't the whole point of "-z" to
> > be able to represent anything without worrying about quoting?
> 
> Yup.  I was tempted to say, in addition to "without worrying about
> quoting", "without worrying about the syntax".
> 
> But unfortunately that would not work.  If we were to add a new
> "frotz" subcommand in a future version of Git that takes N args,
> 
> 	frotz SP <arg1> NUL <arg2> NUL ... <argN> NUL
> 
> may how you'd express it, and it would be wonderful if the current
> version of Git that does not know "frotz" subcommand can at least
> parse and ignore it.  That cannot however be done, though, because
> there is no syntactic difference between the argument terminator
> (after each arg) and subcommand terminator (after each subcommand).

I do agree it would be nice if we could separate syntax from semantics,
just because it lets us reuse and modify parsers more easily. We have
the same problem on output (e.g., anything parsing "diff --name-status
-z" has to know there are two name fields for an R or C entry), and it
has tripped people up in the past.

But:

  - I don't think we'd want a current version of Git to ignore an
    unknown frotz anyway. It would probably say "I don't understand
    frotz, so I don't know if it's safe to ignore it or not".

  - Given only the tool of NUL bytes, I'm not sure how to easily
    design a syntax that isn't awful. I.e., clearly something like:

      frotz SP 2 NUL <arg1> NUL <arg2> NUL

    works, but have we really made the world a better place? It would
    make more sense to me to use a standard serialization format like
    JSON, but that generally comes with its own inherited baggage (like
    non-UTF8 strings).

-Peff
