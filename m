Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396C62036C
	for <e@80x24.org>; Thu, 16 Nov 2017 14:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934273AbdKPOT2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 09:19:28 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:6298 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933562AbdKPOT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 09:19:27 -0500
Received: from [192.168.2.201] ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id FL0leGAhlNSVVFL0meN52p; Thu, 16 Nov 2017 14:19:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510841965;
        bh=IznFz+skYSMctamsthVC8GwiEGjjlBHyZfisR52+UXc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BxODRaHPr4JFKkdu4a6vw83MsIN++3wpNLinzcVREsYvYUH0ZleAD6DgGi0e+398p
         wHs/ojNQvdVb4eFqkHo7N5Yud3DBQum5WvwnHRHPx1HciJjRQfogjKXG/R1CIw1g7C
         gkpbKTh31FQ2LBE41YDv17tNTX02Xw2l20zrVnB4=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=NYGW7yL4 c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=1N6lQhKX0jf5CFLJ_aAA:9 a=UHZf0uTGg3lcstnP:21 a=_lC8c_42_DAMRhAQ:21
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: reschedule pick if index can't be locked
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <20171115104125.1686-1-phillip.wood@talktalk.net>
 <xmqqshdex0ff.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b2ea8018-7afc-46fa-381d-5c471a438fe5@talktalk.net>
Date:   Thu, 16 Nov 2017 14:19:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqshdex0ff.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfM7UX43mMw+oEPv/C/sQjNg138aAye+4cdtIakSN7Om8Zy4V+/lQTh94PJIUkKXjB8f1AWuLtVLo0wAROt9hZ/7BwMHQ66MN7Im2V6CAaLbBr/13ja9+
 HznlAsKl/zg6gC3d8jcQF8j1PwP/0imWQo1jIA25cRUsRn2feTuTa2IkgPBsNgSDWcCZobyZWLj0vbEK9GcwuoSd7vFVvuiA1JTuq4wNGWMYbHhj6ZXz6Crj
 mS+ne0QF80stNlAplvgR8w34IzNpMX82b+uFkHmR/CKAfXTSWEKFh/JzVokUE9VFVW8tBwKrFdumP3cJt8xXBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/11/17 05:22, Junio C Hamano wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> Date: Wed, 15 Nov 2017 10:41:25 +0000
> 
> If the index cannot be locked in do_recursive_merge(), issue an
> error message and go on to the error recovery codepath, instead of
> dying.  When the commit cannot be picked, it needs to be rescheduled
> when performing an interactive rebase, but just dying there won't
> allow that to happen, and when the user runs 'git rebase --continue'
> rather than 'git rebase --abort', the commit gets silently dropped.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> 
>  * I've queue this, taking input from responses by Dscho and Martin.

That's great thanks, sorry for the bug in the original

Best Wishes

Phillip

>  sequencer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 332a383b03..10924ffd49 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -438,7 +438,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  	char **xopt;
>  	static struct lock_file index_lock;
>  
> -	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
> +	if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR) < 0)
> +		return -1;
>  
>  	read_cache();
>  
> 

