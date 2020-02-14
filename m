Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEE0C35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE732187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgBNGgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:36:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:43190 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725840AbgBNGgu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 01:36:50 -0500
Received: (qmail 19233 invoked by uid 109); 14 Feb 2020 06:36:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 06:36:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19311 invoked by uid 111); 14 Feb 2020 06:45:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 01:45:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 01:36:49 -0500
From:   Jeff King <peff@peff.net>
To:     "Crabtree, Andrew" <andrew.crabtree@hpe.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Inconsistent results from git rev-parse --show-toplevel
Message-ID: <20200214063649.GD605125@coredump.intra.peff.net>
References: <TU4PR8401MB111758B9513DD7D8B96CBFAAF90E0@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
 <xmqqftg4zkvo.fsf@gitster-ct.c.googlers.com>
 <TU4PR8401MB1117B81EB9240905AA36B1E9F9090@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
 <20200125195319.GA5519@coredump.intra.peff.net>
 <TU4PR8401MB1117E8EEB853728B0392D83CF9090@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
 <20200130102933.GE840531@coredump.intra.peff.net>
 <TU4PR8401MB111777B793EA9C3D5336CE26F9040@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TU4PR8401MB111777B793EA9C3D5336CE26F9040@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 09:59:31PM +0000, Crabtree, Andrew wrote:

> > > But the bigger thing, I think, is: who is setting GIT_DIR but not
> > > setting GIT_WORK_TREE to match? Because IMHO that's the situation
> > > that is causing the confusion.
> 
> > but it fails a test in t5601 around git-clone. 
> 
> Thanks jeff.  It looks like this might have been tried previously and
> abandoned?  I'm pretty far out of my league here in terms of how
> things are supposed to operate and any history around the previous
> attempts at making it work.
> [...]
> commit d95138e695d99d32dcad528a2a7974f434c51e79

Yeah, the commit you found was doing exactly the thing I suggested. IMHO
the right path forward is to actually fix the weirdness in git-clone. It
would be a backwards incompatibility, but a pretty obscure one. I think
we're likely to help more people than hurt by being able to handle
$GIT_WORK_TREE consistently. At least that's my gut feeling.

I guess one way to fix it without breaking compatibility would be for us
to set $GIT_WORK_TREE alongside $GIT_DIR, but _also_ set a special
$GIT_CLONE_NO_RESPECT_WORK_TREE variable that would instruct it that the
caller isn't trying to do trigger the special $GIT_WORK_TREE behavior.

But we'd have to carry that hack around forever, which doesn't excite
me.

-Peff
