Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27470C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 08:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B9661057
	for <git@archiver.kernel.org>; Fri, 21 May 2021 08:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhEUIpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 04:45:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:33088 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233811AbhEUIpr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 04:45:47 -0400
Received: (qmail 2412 invoked by uid 109); 21 May 2021 08:44:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 May 2021 08:44:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7429 invoked by uid 111); 21 May 2021 08:44:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 May 2021 04:44:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 May 2021 04:44:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4] help: colorize man pages
Message-ID: <YKdy5jhHgG2who27@coredump.intra.peff.net>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
 <xmqqbl94smjb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbl94smjb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 02:06:48PM +0900, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > On 20/05/2021 05:07, Felipe Contreras wrote:
> >> We already colorize tools traditionally not colorized by default, like
> >> diff and grep. Let's do the same for man.
> >
> > I think there is a distinction between 'diff' and 'grep' where we are
> > generating the content and help where we are running man - I would 
> > expect a man page to look the same whether it is displayed by 'man git
> > foo' or 'git help foo'
> 
> ... as long as the user chooses "man" backend, that is.  And I tend
> to agree, but that is our expectation.
> 
> If we added this new mode of driving the same "man" but with
> different environment variables exported to tweak how "less"
> behaves, and taught it to builtin/help.c::exec_viewer() and
> builtin/help.c::man_viewer_list, that might become more palatable in
> the sense that we can view it as feeding the same manual page to
> this another "man" that behaves differently from the plain "man",
> just like we can feed it to "woman" or "konqueror" to get a different
> view.  So those (like you and I) who expect a man page to look the
> same in "man git foo" and "git help -m foo" can keep using our current
> configuration, while those who want yet another variant of "man" output
> in addition to the current "man", "woman", and "konqueror" can choose
> it and get "colorized" output.

I still don't understand what we gain by making this a Git feature, as
all of the changed behavior is totally within the program we are
calling. Imagine that konqueror (or an html viewer like firefox) had an
option to set its color scheme from the command line. Should we
introduce a new baked-in fancy-konqueror backend that is "run the tool
with a tweaked color scheme"?

Why would we do that versus saying: if you want to change the colors in
the tool that Git calls, then configure the tool?

If you like to see colors in manpages, why not configure "man" (either
by setting these environment variables all the time, or by triggering
them in MANPAGER)? And then Git doesn't have to care either way; it is
calling "man" which does what the user wants, colors or no. If you
really for some reason only want colorized man pages when called via
"git help", then why not set man.fancy.cmd to invoke your preferred
config?

If those configurations are awkward to trigger via man (e.g., putting
escapes into termcap variables), isn't that something that could be
improved in man? And then it would benefit everyone who uses man, not
just Git.

-Peff
