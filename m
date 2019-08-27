Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42AAD1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 20:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfH0Uce (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 16:32:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57123 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfH0Uce (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 16:32:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2449115B3D0;
        Tue, 27 Aug 2019 16:32:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j7DeK7huaQNh4/b6vco5XTz6/p0=; b=eJ/FOI
        SoPU6siod1f+jHlhxaqdAbd2nc3d3GEqixU1wYH6goBhsLbwLcB9iC15pNKjicao
        rlRrUt+xzg9Ehr//vR8JwomeVSHAod7wCJC/LoTL5XvXM00+dOX1bfHWb2MY62Q4
        CP2mAV+T3Y7Bx1IrOWWScPt3aRXO7cX6pmlA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QQYFjR056v+qCV4WSPyuorsLI35oT6jQ
        P/HBXLNUclYz3RFONrjj+MfOMudLUwmpR07TTLpPWfD99p/DN9aGBPdaAQkqSif4
        OfpwNujYK4QtvRM4/xq5X9wG0UVWr54IEojPNbe8Vi9e75eJfRB5RXSi9tTdSHQL
        6QjlbV0kah0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19F2815B3CD;
        Tue, 27 Aug 2019 16:32:32 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7994C15B3CA;
        Tue, 27 Aug 2019 16:32:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitk: Make web links clickable
References: <20190826221444.GB7402@blackberry>
Date:   Tue, 27 Aug 2019 13:32:30 -0700
In-Reply-To: <20190826221444.GB7402@blackberry> (Paul Mackerras's message of
        "Tue, 27 Aug 2019 08:14:44 +1000")
Message-ID: <xmqqimqi2vtt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB5AA9A4-C909-11E9-828D-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@ozlabs.org> writes:

> This makes gitk look for lines in the commit message which start with
> "Link:" or "BugLink:" followed by a http or https URL, and make the
> URL clickable.  Clicking on it will invoke an external web browser with
> the URL.
>
> The web browser command is by default "xdg-open" on Linux, "open" on
> MacOS, and "cmd /c start" on Windows.  The command can be changed in
> the preferences window, and it can include parameters as well as the
> command name.  If it is set to the empty string then URLs will no
> longer be made clickable.
>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---

>  gitk | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/gitk b/gitk
> index a14d7a1..4577150 100755
> --- a/gitk
> +++ b/gitk
> @@ -7016,6 +7016,7 @@ proc commit_descriptor {p} {
>  
>  # append some text to the ctext widget, and make any SHA1 ID
>  # that we know about be a clickable link.
> +# Also look for lines of the form "Link: http..." and make them web links.

FWIW, I personally hate those "Link:" that do not say what the links
are for (IOW, I am OK with "BugLink:" or even "Bug:").

In any case, I polled your repository but I did not find anything to
pull.  Do you want me to start my own gitk mirror, queue this patch
there and pull from it myself, or is this meant to be a preview of
what you'll tell me to pull in a few days?

Thanks.

