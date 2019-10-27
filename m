Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499621F4C0
	for <e@80x24.org>; Sun, 27 Oct 2019 12:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJ0MUb (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 08:20:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61797 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfJ0MUb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 08:20:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82B8E9755E;
        Sun, 27 Oct 2019 08:20:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kd24cJKq6lk4bahoPCxt/091C6g=; b=hXqaax
        pyTzgmjpYvi2v5kTxbRaXEaoX1VQdHUzed4wiPZzQ/vxIJl5ihvZECOSoJ3+V00C
        g8iWdQ2Psyn+7lz6f+xSphtb/Wzox51u2eCEWNsXo3prbE4YBAceh/R8J4Hggsc3
        RIZ6lBZmQBKlhD1e+qDXM9184n+VNPHKUhYc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iT5LIBFKxKwCr1IssCyR3IzhdexqMBqr
        PT4E/4h+dsDfIeixM2T2kdFzj1ORGUskP4yem2BO1VXFtAA+5m/o1HzCCVwbH9Sz
        jvvyYUkaw54N2BAgeTKyGx+qW4nOdy+XjPoorX3Yyrg2RaplSz6Wqg1XPfro+V5B
        umtTnGfsECA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7BAE49755D;
        Sun, 27 Oct 2019 08:20:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEA879755C;
        Sun, 27 Oct 2019 08:20:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Luke Dashjr <luke@dashjr.org>, git@vger.kernel.org
Subject: Re: GIT_COMMITTER_* and reflog
References: <201910252149.23787.luke@dashjr.org>
        <20191026022039.GE39574@google.com>
        <xmqqv9scark1.fsf@gitster-ct.c.googlers.com>
        <20191026173702.GA5522@sigill.intra.peff.net>
Date:   Sun, 27 Oct 2019 21:20:24 +0900
In-Reply-To: <20191026173702.GA5522@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 26 Oct 2019 13:37:02 -0400")
Message-ID: <xmqqr22ybcs7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28691C00-F8B4-11E9-BBD2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If somebody wants to pursue a patch, I suspect the solution is probably
> something like this (totally untested):

Looks sensible.  It is very much unsatisfying that datestamp(),
which is used by fmt_ident() when no date string is given, seems to
totally bypass date.c::get_time(), which means the framework to give
fake timestamp via GIT_TEST_DATE_NOW cannot be used to write
reproducible tests.

Given that datestamp() is only used by the push certificate and
fast-import codepaths and nowhere else, I suspect that "fixing" it
retroactively to honor GIT_TEST_DATE_NOW would not have any negative
fallout, but that's not something I should be contemplating on
during the -rc period ;-)

Thanks.

>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index d60767ab73..2ebf2feeb8 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1658,7 +1658,10 @@ static int files_log_ref_write(struct files_ref_store *refs,
>  	if (logfd < 0)
>  		return 0;
>  	result = log_ref_write_fd(logfd, old_oid, new_oid,
> -				  git_committer_info(0), msg);
> +				  fmt_ident(getenv("GIT_COMMITTER_NAME"),
> +					    getenv("GIT_COMMITTER_EMAIL"),
> +					    WANT_COMMITTER_IDENT, NULL, 0),
> +				  msg);
>  	if (result) {
>  		struct strbuf sb = STRBUF_INIT;
>  		int save_errno = errno;
>
> -Peff
