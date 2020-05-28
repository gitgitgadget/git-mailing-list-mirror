Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C73C433E1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD602075A
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405702AbgE1SAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:00:18 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:55727 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405669AbgE1SAK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:00:10 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 09DD13C057C;
        Thu, 28 May 2020 20:00:06 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0_D8NleWgyaU; Thu, 28 May 2020 20:00:00 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 3D9C23C00BE;
        Thu, 28 May 2020 20:00:00 +0200 (CEST)
Received: from lxhi-065.adit-jv.com (10.72.94.23) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 28 May
 2020 19:59:59 +0200
Date:   Thu, 28 May 2020 19:59:54 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>, <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Assessing about commit order in upstream Linux
Message-ID: <20200528175954.GA9275@lxhi-065.adit-jv.com>
References: <20200526065320.GA18107@lxhi-065.adit-jv.com>
 <xmqqr1v6oh6y.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <xmqqr1v6oh6y.fsf@gitster.c.googlers.com>
X-Originating-IP: [10.72.94.23]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, May 26, 2020 at 08:21:25AM -0700, Junio C Hamano wrote:
> Eugeniu Rosca <erosca@de.adit-jv.com> writes:
> 
> > So, the two approaches lead to different results. If you see any false
> > assumption or mistaken belief, could you please pinpoint that? TIA.
> 
> Perhaps the assumption/belief that the set of commits in a history
> can be totally ordered is the issue?  When multiple people work
> together on a project, especially in a project where "pull --no-ff"
> is not enforced, there can exist only partial order among them?
> 

IMHO it might be an issue in truly decentralized projects, for which we
can't define an upstream and a downstream. But is it an issue for Linux?

Here is a quick attempt to sketch how commits flow into linux/master,
every development cycle, again and again, respecting the same pattern.

       +-----------------o Linus
       |   +-------------o Maintainers
       |   |           +-o Contributors
       v   v           v

master o
       |   +-------------------+
       |   |                   |
   C(M)o---o Same story as "A" |
       |   |                   |
     B o   +-------------------+
       |
   A(M)o---o A^2 
       |   |   
   A~1 o   o A^2~1
       |   |   
   A~2 o   o A^2~2
           |
           o A^2~3(M)--o A^2~3^2
           |           |
           |           o A^2~3^2~1
           |           |
           |           o A^2~3^2~2
           |
           o A^2~4(M)--o A^2~4^2
           |           |
           o A^2~5     o A^2~4^2~1
                       |
                       o A^2~4^2~2

The order of these commits matter to me because:

 - Commits A^2~4^2~2 through A^2~4^2 likely originate from the same
   series, with a well defined topic/scope and inner sequence. It would
   be ideal to mirror this same order during backporting. Otherwise,
   both the product of porting is questionable and the reviewing
   effort is high.

 - Likewise, commits A^2~3^2~2 through A^2~3^2 probably come from one
   single series. The reviewers would hugely appreciate if these are
   not  scattered during backporting, but are kept together (preferably
   in the exact same succession).

 - Any merge commit (marked with '(M)' above) might carry a conflict
   resolution in itself (aka 'evil merge') which might act as dependency
   to any of its children. So, cherry picking commits in no particular
   order may very likely introduce build and runtime failures, whose
   reasons may be difficult to spot in the downstream projects.

Having said that, I am curious, does anybody resonate with these
statements, based on personal experience (in Linux or other projects)?

-- 
Best regards,
Eugeniu Rosca
