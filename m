Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE6741FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 04:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbdDREXZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 00:23:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55982 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750758AbdDREXY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 00:23:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 642B674CA5;
        Tue, 18 Apr 2017 00:23:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jN0DKWKSszLFE0bYbQjMhsoNlbo=; b=re+k8i
        uvlz0wWb0/C2yq+vSZTIM6XGvMhsc5yYyo8JShVYAvX2NrL6O8po1+TpDNszwu2v
        Kx1Pi3XlyU0tV0SyJJwzZxksdZc3XuumNr0AcAeT49c/qBEXvXeI4tjAfDAJfUkK
        6qqYrvtOAh0d9t5f2tMiK2fx8rZIkUtfqfFuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DAx+Qr7Gol0T7DeAMHAoyz6hmS4qrOyM
        tTFajUS6ns7cTLOozoHS5/0zX73sYka48nnepVk35/NmwARIGlWTdrXp1/1MT7hi
        XBf+kQjaRNwotneoaCFpiy4R3uDI7AMmLln20wK+sr6pNNR8xNgtrT815WeQ1uVn
        dyDZ14Tiujk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C69874CA4;
        Tue, 18 Apr 2017 00:23:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C29AF74CA2;
        Tue, 18 Apr 2017 00:23:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v9 3/5] dir_iterator: add helpers to dir_iterator_advance
References: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
        <1492462296-4990-4-git-send-email-bnmvco@gmail.com>
Date:   Mon, 17 Apr 2017 21:23:21 -0700
In-Reply-To: <1492462296-4990-4-git-send-email-bnmvco@gmail.com> (Daniel
        Ferreira's message of "Mon, 17 Apr 2017 17:51:34 -0300")
Message-ID: <xmqq8tmyfio6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C25C16F2-23EE-11E7-92A6-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Ferreira <bnmvco@gmail.com> writes:

> Create helpers to dir_iterator_advance(). Make dir_iterator_advance()'s
> code more legible and allow some behavior to be reusable.
>
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---

This is the kind of change we typically call "refactoring" ---
factoring out reusable helpers out of existing code, without
changing the behaviour of the code at all.

> +static int set_iterator_data(struct dir_iterator_int *iter, struct dir_iterator_level *level)
> +{

If you are going to fold line in a patch that immediately follows
this one, do so from the get-go here.

I am not happy with the name of the function in that "set data" does
not convey as much information as it spends words.  

Conceptually, this is called once per each new directory entry
readdir() returns, and the most important "iterator data" that is
set to iter structure per loop is to update iter->base.path with
de->d_name; everything else is secondary and derived data from that.
And from that point of view, I have trouble with this function not
getting "de" passed to it, but the most important setting is instead
done by its caller.

If the function were called "adjust_iterator_data()", I wouldn't
find this function so troubling, I guess; after the caller sets the
iter.base.path, all the secondary data that can be derived from it
that are used by the caller of "advance" are set by this function.

> +	if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
> +		if (errno != ENOENT)
> +			warning("error reading path '%s': %s",
> +				iter->base.path.buf,
> +				strerror(errno));
> +		return -1;
> +	}
> +
> +	/*
> +	 * We have to set these each time because
> +	 * the path strbuf might have been realloc()ed.
> +	 */
> +	iter->base.relative_path =
> +		iter->base.path.buf + iter->levels[0].prefix_len;
> +	iter->base.basename =
> +		iter->base.path.buf + level->prefix_len;
> +	level->dir_state = DIR_STATE_ITER;
> +
> +	return 0;
> +}
> +
