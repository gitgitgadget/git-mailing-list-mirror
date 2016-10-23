Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA92E20229
	for <e@80x24.org>; Sun, 23 Oct 2016 10:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbcJWKOa (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 06:14:30 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:1620 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752092AbcJWKOa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 06:14:30 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t1wJ31SN0z5tlD;
        Sun, 23 Oct 2016 12:14:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 93C7652E5;
        Sun, 23 Oct 2016 12:14:26 +0200 (CEST)
Subject: Re: [PATCH 2/3] submodule tests: replace cloning from . by "$(pwd)"
To:     Stefan Beller <sbeller@google.com>
References: <20161021235939.20792-1-sbeller@google.com>
 <20161021235939.20792-3-sbeller@google.com>
 <c6c5ce05-3511-a992-e079-316f0ce90ecd@kdbg.org>
 <xmqqh984aldl.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaukGh2ynkOQcF=skzxTMYr8CFRyGJw6FEmNsTAcaG_VQ@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <61637cd9-8f83-c988-15c0-54f948153c07@kdbg.org>
Date:   Sun, 23 Oct 2016 12:14:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaukGh2ynkOQcF=skzxTMYr8CFRyGJw6FEmNsTAcaG_VQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.10.2016 um 22:46 schrieb Stefan Beller:
> I have looked into it again, and by now I think the bug is a feature,
> actually.
>
> Consider this:
>
>     git clone . super
>     git -C super submodule add ../submodule
>     # we thought the previous line is buggy
>     git clone super super-clone

At this point, we *should* have this if there were no bugs (at least 
that is my assumption):

   /tmp
   !
   + submodule     <- submodule's remote repo
   !
   + foo           <- we are here (.), super's remote repo
     !
     + super       <- remote.origin.url=/tmp/foo/.
       !
       + submodule <- remote.origin.url=/tmp/foo/./../submodule
                      submodule.submodule.url=../submodule

When I test this, 'git submodule add' fails:

foo@master> git -C super submodule add ../submodule
fatal: repository '/tmp/foo/submodule' does not exist
fatal: clone of '/tmp/foo/submodule' into submodule path 
'/tmp/foo/super/submodule' failed

> Now in the super-clone the ../submodule is the correct
> relative url, because the url where we cloned from doesn't
> end in /.

I do not understand why this would be relevant. The question is not how 
the submodule's remote URL ends, but how the submodule's remote URL is 
constructed from the super-project's URL and the relative path specified 
for 'git submodule add'.

Whether ../submodule or ./submodule is the correct relative URL depends 
on where the origin of the submodule is located relative to the origin 
of the super-project. In the above example, it is ../submodule. However, 
the error message tells us that git looked in /tmp/foo/submodule, which 
looks like the /. bug!

I do not understand where you see a feature here. What am I missing?

-- Hannes

