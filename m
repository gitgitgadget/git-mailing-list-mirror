Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231F81F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966077AbeF1OQA (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:16:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:58190 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965985AbeF1OP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:15:59 -0400
Received: (qmail 13509 invoked by uid 109); 28 Jun 2018 14:15:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 14:15:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20097 invoked by uid 111); 28 Jun 2018 14:16:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 10:16:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 10:15:57 -0400
Date:   Thu, 28 Jun 2018 10:15:57 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: substitute ETC_GIT(CONFIG|ATTRIBUTES) in generated
 docs
Message-ID: <20180628141556.GA15799@sigill.intra.peff.net>
References: <20180627045637.13818-1-tmz@pobox.com>
 <20180627141430.GA13904@sigill.intra.peff.net>
 <20180627150352.GJ20217@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180627150352.GJ20217@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 11:03:52AM -0400, Todd Zullinger wrote:

> So what you're saying is that if I had procrastinated a
> little, you may have written such a patch for me? :)

Yes, but that's a dangerous game of chicken. :)

> >   1. The pre-built documentation that Junio builds for
> >      quick-install-doc. This _could_ be customized during the "quick"
> >      step, but it's probably not worth the effort. However, we'd want
> >      some kind of generic fill-in then, and hopefully not
> >      "/home/jch/etc" or something.
> 
> If building docs separately for such a use, the values can
> be overridden by setting ETC_GITCONFIG and ETC_GITATTRIBUTES
> (or prefix or sysconfig).  To keep the same values as we
> currently use, for example:
> 
>     make -C Documentation V=1 \
>             ETC_GITCONFIG='$$(prefix)/etc/gitconfig' \
>             ETC_GITATTRIBUTES='$$(prefix)/etc/gitattributes'
> 
> I don't know if that's sufficient for folks who build
> documentation to share with a general audience or not.

One downside is that this means the generic-doc builder has to put
nonsense into ETC_GITCONFIG. That means it would be a bad idea to put
this into config.mak, for example, as it would break their regular
build.

We could get rid around that by using $(DOC_ETC_GITCONFIG) or something,
with:

  DOC_ETC_GITCONFIG ?= $(ETC_GITCONFIG)

in the Makefile. But that still leaves the choice of which generic text
to use up to the caller. Maybe we should provide more guidance.

I.e., provide a knob like DOC_GENERIC that fills in generic values for
these values (and maybe some others; it sounds like we have some
existing problem cases).

> It might be enough if the default values are relatively sane
> and consistent.  That would be a slight improvement over the
> current situation still.

Yeah. Taking a step back from the implementation questions, I think
"$(prefix)/etc/gitconfig" is not very helpful text. I'd be happy to see
us come up with a generic way of saying that which is more
comprehensible to end-users. Your patches side-step that by filling in
the real value, but unfortunately we can't do that everywhere. :)

There may not be a good "token" value, though. I.e., we may need to have
two sets of verbiage: the specific one, and the generic one.

> The EDITOR/PAGER bits are in git-var.txt, like this:
> 
>     GIT_EDITOR::
>         Text editor for use by Git commands.  The value is meant to be
>         interpreted by the shell when it is used.  Examples: `~/bin/vi`,
>         `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
>         --nofork`.  The order of preference is the `$GIT_EDITOR`
>         environment variable, then `core.editor` configuration, then
>         `$VISUAL`, then `$EDITOR`, and then the default chosen at compile
>         time, which is usually 'vi'.
>     ifdef::git-default-editor[]
>         The build you are using chose '{git-default-editor}' as the default.
>     endif::git-default-editor[]
> 
> The ifdef would be a little different to set the var if it
> was not set, of course.

Thanks, I didn't know about those cases. The git-scm.com version gets
that right, because we don't set DEFAULT_* there. I wondered if we might
have problems with other generic builds since we do have defaults for
those DEFAULT_* variables. But it looks like those defaults are applied
within the C code itself. So unless Junio starts setting DEFAULT_PAGER
himself, I think his builds are OK.

> I think if we ensure that ETC_GITCONFIG / ETC_GITATTRIBUTES
> are set sanely by default (and easily overridden) then we
> can probably avoid the need to handle it within the asciidoc
> file though.  (There's more on that though below.)

I think these two differ from the DEFAULT_* in that we'll _always_ have
them set in the Makefile. And we probably always want to report them
unless we're in a generic documentation build.

> > It's a shame we have to repeat this logic from the Makefile, though I
> > guess we already do so for prefix, bindir, etc, so far.
> > 
> > Should we factor the path logic from the top-level Makefile into an
> > include that can be used from either?
> 
> Yeah, maybe.  I didn't like the duplication either, but as
> you noticed, we do it already for many of the other
> variables.  I suspect we could put these defaults into
> config.mak.uname which Documentation/Makefile includes and
> then you could run 'make -C Documentation' in a fresh clone
> or tarball and get docs built with the defaults set for each
> platform.

I think it shouldn't go into config.mak.uname, since the idea there was
to keep the long list of platform defaults separate from other logic
(the Makefile is already long enough!). So I'm basically proposing the
same thing but in its own file. :)

-Peff
