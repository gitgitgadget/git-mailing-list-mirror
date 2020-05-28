Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867C4C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74173207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405762AbgE1SMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:12:36 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:55783 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405688AbgE1SMe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:12:34 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id CE08C3C04C1;
        Thu, 28 May 2020 20:12:32 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7t3I6czE2Sm9; Thu, 28 May 2020 20:12:27 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id D76A93C00BE;
        Thu, 28 May 2020 20:12:27 +0200 (CEST)
Received: from lxhi-065.adit-jv.com (10.72.94.23) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 28 May
 2020 20:12:27 +0200
Date:   Thu, 28 May 2020 20:12:26 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
CC:     Junio C Hamano <gitster@pobox.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>, <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Assessing about commit order in upstream Linux
Message-ID: <20200528181226.GB9275@lxhi-065.adit-jv.com>
References: <20200526065320.GA18107@lxhi-065.adit-jv.com>
 <xmqqr1v6oh6y.fsf@gitster.c.googlers.com>
 <20200526171443.GE25173@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526171443.GE25173@kitsune.suse.cz>
X-Originating-IP: [10.72.94.23]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michal,

On Tue, May 26, 2020 at 07:14:43PM +0200, Michal Suchánek wrote:
> On Tue, May 26, 2020 at 08:21:25AM -0700, Junio C Hamano wrote:
> > Eugeniu Rosca <erosca@de.adit-jv.com> writes:
> > 
> > > So, the two approaches lead to different results. If you see any false
> > > assumption or mistaken belief, could you please pinpoint that? TIA.
> > 
> > Perhaps the assumption/belief that the set of commits in a history
> > can be totally ordered is the issue?  When multiple people work
> > together on a project, especially in a project where "pull --no-ff"
> > is not enforced, there can exist only partial order among them?
> > 
> As in if you have history with two branches
> 
>    D
>   / \
>  B   C
>   \ /
>    A
> 
> commits B and C are not comparable. They are both between A and D but
> the order of B and C is arbitrary. Different renderings of the history
> may choose different order of B and C. This is a simle example. Linux
> history is a spaghetti of tens of branches.

While in theory 'B' and 'C' might look equivalent, IMHO in practice
there is a clear distinction between the two. It's commonly known that
Git refers to 'B' as the 'first parent' of 'D'. Git also provides means
to identify such first parents via 'git log --first-parent'.

A fun fact about first parents is that, unless Linus is on vacation
and hands over his responsibilities to GKH, you will be quite
confident that 'git log --first-parent linux/master' will list
stuff committed by Linus himself. That's why (I bet) in the minds
of people involved in Linux development, the diagram looks like:

    D
    | \
    B  C
    | /
    A

IMHO the fact that 'A' is the parent of 'C' (IOW 'C' has an appropriate
base version) is mostly important to achieve an effortless merge of 'C'
and later on loses its major significance. So, I would say that
(contents-wise) the diagram can be further reduced to:

    D
    | \
    B  D^2
    |
    A

Just visually, a sane backporting order looks A, B an D^2 (A is assumed
non-merge and D is skipped, since cherry picking merges is not common).

I am quite sure people have thought about backporting techniques and
strategies long before I started to ask these questions. So, I am
still looking forward to seeing various experiences shared.

-- 
Best regards,
Eugeniu Rosca
