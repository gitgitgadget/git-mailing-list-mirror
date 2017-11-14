Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4521A201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 06:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbdKNGAX (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 01:00:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52973 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750781AbdKNGAW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 01:00:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A351CAF002;
        Tue, 14 Nov 2017 01:00:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q7pTmJT33bj7zWrkpjRcDmz+/us=; b=j7gT11
        VHR0TVX2VpzjLh612ffKnpYwuERO/grDLMBTgol+f4PdV+8o+HD8EhDiHfitSgX0
        5eJ4C7RrBytOOWV8zZi6v6j+ReLgmfE2p4cSGqNcDKS1a6keAVI5ozYLPMw45tKJ
        dMn6WYOC/RZWqmTidHbbPL/3aQmatU3EL4OlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=es5X1kASuqSH3f7yFPKNOF+crTD8m4Fy
        FZ3O3DXiRkB5BhmgOoGZC4vZd4PHBfbhZv7zLesmtEXrolBsV7ZEI30YntExzBzG
        DrdEnXQ2gwtYsGzWHKzMDmsACoWPFI1V7z6n7jrgszNubVLTlnnWYPk7gXz5UNwe
        HlGiyp4zuTM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C003AF001;
        Tue, 14 Nov 2017 01:00:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22BA9AF000;
        Tue, 14 Nov 2017 01:00:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 2/3] am: semi working --cover-at-tip
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
        <948b19c2-9f2d-de9d-1e0a-6681dc9317a9@suse.de>
Date:   Tue, 14 Nov 2017 15:00:20 +0900
In-Reply-To: <948b19c2-9f2d-de9d-1e0a-6681dc9317a9@suse.de> (Nicolas
        Morey-Chaisemartin's message of "Mon, 13 Nov 2017 18:13:36 +0100")
Message-ID: <xmqqbmk54cy3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 191CBA20-C901-11E7-BF37-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:

>  	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
>  		state->sign_commit = gpgsign ? "" : NULL;
> +
>  }

Please give at least a cursory proof-reading before sending things
out.

> @@ -1106,14 +1131,6 @@ static void am_next(struct am_state *state)
>  
>  	oidclr(&state->orig_commit);
>  	unlink(am_path(state, "original-commit"));
> -
> -	if (!get_oid("HEAD", &head))
> -		write_state_text(state, "abort-safety", oid_to_hex(&head));
> -	else
> -		write_state_text(state, "abort-safety", "");
> -
> -	state->cur++;
> -	write_state_count(state, "next", state->cur);

Moving these lines to a later part of the source file is fine, but
can you do so as a separate preparatory patch that does not change
anything else?  That would unclutter the main patch that adds the
feature, allowing better reviews from reviewers.

The hunk below...

> +/**
> + * Increments the patch pointer, and cleans am_state for the application of the
> + * next patch.
> + */
> +static void am_next(struct am_state *state)
> +{
> +	struct object_id head;
> +
> +	/* Flush the cover letter if needed */
> +	if (state->cover_at_tip == 1 &&
> +	    state->series_len > 0 &&
> +	    state->series_id == state->series_len &&
> +	    state->cover_id > 0)
> +		do_apply_cover(state);
> +
> +	am_clean(state);
> +
> +	if (!get_oid("HEAD", &head))
> +		write_state_text(state, "abort-safety", oid_to_hex(&head));
> +	else
> +		write_state_text(state, "abort-safety", "");
> +
> +	state->cur++;
> +	write_state_count(state, "next", state->cur);
> +}

... if you followed that "separate preparatory step" approach, would
show clearly that you added the logic to call do_apply_cover() when
we transition after applying the Nth patch of a series with N patches,
as all the existing lines will show only as unchanged context lines.

By the way, don't we want to sanity check state->last (which we
learn by running "git mailsplit" that splits the incoming mbox into
pieces and counts the number of messages) against state->series_len?
Sometimes people send [PATCH 0-6/6], a 6-patch series with a cover
letter, and then follow-up with [PATCH 7/6].  For somebody like me,
it would be more convenient if the above code (more-or-less) ignored
series_len and called do_apply_cover() after applying the last patch
(which would be [PATCH 7/6]) based on what state->last says.

Thanks.


