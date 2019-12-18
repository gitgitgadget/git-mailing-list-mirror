Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBA3C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CC52176D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bpYekbNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfLRSww (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:52:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63895 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfLRSww (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 13:52:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D26381CA36;
        Wed, 18 Dec 2019 13:52:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A7GIIOq9e93tJ7WtvY9p+pAKjQw=; b=bpYekb
        NTLgs5ZQgv0mrMGpjcCN4Wr29ZHfCOqBSZ4a1Dxtn3bWjDyPxaFTmYjXlBw22tEl
        SCesw/m/sxL+wCh306UZNKGaTY6XH+MJLjG6miVtAG6Li8eWouvH/R2SD+aONJ/Y
        hnTCBLQpilZ5xlEGB+EV3Lb2uxz3CCFWqS12M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MO8tsIivMdX9VX+aeFrYdBGaDAD3loeP
        thGbk/XwuwdSTOQAd7H9HwCWPgyxuxLu8G4VGPiGYFD92ry7GySxHmzdI0YqMj54
        lgJSGNWEmmE3/VzohTIj0MAdTF4duK8PyIYdb+GwqtGFPcaWpUWcslM1jN2KOzHa
        rfEfwkBfL/Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C92B71CA35;
        Wed, 18 Dec 2019 13:52:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 399E31CA34;
        Wed, 18 Dec 2019 13:52:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 1/5] parse_branchname_arg(): fix dash_dash_pos, drop argcount
References: <pull.479.git.1574969538.gitgitgadget@gmail.com>
        <771947d01f759a72b9f8999e929bf1f7765327aa.1574969538.git.gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 10:52:45 -0800
In-Reply-To: <771947d01f759a72b9f8999e929bf1f7765327aa.1574969538.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Thu, 28 Nov 2019
        19:32:14 +0000")
Message-ID: <xmqqk16tea9u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 948A8B26-21C7-11EA-B9FF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> `dash_dash_pos` was only calculated under `opts->accept_pathspec`. This
> is unexpected to readers and made it harder to reason about the code.
> Fix this by restoring the expected meaning.

Perhaps.  I think the original reasoning was to compute only where
dash_dash_pos will be needed, but the code changes over time, and
places that need the value of dash_dash_pos would change over time,
so from that point of view, I think it makes sense to make sure it
gets always computed like this patch does.

> Simplify the code by dropping `argcount` and useless `argc` / `argv`
> manipulations.

I am not sure if this is a good change, though.  It goes against the
reasoning that makes the above "dash-dash-pos" change is a good one,
doesn't it?  When the code changes over time, wouldn't it make the
code more clear to keep track of the count of args it saw in a
separate variable, than relying on the invariant that currently
happens to hold which is "if dash-dash is after the first argument,
return 2 and otherwise return 1"?

> @@ -1121,7 +1121,6 @@ static int parse_branchname_arg(int argc, const char **argv,
>  				int *dwim_remotes_matched)
>  {
>  	const char **new_branch = &opts->new_branch;
> -	int argcount = 0;
>  	const char *arg;
>  	int dash_dash_pos;
>  	int has_dash_dash = 0;
> @@ -1180,17 +1179,21 @@ static int parse_branchname_arg(int argc, const char **argv,
>  	arg = argv[0];
>  	dash_dash_pos = -1;
>  	for (i = 0; i < argc; i++) {
> -		if (opts->accept_pathspec && !strcmp(argv[i], "--")) {
> +		if (!strcmp(argv[i], "--")) {
>  			dash_dash_pos = i;
>  			break;
>  		}
>  	}
> -	if (dash_dash_pos == 0)
> -		return 1; /* case (2) */
> -	else if (dash_dash_pos == 1)
> -		has_dash_dash = 1; /* case (3) or (1) */
> -	else if (dash_dash_pos >= 2)
> -		die(_("only one reference expected, %d given."), dash_dash_pos);
> +
> +	if (opts->accept_pathspec) {
> +	    if (dash_dash_pos == 0)
> +		    return 1; /* case (2) */
> +	    else if (dash_dash_pos == 1)
> +		    has_dash_dash = 1; /* case (3) or (1) */
> +	    else if (dash_dash_pos >= 2)
> +		    die(_("only one reference expected, %d given."), dash_dash_pos);

Non-standard indentation?  In our code, a level of indent is another
horizontal tab.

> +	}
