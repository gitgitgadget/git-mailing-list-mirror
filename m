Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7387C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C201321775
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEHRYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 13:24:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:41858 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726756AbgEHRYq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 13:24:46 -0400
Received: (qmail 10571 invoked by uid 109); 8 May 2020 17:24:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 May 2020 17:24:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30347 invoked by uid 111); 8 May 2020 17:24:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 May 2020 13:24:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 May 2020 13:24:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Force Charlie via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Force Charlie <charlieio@outlook.com>
Subject: Re: [PATCH] Correctly initialize 'installed_handlers'
Message-ID: <20200508172445.GC637136@coredump.intra.peff.net>
References: <pull.630.git.1588921514146.gitgitgadget@gmail.com>
 <20200508083340.GA36538@Carlos-MBP>
 <xmqqy2q2zbej.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy2q2zbej.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 08, 2020 at 08:36:36AM -0700, Junio C Hamano wrote:

> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
> > the way this is handled would seem to indicate otherwise
> >
> > if (!installed_handlers) {
> >                 atexit(remove_tmp_objdir);
> >                 sigchain_push_common(remove_tmp_objdir_on_signal);
> >                 installed_handlers++;
> > }
> 
> It is a curious piece of code.  
> 
> The "prepare a file-scope static and do something and increment it
> when it is 0" pattern expects the function to be called many times
> and do the guarded thing only once.  However, there is this code:
> 
> 	if (the_tmp_objdir)
> 		BUG(...);
> 
> before we do anything else, and then before that "arrange to clean
> up, but do so just once" block, there is
> 
> 	the_tmp_objdir = t;
> 
> where t is the pointer to a "struct tmp_objdir" instance.  So one
> part of the function expects to be called at most once, while
> another part is prepared to be called more than once.
> 
> Almost all of this function is attributed to 2564d994 (tmp-objdir:
> introduce API for temporary object directories, 2016-10-03), so
> let's see if Peff remembers anything about this curiosity.

There is "only once per program" and "only one at a time". When the
tmp_objdir is destroyed (either directly or via tmp_objdir_migrate), we
set the_tmp_objdir back to NULL, and you are free to then create another
one.

In practice there's only one caller (receive-pack) and it only ever uses
one tmp_objdir per program, so it's mostly academic. But tmp-objdir.c
was written to be as reusable and least-surprising as possible. I would
have avoided the "one at a time" rule if I could, but the semantics are
unclear (if you have two active, which one should object-writes go to?).

The atexit and signal handlers could be removed when there's no
tmp_objdir active, but there's no easy way to remove them (there's
nothing portable at all for atexit, and for sigchain we don't know if
somebody else has pushed in the meantime).

-Peff
