Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5FC20966
	for <e@80x24.org>; Sun,  9 Apr 2017 09:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdDIJIw (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 05:08:52 -0400
Received: from mail.ableton.net ([62.96.12.117]:40827 "EHLO mail.ableton.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751814AbdDIJIv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 05:08:51 -0400
X-Greylist: delayed 1805 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Apr 2017 05:08:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ableton.com; s=mail;
        h=Content-Type:MIME-Version:Message-ID:Date:From:Subject:In-Reply-To:CC:To; bh=3m9THs6xR4UZFdPYhU6LaxZCmXsJ9mlBpvNtPO3aZ08=;
        b=fYaZMqAWNI7orqbDoMujB+TRbjuzpPSOIt3CVygVFgW0MCKnkBoAmQg3MDAHOKrjjaEssjepO4GeXTa+ng2Ckl4SJU9+Iy68gW4zBkgP4g8J/CuCzDC9IoWh6eBZfAO1701h8S3Akauurl31aQ2wzqr+CFribPdPAOaVzD0oC08=;
Received: from moon.office.ableton.com ([10.1.15.25])
        by mail.ableton.net with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <haller@ableton.com>)
        id 1cx8Mu-0005Jh-1Z; Sun, 09 Apr 2017 08:38:44 +0000
Received: from [192.168.42.152] (178.0.62.147) by mail.office.ableton.com
 (10.1.15.25) with Microsoft SMTP Server (TLS) id 14.3.319.2; Sun, 9 Apr 2017
 10:38:43 +0200
To:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>
CC:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?= <avarab@gmail.com>,
        "Matt McCutchen" <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <20170408221302.e7sv6cy4xayr2w7o@sigill.intra.peff.net>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   Stefan Haller <haller@ableton.com>
Date:   Sun, 9 Apr 2017 10:38:42 +0200
Message-ID: <1n47m37.1xocjxu1j1pyM%haller@ableton.com>
Organization: Ableton
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [178.0.62.147]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:

> > It might be possible to generate these lease tags prior to operations
> > which modify history and then maybe having a way to list them so you
> > can select which one you meant when you try to use force-with-lease..
> 
> So yeah, I think that is the more interesting direction. I hadn't
> considered resolving the multiple-operation ambiguity at push time. But
> I guess it would be something like "you did a rebase on sha1 X at time
> T, and then one on Y at time T+N", and you pick which one you're
> expecting.

I think it's wrong to think about these leases as something that you
take before you start a rewindy operation. That's the wrong time to take
the lease; by that time, the remote tracking branch may already contain
new things that you haven't seen yet, so using that as a lease at that
time will overwrite those things later. You have to take the lease at a
time where you know that your local branch and the remote tracking
branch are up to date with each other, which is after pull and push. And
if you do that, there's no multiple-operation ambiguity to deal with at
all.

> And I think that may be converging on the "integrate" refs that Stefan is
> talking about elsewhere (or some isomorphism of it).

Does it make things clearer if we don't use the term "integrate", but
call the config value in my proposal simply "branch.*.lease"?


-- 
Stefan Haller
Ableton
http://www.ableton.com/
