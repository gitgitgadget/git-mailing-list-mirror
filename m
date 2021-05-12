Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E041C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E181561925
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhELGXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 02:23:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:52014 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhELGXP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 02:23:15 -0400
Received: (qmail 26357 invoked by uid 109); 12 May 2021 06:22:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 06:22:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2527 invoked by uid 111); 12 May 2021 06:22:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 May 2021 02:22:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 May 2021 02:22:06 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Message-ID: <YJt0Dv7HP2VnLLwv@coredump.intra.peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210512021138.63598-1-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 02:11:37AM +0000, brian m. carlson wrote:

> @@ -367,9 +370,16 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-AS
>  manpage-base-url.xsl: manpage-base-url.xsl.in
>  	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
>  
> +ifdef TXT_TO_MAN
> +%.1 %.5 %.7 : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
> +	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> +	$(TXT_TO_MAN) -o $@+ $< && \
> +	mv $@+ $@
> +else

This depends on GIT-ASCIIDOCFLAGS, which is good. But I think we'd also
want to tell that file whether we are using the direct backend or not.
Otherwise, doing:

  make USE_ASCIIDOCTOR=1 git.1
  make USE_ASCIIDOCTOR=1 USE_ASCIIDOCTOR_MANPAGE=1 git.1

gets confused. Because git.1 is more recent than git.txt, it things
there is nothing to build in the second case. I think you want:

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 536d9a5f3d..4b66a61f51 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -337,7 +337,7 @@ mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
 	date >$@
 
-TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
+TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK):$(USE_ASCIIDOCTOR_MANPAGE))
 
 GIT-ASCIIDOCFLAGS: FORCE
 	@FLAGS='$(TRACK_ASCIIDOCFLAGS)'; \

With that change, plus a patch I'll send in a minute, it's easy to run
doc-diff on the result.

> diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
> index d906a00803..40fa87b121 100644
> --- a/Documentation/asciidoctor-extensions.rb
> +++ b/Documentation/asciidoctor-extensions.rb
> @@ -15,6 +15,8 @@ module Git
>            "#{target}(#{attrs[1]})</ulink>"
>          elsif parent.document.basebackend? 'html'
>            %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
> +        elsif parent.document.basebackend? 'manpage'
> +          %(\\fB#{target}\\fP\\fR(#{attrs[1]})\\fP)

Unfortunately, this doesn't seem to work. Diffing the rendered docs
between regular asciidoctor-then-xmlto and direct-to-manpage shows a lot
of hunks like:

              For more details about the <pathspec> syntax, see the pathspec
  -           entry in gitglossary(7).
  +           entry in \fBgitglossary\fP\fR(7)\fP.

-Peff
