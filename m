Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E087C201A7
	for <e@80x24.org>; Sun, 14 May 2017 08:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbdENIAr (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 04:00:47 -0400
Received: from [195.159.176.226] ([195.159.176.226]:53524 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdENIAq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 04:00:46 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1d9oSD-0007LX-Li
        for git@vger.kernel.org; Sun, 14 May 2017 10:00:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout -b remotes/origin/<branch> should not work
Date:   Sun, 14 May 2017 17:00:36 +0900
Message-ID: <xmqqefvr50m3.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYACtA_q6kJ=gGYe02H-a9g_GV=kKLn8jy2ZZKvjxGYNQ@mail.gmail.com>
        <20170514040048.evwtngo6bixtrput@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
Cancel-Lock: sha1:dEtl4dOAbhaR55iMY/cZvhmgdGE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think this problem extends beyond "remotes/". The worst is:
>
>   git checkout -b HEAD
>
> but there are many confusing variants:
>
>   git checkout -b refs/heads/foo
>   git checkout -b tags/v1.0
>
> etc. Those are all perfectly legal names, but almost certainly not what
> the user intended. I think the plumbing should continue to allow them,
> but I wouldn't object to some common-sense think-o protections in the
> "checkout -b" plumbing (especially if it could be disabled for power
> users).

Yup.  I suspect that the last one has uses (for those who may want
to build on v1.0 tag it is conceivable that a local branch they use
for it is named like so), but I agree that anything that begins with
refs/* is not something any sane person would want to use.

sanity.branchname configuration or something that tells "checkout"
and "branch" Porcelain commands to barf on an attempt to create such
refnames does not sound too bad, and making it on by default may not
even be a bad idea.  But that leads me to say it may not even need
to be a configurable thing (people who DO want funny names can
already and still use the plumbing).

In any case, no command after such a change should forbid checking
out such a funny-named branch if it already exists.  We should
complain only on (an attempted) creation.


