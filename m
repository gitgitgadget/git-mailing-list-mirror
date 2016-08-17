Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74301F6C1
	for <e@80x24.org>; Wed, 17 Aug 2016 07:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbcHQHgA (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 03:36:00 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:13405 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbcHQHf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 03:35:59 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3sDgy51pYGz5tlS;
	Wed, 17 Aug 2016 09:35:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id C72B7303C;
	Wed, 17 Aug 2016 09:35:56 +0200 (CEST)
Subject: Re: git-mergetool reverse file ordering
To:	David Aguilar <davvid@gmail.com>
References: <CAD8hE_yzNZDPkxRy8s4Fy2_dZN5ppWzLM_2xc01C-VAdR1Pj_g@mail.gmail.com>
 <20160814034221.GB21057@gmail.com>
 <20160814103801.tpixnskdsf5ycj66@john.keeping.me.uk>
 <CAD8hE_xR2mB3=_oot9cWxmFy7z4oBhjABNOo3aJKN=bOw5ybzQ@mail.gmail.com>
 <20160817012554.GA12991@gmail.com>
 <18a1ef52-1c5b-4f0a-5da2-777e816a1e3e@kdbg.org>
 <882f5f1d-19a6-7b4b-7c6a-7347981fee72@kdbg.org>
 <20160817064612.GA14619@gmail.com>
Cc:	Luis Gutierrez <luisgutz@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <1c089d6b-0acc-a5da-91bf-1887b6eaedbb@kdbg.org>
Date:	Wed, 17 Aug 2016 09:35:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <20160817064612.GA14619@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 17.08.2016 um 08:46 schrieb David Aguilar:
> The only thing that using diff-files doesn't address is the
> rerere support in mergetool where it processes the files in
> the order specified by "git rerere remaining".  This is why I
> initially thought we needed a generic sort-like command.

I see. This is actually an important code path. How about this code 
structure:

if test $# -eq 0
then
	cd_to_toplevel

	if test -e "$GIT_DIR/MERGE_RR"
	then
		set -- $(git rerere remaining)
	fi
fi
files=$(git diff-files --name-only --diff-filter=U -- "$@")

This does not require an enhancement of rerere-remaining and still 
captures all three cases that currently go through separate branches. 
(Throw in some version of --ignore-submodules= if necessary, but I guess 
it is not.)

We do have a problem if there are file names with spaces, but it is not 
a new problem.

> The patches could then be:
>
> 1. switch to diff-files, add tests, and document how
>    diff.orderFile affects mergetool.
>
> 2. Teach mergetool about the "-O<orderFile>" flag so that it can
>    override the configuration, and add tests.  It could be
>    argued that this should be squashed into (1).
>
> 3. (optional) teach "rerere remaining" to honor the
>    -O<orderfile> flag and teach mergetool to supply the option.
>
> Sound good?

Sure, except that 3. won't be necessary.

-- Hannes

