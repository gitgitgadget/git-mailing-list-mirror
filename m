Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BE0C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 05:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F209613C8
	for <git@archiver.kernel.org>; Fri, 14 May 2021 05:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhENF2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 01:28:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:54378 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhENF2W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 01:28:22 -0400
Received: (qmail 16829 invoked by uid 109); 14 May 2021 05:27:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 May 2021 05:27:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30459 invoked by uid 111); 14 May 2021 05:27:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 May 2021 01:27:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 May 2021 01:27:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Message-ID: <YJ4KLfd16qwnRqUx@coredump.intra.peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
 <20210514003104.94644-2-sandals@crustytoothpaste.net>
 <xmqqbl9e7yqz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbl9e7yqz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 14, 2021 at 12:58:12PM +0900, Junio C Hamano wrote:

> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 2aae4c9cbb..891181c0f3 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -192,10 +192,16 @@ ASCIIDOC_HTML = xhtml5
> >  ASCIIDOC_DOCBOOK = docbook5
> >  ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
> >  ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
> > -ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
> > +TXT_TO_HTML += -alitdd='&\#x2d;&\#x2d;'
> > +TXT_TO_XML  += -alitdd='&\#x2d;&\#x2d;'
> >  DBLATEX_COMMON =
> >  XMLTO_EXTRA += --skip-validation
> >  XMLTO_EXTRA += -x manpage.xsl
> > +ifdef USE_ASCIIDOCTOR_MANPAGE
> > +TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
> > +TXT_TO_MAN += -aplus='+'
> > +TXT_TO_MAN += -alitdd='\--'
> > +endif
> >  endif
> 
> This hunk is wholly inside USE_ASCIIDOCTOR and deals with {litdd}
> and {plus}, which are defined in asciidoc.conf that is not read by
> Asciidoctor, so we'd need to be careful to keep these three places
> (i.e. TXT_TO_HTML, TXT_TO_XML and TXT_TO_MAN) in sync with the
> asciidoct.conf file.
> 
> It is curious that {plus} for Asciidoctor is deffined only for
> manpages and HTML/XML side lacks the definition.  Intended?

I don't think it's needed on the HTML/XML side, as AsciiDoctor ships
with reasonable conversions there to HTML entities. It's only for the
direct-to-manpage path that needs them. This is probably a bug in
AsciiDoctor, but I haven't investigated fully.

> It seems that the latter has several more "attributes" defined that
> we do not replicate in the Makefile---I wonder if that is a sign
> that we can get rid of entries for asterisk, caret, startsb,
> etc. from asciidoc.conf?

I don't think so. Even though AsciiDoctor ships with sensible values for
those attributes, AsciiDoc doesn't seem to. Try committing something
like this and then running "./doc-diff HEAD^ HEAD", which shows all
kinds of problems.

-- >8 --
Subject: drop maybe unused attributes

---
 Documentation/asciidoc.conf | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 3e4c13971b..75f01e2fa1 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -11,15 +11,7 @@
 (?su)[\\]?(?P<name>linkgit):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=
 
 [attributes]
-asterisk=&#42;
 plus=&#43;
-caret=&#94;
-startsb=&#91;
-endsb=&#93;
-backslash=&#92;
-tilde=&#126;
-apostrophe=&#39;
-backtick=&#96;
 litdd=&#45;&#45;
 
 ifdef::backend-docbook[]
-- 
2.31.1.1062.g531ce38507

