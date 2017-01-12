Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB71C1FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 18:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750781AbdALSgs (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 13:36:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51718 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751109AbdALSgP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 13:36:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4D5B5D2FE;
        Thu, 12 Jan 2017 13:36:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uxMIAXWXDOmpyzpI6fm4soPSumk=; b=VZfCB8
        BZ3wtB3hU2vNxS3yjayRDgtJi1lKBReb3eOpzRnbLxSR2qAKsC+9+PgVx37hKr88
        Nc9x+CJ/KmGsibXmOBRTVdePgn26gvA5vCHry+SLenzcg2T5FI1xPZQ28H6hJge0
        w5RbUhSqo4Lo17mYMnbfqo93cN6tlyAqjDDSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V0igLvxFlUUqEvXZVDFSxoWOXajkuY4/
        Oo+0jrH0xqu8ENgfC3W/hg/ptXIZl4n4Ja2LgZnjmXjJqX8f50TUkIfzQqcdOoi7
        nkzFO/IDtkps9rv7HrdqSC7IwE8UBH2ONarZnh+A/Rmd36nCHYvzqhYirv8hF20+
        nzUWaYWVI90=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A87CA5D2FD;
        Thu, 12 Jan 2017 13:36:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13F4E5D2FC;
        Thu, 12 Jan 2017 13:36:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 03/38] sequencer: use a helper to find the commit message
References: <cover.1481642927.git.johannes.schindelin@gmx.de>
        <cover.1483370556.git.johannes.schindelin@gmx.de>
        <780d71b5844b526a850ac9b76d36b764b2580efd.1483370556.git.johannes.schindelin@gmx.de>
Date:   Thu, 12 Jan 2017 10:36:07 -0800
In-Reply-To: <780d71b5844b526a850ac9b76d36b764b2580efd.1483370556.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 2 Jan 2017 16:26:20 +0100
        (CET)")
Message-ID: <xmqqfukoktwo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC304E3C-D8F5-11E6-A7BB-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It is actually not safe to look for a commit message by looking for the
> first empty line and skipping it.
>
> The find_commit_subject() function looks more carefully, so let's use
> it. Since we are interested in the entire commit message, we re-compute
> the string length after verifying that the commit subject is not empty
> (in which case the entire commit message would be empty, something that
> should not happen but that we want to handle gracefully).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Very sensible.

>  sequencer.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 3eededcb98..720857beda 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -703,14 +703,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		next = commit;
>  		next_label = msg.label;
>  
> -		/*
> -		 * Append the commit log message to msgbuf; it starts
> -		 * after the tree, parent, author, committer
> -		 * information followed by "\n\n".
> -		 */
> -		p = strstr(msg.message, "\n\n");
> -		if (p)
> -			strbuf_addstr(&msgbuf, skip_blank_lines(p + 2));
> +		/* Append the commit log message to msgbuf. */
> +		if (find_commit_subject(msg.message, &p))
> +			strbuf_addstr(&msgbuf, p);
>  
>  		if (opts->record_origin) {
>  			if (!has_conforming_footer(&msgbuf, NULL, 0))
