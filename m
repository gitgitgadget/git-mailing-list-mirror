Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBFBC433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 21:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiJEVUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 17:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJEVUs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 17:20:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45C45AC45
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 14:20:47 -0700 (PDT)
Received: (qmail 9220 invoked by uid 109); 5 Oct 2022 21:20:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Oct 2022 21:20:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18289 invoked by uid 111); 5 Oct 2022 21:20:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Oct 2022 17:20:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Oct 2022 17:20:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] t/lib-httpd: pass LANG to Apache
Message-ID: <Yz31Lv+97z9p/0TK@coredump.intra.peff.net>
References: <3b370f7b-df84-0629-d334-aa9dfbca1c05@web.de>
 <xmqqtu4inj6q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtu4inj6q.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2022 at 12:50:53PM -0700, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
> 
> > t5411 starts a web server with no explicit language setting, so it uses
> > the system default.  Ten of its tests expect it to return error messages
> > containing the prefix "fatal: ", emitted by die().  This prefix can be
> > localized since a1fd2cf8cd (i18n: mark message helpers prefix for
> > translation, 2022-06-21), however.  As a result these ten tests break
> > for me on a system with LANG="de_DE.UTF-8" because the web server sends
> > localized messages with "Schwerwiegend: " instead of "fatal: ".
> >
> > Fix these tests by passing LANG to the web server, which is set to "C"
> > by t/test-lib.sh, to get untranslated messages on both sides.
> 
> It is a good thing to do, but we seem to be extra conservative and
> set both LC_ALL=C LANG=C (presumably by following the habit acquired
> back when locale support were being introduced to various systems
> with different degree, which way predates Git itself) and export
> them in the main part of the test framework.
> 
> Shouldn't we be doing the same here?

I think setting both probably is overkill. But if we are going to set
one, the important one is LC_ALL. It overrides specific LC_* variables,
which in turn override LANG. So just setting LANG would get confused if
LC_MESSAGES were set, for example.

That said, there probably is no downside to passing through both, so we
might as well do so.

Other than that, the patch is obviously the right thing to be doing. I'm
surprised it took this long for it to be a problem. ;)

-Peff
