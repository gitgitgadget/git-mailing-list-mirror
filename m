Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6611F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 11:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbcJDLSw (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 07:18:52 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:57056 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbcJDLSv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 07:18:51 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1brNkF-0000Ia-8x; Tue, 04 Oct 2016 13:18:47 +0200
Date:   Tue, 4 Oct 2016 13:18:45 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Slow pushes on 'pu' - even when up-to-date..
Message-ID: <20161004111845.GA20309@book.hvoigt.net>
References: <CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Oct 03, 2016 at 02:11:36PM -0700, Linus Torvalds wrote:
> This seems to be because I'm now on 'pu' as of a day or two ago in
> order to test the abbrev logic, but lookie here:
> 
>     time git ls-remote ra.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux
>     .. shows all the branches and tags ..
>     real 0m0.655s
>     user 0m0.011s
>     sys 0m0.004s
> 
> so the remote is fast to connect to, and with network connection
> overhead and everything, it's just over half a second. But then:
> 
>     time git push ra.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux

The reason behind this is when pushing to an address we do not easily
have the remote refs to compare available. When pushing an existing ref
it would be easy and could get a shortcut but it gets more complicated
for new refs. Currently we fall back to walking the whole history since
that is "the most correct way" we have. But obviously it is not a
practical solution in any way.

I mentioned this fact when discussing the current state and my patches
to make this check less painful. So we still need to think about a
solution for this check when passing an address.

IMO: It's definitely not ready to be switched on as default, unless we
find something a lot cheaper for the above case.

My idea of a solution goes like this:
  * collect all SHA1's of the remotes refs
  * check if we have them locally
  * if not we abort and tell the user to fetch them somehow into local
    refs or disable the check
  * when we have them locally we proceed passing those SHA1's as bases
    instead of --remotes=<name>

Cheers Heiko
