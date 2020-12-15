Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE7EC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 05:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8FC82229C
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 05:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgLOF3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 00:29:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:60922 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgLOF3O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 00:29:14 -0500
Received: (qmail 14026 invoked by uid 109); 15 Dec 2020 05:28:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Dec 2020 05:28:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8278 invoked by uid 111); 15 Dec 2020 05:28:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Dec 2020 00:28:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Dec 2020 00:28:26 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
Message-ID: <X9hJenCYkwTmxNjA@coredump.intra.peff.net>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com>
 <X9GbIG9vZbK1pEoi@camp.crustytoothpaste.net>
 <CAMP44s33J6F60W=2Yd2WSGE78VT0XBkewi8m3unXvathBH2TOQ@mail.gmail.com>
 <X9Lf1p++YktzZMWe@camp.crustytoothpaste.net>
 <X9gT57SAHzGm3ET2@coredump.intra.peff.net>
 <5fd8279ce0696_d7c482087@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fd8279ce0696_d7c482087@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 14, 2020 at 09:03:56PM -0600, Felipe Contreras wrote:

> Jeff King wrote:
> > On Fri, Dec 11, 2020 at 02:56:22AM +0000, brian m. carlson wrote:
> 
> >   - it doesn't suggest any actions that might be bad practices. I agree
> >     that the instructions for auto-loading this .vimrc are more
> >     complicated than necessary and might have security implications.
> >     Carrying a file in contrib/vim that says "copy this to ~/.vim/foo"
> >     or even "copy these lines to your ~/.vimrc" seems a lot safer. And
> >     it makes it easier for people who prefer to adapt the config to
> >     their own setup.
> > 
> > So I'm not opposed to carrying some vim config, but I think it's best to
> > focus on simplicity and providing human-readable instructions, rather
> > than ad-hoc plugin infrastructure.
> 
> Generally I would agree, but do you know what such instructions would look like?
> 
> In particular what instructions would look like for a person that
> contributes to more than 3 projects with different C code-style.
> 
> I can assure they are anything but human-readable.

Mostly what I'm suggesting is asking the user to copy the settings they
want, rather than sourcing a file in the repository that may contain
arbitrary options. So something like:

  " Settings to match Git's style/indentation preferences.
  "
  " You can put these straight in your .vimrc if you want to use
  " them all the time. Or if you want to use them only inside
  " certain directories, wrap them like this:
  "   if match(getcwd(), "/path/to/your/git/repo")
  "      au Filetype c setl ...etc...
  "   endif
  "
  au FileType c setl ...etc...

That means they won't automatically pick up new options if they change,
but that's the point. They should be inspecting and deciding which
options they want to take.

The conditional above definitely has some flaws. It relies on the
working directory rather than the location of the file (which is the
same as your plugin; yours is just picking it up implicitly from calling
git).  And once the autoloaders are set up, I think they'd trigger for
any C file, even outside the repository directory.

Ideally we'd combine the autoloader for BufRead and FileType, but it
seems non-trivial to do so. I think:

  au BufNewFile,BufRead /path/to/git/* if &filetype == "c" | setl ... | endif

works, though it's a little clunky, as each line would need to repeat
it.  There might be a better way. I'm not that familiar with doing
tricky things with vim's autoloading. But my point is mostly that the
value in the information is saying "here are some useful vim settings
you might want to use".  I don't think we need to solve "here's how to
trigger some settings for some directories" for everyone. We should let
them integrate the settings as they see fit.

-Peff
