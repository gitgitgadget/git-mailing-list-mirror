Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC3B1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 21:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfAQVYu (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 16:24:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:40280 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726905AbfAQVYu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 16:24:50 -0500
Received: (qmail 20722 invoked by uid 109); 17 Jan 2019 21:24:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Jan 2019 21:24:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4277 invoked by uid 111); 17 Jan 2019 21:24:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 17 Jan 2019 16:24:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2019 16:24:48 -0500
Date:   Thu, 17 Jan 2019 16:24:48 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH/RFC] fsck: complain when .gitignore and .gitattributes
 are symlinks
Message-ID: <20190117212448.GA13100@sigill.intra.peff.net>
References: <20190114230902.GG162110@google.com>
 <20190117170005.GA27667@sigill.intra.peff.net>
 <xmqq1s5bniuf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1s5bniuf.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 12:13:12PM -0800, Junio C Hamano wrote:

> > @@ -966,7 +968,9 @@ int verify_path(const char *path, unsigned mode)
> >  				if (is_hfs_dotgit(path))
> >  					return 0;
> >  				if (S_ISLNK(mode)) {
> > -					if (is_hfs_dotgitmodules(path))
> > +					if (is_hfs_dotgitmodules(path) ||
> > +					    is_hfs_dotgitignore(path) ||
> > +					    is_hfs_dotgitattributes(path))
> >  						return 0;
> >  				}
> >  			}
> > @@ -974,7 +978,9 @@ int verify_path(const char *path, unsigned mode)
> >  				if (is_ntfs_dotgit(path))
> >  					return 0;
> >  				if (S_ISLNK(mode)) {
> > -					if (is_ntfs_dotgitmodules(path))
> > +					if (is_ntfs_dotgitmodules(path) ||
> > +					    is_ntfs_dotgitignore(path) ||
> > +					    is_ntfs_dotgitattributes(path))
> >  						return 0;
> 
> Curious that we already have these helpers, nobody seems to call
> them in the current codebase, and we haven't seen the "these are
> unused" linter message on the list for a while ;-).

Heh. Yeah, I was surprised by that, too. They were added by e7cb0b4455
(is_ntfs_dotgit: match other .git files, 2018-05-11). The original
version of my series had the hunks quoted above, and then we backed off
on handling them as part of the emergency fix, but I never re-rolled the
preparatory patch to get rid of them.

I think they got overlooked because they're not file-local statics, and
it's much harder to say "this is never called by any function in another
translation unit". You probably have to do analysis on the complete
binaries using "nm" or similar. I think maybe Ramsay does that from time
to time, but I don't offhand know the correct incantation.

Anyway, it sounds like you like the overall direction. Does that include
these verify_path() bits, as well as the fsck part?

-Peff
