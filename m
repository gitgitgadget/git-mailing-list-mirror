Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B219C33CA2
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 09:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683802072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 09:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgAJJKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:10:43 -0500
Received: from smtpq5.tb.mail.iss.as9143.net ([212.54.42.168]:50936 "EHLO
        smtpq5.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgAJJKn (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Jan 2020 04:10:43 -0500
Received: from [212.54.42.115] (helo=lsmtp1.tb.mail.iss.as9143.net)
        by smtpq5.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1ipqJU-0003BV-QO; Fri, 10 Jan 2020 10:10:40 +0100
Received: from 92-109-146-195.cable.dynamic.v4.ziggo.nl ([92.109.146.195] helo=mail9.alinoe.com)
        by lsmtp1.tb.mail.iss.as9143.net with esmtp (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1ipqJU-0005FO-MJ; Fri, 10 Jan 2020 10:10:40 +0100
Received: from carlo by mail9.alinoe.com with local (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1ipqJU-0006Vn-Aj; Fri, 10 Jan 2020 10:10:40 +0100
Date:   Fri, 10 Jan 2020 10:10:40 +0100
From:   Carlo Wood <carlo@alinoe.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git submodule update  strange output behavior.
Message-ID: <20200110101040.00b93fa7@hikaru>
In-Reply-To: <xmqqtv54zcik.fsf@gitster-ct.c.googlers.com>
References: <20200109192040.46aaa01e@hikaru>
        <xmqqtv54zcik.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: carlo@alinoe.com
X-SA-Exim-Scanned: No (on mail9.alinoe.com); SAEximRunCond expanded to false
X-SourceIP: 92.109.146.195
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=M6j51B4s c=1 sm=1 tr=0 a=at3gEZHPcpTZPMkiLtqVSg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10 a=ybZZDoGAAAAA:8 a=BjFOTwK7AAAA:8 a=gFabPq3ExVsPHOp4R7EA:9 a=CjuIK1q_8ugA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=N3Up1mgHhB-0MyeZKEz1:22
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That seems only part of the problem, but yes.

It is only part of the problem because without --quiet
I get the same output; that is - the top-level is still
quiet, but the submodules aren't. That is out of balance
imho.

On Thu, 09 Jan 2020 10:54:27 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Carlo Wood <carlo@alinoe.com> writes:
> 
> > In a project containing submodules, one of the submodules
> > contains a submodule itself, which in turn also contains
> > a submodule.
> >
> > Overview:
> >
> > project/foobar  [submodule]
> > project/cwm4    [submodule]
> > project/evio    [submodule]
> > project/evio/protocol/matrixssl       [submodule]
> > project/evio/protocol/matrixssl/cwm4  [submodule]
> >
> > ('protocol' is a normal subdirectory)
> >
> > Running (with or without the --quiet),
> >
> > $ git submodule --quiet update --init --recursive --remote
> > Fetching submodule protocol/matrixssl
> > Fetching submodule protocol/matrixssl/cwm4
> > Fetching submodule cwm4
> >
> > This is odd (a bug imho) because
> >
> > 1) it seems to only print this fetching information for submodules
> > inside submodules, not for the top-level submodules.
> > 2) it even prints this when using --quiet
> > 3) it prints this every time (also when there is nothing more to
> > fetch).  
> 
> 
> Sounds like a symptom of (a) the top-level "git submodule update"
> knowing how to react to "--quiet" but (b) it forgets to pass down
> the "--quiet" when it recursively runs "git submodule update" in its
> submodules?
> 



-- 
Carlo Wood <carlo@alinoe.com>
