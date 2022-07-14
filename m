Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59388C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbiGNVNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240729AbiGNVNj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:13:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E0DE6F
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:13:36 -0700 (PDT)
Received: (qmail 19439 invoked by uid 109); 14 Jul 2022 21:13:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Jul 2022 21:13:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32125 invoked by uid 111); 14 Jul 2022 21:13:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Jul 2022 17:13:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Jul 2022 17:13:35 -0400
From:   Jeff King <peff@peff.net>
To:     Manuel Boni <ziosombrero@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config.txt: add completion for include, includeIf
Message-ID: <YtCG/xVfWKsiSXUp@coredump.intra.peff.net>
References: <pull.1285.git.1657738937049.gitgitgadget@gmail.com>
 <Ys8dwDZK2L4QfSZu@coredump.intra.peff.net>
 <d21115d5-8bae-c120-453f-9dbb600d0431@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d21115d5-8bae-c120-453f-9dbb600d0431@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc git@vger; please keep the discussion on-list]

On Thu, Jul 14, 2022 at 09:37:55AM +0200, Manuel Boni wrote:

> > First the suggestion: rather than just point them to the "CONFIGURATION
> > FILE" section, there are subsections for "Includes" and "Conditional
> > Includes". Maybe worth pointing to those specific sections?
> 
> Is there specific syntax that I should use to directly point to those
> sections? Or should I simply add something such as "Refer to the 'Includes'
> and 'Conditional Includes' sections"?

Sadly, no, I don't think we can hyperlink to sections easily with
asciidoc. I think we will reliably create an "_includes" id for the
subsection in the HTML output, but no portable way to create a link.
Doing <a href="git-config.html#_includes"> works for HTML, but you'd
want to omit that from the man output (and need to structure the text to
make sense without the hyperlink).

That's roughly what our linkgit: macro does, but I don't think we have
an equivalent for subsections themselves.

So for now, yeah, I think something like:

  See the 'Includes' and 'Conditional Includes' headings in the
  "CONFIGURATION FILE" section of the main linkgit:git-config[1]
  documentation.

or something similar.

> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index e376d547ce..5b5b976569 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -445,6 +445,8 @@ include::config/i18n.txt[]
> >   include::config/imap.txt[]
> > +include::config/includeif.txt[]
> > +
> >   include::config/index.txt[]
> >   include::config/init.txt[]
> > 
> > Without that, I don't think the completion will find it either (at least
> > your tests did not seem to pass for me until I added it).
> 
> Strange, the tests worked fine for me even without that line, but I will add
> it anyway.

Ah, sorry, I was holding it wrong. I hadn't run "make" to build
"config-list.h" when I was testing before. The generate-configlist.sh
script just globs Documentation/config/*.txt, so it works as soon as you
run "make"[1].

So in that sense your commit message _is_ accurate, because it doesn't
affect the documentation at all. But IMHO it is worth including the new
entries there.

-Peff

[1] There's an interesting subtlety there. The Makefile rule for
    config-list.h depends on config/*.txt, too. So it picks up the new
    file correctly, but it fails to notice if you then switch away from
    your commit back to vanilla "master". It thinks config-list.h
    doesn't need to be rebuilt! Probably not worth worrying about too
    much as we don't often remove files, and certainly not something
    that needs to be dealt with for your change.
