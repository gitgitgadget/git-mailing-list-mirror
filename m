Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA31C77B6E
	for <git@archiver.kernel.org>; Sun,  9 Apr 2023 19:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDITIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Apr 2023 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDITII (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2023 15:08:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEBD35A7
        for <git@vger.kernel.org>; Sun,  9 Apr 2023 12:08:07 -0700 (PDT)
Received: (qmail 22888 invoked by uid 109); 9 Apr 2023 19:08:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 09 Apr 2023 19:08:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23578 invoked by uid 111); 9 Apr 2023 19:08:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 09 Apr 2023 15:08:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 9 Apr 2023 15:08:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: simplify man version
Message-ID: <20230409190805.GA77061@coredump.intra.peff.net>
References: <20230408001829.11031-1-felipe.contreras@gmail.com>
 <xmqqr0suf0wz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0suf0wz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2023 at 03:45:48PM -0700, Junio C Hamano wrote:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index a6ba5bd460..4721b000c1 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -150,8 +150,7 @@ ASCIIDOC_HTML = xhtml11
> >  ASCIIDOC_DOCBOOK = docbook
> >  ASCIIDOC_CONF = -f asciidoc.conf
> >  ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
> > -		-amanversion=$(GIT_VERSION) \
> > -		-amanmanual='Git Manual' -amansource='Git'
> > +		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)'
> >  ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
> >  TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
> >  TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
> 
> Is this a complete patch, or will this leave us in an incomplete
> in-between place?
> 
> We have some references to manversion in "git grep manversion
> Documentation/" in asciidoc.conf and asciidoctor-extensions.rb
> remaining after this ptach is applied, which presumably are no
> longer used.  I would imagine that these leftover references end up
> substituting them with something benign, like an empty string, in
> the output, but it somehow makes me feel dirty [*].

I think we are OK with this patch on its own. Asciidoc seems to be smart
enough to omit the empty XML element on its own. Asciidoctor isn't (and
nor is ruby hack which adds it in), but docbook is essentially just
concatenating them anyway. Either way, the generated roff looks like:

  .TH "GIT" "1" "2023\-04\-06" "Git 2\&.40\&.0\&.316\&.g67fafd" "Git Manual"

(the first "GIT" is the command name, so this is from git.1).

I do think we probably want to pair this with another patch removing the
asciidoctor-extensions hack, but the reasoning there is separate (it was
needed for some older versions that we can probably declare as "too old"
now).

-Peff
