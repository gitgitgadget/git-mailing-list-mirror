Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD581F516
	for <e@80x24.org>; Wed, 27 Jun 2018 14:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964810AbeF0OOd (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 10:14:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:56846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754339AbeF0OOc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 10:14:32 -0400
Received: (qmail 22422 invoked by uid 109); 27 Jun 2018 14:14:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Jun 2018 14:14:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8407 invoked by uid 111); 27 Jun 2018 14:14:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Jun 2018 10:14:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jun 2018 10:14:30 -0400
Date:   Wed, 27 Jun 2018 10:14:30 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: substitute ETC_GIT(CONFIG|ATTRIBUTES) in generated
 docs
Message-ID: <20180627141430.GA13904@sigill.intra.peff.net>
References: <20180627045637.13818-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180627045637.13818-1-tmz@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 12:56:37AM -0400, Todd Zullinger wrote:

> Replace `$(prefix)/etc/gitconfig` and `$(prefix)/etc/gitattributes` in
> generated documentation with the paths chosen when building.  Readers of
> the documentation should not need to know how `$(prefix)` was defined.

Yes, I was just complaining about this yesterday. Besides readers not
having any clue what $(prefix) means here, $(prefix)/etc is not even
correct for builds with prefix=/usr.

So I like the overall direction here, but it leaves me with one
question: what happens for documentation outside of customized builds?

Specifically, I'm thinking of:

  1. The pre-built documentation that Junio builds for
     quick-install-doc. This _could_ be customized during the "quick"
     step, but it's probably not worth the effort. However, we'd want
     some kind of generic fill-in then, and hopefully not
     "/home/jch/etc" or something.

  2. The manpages on git-scm.com, which are built with asciidoctor. I
     think we'd want the same generic value there. Ideally it would be
     embedded in the asciidoc source as "if this attribute isn't
     defined, then use this", but it's not the end of the world to
     require a patch to the site to handle this.

     (Related, there's a build target in the local Makefile for using
     asciidoctor; does it need updated, too?)

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index d079d7c73a..75af671798 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -95,6 +95,7 @@ DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
>  
>  prefix ?= $(HOME)
>  bindir ?= $(prefix)/bin
> +sysconfdir ?= $(prefix)/etc
>  htmldir ?= $(prefix)/share/doc/git-doc
>  infodir ?= $(prefix)/share/info
>  pdfdir ?= $(prefix)/share/doc/git-doc
> @@ -205,6 +206,18 @@ DEFAULT_EDITOR_SQ = $(subst ','\'',$(DEFAULT_EDITOR))
>  ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
>  endif
>  
> +ifndef ETC_GITCONFIG
> +ETC_GITCONFIG = $(sysconfdir)/gitconfig
> +endif
> +ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
> +ASCIIDOC_EXTRA += -a 'etc-gitconfig=$(ETC_GITCONFIG_SQ)'
> +
> +ifndef ETC_GITATTRIBUTES
> +ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
> +endif
> +ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
> +ASCIIDOC_EXTRA += -a 'etc-gitattributes=$(ETC_GITATTRIBUTES_SQ)'
> +

It's a shame we have to repeat this logic from the Makefile, though I
guess we already do so for prefix, bindir, etc, so far.

Should we factor the path logic from the top-level Makefile into an
include that can be used from either?

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1cc18a828c..ed903b60bd 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -5,7 +5,7 @@ The Git configuration file contains a number of variables that affect
>  the Git commands' behavior. The `.git/config` file in each repository
>  is used to store the configuration for that repository, and
>  `$HOME/.gitconfig` is used to store a per-user configuration as
> -fallback values for the `.git/config` file. The file `/etc/gitconfig`
> +fallback values for the `.git/config` file. The file +{etc-gitconfig}+

I think the formatting tweak you've done here is the right thing.
There's no way to expand within literal backticks (since that's the
point). So we only care about the monospacing effect, which ++ should
give.

-Peff
