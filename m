Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8632C20953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbdCPWaL (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:30:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52516 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752193AbdCPWaK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:30:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5E616D515;
        Thu, 16 Mar 2017 18:29:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t2Hbn6b/V0zZSlIgbRLtEbwNpkA=; b=NZ1jdn
        snERHAmGoMsiMkHoDS6ry55few/ydLZmoQPkYkdAjBfrqspnqmlgn32p14OzsIpM
        rpFBMkyr6iG5Ilm2LAREav30CZskfGZmFCpYFK8JrO/goRZtar01FimVqZBrT7P5
        uDsDg7S0fEbKOUyZVB9aCJFOTKqdbCxGjXc+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IXm9AYSnpZaHEyLvVecj01O/nPWMtTAM
        zj42fDahBocO+wX0OlrB6sN7BqVJIqdwynb/IsxPtPxApddz/rrp/8cxnax2bTt7
        Z8QoDkZ/G5bhX8uMaSn3l/xYRCPPL519vu3oW3GFrp6TGcVjBKL7TjPjEabb2KKX
        92yf5BU1nRY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB50A6D514;
        Thu, 16 Mar 2017 18:29:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37D456D513;
        Thu, 16 Mar 2017 18:29:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: sequencer "edit" command always issues a warning
References: <20170316131534.4vpbub3vmde7maua@sigill.intra.peff.net>
Date:   Thu, 16 Mar 2017 15:29:07 -0700
In-Reply-To: <20170316131534.4vpbub3vmde7maua@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 16 Mar 2017 09:15:34 -0400")
Message-ID: <xmqqy3w4ama4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F86F178C-0A97-11E7-8798-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I was rebasing with the new built-in sequencer code today, and I was
> surprised to see the use of warning() here:
>
>   $ git rebase -i
>   [set one commit to 'edit']
>   warning: stopped at 6ce6b914a... odb_pack_keep(): stop generating keepfile name
>   You can amend the commit now, with
>     [...more instructions...]
>
> It alarmed me for a minute until I realized that no, this is nothing to
> be alarmed about, but just git doing exactly what I told it to do.
>
> The original just wrote:
>
>   Stopped at 6ce6b914a... odb_pack_keep(): stop generating keepfile name
>
> It would be easy to switch back:
>
> diff --git a/sequencer.c b/sequencer.c
> index 1f729b053..8183a83c1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1997,7 +1997,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  			if (item->command == TODO_EDIT) {
>  				struct commit *commit = item->commit;
>  				if (!res)
> -					warning(_("stopped at %s... %.*s"),
> +					fprintf(stderr,
> +						_("Stopped at %s...  %.*s"),
>  						short_commit_name(commit),
>  						item->arg_len, item->arg);
>  				return error_with_patch(commit,
>
> and that would match most of the other messages that the command issues,
> which use a bare fprintf() and start with a capital letter. But I'm not
> sure if there was some reason to treat this one differently.

I doubt there was.  At least, I didn't think I read any rationale
for switching in logs or in-code comments.

If we stop due to conflicting changes during a "rebase -i" or a
range "cherry-pick/revert" session, warning() might make sense, but
I agree with you that stopping at "edit" is an expected thing.  If
we had info("stopped at...") that may be appropriate, but writing it
out to stderr is just fine, I would think.

Thanks for spotting.
