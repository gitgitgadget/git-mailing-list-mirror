Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D1F1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 01:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeKHKvN (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 05:51:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:44310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728164AbeKHKvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 05:51:13 -0500
Received: (qmail 19270 invoked by uid 109); 8 Nov 2018 01:18:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Nov 2018 01:18:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20857 invoked by uid 111); 8 Nov 2018 01:17:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Nov 2018 20:17:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Nov 2018 20:18:14 -0500
Date:   Wed, 7 Nov 2018 20:18:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
Message-ID: <20181108011813.GA10148@sigill.intra.peff.net>
References: <pull.66.git.gitgitgadget@gmail.com>
 <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
 <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org>
 <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
 <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org>
 <20181107204142.GA30078@sigill.intra.peff.net>
 <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org>
 <20181107220320.GA8970@sigill.intra.peff.net>
 <xmqqlg649zs8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlg649zs8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 08, 2018 at 09:30:15AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Nov 07, 2018 at 10:36:52PM +0100, Johannes Sixt wrote:
> >
> > All that said, if we're just interested in allowing this for config,
> > then we already have such a wrapper function: git_config_pathname().
> >
> > So I don't think it's a big deal to implement it in any of these ways.
> > It's much more important to get the syntax right, because that's
> > user-facing and will be with us forever.
> 
> All of us are on the same page after seeing the clarification by
> Dscho, it seems.  I came to pretty much the same conclusion this
> morning before reading this subthread.  Outside config values, the
> callers of expand_user_path() only feed "~/.git$constant", and they
> are all about "personal customization" that do not want to be shared
> with other users of the same installation, so "relative to runtime
> prefix" feature would not be wanted.  But we do not know about new
> caller's needs.  For now I am OK to have it in expand_user_path(),
> possibly renaming the function if people feel it is needed (I don't).

I think we would want to carefully think about the call in enter_repo().
We do not want git-daemon to accidentally expose repositories in
$RUNTIME_PREFIX.

Looking over the code, I think this is OK. The expansion happens in
enter_repo(), and then we take the path that was found and do our
ok_paths checks on it (which makes sense -- even now you'd ask to export
"/home/" and it would need to look at "~peff/repo.git" and expand that
to "/home/peff/repo.git" before doing a simple string check.

> Between ~<reserved name> and $VARIABLE_LOOKING_THINGS, I do not have
> a strong preference either way, but I am getting an impression that
> the latter is more generally favoured in the discussion?

I certainly prefer the latter, but I thought I was the only one to have
expressed support so far. ;)

-Peff
