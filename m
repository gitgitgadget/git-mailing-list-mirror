Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528E2C33CA2
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 09:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAD12072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 09:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgAJJMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:12:53 -0500
Received: from smtpq5.tb.mail.iss.as9143.net ([212.54.42.168]:53120 "EHLO
        smtpq5.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgAJJMx (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Jan 2020 04:12:53 -0500
Received: from [212.54.42.115] (helo=lsmtp1.tb.mail.iss.as9143.net)
        by smtpq5.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <carlo@alinoe.COM>)
        id 1ipqLb-0004Pl-FZ; Fri, 10 Jan 2020 10:12:51 +0100
Received: from 92-109-146-195.cable.dynamic.v4.ziggo.nl ([92.109.146.195] helo=mail9.alinoe.com)
        by lsmtp1.tb.mail.iss.as9143.net with esmtp (Exim 4.90_1)
        (envelope-from <carlo@alinoe.COM>)
        id 1ipqLb-0005cV-BS; Fri, 10 Jan 2020 10:12:51 +0100
Received: from carlo by mail9.alinoe.com with local (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1ipqLb-0006WZ-70; Fri, 10 Jan 2020 10:12:51 +0100
Date:   Fri, 10 Jan 2020 10:12:51 +0100
From:   Carlo Wood <carlo@alinoe.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git submodule update  strange output behavior.
Message-ID: <20200110101251.3b9f9332@hikaru>
In-Reply-To: <xmqq8smgz9as.fsf@gitster-ct.c.googlers.com>
References: <20200109192040.46aaa01e@hikaru>
        <xmqqtv54zcik.fsf@gitster-ct.c.googlers.com>
        <xmqq8smgz9as.fsf@gitster-ct.c.googlers.com>
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
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=M6j51B4s c=1 sm=1 tr=0 a=at3gEZHPcpTZPMkiLtqVSg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10 a=ybZZDoGAAAAA:8 a=BjFOTwK7AAAA:8 a=bzAFebWYQkT7IjBsXEQA:9 a=CjuIK1q_8ugA:10 a=8cuHeNKGeTYA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=N3Up1mgHhB-0MyeZKEz1:22
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems to me that the other part of the problem is printing
this output for submodules when nothing (needed to be) is fetched.

I haven't tested if output for the top-level is printed (without
--quiet) when also there fetching is needed; is that even possible?

On Thu, 09 Jan 2020 12:03:55 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Carlo Wood <carlo@alinoe.com> writes:
> >  
> >> In a project containing submodules, one of the submodules
> >> contains a submodule itself, which in turn also contains
> >> a submodule.
> >>
> >> Overview:
> >>
> >> project/foobar  [submodule]
> >> project/cwm4    [submodule]
> >> project/evio    [submodule]
> >> project/evio/protocol/matrixssl       [submodule]
> >> project/evio/protocol/matrixssl/cwm4  [submodule]
> >>
> >> ('protocol' is a normal subdirectory)
> >>
> >> Running (with or without the --quiet),
> >>
> >> $ git submodule --quiet update --init --recursive --remote
> >> Fetching submodule protocol/matrixssl
> >> Fetching submodule protocol/matrixssl/cwm4
> >> Fetching submodule cwm4
> >>
> >> This is odd (a bug imho) because
> >>
> >> 1) it seems to only print this fetching information for submodules
> >> inside submodules, not for the top-level submodules.
> >> 2) it even prints this when using --quiet
> >> 3) it prints this every time (also when there is nothing more to
> >> fetch).  
> >
> >
> > Sounds like a symptom of (a) the top-level "git submodule update"
> > knowing how to react to "--quiet" but (b) it forgets to pass down
> > the "--quiet" when it recursively runs "git submodule update" in its
> > submodules?  
> 
> Just a shot in the dark.  Not even compile tested ;-)
> 
>  submodule.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 9da7181321..535bb6bf04 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1454,11 +1454,12 @@ static int get_next_submodule(struct
> child_process *cp, argv_array_pushv(&cp->args, spf->args.argv);
>  			argv_array_push(&cp->args, default_argv);
>  			argv_array_push(&cp->args,
> "--submodule-prefix"); -
>  			strbuf_addf(&submodule_prefix, "%s%s/",
>  						       spf->prefix,
>  						       task->sub->path);
>  			argv_array_push(&cp->args,
> submodule_prefix.buf);
> +			if (spf->quiet)
> +				argv_array_push(&cp->args,
> "--quiet"); 
>  			spf->count++;
>  			*task_cb = task;



-- 
Carlo Wood <carlo@alinoe.com>
