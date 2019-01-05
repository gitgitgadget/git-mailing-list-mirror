Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D11D1F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 08:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfAEIfd convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 5 Jan 2019 03:35:33 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:44900 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfAEIfd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 03:35:33 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id A7A2720039F
        for <git@vger.kernel.org>; Sat,  5 Jan 2019 09:35:29 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Add optional targets for documentation l10n
Date:   Sat, 05 Jan 2019 09:35:29 +0100
Message-ID: <220955359.FqXrlbFPp5@cayenne>
In-Reply-To: <xmqqk1jkb0c9.fsf@gitster-ct.c.googlers.com>
References: <20190104165406.22358-1-jn.avila@free.fr> <20190104165406.22358-2-jn.avila@free.fr> <xmqqk1jkb0c9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, 4 January 2019 22:05:10 CET Junio C Hamano wrote:
> Jean-Noël Avila <jn.avila@free.fr> writes:
> 
> > From: Jean-Noel Avila <jn.avila@free.fr>
> >
> > The standard doc lists can be filtered to allow using the compilation
> > rules with translated manpages where all the pages of the original
> > version may not be present.
> >
> > The install variable are reused in the secondary repo so that the
> > configured paths can be used for translated manpages too.
> >
> > Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> > ---
> >  Documentation/Makefile | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index b5be2e2d3f..1f61a1fe86 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -35,13 +35,18 @@ MAN7_TXT += gittutorial-2.txt
> >  MAN7_TXT += gittutorial.txt
> >  MAN7_TXT += gitworkflows.txt
> >  
> > -MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
> > +TMP_MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
> > +MAN_FILTER ?= $(TMP_MAN_TXT)
> > +MAN_TXT = $(filter $(TMP_MAN_TXT), $(MAN_FILTER))
> > +undefine TMP_MAN_TXT
> > +
> 
> I think your arguments to $(filter) is the other way around, but
> other than that, I think I get what you are trying to do.  Let me
> make sure I got it right.
> 
> The idea is to use $(filter PATTERN..., TEXT) that removes words in
> TEXT that do not match any of the words in PATTERN, and for normal
> build, MAN_FILTER is set identical to TMP_MAN_TXT (which is the
> original MAN_TXT), so there is no filtering happen, but in a build
> that does tweak MAN_FILTER, MAN_TXT can become a subset of the
> original MAN_TXT.
> 
> Am I on the right track?
>

Yes that's exactly the purpose of this trick. In fact, $(filter) in this 
configuration is equivalent to an intersection of lists, so the order does not 
change the end result.
 
> >  MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))
> >  MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))
> 
> And these act on already-filtered MAN_TXT
> 

Yes the filtered list fans out to the outputs.

> >  OBSOLETE_HTML += everyday.html
> >  OBSOLETE_HTML += git-remote-helpers.html
> > -DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
> > +
> > +TMP_DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
> >  
> >  ARTICLES += howto-index
> >  ARTICLES += git-tools
> > @@ -81,11 +86,14 @@ TECH_DOCS += technical/trivial-merge
> >  SP_ARTICLES += $(TECH_DOCS)
> >  SP_ARTICLES += technical/api-index
> >  
> > -DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
> > +TMP_DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
> > +HTML_FILTER ?= $(TMP_DOC_HTML)
> > +DOC_HTML = $(filter $(HTML_FILTER),$(TMP_DOC_HTML))
> > +undefine TMP_DOC_HTML
> 
> This one uses $(filter) in the right direction.
> 
> So is it expected that HTML help pages that correspond to manpages
> are strict subset of manpages?  
> 
> I see HTML_FILTER may be useful to filter HTML pages that come from
> $(ARTICLES), but I'd expect that all $(MAN_HTML) that came from the
> already-filtered $(MAN_TXT) would not require any further filtering.
> With the approach shown, the secondary project ends up needing to
> list all the translated MAN_TXT twice (once for MAN_FILTER, and
> again for HTML_FILTER), doesn't it?

The issue I had here is that DOC_HTML is a superset of of MAN_HTML (which 
needed to be translated anyway for MAN_XML) and I have no way to remove from 
the difference of them the files that are not already translated. So a second 
filter is needed, even if now, MAN_FILTER==HTML_FILTER.

As the translations expand hopefully, we will add the html documentation.

> 
> I am wondering if it makes more sense to have HTML_FILTER filter _only_
> parts of the DOC_HTML that does not come from MAN_TXT (i.e. those
> $(ARTICLES) pages).
> 

It can be done. That would separate manpage filter from doc filter. The 
secondary project can be simplified.

> > -DOC_MAN1 = $(patsubst %.txt,%.1,$(MAN1_TXT))
> > -DOC_MAN5 = $(patsubst %.txt,%.5,$(MAN5_TXT))
> > -DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
> > +DOC_MAN1 = $(patsubst %.txt,%.1,$(filter $(MAN_FILTER), $(MAN1_TXT)))
> > +DOC_MAN5 = $(patsubst %.txt,%.5,$(filter $(MAN_FILTER), $(MAN5_TXT)))
> > +DOC_MAN7 = $(patsubst %.txt,%.7,$(filter $(MAN_FILTER), $(MAN7_TXT)))
> 
> These are OK, too.
> 
> By the way, lose the SP after ',' in $(filter).  As we can see in
> the context lines in the patch, args to $(make-functions) are
> separated with comma without surrounding SP by convention.
> 
> What kind of PATTERN does the secondary project supply when invoking
> this Makefile?  If it is list of filenames, I am wondering if it is
> simpler to have it override MAN{1,5,7}_TXT variables, without adding
> these "TMP_* + fliter + undef TMP_*" dance.

Ah, I see. The filter from MAN{1,5,7}_TXT would ripple the same way as MAN_TXT, 
just one level upstream.  The filtering at this level would no longer be 
needed.

Unfortunately, the TMP_* dance would also be needed because these variables 
are built in several steps by append operations, and once filtered, the 
original variables are still useless. My Makefile-fu is low, so I may be 
missing something about redefining variables.

More generally, is this setup sustainable?



