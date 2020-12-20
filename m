Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64E1C4361B
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 10:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BE022D50
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 10:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgLTK3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 05:29:18 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:57927 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgLTK3S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 05:29:18 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4CzJjG1876z5tl9;
        Sun, 20 Dec 2020 11:28:34 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0D78E1DB0;
        Sun, 20 Dec 2020 11:28:33 +0100 (CET)
Subject: Re: [BUG] Regression in 'git mergetool --tool-help'
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git List <git@vger.kernel.org>, pudinha <rogi@skylittlesystem.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
 <CAMP44s15CJVGRg5Qxcgqq8xVkDhpVyxND67-iQZF9uZ_PRstEQ@mail.gmail.com>
 <xmqqczz6qs0p.fsf@gitster.c.googlers.com>
 <5fddeda8a5a92_1de0de2088a@natae.notmuch>
 <xmqqsg81pvm8.fsf@gitster.c.googlers.com>
 <c4f2330f-715b-1745-5ad7-5477f4e833db@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <568f42a0-f630-64ca-9f77-183dcaa56d1e@kdbg.org>
Date:   Sun, 20 Dec 2020 11:28:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <c4f2330f-715b-1745-5ad7-5477f4e833db@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.12.20 um 03:13 schrieb Philippe Blain:
> Thanks for both answers. Felipe's solution does the trick, but Junio's
> does not;
> it seems we do have to have a newline there. The following also works,
> and I think
> is portable:
> 
> diff --git i/git-mergetool--lib.sh w/git-mergetool--lib.sh
> index 2defef28cd..6f03975493 100644
> --- i/git-mergetool--lib.sh
> +++ w/git-mergetool--lib.sh
> @@ -46,7 +46,7 @@ show_tool_names () {
>          while read scriptname
>          do
>              setup_tool "$scriptname" 2>/dev/null
> -            variants="$variants$(list_tool_variants)\n"
> +            variants="$(echo "$variants" && list_tool_variants)"
>          done
>          variants="$(echo "$variants" | sort | uniq)"
> 
> I figured out what was different between the different Ubuntu versions I
> was testing:
> the Ubuntu 14 and 18 systems have Bash as /bin/sh, but my Ubuntu 20 system
> has /usr/bin/dash as /bin/sh (the default for Ubuntu these days).
> 
> I'll try to send a formal patch with the diff above, time permitting...

If possible, please do not use sub-processes like in your suggested
patch. How about

		variants="$variants
$(list_tool_variants)"

It leaves a blank line at the beginning of $variants instead of the end
and should not make a difference in the outcome of

	variants="$(echo "$variants" | sort | uniq)"

BTW, is `sort -u` not available everywhere?

-- Hannes
