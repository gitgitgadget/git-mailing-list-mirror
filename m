Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7666BC433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532A8610E6
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350335AbhICRaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:30:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60806 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350370AbhICRaS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:30:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DF1FF57D8;
        Fri,  3 Sep 2021 13:29:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n8mzY9TrwAhnpDIddUmQbzegT7JcbIR1wVCNOc
        VqlKo=; b=vmhaaQZL7rzAtCxpCjx/6cB9IXwLK42K4nB4+ZtpiigHb8Ho2zlw0F
        qxwYQghH3L0/r0sufuBGPIU2Ax4emvliS/eDT8+e31sOo7qBB+Fhapl2/naF1zRo
        nBZm2JrSOtDSVjE4hC4Dt6EP1XYUXXxVisAVhLG0zegp11Qt6dyn8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56935F57D7;
        Fri,  3 Sep 2021 13:29:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C585AF57D6;
        Fri,  3 Sep 2021 13:29:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com>
        <xmqqsfyoqm6e.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2109031709190.55@tvgsbejvaqbjf.bet>
Date:   Fri, 03 Sep 2021 10:29:16 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2109031709190.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 3 Sep 2021 17:20:35 +0200 (CEST)")
Message-ID: <xmqqwnnxftzn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76DDE5E4-0CDC-11EC-AC59-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It would even work if the current line is shorter, but as you point out:
> it is wasteful. And it could be improved to be more readable. I reworked
> it, and it now looks like this:
>
> 	if (!pipe_command(&cp, NULL, 0, &out, 0, NULL, 0)) {
> 		const char *line = out.buf;
>
> 		while (*line) {
> 			const char *eol = strchrnul(line, '\n'), *p;
> 			size_t len = eol - line;
> 			char *branch;
>
> 			if (!skip_prefix(line, "ref: ", &p) ||
> 			    !strip_suffix_mem(line, &len, "\tHEAD")) {
> 				line = eol + (*eol == '\n');
> 				continue;
> 			}
>
> 			eol = line + len;
> 			if (skip_prefix(p, "refs/heads/", &p)) {
> 				branch = xstrndup(p, eol - p);
> 				strbuf_release(&out);
> 				return branch;
> 			}
>
> 			error(_("remote HEAD is not a branch: '%.*s'"),
> 			      (int)(eol - p), p);
> 			strbuf_release(&out);
> 			return NULL;
> 		}
> 	}
>
> It now parses the output line by line, looking for the expected prefix and
> suffix, then verifies the ref name format, and either returns the short
> branch name or errors out with the message that this is not a branch.

It is much easier to read and understand how the loop works with
above.

>> > +			error(_("remote HEAD is not a branch: '%.*s'"),
>> > +			      (int)(head - ref), ref);
>> > +			strbuf_release(&out);
>> > +			return NULL;
>>
>> OK.  Any symref whose basename is HEAD in their remote-tracking
>> hierarchy would have been rejected earlier in the loop.
>>
>> Is there a particular reason why we return early here, instead of
>> breaking out of hte loop and let the generic "failed to get" code
>> path below to handle this case?
>
> Yes, the reason is that I wanted to err on the side of caution. If the
> remote repository reports a default branch that is not a default branch at
> all, I do not want to pretend that things are fine and then run into
> trouble later when we set up a non-branch as remote-tracking target or
> something like that.

Wouldn't we have the same problem when the remote end does not
advertise HEAD and we fall back to "local default", though?  We'd
run into trouble later as we use "local default" that may correspond
to a non-branch there as remote-tracking target, or something like
that.

Not that I care too deeply in the error case, though.  I just felt
that this early return was an uneven way to follow the principle to
err on the side of caution, as we continue with the local default
when the other side fails to tell us what their HEAD points at.

Thanks.
