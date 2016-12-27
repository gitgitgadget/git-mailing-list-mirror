Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71FE6200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 21:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755014AbcL0VSa (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 16:18:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59724 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753107AbcL0VSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 16:18:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF6CD5B5EA;
        Tue, 27 Dec 2016 16:17:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=XrqmAI1sbkCaRkVByokAvOAFuBE=; b=Y73YzlShfYmv+dIYG6X5
        GGbNDF0oTKf/wNlZFdAY/cJSItcUM/NOEdSzaBwHdIMushdZhMxDLfWqr3YATHIT
        rHhk+3pq8xZSiwcC3xn3jTG1NK/uyvGWcUL/hiAyfCqC5i1Bsrp9+0EwTuPNsmcX
        JZNbtYSeK1IM2zVj+rO9Pjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=CsUYStunXc+Kyddvz5IBewQwLG19v/dCLfgjzJfroIn4ir
        MnSAAl+QTIR+kZ7ZxIyKz/F2ODkoBc8rDli0EAuzE1oEp/+lisfaaPJXaDjdmybW
        RuvcaY0SEiHGeEcbFcpG9h//tdebQ/MfFCXppaV8H840ojKxrBvlW00cM2IIU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A84135B5E9;
        Tue, 27 Dec 2016 16:17:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 312A95B5E8;
        Tue, 27 Dec 2016 16:17:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v9 19/20] branch: use ref-filter printing APIs
Date:   Tue, 27 Dec 2016 13:17:04 -0800
References: <20161227162357.28212-1-Karthik.188@gmail.com>
        <20161227162357.28212-20-Karthik.188@gmail.com>
Message-ID: <xmqqinq56phu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E25BFC82-CC79-11E6-B32F-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

>  static char branch_colors[][COLOR_MAXLEN] = {
> -	GIT_COLOR_RESET,
> -	GIT_COLOR_NORMAL,	/* PLAIN */
> -	GIT_COLOR_RED,		/* REMOTE */
> -	GIT_COLOR_NORMAL,	/* LOCAL */
> -	GIT_COLOR_GREEN,	/* CURRENT */
> -	GIT_COLOR_BLUE,		/* UPSTREAM */
> +	"%(color:reset)",
> +	"%(color:reset)",	/* PLAIN */
> +	"%(color:red)",		/* REMOTE */
> +	"%(color:reset)",	/* LOCAL */
> +	"%(color:green)",	/* CURRENT */
> +	"%(color:blue)",	/* UPSTREAM */
>  };

The contents of this table is no longer tied to COLOR_MAXLEN.  The
above entries used by default happen to be shorter, but it is
misleading.

	static const char *branch_colors[] = {
	"%(color:reset)",
	...
	};

perhaps?

More importantly, does this re-definition of the branch_colors[]
work with custom colors filled in git_branch_config() by calling
e.g. color_parse("red", branch_colors[BRANCH_COLOR_REMOTE]), where
"red" and "remote" come from an existing configuration file?

	[color "branch"]
		remote = red

It obviously would not work if you changed the type of branch_colors[]
because the color_parse() wants the caller to have allocated space
of COLOR_MAXLEN.  

But if filling these ANSI escape sequence into the format works OK,
then doesn't it tell us that we do not need to have this change to
use "%(color:reset)" etc. as the new default values?
